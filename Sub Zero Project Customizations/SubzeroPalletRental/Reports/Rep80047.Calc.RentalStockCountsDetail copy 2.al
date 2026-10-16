// report 80047 "Calc.RentalStockCountsDetail"
// {
//     Caption = 'Calculate Rental Stock Counts Detail';
//     ProcessingOnly = true;
//     UseRequestPage = true;

//     dataset
//     {
//         dataitem(DaysLoop; Integer)
//         {
//             DataItemTableView = sorting(Number) order(ascending);

//             dataitem(Customer; Customer)
//             {
//                 RequestFilterFields = "No.";

//                 dataitem("Storage Condition"; "Storage Condition")
//                 {
//                     DataItemTableView =
//                         sorting(Code)
//                         where("Use for Warehouse Rents" = const(true));

//                     RequestFilterFields = Code;

//                     dataitem(Item; Item)
//                     {
//                         DataItemTableView =
//                             sorting("Rent Pallet/Day")
//                             order(ascending)
//                             where(
//                                 Type = const(Inventory),
//                                 Blocked = const(false),
//                                 "Storage Condition Code" = filter(<> '')
//                             );

//                         DataItemLink =
//                             "Storage Condition Code" = field(Code);

//                         RequestFilterFields = "No.";

//                         trigger OnPreDataItem()
//                         begin
//                             SetRange("Customer Code", Customer."No.");
//                         end;

//                         trigger OnAfterGetRecord()
//                         var
//                             ItemQtyPerPallet: Decimal;
//                         begin
//                             ResetGlobalDecimals();

//                             Item.TestField("Base Unit of Measure");
//                             Item.TestField("Base UOM Per Pallet");

//                             ItemQtyPerPallet := Item."Base UOM Per Pallet";

//                             if ItemQtyPerPallet = 0 then
//                                 Error(
//                                     'Base UOM Per Pallet must be greater than zero for Item %1.',
//                                     Item."No.");

//                             GetOpeningQuantity(Item."No.");

//                             CalculateDailyMovements(
//                                 Item."No.",
//                                 ItemQtyPerPallet);

//                             CalculatePalletQuantities(ItemQtyPerPallet);

//                             GetStorageRate(
//                                 Customer."No.",
//                                 Item."Storage Condition Code");

//                             Item.CalcFields("Purchase Exist");

//                             if not Item."Purchase Exist" then
//                                 CurrReport.Skip();

//                             InsertDailyWarehouseRentLineDetail(
//                                 Customer."No.",
//                                 "Storage Condition".Code,
//                                 Item."No.",
//                                 Item.Description,
//                                 Customer.Name);

//                             UpdateRunningQuantity(Item."No.");
//                         end;
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         PerDayRate := 0;
//                     end;
//                 }
//             }

//             trigger OnPreDataItem()
//             begin
//                 SetRange(Number, 0, DaysInPeriod);
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 AsOnDate := StartDate + Number;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(Content)
//             {
//                 group(General)
//                 {
//                     field(StartDate; StartDate)
//                     {
//                         Caption = 'Start Date';
//                         ApplicationArea = All;
//                     }

//                     field(EndDate; EndDate)
//                     {
//                         Caption = 'End Date';
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }
//     }

//     var
//         StartDate: Date;
//         EndDate: Date;
//         AsOnDate: Date;
//         DaysInPeriod: Integer;

//         PerDayRate: Decimal;

//         GoodsIn_UOM: Decimal;
//         GoodsOut_UOM: Decimal;
//         GoodsInOut_UOM: Decimal;

//         GoodsIn_Actual_Pallet: Decimal;
//         GoodsOut_Actual_Pallet: Decimal;
//         GoodsInOut_Actual_Pallet: Decimal;

//         GoodsIn_Round_Pallet: Decimal;
//         GoodsOut_Round_Pallet: Decimal;
//         GoodsInOut_Round_Pallet: Decimal;

//         OpeningQty_UOM: Decimal;
//         TotalOccupancyPallets: Decimal;
//         BalancePallets: Decimal;
//         ChargeablePallets: Decimal;
//         TotalDaysInaMonth: Decimal;

//         StorageRates: Record "Storage Condition_Customer";
//         MonthlyFeeCharged: Dictionary of [Text, Boolean];
//         FixedChargeCharged: Dictionary of [Text, Boolean];

//         RunningItemQuantity: Dictionary of [Code[20], Decimal];
//         FixedLocPool: Dictionary of [Text, Decimal];

