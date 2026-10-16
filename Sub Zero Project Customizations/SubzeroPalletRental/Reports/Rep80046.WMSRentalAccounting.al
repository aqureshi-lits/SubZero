// report 80046 "WMS Rental Accounting"
// {
//     Caption = 'WMS Rental Accounting';
//     PreviewMode = PrintLayout;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Src/Layout/WMS Rental Accounting.rdl';
//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             RequestFilterFields = "No.";
//             column(CustomerNo; Customer."No.") { }
//             column(CustomerName; Customer.Name) { }
//             column(CompanyInfoName; CompanyInformation.Name) { }
//             column(ReportName; 'WMS Rental Accounting') { }
//             Column(AsOnDateTime; CurrentDateTime()) { }
//             column(StartDate; Format(StartDate, 0, 4)) { }
//             column(EndDate; Format(EndDate, 0, 4)) { }
//             dataitem("Daily Rental Stock"; "Daily Rental Stock Detail")
//             // dataitem("Daily Rental Stock"; "Daily Rental Stock")
//             {
//                 DataItemLink = "Customer Code" = field("No.");
//                 DataItemTableView = sorting("Posting Date", "Customer Code", "Storage Condition", "Per Day Rate") order(ascending);
//                 column(Storage_Condition; "Daily Rental Stock"."Storage Condition") { }
//                 column(Per_Day_Rate; "Daily Rental Stock"."Per Day Rate") { }

//                 column(GoodsIn_UOM; GoodsIn_UOM) { }
//                 column(GoodsOut_UOM; GoodsOut_UOM) { }
//                 column(GoodsInOut_UOM; GoodsInOut_UOM) { }
//                 column(GoodsIn_Actual_Pallet; Round(GoodsIn_Actual_Pallet, 0.001, '>')) { }
//                 column(GoodsIn_Round_Pallet; GoodsIn_Round_Pallet) { }
//                 column(GoodsOut_Actual_Pallet; Round(GoodsOut_Actual_Pallet, 0.001, '>')) { }
//                 column(GoodsOut_Round_Pallet; GoodsOut_Round_Pallet) { }
//                 column(GoodsInOut_Actual_Pallet; Round(GoodsInOut_Actual_Pallet, 0.001, '>')) { }
//                 column(GoodsInOut_Round_Pallet; GoodsInOut_Round_Pallet) { }
//                 column(OpeningStock_UOM; OpeningStock_UOM) { }
//                 column(ClosingStock_UOM; ClosingStock_UOM) { }
//                 column(OpeningStock_Actual_Pallet; Round(OpeningStock_Actual_Pallet, 0.001, '>')) { }
//                 column(OpeningStock_Round_Pallet; OpeningStock_Round_Pallet) { }
//                 column(ClosingStock_Actual_Pallet; Round(ClosingStock_Actual_Pallet, 0.001, '>')) { }
//                 column(ClosingStock_Round_Pallet; ClosingStock_Round_Pallet) { }
//                 column(ChargesAmount; ChargesAmount) { }
//                 column(VATAmount; VATAmount) { }
//                 column(NetAmount; NetAmount) { }

