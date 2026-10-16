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
//                 DataItemTableView = sorting("No.") order(ascending) where("WMS Billing Type" = filter(<> ' '));


//                 dataitem("Storage Condition"; "Storage Condition")
//                 {
//                     DataItemTableView = sorting(Code) where("Use for Warehouse Rents" = const(true));
//                     RequestFilterFields = Code;
//                     dataitem(Item; "Item")
//                     {

//                         DataItemTableView = sorting("Rent Pallet/Day") order(ascending) where(Type = const(Inventory), Blocked = const(false), "Storage Condition Code" = filter(<> ''));
//                         DataItemLink = "Storage Condition Code" = field(Code);
//                         RequestFilterFields = "No.";
//                         trigger OnPreDataItem() //Item
//                         begin
//                             // Item.CalcFields("Customer Code");
//                             SetRange("Customer Code", Customer."No.");
//                         end;

//                         trigger OnAfterGetRecord() //Item
//                         var
//                             ItemLedgerEntry: Record "Item Ledger Entry";
//                             ItemLedgerEntry2: Record "Item Ledger Entry";
//                             // ItemCBM: Decimal;
//                             ItemQtyPerPallet: Decimal;
//                             QtyIn_UOM: Decimal;
//                             QtyOut_UOM: Decimal;
//                             QtyInOut_UOM: Decimal;
//                             WMSBillingManagement: Codeunit "WMS Billing Management";
//                             OpeningItemLedgerEntry: Record "Item Ledger Entry";

//                             MinimumBillablePallets: Decimal;

//                             MinimumStorageEndDate: Date;

//                         begin
//                             // if "Storage Condtion Code" = '' then
//                             //     CurrReport.Skip();

//                             Item.TestField("Base Unit of Measure");
//                             Item.TestField("Base UOM Per Pallet");
//                             ItemQtyPerPallet := item."Base UOM Per Pallet";
//                             if ItemQtyPerPallet = 0 then
//                                 Error(
//                                 'Base UOM Per Pallet must be greater than zero for Item %1.',
//                                 Item."No.");
//                             // Stock available before the current posting date.
//                             OpeningItemLedgerEntry.Reset();
//                             OpeningItemLedgerEntry.SetRange("Item No.", Item."No.");
//                             OpeningItemLedgerEntry.SetFilter("Posting Date", '<%1', AsOnDate);
//                             OpeningItemLedgerEntry.CalcSums(Quantity);

//                             OpeningQty_UOM := OpeningItemLedgerEntry.Quantity;

//                             //ItemQtyPerPallet := 1;
//                             //Entry In start
//                             ItemLedgerEntry.SetRange("Item No.", Item."No.");
//                             ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
//                             ItemLedgerEntry.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::Purchase, ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
//                             ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');
//                             //ItemLedgerEntry.SetFilter("WMS Billing Type", '<>%1', ItemLedgerEntry."WMS Billing Type"::" ");
//                             if ItemLedgerEntry.FindSet() then
//                                 repeat
//                                     ItemLedgerEntry2.Reset();
//                                     ItemLedgerEntry2.SetRange("Item No.", Item."No.");
//                                     ItemLedgerEntry2.SetRange("Posting Date", AsOnDate);
//                                     ItemLedgerEntry2.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::Sale, ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
//                                     ItemLedgerEntry2.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
//                                     //ItemLedgerEntry2.SetFilter("WMS Billing Type", '<>%1', ItemLedgerEntry2."WMS Billing Type"::" ");
//                                     ItemLedgerEntry2.CalcSums(Quantity);
//                                     QtyInOut_UOM += (ItemLedgerEntry2.Quantity * -1);
//                                     // QtyIn_UOM += ItemLedgerEntry.Quantity - (ItemLedgerEntry2.Quantity * -1);
//                                     QtyIn_UOM += ItemLedgerEntry.Quantity;
//                                 until ItemLedgerEntry.Next() = 0;
//                             //Entry In End

