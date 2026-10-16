pageextension 50005 SalesInvocieSubformExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Line Discount %")
        {
            field("LIT Narration"; Rec."LIT Narration")
            {
                ApplicationArea = all;
            }
        }
    }
}