//     trigger OnInitReport()
//     var
//         DailyRentalStock: Record "Daily Rental Stock Detail";
//     begin
//         DailyRentalStock.SetCurrentKey("Posting Date");
//         DailyRentalStock.SetAscending("Posting Date", true);

//         if DailyRentalStock.FindLast() then begin
//             StartDate := DailyRentalStock."Posting Date" + 1;
//             EndDate := WorkDate() - 1;
//         end;
//     end;

//     trigger OnPreReport()
//     begin
//         ValidateRequestDates();

//         DaysInPeriod := EndDate - StartDate;

//         Clear(RunningItemQuantity);
//         Clear(MonthlyFeeCharged);
//         Clear(FixedChargeCharged);
//         Clear(FixedLocPool);
//     end;

//     trigger OnPostReport()
//     begin
//         Message('Warehouse rental lines calculation completed.');
//     end;

//     procedure SetCustomer(var CustRec: Record Customer)
//     begin
//         Customer.SetView(CustRec.GetView());
//     end;

//     local procedure ValidateRequestDates()
//     begin
//         if StartDate = 0D then
//             Error('Start Date must not be blank.');

//         if EndDate = 0D then
//             Error('End Date must not be blank.');

//         if StartDate > EndDate then
//             Error('Start date must not be greater than end date.');

//         if StartDate >= WorkDate() then
//             Error(
//                 'Start Date must be less than %1.',
//                 WorkDate());

//         if EndDate >= WorkDate() then
//             Error(
//                 'End Date must be less than %1.',
//                 WorkDate());
//     end;

//     local procedure GetOpeningQuantity(ItemNo: Code[20])
//     var
//         OpeningItemLedgerEntry: Record "Item Ledger Entry";
//         CachedQuantity: Decimal;
//     begin
//         /*
//             On the first processing day, opening quantity is calculated from
//             Item Ledger Entry.

//             For subsequent days, the balance from the previous day is used.
//             This avoids recalculating the entire historical Item Ledger Entry
//             balance for every date.
//         */

//         if RunningItemQuantity.Get(ItemNo, CachedQuantity) then begin
//             OpeningQty_UOM := CachedQuantity;
//             exit;
//         end;

//         OpeningItemLedgerEntry.Reset();
//         OpeningItemLedgerEntry.SetRange("Item No.", ItemNo);
//         OpeningItemLedgerEntry.SetFilter(
//             "Posting Date",
//             '<%1',
//             StartDate);

//         OpeningItemLedgerEntry.CalcSums(Quantity);

//         OpeningQty_UOM := OpeningItemLedgerEntry.Quantity;

//         RunningItemQuantity.Add(
//             ItemNo,
//             OpeningQty_UOM);
//     end;

//     local procedure UpdateRunningQuantity(ItemNo: Code[20])
//     var
//         ClosingQuantity: Decimal;
//     begin
//         ClosingQuantity :=
//             OpeningQty_UOM +
//             GoodsIn_UOM -
//             GoodsOut_UOM -
//             GoodsInOut_UOM;

//         RunningItemQuantity.Set(
//             ItemNo,
//             ClosingQuantity);
//     end;

//     local procedure CalculateDailyMovements(
//         ItemNo: Code[20];
//         ItemQtyPerPallet: Decimal)
//     var
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         InboundLots: Dictionary of [Text, Boolean];
//         LotKey: Text;
//     begin
//         /*
//             First query:
//             Read all inbound entries and remember their lot numbers.

//             This replaces the previous pattern where outbound entries were
//             queried separately for every inbound entry.
//         */

//         ItemLedgerEntry.Reset();
//         ItemLedgerEntry.SetRange("Item No.", ItemNo);
//         ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
//         ItemLedgerEntry.SetFilter(
//             "Entry Type",
//             '%1|%2',
//             ItemLedgerEntry."Entry Type"::Purchase,
//             ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
//         ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');

//         if ItemLedgerEntry.FindSet() then
//             repeat
//                 QtyAddToInbound(ItemLedgerEntry.Quantity);

//                 LotKey := ItemLedgerEntry."Lot No.";

//                 if not InboundLots.ContainsKey(LotKey) then
//                     InboundLots.Add(LotKey, true);
//             until ItemLedgerEntry.Next() = 0;

//         /*
//             Second query:
//             Read all outbound entries once.

//             If an outbound lot was received on the same day, it is classified
//             as Same Day In-Out. Otherwise, it is classified as Goods Out.
//         */