//                             //Entry Out start
//                             ItemLedgerEntry.Reset();
//                             ItemLedgerEntry.SetRange("Item No.", Item."No.");
//                             ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
//                             ItemLedgerEntry.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry2."Entry Type"::Sale, ItemLedgerEntry2."Entry Type"::"Negative Adjmt.");
//                             ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');
//                             //ItemLedgerEntry.SetFilter("WMS Billing Type", '<>%1', ItemLedgerEntry."WMS Billing Type"::" ");
//                             if ItemLedgerEntry.FindSet() then
//                                 repeat
//                                     ItemLedgerEntry2.Reset();
//                                     ItemLedgerEntry2.SetRange("Item No.", Item."No.");
//                                     ItemLedgerEntry2.SetRange("Posting Date", AsOnDate);
//                                     ItemLedgerEntry2.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry2."Entry Type"::Purchase, ItemLedgerEntry2."Entry Type"::"Positive Adjmt.");
//                                     ItemLedgerEntry2.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
//                                     //ItemLedgerEntry2.SetFilter("WMS Billing Type", '<>%1', ItemLedgerEntry2."WMS Billing Type"::" ");


//                                     if not ItemLedgerEntry2.FindFirst() then
//                                         // ItemLedgerEntry2.CalcSums(Quantity);
//                                         QtyOut_UOM += (ItemLedgerEntry.Quantity * -1);
//                                 until ItemLedgerEntry.Next() = 0;
//                             //Entry Out End

//                             GoodsIn_UOM += QtyIn_UOM;
//                             GoodsOut_UOM += QtyOut_UOM;
//                             GoodsInOut_UOM += QtyInOut_UOM;
//                             GoodsIn_Actual_Pallet += QtyIn_UOM / ItemQtyPerPallet;
//                             GoodsIn_Round_Pallet += Round(QtyIn_UOM / ItemQtyPerPallet, 1, '>');
//                             GoodsOut_Actual_Pallet += QtyOut_UOM / ItemQtyPerPallet;
//                             GoodsOut_Round_Pallet += Round(QtyOut_UOM / ItemQtyPerPallet, 1, '>');
//                             GoodsInOut_Actual_Pallet += QtyInOut_UOM / ItemQtyPerPallet;
//                             GoodsInOut_Round_Pallet += Round(QtyInOut_UOM / ItemQtyPerPallet, 1, '>');

//                             // Goods received today are charged today.
//                             // Goods shipped today remain chargeable today.
//                             // The shipment reduces the balance used from the next day.

//                             TotalOccupancyPallets :=
//                                 Round(
//                                     (OpeningQty_UOM + QtyIn_UOM) / ItemQtyPerPallet,
//                                     1,
//                                     '>');

//                             BalancePallets :=
//                                 Round(
//                                     (
//                                         OpeningQty_UOM +
//                                         QtyIn_UOM -
//                                         QtyOut_UOM -
//                                         QtyInOut_UOM
//                                     ) / ItemQtyPerPallet,
//                                     1,
//                                     '>');

//                             if BalancePallets < 0 then
//                                 BalancePallets := 0;

//                             storageRates.SetRange("Customer No.", Customer."No.");
//                             storageRates.SetRange("Code", Item."Storage Condition Code");
//                             if "Storage Condition".FindFirst() then begin
//                                 if storageRates.FindFirst() then begin
//                                     if storageRates."Rent Pallet/Day" <> 0 then
//                                         PerDayRate := storageRates."Rent Pallet/Day";
//                                 end;
//                             end;

//                             if PerDayRate = -1 then begin
//                                 PerDayRate := storageRates."Rent Pallet/Day";

//                             end
//                             else begin
//                                 // if Customer."WMS Storage Rate" <> PerDayRate then begin
//                                 //Added By FA 06122022
//                                 CalcFields("Purchase Exist");
//                                 if Item."Purchase Exist" = true then begin
//                                     // CalcFields(Inventory);
//                                     // if Item.Inventory > 0 then begin
//                                     PerDayRate := storageRates."Rent Pallet/Day";
//                                     InsertDailyWarehouseRentLineDetail(Customer."No.", "Storage Condition".Code, Item."No.", Item.Description, Customer.Name);
//                                     // InsertDailyWarehouseRentLine(Customer."No.", "Storage Condition".Code); Commented By FAz

//                                     ResetGlobalDecimals();
//                                     //end;
//                                 end

//                             end;

//                             // // CalcFields(Inventory);
//                             // //Added By FA 06122022
//                             // CalcFields("Purchase Exist");
//                             // if Item."Purchase Exist" = true then begin
//                             //     // if Item.Inventory > 0 then begin
//                             //     //Adding Values FAz
//                             //     //PerDayRate := Customer."WMS Storage Rate";
//                             //     PerDayRate := storageRates."Rent Pallet/Day";
//                             //     InsertDailyWarehouseRentLineDetail(Customer."No.", "Storage Condition".Code, Item."No.", Item.Description, Customer.Name);
//                             //     ResetGlobalDecimals();
//                             // end;


