pageextension 80028 "Pallet Rental Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            group("Pallet Rental")
            {
                Caption = 'Pallet Rental';
                // field("Pallet Billing Method"; Rec."Pallet Billing Method")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Rental scenario for this order. Defaulted from the customer; can be overridden per order.';
                // }
                // field("Minimum Storage Days"; Rec."Minimum Storage Days")
                // {
                //     ApplicationArea = All;
                //     Enabled = Rec."Pallet Billing Method" = Rec."Pallet Billing Method"::"Fixed Days";
                // }
                // field("DO Per-Day Rate"; Rec."DO Per-Day Rate")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
}