//         ItemLedgerEntry.Reset();
//         ItemLedgerEntry.SetRange("Item No.", ItemNo);
//         ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
//         ItemLedgerEntry.SetFilter(
//             "Entry Type",
//             '%1|%2',
//             ItemLedgerEntry."Entry Type"::Sale,
//             ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
//         ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');

//         if ItemLedgerEntry.FindSet() then
//             repeat
//                 LotKey := ItemLedgerEntry."Lot No.";

//                 if InboundLots.ContainsKey(LotKey) then
//                     GoodsInOut_UOM += ItemLedgerEntry.Quantity * -1
//                 else
//                     GoodsOut_UOM += ItemLedgerEntry.Quantity * -1;
//             until ItemLedgerEntry.Next() = 0;

//         /*
//             GoodsIn_UOM contains all positive inbound quantities.

//             Same-day outbound quantity is reported separately but the full
//             incoming quantity remains included in Goods In, matching the
//             existing report behavior.
//         */
//     end;

//     local procedure QtyAddToInbound(Quantity: Decimal)
//     begin
//         GoodsIn_UOM += Quantity;
//     end;

//     local procedure CalculatePalletQuantities(
//         ItemQtyPerPallet: Decimal)
//     begin
//         GoodsIn_Actual_Pallet :=
//             GoodsIn_UOM / ItemQtyPerPallet;

//         GoodsIn_Round_Pallet :=
//             Round(
//                 GoodsIn_Actual_Pallet,
//                 1,
//                 '>');

//         GoodsOut_Actual_Pallet :=
//             GoodsOut_UOM / ItemQtyPerPallet;

//         GoodsOut_Round_Pallet :=
//             Round(
//                 GoodsOut_Actual_Pallet,
//                 1,
//                 '>');

//         GoodsInOut_Actual_Pallet :=
//             GoodsInOut_UOM / ItemQtyPerPallet;

//         GoodsInOut_Round_Pallet :=
//             Round(
//                 GoodsInOut_Actual_Pallet,
//                 1,
//                 '>');

//         /*
//             Goods received today are chargeable today.

//             Goods shipped today remain part of today's occupancy.
//             The outbound quantity reduces tomorrow's opening quantity.
//         */

//         TotalOccupancyPallets :=
//             Round(
//                 (OpeningQty_UOM + GoodsIn_UOM) /
//                 ItemQtyPerPallet,
//                 1,
//                 '>');

//         BalancePallets :=
//             Round(
//                 (
//                     OpeningQty_UOM +
//                     GoodsIn_UOM -
//                     GoodsOut_UOM -
//                     GoodsInOut_UOM
//                 ) /
//                 ItemQtyPerPallet,
//                 1,
//                 '>');

//         if BalancePallets < 0 then
//             BalancePallets := 0;
//     end;

//     local procedure GetStorageRate(
//         CustomerNo: Code[20];
//         StorageConditionCode: Code[20])
//     begin
//         PerDayRate := 0;

//         StorageRates.Reset();
//         StorageRates.SetRange("Customer No.", CustomerNo);
//         StorageRates.SetRange("Code", StorageConditionCode);

//         if StorageRates.FindFirst() then
//             PerDayRate := StorageRates."Rent Pallet/Day";
//     end;

//     local procedure ResetGlobalDecimals()
//     begin
//         GoodsIn_UOM := 0;
//         GoodsOut_UOM := 0;
//         GoodsInOut_UOM := 0;

//         GoodsIn_Actual_Pallet := 0;
//         GoodsOut_Actual_Pallet := 0;
//         GoodsInOut_Actual_Pallet := 0;

//         GoodsIn_Round_Pallet := 0;
//         GoodsOut_Round_Pallet := 0;
//         GoodsInOut_Round_Pallet := 0;

//         OpeningQty_UOM := 0;
//         TotalOccupancyPallets := 0;
//         BalancePallets := 0;
//         ChargeablePallets := 0;
//         TotalDaysInaMonth := 0;
//         PerDayRate := 0;
//     end;

//     local procedure InsertDailyWarehouseRentLineDetail(
//         CustomerNo: Code[20];
//         ItemStorageConditionCode: Code[20];
//         ItemNo: Code[20];
//         ItemName: Text[100];
//         CustomerName: Text[100])
//     var
//         DailyRentalStockDetail: Record "Daily Rental Stock Detail";
//         InboundILE: Record "Item Ledger Entry";
//         WMSBillingManagement: Codeunit "WMS Billing Management";
//         ItemQtyPerPallet: Decimal;
//         ItemRec: Record Item;
//         MinimumBillablePallets: Decimal;
//         MinimumStorageEndDate: Date;
//     begin
//         DailyRentalStockDetail.Init();