//                 trigger OnPreDataItem()
//                 begin
//                     SetRange("Posting Date", StartDate);
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     // DailyRentalStock2: Record "Daily Rental Stock";
//                     DailyRentalStock2: Record "Daily Rental Stock Detail";
//                 begin
//                     ResetGlobalDecimals();
//                     CalculateOpeningStock(Customer."No.", "Daily Rental Stock"."Storage Condition", "Daily Rental Stock"."Per Day Rate", Customer."Customer CBM");
//                     DailyRentalStock2.SetRange("Customer Code", Customer."No.");
//                     DailyRentalStock2.SetRange("Storage Condition", "Daily Rental Stock"."Storage Condition");
//                     DailyRentalStock2.SetRange("Per Day Rate", "Daily Rental Stock"."Per Day Rate");
//                     DailyRentalStock2.SetRange("Posting Date", StartDate, EndDate);
//                     if DailyRentalStock2.FindSet() then
//                         repeat
//                             GoodsIn_UOM := GoodsIn_UOM + DailyRentalStock2."Goods In (UOM)";
//                             GoodsOut_UOM := GoodsOut_UOM + DailyRentalStock2."Goods Out (UOM)";
//                             GoodsInOut_UOM := GoodsInOut_UOM + DailyRentalStock2."Same Day In-Out (UOM)";
//                             GoodsIn_Actual_Pallet := GoodsIn_Actual_Pallet + DailyRentalStock2."Goods In (Actual-Pallet)";
//                             GoodsIn_Round_Pallet := GoodsIn_Round_Pallet + DailyRentalStock2."Goods In (Round-Pallet)";
//                             GoodsOut_Actual_Pallet := GoodsOut_Actual_Pallet + DailyRentalStock2."Goods Out (Actual-Pallet)";
//                             GoodsOut_Round_Pallet := GoodsOut_Round_Pallet + DailyRentalStock2."Goods Out (Round-Pallet)";
//                             GoodsInOut_Actual_Pallet := GoodsInOut_Actual_Pallet + DailyRentalStock2."Same Day In-Out (Act.-Pallet)";
//                             GoodsInOut_Round_Pallet := GoodsInOut_Round_Pallet + DailyRentalStock2."Same Day In-Out (Round-Pallet)";

//                             PerDayStock_UOM := PerDayStock_UOM + DailyRentalStock2."Goods In (UOM)" - DailyRentalStock2."Goods Out (UOM)";
//                             PerDayStock_Actual_Pallet := PerDayStock_Actual_Pallet + DailyRentalStock2."Goods In (Actual-Pallet)" - DailyRentalStock2."Goods Out (Actual-Pallet)";
//                             PerDayStock_Round_Pallet := PerDayStock_Round_Pallet + DailyRentalStock2."Goods In (Round-Pallet)" - DailyRentalStock2."Goods Out (Round-Pallet)";

//                             if PerDayStock_UOM > 0 then begin
//                                 ClosingStock_UOM += PerDayStock_UOM;
//                                 ClosingStock_Actual_Pallet += PerDayStock_Actual_Pallet;
//                                 ClosingStock_Round_Pallet += PerDayStock_Round_Pallet;
//                             end;
//                         until DailyRentalStock2.Next() = 0;
//                     ChargesAmount := "Daily Rental Stock"."Per Day Rate" * ClosingStock_Round_Pallet;
//                     VATAmount := (ChargesAmount * 5) / 100;
//                     NetAmount := ChargesAmount + VATAmount;
//                 end;
//             }

//             trigger OnAfterGetRecord() //Customer
//             var
//                 DailyRentalStock: Record "Daily Rental Stock";
//             begin
//                 Clear(PalletCount);
//                 DailyRentalStock.SetRange("Posting Date", EndDate);
//                 DailyRentalStock.SetRange("Customer Code", Customer."No.");
//                 if not DailyRentalStock.FindSet() then
//                     Error('The daily warehouse rentals must be calculated for %1. Customer No. %2.', EndDate, Customer."No.");
//                 ResetGlobalDecimals();
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
//                     field(StartDate; StartDate)
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
//         CompanyInformation: Record "Company Information";
//         StartDate: Date;
//         EndDate: Date;
//         // AsOnDate: Date;
//         DaysInPeriod: Integer;
//         PalletCount: array[20] of Decimal;
//         i: Integer;
//         GoodsIn_UOM: Decimal;
//         GoodsOut_UOM: Decimal;
//         GoodsInOut_UOM: Decimal;

//         GoodsIn_Actual_Pallet: Decimal;
//         GoodsOut_Actual_Pallet: Decimal;
//         GoodsInOut_Actual_Pallet: Decimal;

//         GoodsIn_Round_Pallet: Decimal;
//         GoodsOut_Round_Pallet: Decimal;
//         GoodsInOut_Round_Pallet: Decimal;

//         OpeningStock_UOM: Decimal;
//         ClosingStock_UOM: Decimal;
//         OpeningStock_Actual_Pallet: Decimal;
//         ClosingStock_Actual_Pallet: Decimal;
//         OpeningStock_Round_Pallet: Decimal;
//         ClosingStock_Round_Pallet: Decimal;

//         PerDayStock_UOM: Decimal;
//         PerDayStock_Actual_Pallet: Decimal;
//         PerDayStock_Round_Pallet: Decimal;