//                         end;

//                         trigger OnPostDataItem() //Item
//                         var
//                         begin
//                             // Message('Item Post');
//                             //XYZ
//                             // InsertDailyWarehouseRentLineDetail(Customer."No.", "Storage Condition".Code, Item."No.", Item.Description);

//                             // InsertDailyWarehouseRentLine(Customer."No.", "Storage Condition".Code);

//                         end;
//                     }
//                     trigger OnPreDataItem() //Item  "Storage Condition"
//                     begin

//                     end;

//                     trigger OnAfterGetRecord() //Item "Storage Condition"
//                     begin
//                         ResetGlobalDecimals();
//                         PerDayRate := -1;

//                     end;

//                     trigger OnPostdataItem()
//                     var
//                         myInt: Integer;
//                     begin
//                         // Message('Storage Condition');
//                     end;
//                 }
//                 trigger OnAfterGetRecord() //Customer
//                 begin
//                     //TestField("Customer CBM");
//                 end;

//                 trigger OnPostdataItem()
//                 var
//                     myInt: Integer;
//                 begin
//                     // Message('Customer Report');
//                 end;
//             }
//             trigger OnPreDataItem() //DaysLoop
//             begin
//                 SetRange(Number, 0, DaysInPeriod);
//             end;

//             trigger OnAfterGetRecord() //DaysLoop
//             var
//             begin
//                 if Number = 0 then begin
//                     AsOnDate := StartDate;
//                 end else begin
//                     AsOnDate := CalcDate(StrSubstNo('<>+%1D', Number), StartDate);
//                 end;
//             end;

//             trigger OnPostdataItem()
//             var
//                 myInt: Integer;
//             begin
//                 // Message('Days Loop Condition');
//             end;
//         }
//     }

//     requestpage
//     {

//         SaveValues = true;
//         layout
//         {
//             area(content)
//             {
//                 group(General)
//                 {
//                     field(StartDate;
//                     StartDate)
//                     {
//                         Caption = 'Start Date';
//                         ApplicationArea = all;
//                     }
//                     field(EndDate; EndDate)
//                     {
//                         Caption = 'End Date';
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     var
//         StartDate: Date;
//         EndDate: Date;
//         AsOnDate: Date;
//         DaysInPeriod: Integer;
//         PerDayRate: Decimal;
//         //CustomerCBM: Decimal;

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

//     trigger OnInitReport()
//     var
//         DailyRentalStock: Record "Daily Rental Stock Detail";
//     begin
//         DailyRentalStock.SetAscending("Posting Date", true);
//         if DailyRentalStock.FindLast() then begin
//             StartDate := CalcDate('<+1D>', DailyRentalStock."Posting Date");
//             EndDate := CalcDate('<-1D>', WorkDate());
//         end
//     end;

//     trigger OnPreReport()
//     begin
//         if StartDate = 0D then
//             Error('Start Date must not be blank.');
//         if EndDate = 0D then
//             Error('End Date must not be blank.');
//         if StartDate > EndDate then
//             Error('Start date must not be greater than end date.');
//         if StartDate >= WorkDate() then
//             Error('Start Date must be less than %1.', WorkDate());
//         if EndDate >= WorkDate() then
//             Error('End Date must be less than %1.', WorkDate());
//         DaysInPeriod := EndDate - StartDate;
//         // CustomerCBM := 1.6;
//     end;

//     trigger OnPostReport()
//     begin
//         Message('Warehouse rental lines calculation completed.');
//     end;

//     procedure SetCustomer(var CustRec: Record Customer)
//     begin
//         Customer.SetView(CustRec.GetView());
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

//     end;