//         DailyRentalStockDetail."Posting Date" := AsOnDate;
//         DailyRentalStockDetail."Customer Code" := CustomerNo;
//         DailyRentalStockDetail."Customer Name" := CustomerName;
//         DailyRentalStockDetail."Storage Condition" :=
//             ItemStorageConditionCode;
//         DailyRentalStockDetail."Per Day Rate" := PerDayRate;
//         DailyRentalStockDetail."Item Code" := ItemNo;
//         DailyRentalStockDetail."Item Name" := ItemName;

//         DailyRentalStockDetail."Goods In (UOM)" :=
//             GoodsIn_UOM;

//         DailyRentalStockDetail."Goods Out (UOM)" :=
//             GoodsOut_UOM;

//         DailyRentalStockDetail."Same Day In-Out (UOM)" :=
//             GoodsInOut_UOM;

//         DailyRentalStockDetail."Goods In (Actual-Pallet)" :=
//             GoodsIn_Actual_Pallet;

//         DailyRentalStockDetail."Goods In (Round-Pallet)" :=
//             GoodsIn_Round_Pallet;

//         DailyRentalStockDetail."Goods Out (Actual-Pallet)" :=
//             GoodsOut_Actual_Pallet;

//         DailyRentalStockDetail."Goods Out (Round-Pallet)" :=
//             GoodsOut_Round_Pallet;

//         DailyRentalStockDetail."Same Day In-Out (Act.-Pallet)" :=
//             GoodsInOut_Actual_Pallet;

//         DailyRentalStockDetail."Same Day In-Out (Round-Pallet)" :=
//             GoodsInOut_Round_Pallet;

//         Clear(InboundILE);

//         if WMSBillingManagement.GetLatestInboundTerms(
//             ItemNo,
//             AsOnDate,
//             InboundILE)
//         then
//             WMSBillingManagement.CopyTermsToDailyRental(
//                 DailyRentalStockDetail,
//                 Customer,
//                 InboundILE);

//         // if GoodsIn_UOM <> 0 then begin
//         //     TotalDaysInaMonth := GetDaysInMonth(AsOnDate);

//         //     DailyRentalStockDetail."WMS Fixed Monthly Charge" :=
//         //         Round(
//         //             (Customer."WMS Fixed Monthly Charge" / 30) *
//         //             TotalDaysInaMonth,
//         //             0.01,
//         //             '=');

//         //     DailyRentalStockDetail."WMS Management Fee" :=
//         //         Customer."WMS Management Fee";
//         // end;

//         DailyRentalStockDetail."WMS Total Occupancy Pallets" :=
//             TotalOccupancyPallets;

//         DailyRentalStockDetail."WMS Balance Pallets" :=
//             BalancePallets;

//         CalculateChargeablePallets(
//             DailyRentalStockDetail,
//             InboundILE,
//             ItemNo,
//             ItemRec,
//             ItemQtyPerPallet,
//             MinimumBillablePallets,
//             MinimumStorageEndDate);

//         ApplyMonthlyCharges(DailyRentalStockDetail, CustomerNo);

//         CalculateAdditionalCharges(
//             DailyRentalStockDetail,
//             InboundILE);

//         DailyRentalStockDetail."WMS Chargeable Pallets" :=
//             ChargeablePallets;

//         MarkMonthlyChargesApplied(DailyRentalStockDetail, CustomerNo);

//         if IsEmptyRentalLine() then
//             exit;

//         DailyRentalStockDetail.Insert();
//     end;

//     local procedure CalculateChargeablePallets(
//         var DailyRentalStockDetail: Record "Daily Rental Stock Detail";
//         InboundILE: Record "Item Ledger Entry";
//         ItemNo: Code[20];
//         var ItemRec: Record Item;
//         var ItemQtyPerPallet: Decimal;
//         var MinimumBillablePallets: Decimal;
//         var MinimumStorageEndDate: Date)
//     begin
//         ChargeablePallets := 0;

//         // case DailyRentalStockDetail."WMS Billing Type" of
//         //     DailyRentalStockDetail."WMS Billing Type"::"Fixed Location":
//         //         begin
//         //             ChargeablePallets :=
//         //                 TotalOccupancyPallets -
//         //                 DailyRentalStockDetail."WMS Allocated Pallets";

