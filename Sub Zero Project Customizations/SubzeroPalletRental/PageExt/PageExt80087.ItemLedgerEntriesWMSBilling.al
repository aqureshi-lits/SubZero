pageextension 80087 "Item Ledger WMS Billing" extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("WMS Over time"; Rec."WMS Over time") { ApplicationArea = All; Editable = false; }
            field("WMS Plug In"; Rec."WMS Plug In") { ApplicationArea = All; Editable = false; }
            field("WMS DM Inspection"; Rec."WMS DM Inspection") { ApplicationArea = All; Editable = false; }
            field("Container Type"; Rec."Container Type") { ApplicationArea = All; Editable = false; }
            field("WMS Management Fee"; Rec."WMS Management Fee") { ApplicationArea = All; Editable = false; }
            field("WMS Purchase Order No."; Rec."WMS Purchase Order No.") { ApplicationArea = All; Editable = false; }
            field("WMS Purchase Receipt No."; Rec."WMS Purchase Receipt No.") { ApplicationArea = All; Editable = false; }


        }
    }
}
