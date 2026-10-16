tableextension 80025 "Pallet Rental Sales Header" extends "Sales Header"
{
    fields
    {
        // field(80020; "Pallet Billing Method"; Enum "WMS Billing Type")
        // {
        //     Caption = 'Pallet Billing Method';
        //     DataClassification = CustomerContent;
        //     ToolTip = 'Rental billing scenario applied to this order. Defaulted from the customer and can be overridden per order.';
        // }
        // field(80023; "Minimum Storage Days"; Integer)
        // {
        //     Caption = 'Minimum Storage Days';
        //     DataClassification = CustomerContent;
        // }
        // field(80025; "DO Per-Day Rate"; Decimal)
        // {
        //     Caption = 'DO Per-Day Rate';
        //     DataClassification = CustomerContent;
        //     ToolTip = 'Optional per-day rate defined on this dispatch/delivery order. When set, it overrides the customer/storage-condition matrix rate for pallets shipped on this order.';
        // }
    }

    // procedure CopyPalletBillingFromCustomer()
    // var
    //     Cust: Record Customer;
    // begin
    //     if "Sell-to Customer No." = '' then
    //         exit;
    //     if not Cust.Get("Sell-to Customer No.") then
    //         exit;
    //     "Pallet Billing Method" := Cust."Pallet Billing Method";
    //     "Minimum Storage Days" := Cust."WMS Minimum Storage Days";

    // end;
}