//     // local procedure InsertDailyWarehouseRentLine(CustomerNo: Code[20]; ItemStorageCondtionCode: Code[20])
//     // var
//     //     DailyRentalStock: Record "Daily Rental Stock";
//     // begin
//     //     DailyRentalStock.Init();
//     //     DailyRentalStock."Posting Date" := AsOnDate;
//     //     DailyRentalStock."Customer Code" := CustomerNo;
//     //     // DailyRentalStock."Storage Condition" := ItemCategoyCode;
//     //     DailyRentalStock."Storage Condition" := ItemStorageCondtionCode;
//     //     DailyRentalStock."Per Day Rate" := PerDayRate;
//     //     DailyRentalStock."Goods In (UOM)" := GoodsIn_UOM;
//     //     DailyRentalStock."Goods Out (UOM)" := GoodsOut_UOM;
//     //     DailyRentalStock."Same Day In-Out (UOM)" := GoodsInOut_UOM;
//     //     DailyRentalStock."Goods In (Actual-Pallet)" := GoodsIn_Actual_Pallet;
//     //     DailyRentalStock."Goods In (Round-Pallet)" := GoodsIn_Round_Pallet;
//     //     DailyRentalStock."Goods Out (Actual-Pallet)" := GoodsOut_Actual_Pallet;
//     //     DailyRentalStock."Goods Out (Round-Pallet)" := GoodsOut_Round_Pallet;
//     //     DailyRentalStock."Same Day In-Out (Act.-Pallet)" := GoodsInOut_Actual_Pallet;
//     //     DailyRentalStock."Same Day In-Out (Round-Pallet)" := GoodsInOut_Round_Pallet;
//     //     if DailyRentalStock.Insert() then
//     //         DailyRentalStock.Modify();
//     // end;

//     local procedure InsertDailyWarehouseRentLineDetail(CustomerNo: Code[20];
//     ItemStorageCondtionCode: Code[20];
//     ItemNo: Code[20];
//     ItemName: Text[100];
//     CusName: Text[100])
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
//         DailyRentalStockDetail."Customer Name" := CusName;
//         // DailyRentalStock."Storage Condition" := ItemCategoyCode;
//         DailyRentalStockDetail."Storage Condition" := ItemStorageCondtionCode;
//         DailyRentalStockDetail."Per Day Rate" := PerDayRate;
//         DailyRentalStockDetail."Item Code" := ItemNo;
//         DailyRentalStockDetail."Item Name" := ItemName;
//         DailyRentalStockDetail."Goods In (UOM)" := GoodsIn_UOM;
//         DailyRentalStockDetail."Goods Out (UOM)" := GoodsOut_UOM;
//         DailyRentalStockDetail."Same Day In-Out (UOM)" := GoodsInOut_UOM;
//         DailyRentalStockDetail."Goods In (Actual-Pallet)" := GoodsIn_Actual_Pallet;
//         DailyRentalStockDetail."Goods In (Round-Pallet)" := GoodsIn_Round_Pallet;
//         DailyRentalStockDetail."Goods Out (Actual-Pallet)" := GoodsOut_Actual_Pallet;
//         DailyRentalStockDetail."Goods Out (Round-Pallet)" := GoodsOut_Round_Pallet;
//         DailyRentalStockDetail."Same Day In-Out (Act.-Pallet)" := GoodsInOut_Actual_Pallet;
//         DailyRentalStockDetail."Same Day In-Out (Round-Pallet)" := GoodsInOut_Round_Pallet;
//         if WMSBillingManagement.GetLatestInboundTerms(ItemNo, AsOnDate, InboundILE) then
//             WMSBillingManagement.CopyTermsToDailyRental(DailyRentalStockDetail, Customer, InboundILE);

//         if GoodsIn_UOM <> 0 then begin
//             TotalDaysInaMonth := GetDaysInMonth(AsOnDate);
//             DailyRentalStockDetail."WMS Fixed Monthly Charge" := Round((customer."WMS Fixed Monthly Charge" / 30) * TotalDaysInaMonth, 0.01, '=');
//             DailyRentalStockDetail."WMS Management Fee" := customer."WMS Management Fee";
//             // dailyRentalStockDetail."Over Time" := customer."WMS Storage Rate";
//         end;
//         // DailyRentalStockDetail."Total Charges" := customer."WMS Management Fee" + customer."WMS Fixed Monthly Charge" + DailyRentalStockDetail."Per Day Rate" * DailyRentalStockDetail."WMS Chargeable Pallets";
//         //
//         DailyRentalStockDetail."WMS Total Occupancy Pallets" :=
//                 TotalOccupancyPallets;

//         DailyRentalStockDetail."WMS Balance Pallets" :=
//             BalancePallets;

