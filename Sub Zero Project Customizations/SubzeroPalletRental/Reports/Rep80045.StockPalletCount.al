report 80045 "Stock Pallet Count Detail"
{
    Caption = 'Stock Pallet Count Detail';
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Layout/Stock Pallet Count - Detail.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(CustomerNo; Customer."No.") { }
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(ReportName; 'Stock Pallet Count') { }
            Column(AsOnDateTime; CurrentDateTime()) { }
            column(StartDate; Format(StartDate, 0, 4)) { }
            column(EndDate; Format(EndDate, 0, 4)) { }
            dataitem(DaysLoop; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending);

                column(Date_Value; Format(AsOnDate, 0, 4)) { }
                dataitem("Storage Condition"; "Storage Condition")
                {
                    DataItemTableView = sorting(Code) where("Use for Warehouse Rents" = const(true));
                    RequestFilterFields = Code;

                    column(StorageConditionCode; "Storage Condition".Code) { }
                    column(PalletCount; PalletCount[i]) { }

                    trigger OnAfterGetRecord() //Item Storage Condition Code
                    var
                        // DailyRentalStock: Record "Daily Rental Stock";
                        DailyRentalStock: Record "Daily Rental Stock Detail";
                    begin
                        i += 1;
                        PalletCount[i] := GetOpeningPalletCount("Storage Condition".Code, Customer."No.", AsOnDate, Customer."Customer CBM")

                        // if AsOnDate = StartDate then
                        //     PalletCount[i] := GetOpeningPalletCount("Storage Condition".Code, Customer."No.", AsOnDate, Customer."Customer CBM")
                        // else begin
                        //     DailyRentalStock.SetRange("Posting Date", AsOnDate);
                        //     DailyRentalStock.SetRange("Customer Code", Customer."No.");
                        //     DailyRentalStock.SetRange("Storage Condition", "Storage Condition".Code);
                        //     if DailyRentalStock.FindSet() then
                        //         repeat
                        //             //PalletCount[i] := PalletCount[i] + DailyRentalStock."Goods In (Round-Pallet)" - DailyRentalStock."Goods Out (Round-Pallet)" - DailyRentalStock."Same Day In-Out (Round-Pallet)";
                        //             PalletCount[i] := PalletCount[i] + DailyRentalStock."Goods In (Actual-Pallet)" - DailyRentalStock."Goods Out (Actual-Pallet)" - DailyRentalStock."Same Day In-Out (Act.-Pallet)";

                        //         until DailyRentalStock.Next() = 0;
                        //     PalletCount[i] := Round(PalletCount[i], 1, '>');
                        // end;
                    end;
                }
                trigger OnPreDataItem() //DaysLoop
                begin
                    SetRange(Number, 0, DaysInPeriod);
                end;

                trigger OnAfterGetRecord() //DaysLoop
                var
                    // DailyRentalStock: Record "Daily Rental Stock";
                    DailyRentalStock: Record "Daily Rental Stock Detail";
                begin
                    if Number = 0 then begin
                        AsOnDate := StartDate;
                    end else begin
                        AsOnDate := CalcDate(StrSubstNo('<>+%1D', Number), StartDate);
                    end;
                    DailyRentalStock.SetRange("Posting Date", AsOnDate);
                    DailyRentalStock.SetRange("Customer Code", Customer."No.");
                    if not DailyRentalStock.FindSet() then
                        Error('The daily warehouse rentals must be calculated for %1. Customer No. %2.', AsOnDate, Customer."No.");
                    i := 0;
                end;
            }

            trigger OnAfterGetRecord() //Customer
            begin
                Clear(PalletCount);
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
        AsOnDate: Date;
        DaysInPeriod: Integer;
        PalletCount: array[20] of Decimal;
        i: Integer;

    trigger OnInitReport()
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
        // exit(CustomerCBM / ItemUnitofMeasure.Cubage)Comment By FA 08112022
        exit(CustomerCBM / (ItemUnitofMeasure.Cubage / 1000000));//Added By FA 08112022
    end;


    local procedure GetOpeningPalletCount(ItemStorageConditionCode: Code[20]; CustomerNo: Code[20]; AsOnDate: Date; CustomerCBM: Decimal): Decimal
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalPalletCount: Decimal;
        ItemQtyPerPallet: Decimal;
    begin
        Item.SetRange("Customer Code", CustomerNo);
        Item.SetRange(Type, Item.Type::Inventory);
        Item.SetRange(Blocked, false);
        Item.SetRange("Storage Condition Code", ItemStorageConditionCode);
        // Item.CalcFields(Inventory);
        // Item.SetFilter(Inventory, '<> 0');
        Item.CalcFields("Purchase Exist");
        Item.SetRange("Purchase Exist", true);
        if Item.FindSet() then
            repeat
                ItemQtyPerPallet := GetItemQtyPerPallet(Item."No.", Item."Base Unit of Measure", CustomerCBM);
                ItemLedgerEntry.SetRange("Item No.", Item."No.");
                ItemLedgerEntry.SetFilter("Posting Date", '..%1', ClosingDate(AsOnDate));
                ItemLedgerEntry.CalcSums(Quantity);
                TotalPalletCount += Round(ItemLedgerEntry.Quantity / ItemQtyPerPallet, 1, '>');
            until Item.Next() = 0;
        if TotalPalletCount > 0 then
            exit(TotalPalletCount)
        else
            exit(0);
    end;
}
