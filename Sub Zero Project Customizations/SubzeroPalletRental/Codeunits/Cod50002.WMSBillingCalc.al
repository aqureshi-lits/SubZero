codeunit 80089 "WMS Billing Management"
{
    procedure GetLatestInboundTerms(ItemNo: Code[20]; OnDate: Date; var InboundILE: Record "Item Ledger Entry"): Boolean
    begin
        Clear(InboundILE);
        InboundILE.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
        InboundILE.SetRange("Item No.", ItemNo);
        InboundILE.SetRange(Positive, true);
        InboundILE.SetFilter("Posting Date", '..%1', OnDate);
        InboundILE.SetFilter("WMS Purchase Receipt No.", '<>%1', '');
        exit(InboundILE.FindLast());
    end;

    procedure CopyTermsToDailyRental(var DailyRentalStockDetail: Record "Daily Rental Stock Detail"; Customer: Record Customer; InboundILE: Record "Item Ledger Entry")
    begin
        DailyRentalStockDetail."WMS Billing Type" := Customer."WMS Billing Type";
        DailyRentalStockDetail."WMS Allocated Pallets" := Customer."WMS Allocated Pallets";
        DailyRentalStockDetail."WMS Minimum Storage Days" := Customer."WMS Minimum Storage Days";
        //DailyRentalStockDetail."Per Day Rate" := Customer."WMS Storage Rate";
        // DailyRentalStockDetail."WMS Fixed Monthly Charge" := InboundILE."WMS Fixed Monthly Charge";
        // DailyRentalStockDetail."WMS Management Fee" := InboundILE."WMS Management Fee";
        DailyRentalStockDetail."WMS Purchase Order No." := InboundILE."WMS Purchase Order No.";
    end;

    procedure CalculateStorageCharge(BillingType: Enum "WMS Billing Type"; OccupancyPallets: Decimal; AllocatedPallets: Decimal; Rate: Decimal): Decimal
    var
        ChargeablePallets: Decimal;
    begin
        ChargeablePallets := OccupancyPallets;
        if BillingType = BillingType::"Fixed Location" then begin
            ChargeablePallets -= AllocatedPallets;
            if ChargeablePallets < 0 then
                ChargeablePallets := 0;
        end;
        exit(ChargeablePallets * Rate);
    end;

    procedure CalculateMinimumDaysCharge(PalletsShipped: Decimal; Rate: Decimal; ReceiptDate: Date; ShipmentDate: Date; MinimumDays: Integer): Decimal
    var
        ActualDays: Integer;
        ShortfallDays: Integer;
    begin
        if (PalletsShipped <= 0) or (Rate <= 0) or (ReceiptDate = 0D) or (ShipmentDate = 0D) or (MinimumDays <= 0) then
            exit(0);
        ActualDays := ShipmentDate - ReceiptDate + 1;
        ShortfallDays := MinimumDays - ActualDays;
        if ShortfallDays <= 0 then
            exit(0);
        exit(PalletsShipped * Rate * ShortfallDays);
    end;
}