//         case DailyRentalStockDetail."WMS Billing Type" of
//             DailyRentalStockDetail."WMS Billing Type"::"Fixed Location":
//                 begin
//                     ChargeablePallets :=
//                         TotalOccupancyPallets -
//                         DailyRentalStockDetail."WMS Allocated Pallets";

//                     if ChargeablePallets < 0 then
//                         ChargeablePallets := 0;
//                 end;

//             DailyRentalStockDetail."WMS Billing Type"::Normal,
//             DailyRentalStockDetail."WMS Billing Type"::"Fixed Days":
//                 begin
//                     ChargeablePallets := TotalOccupancyPallets;
//                     //
//                     if InboundILE."Entry No." <> 0 then begin
//                         if ItemRec.Get(ItemNo) then begin
//                             ItemRec.TestField("Base Unit of Measure");

//                             // ItemQtyPerPallet :=
//                             // GetItemQtyPerPallet(
//                             //     ItemRec."No.",
//                             //     ItemRec."Base Unit of Measure",
//                             //     Customer."Customer CBM");

//                             MinimumBillablePallets :=
//                                 Round(
//                                     InboundILE.Quantity /
//                                     ItemQtyPerPallet,
//                                     1,
//                                     '>');

//                             MinimumStorageEndDate :=
//                                 InboundILE."Posting Date" +
//                                 DailyRentalStockDetail."WMS Minimum Storage Days" -
//                                 1;

//                             // Keep the received pallets chargeable through
//                             // the complete minimum-storage period.
//                             if AsOnDate <= MinimumStorageEndDate then
//                                 if MinimumBillablePallets > ChargeablePallets then
//                                     ChargeablePallets :=
//                                         MinimumBillablePallets;
//                         end;
//                     end;
//                     //
//                 end;


//         end;
//         if GoodsIn_UOM <> 0 then begin
//             DailyRentalStockDetail."Over Time" := InboundILE."WMS Over time";
//             DailyRentalStockDetail."Plug In" := InboundILE."WMS Plug In";
//             DailyRentalStockDetail."DM Inspection" := InboundILE."WMS DM Inspection";
//             If InboundILE."Container Type" = InboundILE."Container Type"::"Loose Pallet" then
//                 dailyRentalStockDetail."Handling Charges" := GetContainercharges(InboundILE."Container Type", customer."No.") * GoodsIn_Round_Pallet
//             else
//                 dailyRentalStockDetail."Handling Charges" := GetContainercharges(InboundILE."Container Type", customer."No.");
//             DailyRentalStockDetail."Total Charges" := customer."WMS Management Fee" +
//             DailyRentalStockDetail."WMS Fixed Monthly Charge" + PerDayRate * ChargeablePallets
//             + InboundILE."WMS Over time" + InboundILE."WMS Plug In" + InboundILE."WMS DM Inspection"

//             + dailyRentalStockDetail."Handling Charges";
//         end
//         else
//             DailyRentalStockDetail."Total Charges" := PerDayRate * ChargeablePallets;

//         DailyRentalStockDetail."WMS Chargeable Pallets" :=
//             ChargeablePallets;
//         //

//         // Do not insert an empty daily rental line.
//         // Fixed Days lines continue because ChargeablePallets remains greater than zero
//         // until the minimum storage period finishes.
//         if (TotalOccupancyPallets = 0) and
//         (BalancePallets = 0) and
//         (ChargeablePallets = 0) and
//         (GoodsIn_UOM = 0) and
//         (GoodsOut_UOM = 0) and
//         (GoodsInOut_UOM = 0)
//         then
//             exit;
//         DailyRentalStockDetail.Insert();
//         //  then // DailyRentalStockDetail.Modify();
//     end;

//     local procedure GetDaysInMonth(AsOnDate: Date): Integer
//     begin
//         exit(Date2DMY(CalcDate('<CM>', AsOnDate), 1));
//     end;

//     procedure GetContainercharges(Containertype: Enum containerType; CustomerNo: Code[20]): Decimal
//     var
//         CustomerStorageCharges: Record "Charges";
//     begin
//         CustomerStorageCharges.SetRange("Code", Format(Containertype));
//         customerStorageCharges.SetRange("Customer No.", CustomerNo);
//         if CustomerStorageCharges.FindFirst() then
//             exit(CustomerStorageCharges.amount);
//         exit(0);
//     end;
// }
