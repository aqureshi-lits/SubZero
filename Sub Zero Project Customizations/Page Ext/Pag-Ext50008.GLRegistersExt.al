pageextension 50008 "G/L RegistersExt" extends "G/L Registers"
{
    layout

    {
        addlast(Control1)
        {
            field("LIT Document No."; Rec."LIT Document No.")
            {
                ApplicationArea = all;
            }

            field("LIT External Document No."; Rec."LIT External Document No.")
            {
                ApplicationArea = all;
            }

            field("LIT Pre-Document No."; Rec."LIT Pre-Document No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
