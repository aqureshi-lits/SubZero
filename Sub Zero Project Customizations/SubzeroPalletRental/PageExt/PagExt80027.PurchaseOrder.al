pageextension 80085 "Purchase Order WMS Billing" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            group("Warehouse Billing")
            {
                Caption = 'Warehouse Billing';
                field("Container Type"; Rec."Container Type")
                {
                    ApplicationArea = all;
                }

                field("Over Time"; Rec."Over Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the over time charge for the posted receipt.';
                }
                field("Plug In"; Rec."Plug In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the plug in charge for the posted receipt.';
                }

                field("DM Inspection"; Rec."DM Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the DM inspection charge for the posted receipt.';
                }

                // Field("WMS Management Fee"; Rec."WMS Management Fee")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the management fee charged once for the billing period.';
                // }
            }
        }
    }
}