//         ChargesAmount: Decimal;
//         VATAmount: Decimal;
//         NetAmount: Decimal;

//     trigger OnInitReport()
//     var
//     begin
//         StartDate := CalcDate('<-1M>', WorkDate());
//         EndDate := CalcDate('<-1D>', WorkDate());
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
//         CompanyInformation.Get();
//     end;

//     local procedure GetItemQtyPerPallet(ItemNo: Code[20]; BaseUnitofMeasureCode: Code[10]; CustomerCBM: Decimal): Decimal
//     var
//         ItemUnitofMeasure: Record "Item Unit of Measure";
//     begin
//         if not ItemUnitofMeasure.Get(ItemNo, BaseUnitofMeasureCode) then
//             Error('The item unit of measure record not found. Item No. %1. Unit of Measure Code: %2.', ItemNo, BaseUnitofMeasureCode);
//         if ItemUnitofMeasure.Cubage = 0 then
//             Error('The Cubage value must not be blank in Item Unit of Measure table. Item No. %1. Unit of Measure Code: %2.', ItemNo, BaseUnitofMeasureCode);
//         // exit(CustomerCBM / ItemUnitofMeasure.Cubage) Comment By FA 08112022
//         exit(CustomerCBM / (ItemUnitofMeasure.Cubage / 1000000))//Added By FA
//     end;


//     local procedure CalculateOpeningStock(CustomerNo: Code[20]; ItemStorageConditionCode: Code[20]; PerDayRate: Decimal; CustomerCBM: Decimal)
//     var
//         Item: Record Item;
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         TotalQty: Decimal;
//         TotalPalletCount_Actual: Decimal;
//         TotalPalletCount_Round: Decimal;
//         ItemQtyPerPallet: Decimal;
//     begin
//         Item.SetRange("Customer Code", CustomerNo);
//         Item.SetRange(Type, Item.Type::Inventory);
//         Item.SetRange(Blocked, false);
//         Item.SetRange("Storage Condition Code", ItemStorageConditionCode);
//         Item.SetRange("Rent Pallet/Day", PerDayRate);
//         if Item.FindSet() then
//             repeat
//                 ItemQtyPerPallet := GetItemQtyPerPallet(Item."No.", Item."Base Unit of Measure", CustomerCBM);
//                 ItemLedgerEntry.SetRange("Item No.", Item."No.");
//                 // ItemLedgerEntry.SetRange("Posting Date", AsOnDate);
//                 ItemLedgerEntry.SetFilter("Posting Date", '..%1', ClosingDate(StartDate));
//                 ItemLedgerEntry.CalcSums(Quantity);
//                 TotalQty += ItemLedgerEntry.Quantity;
//                 TotalPalletCount_Actual += ItemLedgerEntry.Quantity / ItemQtyPerPallet;
//                 TotalPalletCount_Round += Round(ItemLedgerEntry.Quantity / ItemQtyPerPallet, 1, '>');
//             until Item.Next() = 0;
//         if TotalQty > 0 then begin
//             OpeningStock_UOM := TotalQty;
//             OpeningStock_Actual_Pallet := TotalPalletCount_Actual;
//             OpeningStock_Round_Pallet := TotalPalletCount_Round;
//         end else begin
//             OpeningStock_UOM := 0;
//             OpeningStock_Actual_Pallet := 0;
//             OpeningStock_Round_Pallet := 0;
//         end;
//         PerDayStock_UOM := OpeningStock_UOM;
//         PerDayStock_Actual_Pallet := OpeningStock_Actual_Pallet;
//         PerDayStock_Round_Pallet := OpeningStock_Round_Pallet;
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
//         OpeningStock_UOM := 0;
//         ClosingStock_UOM := 0;
//         OpeningStock_Actual_Pallet := 0;
//         ClosingStock_Actual_Pallet := 0;
//         OpeningStock_Round_Pallet := 0;
//         ClosingStock_Round_Pallet := 0;
//         PerDayStock_UOM := 0;
//         PerDayStock_Actual_Pallet := 0;
//         PerDayStock_Round_Pallet := 0;
//         ChargesAmount := 0;
//         VATAmount := 0;
//         NetAmount := 0;
//     end;
// }
