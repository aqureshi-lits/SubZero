report 80047 "Calc.RentalStockCountsDetail"
{
    Caption = 'Calculate Rental Stock Counts Detail';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DaysLoop; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending);

            dataitem(Customer; Customer)
            {
                RequestFilterFields = "No.";

                dataitem("Storage Condition"; "Storage Condition")
                {
                    DataItemTableView = sorting(Code) where("Use for Warehouse Rents" = const(true));
                    RequestFilterFields = Code;

                    trigger OnAfterGetRecord()
                    begin
                        ProcessCustomerStorageCondition("Storage Condition".Code);
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 0, DaysInPeriod);
            end;

            trigger OnAfterGetRecord()
            begin
                AsOnDate := StartDate + Number;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        StorageRates: Record "Storage Condition_Customer";
        LatestInboundILE: Record "Item Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        AsOnDate: Date;
        DaysInPeriod: Integer;
        PerDayRate: Decimal;
        GoodsIn_UOM: Decimal;
        GoodsOut_UOM: Decimal;
        GoodsInOut_UOM: Decimal;
        GoodsIn_Actual_Pallet: Decimal;
        GoodsOut_Actual_Pallet: Decimal;
        GoodsInOut_Actual_Pallet: Decimal;
        GoodsIn_Round_Pallet: Decimal;
        GoodsOut_Round_Pallet: Decimal;
        GoodsInOut_Round_Pallet: Decimal;
        TotalOccupancyPallets: Decimal;
        BalancePallets: Decimal;
        ChargeablePallets: Decimal;
        MinRuleChargeablePallets: Decimal;
        OverTimeTotal: Decimal;
        PlugInTotal: Decimal;
        DMInspectionTotal: Decimal;
        HandlingTotal: Decimal;
        RunningItemQuantity: Dictionary of [Code[20], Decimal];
        MonthlyFeeCharged: Dictionary of [Text, Boolean];
        FixedChargeCharged: Dictionary of [Text, Boolean];
        GRNNos: List of [Text];
        GDNNos: List of [Text];
        ReceiptPallets: Dictionary of [Code[20], Decimal];
        ChargedReceipts: Dictionary of [Code[20], Boolean];

    trigger OnInitReport()
    var
        DailyRentalStock: Record "Daily Rental Stock Detail";
    begin
        DailyRentalStock.SetCurrentKey("Posting Date");
        if DailyRentalStock.FindLast() then begin
            StartDate := DailyRentalStock."Posting Date" + 1;
            EndDate := WorkDate() - 1;
        end;
    end;

    trigger OnPreReport()
    begin
        ValidateRequestDates();
        DaysInPeriod := EndDate - StartDate;
        Clear(RunningItemQuantity);
        Clear(MonthlyFeeCharged);
        Clear(FixedChargeCharged);
        Clear(ChargedReceipts);
    end;

    trigger OnPostReport()
    begin
        Message('Warehouse rental lines calculation completed.');
    end;

    procedure SetCustomer(var CustRec: Record Customer)
    begin
        Customer.SetView(CustRec.GetView());
    end;

    local procedure ValidateRequestDates()
    begin
        if StartDate = 0D then
            Error('Start Date must not be blank.');
        if EndDate = 0D then
            Error('End Date must not be blank.');
        if StartDate > EndDate then
            Error('Start date must not be greater than end date.');
        if StartDate >= WorkDate() then
            Error('Start Date must be less than %1.', WorkDate());
        if EndDate >= WorkDate() then
            Error('End Date must be less than %1.', WorkDate());
    end;

    // ---------------- Customer-level processing ----------------

    local procedure ProcessCustomerStorageCondition(StorageConditionCode: Code[20])
    var
        ItemRec: Record Item;
    begin
        ResetTotals();
        GetStorageRate(Customer."No.", StorageConditionCode);

        ItemRec.SetRange("Customer Code", Customer."No.");
        ItemRec.SetRange("Storage Condition Code", StorageConditionCode);
        ItemRec.SetRange(Type, ItemRec.Type::Inventory);
        ItemRec.SetRange(Blocked, false);
        ItemRec.SetAutoCalcFields("Purchase Exist");
        if ItemRec.FindSet() then
            repeat
                if ItemRec."Purchase Exist" then
                    AccumulateItem(ItemRec);
            until ItemRec.Next() = 0;

        InsertCustomerLine(StorageConditionCode);
    end;

    local procedure AccumulateItem(ItemRec: Record Item)
    var
        InboundILE: Record "Item Ledger Entry";
        TermsBuffer: Record "Daily Rental Stock Detail";
        WMSBillingManagement: Codeunit "WMS Billing Management";
        QtyPerPallet: Decimal;
        OpeningQty: Decimal;
        QtyIn: Decimal;
        QtyOut: Decimal;
        QtyInOut: Decimal;
        ItemOccupancy: Decimal;
        ItemBalance: Decimal;
        ItemChargeable: Decimal;
        MinimumPallets: Decimal;
    begin
        QtyPerPallet := ItemRec."Base UOM Per Pallet";
        if QtyPerPallet = 0 then
            Error('Base UOM Per Pallet must be greater than zero for Item %1.', ItemRec."No.");

        OpeningQty := GetOpeningQuantity(ItemRec."No.");
        CalculateDailyMovements(ItemRec."No.", QtyPerPallet, QtyIn, QtyOut, QtyInOut);

        // Actual pallets summed to the customer, rounded once in InsertCustomerLine
        ItemOccupancy := (OpeningQty + QtyIn) / QtyPerPallet;
        ItemBalance := (OpeningQty + QtyIn - QtyOut - QtyInOut) / QtyPerPallet;
        if ItemBalance < 0 then
            ItemBalance := 0;

        GoodsIn_UOM += QtyIn;
        GoodsOut_UOM += QtyOut;
        GoodsInOut_UOM += QtyInOut;
        GoodsIn_Actual_Pallet += QtyIn / QtyPerPallet;
        GoodsOut_Actual_Pallet += Round(QtyOut / QtyPerPallet, 1, '<');
        GoodsInOut_Actual_Pallet += QtyInOut / QtyPerPallet;
        TotalOccupancyPallets += ItemOccupancy;
        BalancePallets += ItemBalance;

        //


        // Billing terms from the item's latest receipt
        Clear(InboundILE);
        Clear(TermsBuffer);
        if WMSBillingManagement.GetLatestInboundTerms(ItemRec."No.", AsOnDate, InboundILE) then
            WMSBillingManagement.CopyTermsToDailyRental(TermsBuffer, Customer, InboundILE);

        if InboundILE."Entry No." > LatestInboundILE."Entry No." then
            LatestInboundILE := InboundILE;

        // Normal / Fixed Days: minimum storage period
        ItemChargeable := ItemOccupancy;
        if InboundILE."Entry No." <> 0 then
            if TermsBuffer."WMS Minimum Storage Days" > 0 then
                if AsOnDate <= InboundILE."Posting Date" + TermsBuffer."WMS Minimum Storage Days" - 1 then begin
                    MinimumPallets := InboundILE.Quantity / QtyPerPallet;
                    if MinimumPallets > ItemChargeable then
                        ItemChargeable := MinimumPallets;
                end;
        MinRuleChargeablePallets += ItemChargeable;

        // NOTE: Over Time / Plug In / DM Inspection / Handling are NOT calculated here.
        // They are calculated once per GRN in CalculateReceiptCharges.

        RunningItemQuantity.Set(ItemRec."No.", OpeningQty + QtyIn - QtyOut - QtyInOut);
    end;

    local procedure InsertCustomerLine(StorageConditionCode: Code[20])
    var
        DailyRentalStockDetail: Record "Daily Rental Stock Detail";
        WMSBillingManagement: Codeunit "WMS Billing Management";
    begin
        if (TotalOccupancyPallets = 0) and (BalancePallets = 0) and
           (GoodsIn_UOM = 0) and (GoodsOut_UOM = 0) and (GoodsInOut_UOM = 0)
        then
            exit;

        // Round once at customer level
        GoodsIn_Round_Pallet := Round(GoodsIn_Actual_Pallet, 1, '>');
        GoodsOut_Round_Pallet := Round(GoodsOut_Actual_Pallet, 1, '<');
        GoodsInOut_Round_Pallet := Round(GoodsInOut_Actual_Pallet, 1, '>');
        TotalOccupancyPallets := Round(TotalOccupancyPallets, 1, '>');
        BalancePallets := Round(BalancePallets, 1, '>');
        MinRuleChargeablePallets := Round(MinRuleChargeablePallets, 1, '>');

        DailyRentalStockDetail.Init();

        if LatestInboundILE."Entry No." <> 0 then
            WMSBillingManagement.CopyTermsToDailyRental(DailyRentalStockDetail, Customer, LatestInboundILE);

        DailyRentalStockDetail."Posting Date" := AsOnDate;
        DailyRentalStockDetail."Customer Code" := Customer."No.";
        DailyRentalStockDetail."Customer Name" := Customer.Name;
        DailyRentalStockDetail."Storage Condition" := StorageConditionCode;
        DailyRentalStockDetail."Per Day Rate" := PerDayRate;

        DailyRentalStockDetail."Goods In (UOM)" := GoodsIn_UOM;
        DailyRentalStockDetail."Goods Out (UOM)" := GoodsOut_UOM;
        DailyRentalStockDetail."Same Day In-Out (UOM)" := GoodsInOut_UOM;
        DailyRentalStockDetail."Goods In (Actual-Pallet)" := GoodsIn_Actual_Pallet;
        DailyRentalStockDetail."Goods In (Round-Pallet)" := GoodsIn_Round_Pallet;
        DailyRentalStockDetail."Goods Out (Actual-Pallet)" := GoodsOut_Actual_Pallet;
        DailyRentalStockDetail."Goods Out (Round-Pallet)" := GoodsOut_Round_Pallet;
        DailyRentalStockDetail."Same Day In-Out (Act.-Pallet)" := GoodsInOut_Actual_Pallet;
        DailyRentalStockDetail."Same Day In-Out (Round-Pallet)" := GoodsInOut_Round_Pallet;
        DailyRentalStockDetail."WMS Total Occupancy Pallets" := TotalOccupancyPallets;
        DailyRentalStockDetail."WMS Balance Pallets" := BalancePallets;

        DailyRentalStockDetail."GRN No.'s" :=
            CopyStr(JoinList(GRNNos), 1, MaxStrLen(DailyRentalStockDetail."GRN No.'s"));
        DailyRentalStockDetail."GDN No.'s" :=
            CopyStr(JoinList(GDNNos), 1, MaxStrLen(DailyRentalStockDetail."GDN No.'s"));

        // Blank billing type fallback
        if DailyRentalStockDetail."WMS Billing Type" = DailyRentalStockDetail."WMS Billing Type"::" " then
            if DailyRentalStockDetail."WMS Allocated Pallets" > 0 then
                DailyRentalStockDetail."WMS Billing Type" := DailyRentalStockDetail."WMS Billing Type"::"Fixed Location"
            else
                DailyRentalStockDetail."WMS Billing Type" := DailyRentalStockDetail."WMS Billing Type"::Normal;

        if DailyRentalStockDetail."WMS Billing Type" = DailyRentalStockDetail."WMS Billing Type"::"Fixed Location" then begin
            ChargeablePallets := TotalOccupancyPallets - DailyRentalStockDetail."WMS Allocated Pallets";
            if ChargeablePallets < 0 then
                ChargeablePallets := 0;
        end else
            ChargeablePallets := MinRuleChargeablePallets;

        DailyRentalStockDetail."WMS Chargeable Pallets" := ChargeablePallets;

        ApplyMonthlyCharges(DailyRentalStockDetail);

        // Over Time / Plug In / DM Inspection / Handling: once per GRN
        CalculateReceiptCharges();

        DailyRentalStockDetail."Over Time" := OverTimeTotal;
        DailyRentalStockDetail."Plug In" := PlugInTotal;
        DailyRentalStockDetail."DM Inspection" := DMInspectionTotal;
        DailyRentalStockDetail."Handling Charges" := HandlingTotal;

        DailyRentalStockDetail."Total Charges" :=
            DailyRentalStockDetail."WMS Management Fee" +
            DailyRentalStockDetail."WMS Fixed Monthly Charge" +
            (PerDayRate * ChargeablePallets) +
            OverTimeTotal + PlugInTotal + DMInspectionTotal + HandlingTotal;

        DailyRentalStockDetail.Insert();
        MarkMonthlyChargesApplied(DailyRentalStockDetail);
    end;

    // ---------------- Receipt (GRN) charges: once per GRN ----------------

    local procedure AddReceiptPallets(ReceiptNo: Code[20]; Pallets: Decimal)
    var
        Existing: Decimal;
    begin
        if ReceiptNo = '' then
            exit;
        if ReceiptPallets.Get(ReceiptNo, Existing) then
            ReceiptPallets.Set(ReceiptNo, Existing + Pallets)
        else
            ReceiptPallets.Add(ReceiptNo, Pallets);
    end;

    local procedure CalculateReceiptCharges()
    var
        ILE: Record "Item Ledger Entry";
        ReceiptNo: Code[20];
        Pallets: Decimal;
        Rate: Decimal;
    begin
        OverTimeTotal := 0;
        PlugInTotal := 0;
        DMInspectionTotal := 0;
        HandlingTotal := 0;

        foreach ReceiptNo in ReceiptPallets.Keys do
            if not ChargedReceipts.ContainsKey(ReceiptNo) then begin
                // Read charges from the first ILE of the GRN only
                ILE.Reset();
                ILE.SetRange("Document No.", ReceiptNo);
                ILE.SetRange("Posting Date", AsOnDate);
                ILE.SetFilter("Entry Type", '%1|%2',
                    ILE."Entry Type"::Purchase, ILE."Entry Type"::"Positive Adjmt.");
                if ILE.FindFirst() then begin
                    OverTimeTotal += ILE."WMS Over time";
                    PlugInTotal += ILE."WMS Plug In";
                    DMInspectionTotal += ILE."WMS DM Inspection";

                    Pallets := Round(ReceiptPallets.Get(ReceiptNo), 1, '>');
                    Rate := GetContainerCharges(ILE."Container Type", Customer."No.");

                    case ILE."Container Type" of
                        ILE."Container Type"::"Loose Pallet":
                            HandlingTotal += Rate * Pallets;
                        ILE."Container Type"::"Internal Transfer":
                            HandlingTotal += GetInternalTransferCharge(Pallets);
                        else
                            HandlingTotal += Rate;
                    end;
                end;

                ChargedReceipts.Add(ReceiptNo, true);
            end;
    end;

    local procedure GetInternalTransferCharge(Pallets: Decimal): Decimal
    begin
        // Up to 5 pallets = 50 flat, 6 and above = 10 per pallet
        if Pallets <= 0 then
            exit(0);
        if Pallets <= 5 then
            exit(50);
        exit(Pallets * 10);
    end;

    // ---------------- Item ledger helpers ----------------

    local procedure GetOpeningQuantity(ItemNo: Code[20]): Decimal
    var
        OpeningItemLedgerEntry: Record "Item Ledger Entry";
        CachedQuantity: Decimal;
    begin
        if RunningItemQuantity.Get(ItemNo, CachedQuantity) then
            exit(CachedQuantity);

        OpeningItemLedgerEntry.SetRange("Item No.", ItemNo);
        OpeningItemLedgerEntry.SetFilter("Posting Date", '<%1', StartDate);
        OpeningItemLedgerEntry.CalcSums(Quantity);
        RunningItemQuantity.Add(ItemNo, OpeningItemLedgerEntry.Quantity);
        exit(OpeningItemLedgerEntry.Quantity);
    end;

    local procedure CalculateDailyMovements(ItemNo: Code[20]; QtyPerPallet: Decimal; var QtyIn: Decimal; var QtyOut: Decimal; var QtyInOut: Decimal)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        InboundLots: Dictionary of [Text, Boolean];
    begin
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
        ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');

        // Inbound
        ItemLedgerEntry.SetFilter("Entry Type", '%1|%2',
            ItemLedgerEntry."Entry Type"::Purchase, ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
        if ItemLedgerEntry.FindSet() then
            repeat
                QtyIn += ItemLedgerEntry.Quantity;
                AddReceiptPallets(ItemLedgerEntry."Document No.", ItemLedgerEntry.Quantity / QtyPerPallet);
                AddDistinct(GRNNos, GetPurchaseOrderNo(ItemLedgerEntry));
                if not InboundLots.ContainsKey(ItemLedgerEntry."Lot No.") then
                    InboundLots.Add(ItemLedgerEntry."Lot No.", true);
            until ItemLedgerEntry.Next() = 0;

        // Outbound
        ItemLedgerEntry.SetFilter("Entry Type", '%1|%2',
            ItemLedgerEntry."Entry Type"::Sale, ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
        if ItemLedgerEntry.FindSet() then
            repeat
                AddDistinct(GDNNos, GetSalesOrderNo(ItemLedgerEntry));
                if InboundLots.ContainsKey(ItemLedgerEntry."Lot No.") then
                    QtyInOut += -ItemLedgerEntry.Quantity
                else
                    QtyOut += -ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next() = 0;
    end;

    // ---------------- Rates and monthly charges ----------------

    local procedure GetStorageRate(CustomerNo: Code[20]; StorageConditionCode: Code[20])
    begin
        PerDayRate := 0;
        StorageRates.Reset();
        StorageRates.SetRange("Customer No.", CustomerNo);
        StorageRates.SetRange("Code", StorageConditionCode);
        if StorageRates.FindFirst() then
            PerDayRate := StorageRates."Rent Pallet/Day";
    end;

    procedure GetContainerCharges(ContainerTypeValue: Enum containerType; CustomerNo: Code[20]): Decimal
    var
        CustomerStorageCharges: Record Charges;
    begin
        CustomerStorageCharges.SetRange(Code, Format(ContainerTypeValue));
        CustomerStorageCharges.SetRange("Customer No.", CustomerNo);
        if CustomerStorageCharges.FindFirst() then
            exit(CustomerStorageCharges.Amount);
        exit(0);
    end;

    local procedure ApplyMonthlyCharges(var DailyRentalStockDetail: Record "Daily Rental Stock Detail")
    begin
        if Customer."WMS Management Fee" <> 0 then
            if not IsMonthlyChargeApplied(MonthlyFeeCharged, true) then
                DailyRentalStockDetail."WMS Management Fee" :=
                    Round((Customer."WMS Management Fee" / 30) * GetDaysInMonth(AsOnDate), 0.01, '=');

        if (DailyRentalStockDetail."WMS Billing Type" = DailyRentalStockDetail."WMS Billing Type"::"Fixed Location") and
           (TotalOccupancyPallets >= 1) and
           (Customer."WMS Fixed Monthly Charge" <> 0)
        then
            if not IsMonthlyChargeApplied(FixedChargeCharged, false) then
                DailyRentalStockDetail."WMS Fixed Monthly Charge" := Customer."WMS Fixed Monthly Charge";
    end;

    local procedure IsMonthlyChargeApplied(var ChargeCache: Dictionary of [Text, Boolean]; IsManagementFee: Boolean): Boolean
    var
        DailyRentalStockDetail: Record "Daily Rental Stock Detail";
        MonthKey: Text;
    begin
        MonthKey := GetMonthKey();
        if ChargeCache.ContainsKey(MonthKey) then
            exit(true);

        DailyRentalStockDetail.SetRange("Customer Code", Customer."No.");
        DailyRentalStockDetail.SetRange("Posting Date", CalcDate('<-CM>', AsOnDate), CalcDate('<CM>', AsOnDate));
        if IsManagementFee then
            DailyRentalStockDetail.SetFilter("WMS Management Fee", '<>0')
        else
            DailyRentalStockDetail.SetFilter("WMS Fixed Monthly Charge", '<>0');

        if not DailyRentalStockDetail.IsEmpty() then begin
            ChargeCache.Add(MonthKey, true);
            exit(true);
        end;
        exit(false);
    end;

    local procedure MarkMonthlyChargesApplied(DailyRentalStockDetail: Record "Daily Rental Stock Detail")
    var
        MonthKey: Text;
    begin
        MonthKey := GetMonthKey();
        if DailyRentalStockDetail."WMS Management Fee" <> 0 then
            if not MonthlyFeeCharged.ContainsKey(MonthKey) then
                MonthlyFeeCharged.Add(MonthKey, true);
        if DailyRentalStockDetail."WMS Fixed Monthly Charge" <> 0 then
            if not FixedChargeCharged.ContainsKey(MonthKey) then
                FixedChargeCharged.Add(MonthKey, true);
    end;

    local procedure GetMonthKey(): Text
    begin
        exit(Customer."No." + '|' + Format(AsOnDate, 0, '<Year4><Month,2>'));
    end;

    local procedure GetDaysInMonth(DateValue: Date): Integer
    begin
        exit(Date2DMY(CalcDate('<CM>', DateValue), 1));
    end;

    local procedure ResetTotals()
    begin
        Clear(LatestInboundILE);
        GoodsIn_UOM := 0;
        GoodsOut_UOM := 0;
        GoodsInOut_UOM := 0;
        GoodsIn_Actual_Pallet := 0;
        GoodsOut_Actual_Pallet := 0;
        GoodsInOut_Actual_Pallet := 0;
        GoodsIn_Round_Pallet := 0;
        GoodsOut_Round_Pallet := 0;
        GoodsInOut_Round_Pallet := 0;
        TotalOccupancyPallets := 0;
        BalancePallets := 0;
        ChargeablePallets := 0;
        MinRuleChargeablePallets := 0;
        OverTimeTotal := 0;
        PlugInTotal := 0;
        DMInspectionTotal := 0;
        HandlingTotal := 0;
        Clear(GRNNos);
        Clear(GDNNos);
        Clear(ReceiptPallets);
    end;

    // ---------------- GRN / GDN numbers ----------------

    local procedure GetPurchaseOrderNo(ItemLedgerEntry: Record "Item Ledger Entry"): Code[35]
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        if ItemLedgerEntry."Document Type" <> ItemLedgerEntry."Document Type"::"Purchase Receipt" then
            exit('');
        PurchRcptHeader.SetLoadFields("Vendor Shipment No.");
        if PurchRcptHeader.Get(ItemLedgerEntry."Document No.") then
            exit(PurchRcptHeader."No.");
        exit('');
    end;

    local procedure GetSalesOrderNo(ItemLedgerEntry: Record "Item Ledger Entry"): Code[35]
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if ItemLedgerEntry."Document Type" <> ItemLedgerEntry."Document Type"::"Sales Shipment" then
            exit('');
        SalesShipmentHeader.SetLoadFields("External Document No.");
        if SalesShipmentHeader.Get(ItemLedgerEntry."Document No.") then
            exit(SalesShipmentHeader."No.");
        exit('');
    end;

    local procedure AddDistinct(var NoList: List of [Text]; DocNo: Text)
    begin
        if DocNo = '' then
            exit;
        if not NoList.Contains(DocNo) then
            NoList.Add(DocNo);
    end;

    local procedure JoinList(NoList: List of [Text]): Text
    var
        Result: TextBuilder;
        DocNo: Text;
    begin
        foreach DocNo in NoList do begin
            if Result.Length() > 0 then
                Result.Append(',');
            Result.Append(DocNo);
        end;
        exit(Result.ToText());
    end;
}