//         //             if ChargeablePallets < 0 then
//         //                 ChargeablePallets := 0;
//         //         end;
//         case DailyRentalStockDetail."WMS Billing Type" of
//             DailyRentalStockDetail."WMS Billing Type"::"Fixed Location":
//                 begin
//                     ChargeablePallets := ConsumeFixedLocationPool(Customer."No.", DailyRentalStockDetail."WMS Allocated Pallets");
//                 end;

//             DailyRentalStockDetail."WMS Billing Type"::Normal,
//                     DailyRentalStockDetail."WMS Billing Type"::"Fixed Days":
//                 begin
//                     ChargeablePallets := TotalOccupancyPallets;

//                     if InboundILE."Entry No." = 0 then
//                         exit;

//                     if not ItemRec.Get(ItemNo) then
//                         exit;

//                     ItemRec.TestField("Base Unit of Measure");
//                     ItemRec.TestField("Base UOM Per Pallet");

//                     ItemQtyPerPallet :=
//                         ItemRec."Base UOM Per Pallet";

//                     MinimumBillablePallets :=
//                         Round(
//                             InboundILE.Quantity /
//                             ItemQtyPerPallet,
//                             1,
//                             '>');

//                     MinimumStorageEndDate :=
//                         InboundILE."Posting Date" +
//                         DailyRentalStockDetail."WMS Minimum Storage Days" -
//                         1;

//                     if AsOnDate <= MinimumStorageEndDate then
//                         if MinimumBillablePallets > ChargeablePallets then
//                             ChargeablePallets :=
//                                 MinimumBillablePallets;
//                 end;
//         end;
//     end;

//     local procedure CalculateAdditionalCharges(
//         var DailyRentalStockDetail: Record "Daily Rental Stock Detail";
//         InboundILE: Record "Item Ledger Entry")
//     begin
//         if GoodsIn_UOM <> 0 then begin
//             DailyRentalStockDetail."Over Time" :=
//                 InboundILE."WMS Over time";

//             DailyRentalStockDetail."Plug In" :=
//                 InboundILE."WMS Plug In";

//             DailyRentalStockDetail."DM Inspection" :=
//                 InboundILE."WMS DM Inspection";

//             if InboundILE."Container Type" =
//                InboundILE."Container Type"::"Loose Pallet"
//             then
//                 DailyRentalStockDetail."Handling Charges" :=
//                     GetContainerCharges(
//                         InboundILE."Container Type",
//                         Customer."No.") *
//                     GoodsIn_Round_Pallet
//             else
//                 DailyRentalStockDetail."Handling Charges" :=
//                     GetContainerCharges(
//                         InboundILE."Container Type",
//                         Customer."No.");

//             DailyRentalStockDetail."Total Charges" :=
//                 Customer."WMS Management Fee" +
//                 DailyRentalStockDetail."WMS Fixed Monthly Charge" +
//                 (PerDayRate * ChargeablePallets) +
//                 InboundILE."WMS Over time" +
//                 InboundILE."WMS Plug In" +
//                 InboundILE."WMS DM Inspection" +
//                 DailyRentalStockDetail."Handling Charges";
//         end else
//             DailyRentalStockDetail."Total Charges" :=
//                 PerDayRate * ChargeablePallets;
//     end;

//     local procedure IsEmptyRentalLine(): Boolean
//     begin
//         exit(
//             (TotalOccupancyPallets = 0) and
//             (BalancePallets = 0) and
//             (ChargeablePallets = 0) and
//             (GoodsIn_UOM = 0) and
//             (GoodsOut_UOM = 0) and
//             (GoodsInOut_UOM = 0));
//     end;

//     local procedure GetDaysInMonth(DateValue: Date): Integer
//     begin
//         exit(
//             Date2DMY(
//                 CalcDate('<CM>', DateValue),
//                 1));
//     end;

//     procedure GetContainerCharges(
//         ContainerTypeValue: Enum containerType;
//         CustomerNo: Code[20]): Decimal
//     var
//         CustomerStorageCharges: Record Charges;
//     begin
//         CustomerStorageCharges.Reset();
//         CustomerStorageCharges.SetRange(
//             Code,
//             Format(ContainerTypeValue));

//         CustomerStorageCharges.SetRange(
//             "Customer No.",
//             CustomerNo);

//         if CustomerStorageCharges.FindFirst() then
//             exit(CustomerStorageCharges.Amount);

//         exit(0);
//     end;

