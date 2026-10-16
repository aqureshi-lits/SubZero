report 80048 "WMS Rental Accounting Detail"
{
    Caption = 'WMS Rental Accounting';
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Layout/WMS Rental Accounting - Detail.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(CustomerNo; Customer."No.") { }
            column(CustomerName; Customer.Name) { }
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(ReportName; 'WMS Rental Accounting') { }
            Column(AsOnDateTime; CurrentDateTime()) { }
            column(StartDate; Format(StartDate, 0, 4)) { }
            column(EndDate; Format(EndDate, 0, 4)) { }
            column(Customer_CBM; "Customer CBM")
            {
            }
            // dataitem("Daily Rental Stock Detail"; "Daily Rental Stock Detail")
            dataitem("Daily Rental Stock Detail"; "Daily Rental Stock Detail")
            {
                DataItemLink = "Customer Code" = field("No.");
                DataItemTableView = sorting("Storage Condition", "Item Code") order(ascending);
                RequestFilterFields = "Item Code";
                column(Storage_Condition; "Daily Rental Stock Detail"."Storage Condition") { }
                column(Per_Day_Rate; "Daily Rental Stock Detail"."Per Day Rate") { }
                column(Posting_Date; "Posting Date") { }
                column(Item_Code; "Daily Rental Stock Detail"."Item Code") { }
                column(Item_Name; "Daily Rental Stock Detail"."Item Name") { }
                //Adding Base Measure unit FA
                column(length; length) { }
                column(width; width) { }
                column(height; height) { }
                column(cbm; cbm) { }
                column(cpm; cpm) { }
                column(cpr; cpr) { }





                column(GoodsIn_UOM; GoodsIn_UOM) { }
                column(GoodsOut_UOM; GoodsOut_UOM) { }
                column(GoodsInOut_UOM; GoodsInOut_UOM) { }
                column(GoodsIn_Actual_Pallet; Round(GoodsIn_Actual_Pallet, 0.001, '>')) { }
                column(GoodsIn_Round_Pallet; GoodsIn_Round_Pallet) { }
                column(GoodsOut_Actual_Pallet; Round(GoodsOut_Actual_Pallet, 0.001, '>')) { }
                column(GoodsOut_Round_Pallet; GoodsOut_Round_Pallet) { }
                column(GoodsInOut_Actual_Pallet; Round(GoodsInOut_Actual_Pallet, 0.001, '>')) { }
                column(GoodsInOut_Round_Pallet; GoodsInOut_Round_Pallet) { }
                column(OpeningStock_UOM; OpeningStock_UOM) { }
                column(ClosingStock_UOM; ClosingStock_UOM) { }
                column(OpeningStock_Actual_Pallet; Round(OpeningStock_Actual_Pallet, 0.001, '>')) { }
                column(OpeningStock_Round_Pallet; OpeningStock_Round_Pallet) { }
                column(ClosingStock_Actual_Pallet; Round(ClosingStock_Actual_Pallet, 0.001, '>')) { }
                column(ClosingStock_Round_Pallet; ClosingStock_Round_Pallet) { }
                column(ChargesAmount; ChargesAmount) { }
                column(VATAmount; VATAmount) { }
                column(NetAmount; NetAmount) { }

                trigger OnPreDataItem()
                begin
                    // SetRange("Posting Date", StartDate);
                    SetRange("Posting Date", StartDate, EndDate);
                end;

                trigger OnAfterGetRecord()
                var
                    // DailyRentalStock2: Record "Daily Rental Stock Detail";
                    DailyRentalStockDetail2: Record "Daily Rental Stock Detail";

                begin
                    ResetGlobalDecimals();
                    CalculateOpeningStock(Customer."No.", "Daily Rental Stock Detail"."Storage Condition", "Daily Rental Stock Detail"."Per Day Rate",
                    Customer."Customer CBM", "Daily Rental Stock Detail"."Posting Date", "Daily Rental Stock Detail"."Item Code");
                    DailyRentalStockDetail2.SetRange("Customer Code", Customer."No.");
                    DailyRentalStockDetail2.SetRange("Storage Condition", "Daily Rental Stock Detail"."Storage Condition");
                    DailyRentalStockDetail2.SetRange("Per Day Rate", "Daily Rental Stock Detail"."Per Day Rate");
                    //Added By FA
                    DailyRentalStockDetail2.SetRange("Item Code", "Daily Rental Stock Detail"."Item Code");
                    DailyRentalStockDetail2.SetRange("Posting Date", "Daily Rental Stock Detail"."Posting Date");
                    if DailyRentalStockDetail2.FindSet() then
                        repeat

                            GoodsIn_UOM := GoodsIn_UOM + DailyRentalStockDetail2."Goods In (UOM)";
                            GoodsOut_UOM := GoodsOut_UOM + DailyRentalStockDetail2."Goods Out (UOM)";
                            GoodsInOut_UOM := GoodsInOut_UOM + DailyRentalStockDetail2."Same Day In-Out (UOM)";
                            GoodsIn_Actual_Pallet := GoodsIn_Actual_Pallet + DailyRentalStockDetail2."Goods In (Actual-Pallet)";
                            GoodsIn_Round_Pallet := GoodsIn_Round_Pallet + DailyRentalStockDetail2."Goods In (Round-Pallet)";
                            GoodsOut_Actual_Pallet := GoodsOut_Actual_Pallet + DailyRentalStockDetail2."Goods Out (Actual-Pallet)";
                            GoodsOut_Round_Pallet := GoodsOut_Round_Pallet + DailyRentalStockDetail2."Goods Out (Round-Pallet)";
                            GoodsInOut_Actual_Pallet := GoodsInOut_Actual_Pallet + DailyRentalStockDetail2."Same Day In-Out (Act.-Pallet)";
                            GoodsInOut_Round_Pallet := GoodsInOut_Round_Pallet + DailyRentalStockDetail2."Same Day In-Out (Round-Pallet)";

                            // PerDayStock_UOM := PerDayStock_UOM + DailyRentalStockDetail2."Goods In (UOM)" - DailyRentalStockDetail2."Goods Out (UOM)";
                            // PerDayStock_Actual_Pallet := PerDayStock_Actual_Pallet + DailyRentalStockDetail2."Goods In (Actual-Pallet)" - DailyRentalStockDetail2."Goods Out (Actual-Pallet)";
                            // PerDayStock_Round_Pallet := PerDayStock_Round_Pallet + DailyRentalStockDetail2."Goods In (Round-Pallet)" - DailyRentalStockDetail2."Goods Out (Round-Pallet)";
                            CalculateBaseunitofMeasure(DailyRentalStockDetail2."Item Code", Customer."Customer CBM");
                            if PerDayStock_UOM > 0 then begin
                                ClosingStock_UOM := PerDayStock_UOM;
                                ClosingStock_Actual_Pallet := PerDayStock_Actual_Pallet;
                                ClosingStock_Round_Pallet := PerDayStock_Round_Pallet;
                                //Commented By FA
                                // ClosingStock_UOM += PerDayStock_UOM;
                                // ClosingStock_Actual_Pallet += PerDayStock_Actual_Pallet;
                                // ClosingStock_Round_Pallet += PerDayStock_Round_Pallet;
                            end;

                        until DailyRentalStockDetail2.Next() = 0;
                    // if OpeningStock_UOM = 0 then
                    // OpeningStock_UOM := GoodsIn_UOM - GoodsOut_UOM;
                    AdditionalStorageCharge := "Daily Rental Stock Detail"."WMS Additional Charge";

                    RateToUse :=
                        "Daily Rental Stock Detail"."Per Day Rate";

                    if RateToUse = 0 then
                        RateToUse :=
                            "Daily Rental Stock Detail"."Per Day Rate";

                    case "Daily Rental Stock Detail"."WMS Billing Type" of

                        "WMS Billing Type"::Normal,
                        "WMS Billing Type"::"Fixed Days":
                            begin
                                ChargesAmount :=
                                    ClosingStock_Round_Pallet * RateToUse;
                            end;

                        "WMS Billing Type"::"Fixed Location":
                            begin
                                ChargeablePallets :=
                                    ClosingStock_Round_Pallet -
                                    "Daily Rental Stock Detail"."WMS Allocated Pallets";

                                if ChargeablePallets < 0 then
                                    ChargeablePallets := 0;

                                ChargesAmount :=
                                    ChargeablePallets * RateToUse;
                            end;
                    end;

                    VATAmount :=
                        (ChargesAmount * 5) / 100;

                    NetAmount :=
                        ChargesAmount +
                        VATAmount;
                end;
            }

            trigger OnAfterGetRecord() //Customer
            var
                // DailyRentalStock: Record "Daily Rental Stock Detail";
                DailyRentalStockDetail: Record "Daily Rental Stock Detail";
            begin
                Clear(PalletCount);
                DailyRentalStockDetail.SetRange("Posting Date", EndDate);
                DailyRentalStockDetail.SetRange("Customer Code", Customer."No.");
                if not DailyRentalStockDetail.FindSet() then
                    Error('The daily warehouse rentals must be calculated for %1. Customer No. %2.', EndDate, Customer."No.");
                ResetGlobalDecimals();
                OpeningStock_UOM := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = all;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        // AsOnDate: Date;
        DaysInPeriod: Integer;
        PalletCount: array[20] of Decimal;
        i: Integer;
        GoodsIn_UOM: Decimal;
        GoodsOut_UOM: Decimal;
        GoodsInOut_UOM: Decimal;

        GoodsIn_Actual_Pallet: Decimal;
        GoodsOut_Actual_Pallet: Decimal;
        GoodsInOut_Actual_Pallet: Decimal;

        GoodsIn_Round_Pallet: Decimal;
        GoodsOut_Round_Pallet: Decimal;
        GoodsInOut_Round_Pallet: Decimal;
        OpeningStock_UOM: Decimal;
        //Adding Variables For Closing Stock
        OpeningStock_UOM_2: Decimal;
        OpeningStock_Actual_Pallet_2: Decimal;
        OpeningStock_Round_Pallet_2: Decimal;
        ClosingStock_UOM: Decimal;
        OpeningStock_Actual_Pallet: Decimal;
        ClosingStock_Actual_Pallet: Decimal;
        OpeningStock_Round_Pallet: Decimal;
        ClosingStock_Round_Pallet: Decimal;

        PerDayStock_UOM: Decimal;
        PerDayStock_Actual_Pallet: Decimal;
        PerDayStock_Round_Pallet: Decimal;

        ChargesAmount: Decimal;

        VATAmount: Decimal;
        NetAmount: Decimal;
        length: Decimal;
        width: Decimal;
        height: Decimal;
        cbm: Decimal;
        cpm: Decimal;
        cpr: Decimal;

        WMSBillingManagement: Codeunit "WMS Billing Management";
        RateToUse: Decimal;
        AdditionalStorageCharge: Decimal;
        ChargeablePallets: Decimal;

    trigger OnInitReport()
    var
    begin
        StartDate := CalcDate('<-1M>', WorkDate());
        EndDate := CalcDate('<-1D>', WorkDate());
    end;

    trigger OnPreReport()
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
        DaysInPeriod := EndDate - StartDate;
        CompanyInformation.Get();
    end;

    local procedure GetItemQtyPerPallet(ItemNo: Code[20]; BaseUnitofMeasureCode: Code[10]; CustomerCBM: Decimal): Decimal
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        if not ItemUnitofMeasure.Get(ItemNo, BaseUnitofMeasureCode) then
            Error('The item unit of measure record not found. Item No. %1. Unit of Measure Code: %2.', ItemNo, BaseUnitofMeasureCode);
        if ItemUnitofMeasure.Cubage = 0 then
            Error('The Cubage value must not be blank in Item Unit of Measure table. Item No. %1. Unit of Measure Code: %2.', ItemNo, BaseUnitofMeasureCode);
        // exit(CustomerCBM / ItemUnitofMeasure.Cubage) Comment By FA 08112022
        exit(CustomerCBM / (ItemUnitofMeasure.Cubage / 1000000))//Added By FA
    end;


    local procedure CalculateOpeningStock(CustomerNo: Code[20]; ItemStorageConditionCode: Code[20]; PerDayRate: Decimal; CustomerCBM: Decimal; StockDate: Date; ItemNo: Code[20])
    var
        Item: Record Item;
        Item2: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        TotalQty: Decimal;
        TotalQty_2: Decimal;
        TotalPalletCount_Actual_2: Decimal;
        TotalPalletCount_Round_2: Decimal;
        TotalPalletCount_Actual: Decimal;
        TotalPalletCount_Round: Decimal;
        ItemQtyPerPallet: Decimal;
    begin
        Item.SetRange("Customer Code", CustomerNo);
        Item.SetRange(Type, Item.Type::Inventory);
        Item.SetRange(Blocked, false);
        Item.SetRange("Storage Condition Code", ItemStorageConditionCode);
        Item.SetRange("No.", ItemNo);
        Item.SetRange("Rent Pallet/Day", PerDayRate);
        // Item.CalcFields(Inventory);
        // Item.SetFilter(Inventory, '<>0');
        Item.CalcFields("Purchase Exist");
        Item.SetRange("Purchase Exist", true);
        if Item.FindSet() then
            repeat
                ItemQtyPerPallet := GetItemQtyPerPallet(Item."No.", Item."Base Unit of Measure", CustomerCBM);
                ItemLedgerEntry.SetRange("Item No.", Item."No.");
                // ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
                // ItemLedgerEntry.SetFilter("Posting Date", '..%1', ClosingDate(StartDate));
                ItemLedgerEntry.SetFilter("Posting Date", ' <%1', StockDate);
                ItemLedgerEntry.CalcSums(Quantity);
                TotalQty += ItemLedgerEntry.Quantity;
                TotalPalletCount_Actual += ItemLedgerEntry.Quantity / ItemQtyPerPallet;
                TotalPalletCount_Round += Round(ItemLedgerEntry.Quantity / ItemQtyPerPallet, 1, '>');
            until Item.Next() = 0;
        if TotalQty > 0 then begin
            // OpeningStock_UOM := TotalQty; FA 15012022
            OpeningStock_UOM := TotalQty;
            OpeningStock_Actual_Pallet := TotalPalletCount_Actual;
            OpeningStock_Round_Pallet := TotalPalletCount_Round;
        end else begin
            // OpeningStock_UOM := 0; FA 15012022
            OpeningStock_UOM := 0;
            OpeningStock_Actual_Pallet := 0;
            OpeningStock_Round_Pallet := 0;
        end;



        //For Closing Stock Added By FA
        Item2.SetRange("Customer Code", CustomerNo);
        Item2.SetRange(Type, Item.Type::Inventory);
        Item2.SetRange(Blocked, false);
        Item2.SetRange("Storage Condition Code", ItemStorageConditionCode);
        Item2.SetRange("No.", ItemNo);
        Item2.SetRange("Rent Pallet/Day", PerDayRate);
        // Item2.CalcFields(Inventory);
        // Item2.SetFilter(Inventory, '<>0');
        Item2.CalcFields("Purchase Exist");
        Item2.SetRange("Purchase Exist", true);
        if Item2.FindSet() then
            repeat
                ItemQtyPerPallet := GetItemQtyPerPallet(Item2."No.", Item2."Base Unit of Measure", CustomerCBM);
                ItemLedgerEntry2.Reset();
                ItemLedgerEntry2.SetRange("Item No.", Item2."No.");
                // ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
                // ItemLedgerEntry.SetFilter("Posting Date", '..%1', ClosingDate(StartDate));
                ItemLedgerEntry2.SetFilter("Posting Date", ' <=%1', StockDate);
                ItemLedgerEntry2.CalcSums(Quantity);
                TotalQty_2 += ItemLedgerEntry2.Quantity;
                TotalPalletCount_Actual_2 += ItemLedgerEntry2.Quantity / ItemQtyPerPallet;
                TotalPalletCount_Round_2 += Round(ItemLedgerEntry2.Quantity / ItemQtyPerPallet, 1, '>');
            until Item2.Next() = 0;
        if TotalQty_2 > 0 then begin
            // OpeningStock_UOM := TotalQty; FA 15012022
            OpeningStock_UOM_2 := TotalQty_2;
            OpeningStock_Actual_Pallet_2 := TotalPalletCount_Actual_2;
            OpeningStock_Round_Pallet_2 := TotalPalletCount_Round_2;
        end else begin
            // OpeningStock_UOM := 0; FA 15012022
            OpeningStock_UOM_2 := 0;
            OpeningStock_Actual_Pallet_2 := 0;
            OpeningStock_Round_Pallet_2 := 0;
        end;
        PerDayStock_UOM := OpeningStock_UOM_2;
        PerDayStock_Actual_Pallet := OpeningStock_Actual_Pallet_2;
        PerDayStock_Round_Pallet := OpeningStock_Round_Pallet_2;
    end;

    local procedure ResetGlobalDecimals()
    begin
        GoodsIn_UOM := 0;
        GoodsOut_UOM := 0;
        GoodsInOut_UOM := 0;
        GoodsIn_Actual_Pallet := 0;
        GoodsOut_Actual_Pallet := 0;
        GoodsInOut_Actual_Pallet := 0;
        GoodsIn_Round_Pallet := 0;
        GoodsOut_Round_Pallet := 0;
        GoodsInOut_Round_Pallet := 0;
        OpeningStock_UOM := 0;
        OpeningStock_UOM_2 := 0;
        OpeningStock_Actual_Pallet_2 := 0;
        OpeningStock_Round_Pallet_2 := 0;
        ClosingStock_UOM := 0;
        OpeningStock_Actual_Pallet := 0;
        ClosingStock_Actual_Pallet := 0;
        OpeningStock_Round_Pallet := 0;
        ClosingStock_Round_Pallet := 0;
        PerDayStock_UOM := 0;
        PerDayStock_Actual_Pallet := 0;
        PerDayStock_Round_Pallet := 0;
        ChargesAmount := 0;
        VATAmount := 0;
        NetAmount := 0;
        //Adding New Variables by FA
        length := 0;
        width := 0;
        height := 0;
        cbm := 0;
        cpm := 0;
        cpr := 0;
    end;

    procedure CalculateBaseunitofMeasure(ItemCode: Code[30]; CustomerCBMDec: Decimal)
    var
        myInt: Integer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        ItemUnitofMeasure.Reset();
        ItemUnitofMeasure.SetRange("Item No.", ItemCode);
        if ItemUnitofMeasure.FindSet() then begin
            length := ItemUnitofMeasure.Length;
            width := ItemUnitofMeasure.Width;
            height := ItemUnitofMeasure.Height;
            cbm := ItemUnitofMeasure.Cubage / 1000000;
            cpm := CustomerCBMDec / cbm;
            cpr := Round(cpm, 1, '>');
        end

    end;
}