//     local procedure ApplyMonthlyCharges(
//     var DailyRentalStockDetail: Record "Daily Rental Stock Detail";
//     CustomerNo: Code[20])
//     begin
//         // Management fee: once per customer per month
//         if Customer."WMS Management Fee" <> 0 then
//             if not IsMonthlyChargeApplied(CustomerNo, MonthlyFeeCharged, true) then begin
//                 TotalDaysInaMonth := GetDaysInMonth(AsOnDate);
//                 DailyRentalStockDetail."WMS Management Fee" := Round((Customer."WMS Management Fee" / 30) * TotalDaysInaMonth, 0.01, '=');
//                 //         Round(
//                 //             (Customer."WMS Fixed Monthly Charge" / 30) *
//                 //             TotalDaysInaMonth,
//                 //             0.01,
//                 //             '=');
//             end;

//         // Fixed monthly charge: Fixed Location only, when at least 1 pallet exists
//         if (DailyRentalStockDetail."WMS Billing Type" = DailyRentalStockDetail."WMS Billing Type"::"Fixed Location") and
//            (TotalOccupancyPallets >= 1) and
//            (Customer."WMS Fixed Monthly Charge" <> 0)
//         then
//             if not IsMonthlyChargeApplied(CustomerNo, FixedChargeCharged, false) then
//                 DailyRentalStockDetail."WMS Fixed Monthly Charge" := Customer."WMS Fixed Monthly Charge";
//     end;

//     local procedure IsMonthlyChargeApplied(
//         CustomerNo: Code[20];
//         var ChargeCache: Dictionary of [Text, Boolean];
//         IsManagementFee: Boolean): Boolean
//     var
//         DailyRentalStockDetail: Record "Daily Rental Stock Detail";
//         MonthKey: Text;
//     begin
//         MonthKey := GetMonthKey(CustomerNo);

//         if ChargeCache.ContainsKey(MonthKey) then
//             exit(true);

//         // Check lines saved in previous runs
//         DailyRentalStockDetail.SetRange("Customer Code", CustomerNo);
//         DailyRentalStockDetail.SetRange(
//             "Posting Date",
//             CalcDate('<-CM>', AsOnDate),
//             CalcDate('<CM>', AsOnDate));

//         if IsManagementFee then
//             DailyRentalStockDetail.SetFilter("WMS Management Fee", '<>0')
//         else
//             DailyRentalStockDetail.SetFilter("WMS Fixed Monthly Charge", '<>0');

//         if not DailyRentalStockDetail.IsEmpty() then begin
//             ChargeCache.Add(MonthKey, true);
//             exit(true);
//         end;

//         exit(false);
//     end;

//     local procedure MarkMonthlyChargesApplied(
//         DailyRentalStockDetail: Record "Daily Rental Stock Detail";
//         CustomerNo: Code[20])
//     var
//         MonthKey: Text;
//     begin
//         MonthKey := GetMonthKey(CustomerNo);

//         if DailyRentalStockDetail."WMS Management Fee" <> 0 then
//             if not MonthlyFeeCharged.ContainsKey(MonthKey) then
//                 MonthlyFeeCharged.Add(MonthKey, true);

//         if DailyRentalStockDetail."WMS Fixed Monthly Charge" <> 0 then
//             if not FixedChargeCharged.ContainsKey(MonthKey) then
//                 FixedChargeCharged.Add(MonthKey, true);
//     end;

//     local procedure GetMonthKey(CustomerNo: Code[20]): Text
//     begin
//         exit(CustomerNo + '|' + Format(CalcDate('<-CM>', AsOnDate), 0, '<Year4><Month,2>'));
//     end;

//     local procedure ConsumeFixedLocationPool(
//     CustomerNo: Code[20];
//     AllocatedPallets: Decimal): Decimal
//     var
//         PoolKey: Text;
//         RemainingPallets: Decimal;
//         Chargeable: Decimal;
//     begin
//         PoolKey := CustomerNo + '|' + Format(AsOnDate, 0, '<Year4><Month,2><Day,2>');

//         // The first item of the day for this customer opens the pool
//         if not FixedLocPool.Get(PoolKey, RemainingPallets) then
//             RemainingPallets := AllocatedPallets;

//         if TotalOccupancyPallets <= RemainingPallets then begin
//             Chargeable := 0;
//             RemainingPallets -= TotalOccupancyPallets;
//         end else begin
//             Chargeable := TotalOccupancyPallets - RemainingPallets;
//             RemainingPallets := 0;
//         end;

//         FixedLocPool.Set(PoolKey, RemainingPallets);
//         exit(Chargeable);
//     end;
// }