pageextension 60113 ComInfExt extends "Company Information"
{
    layout
    {
        addafter(Address)
        {
            field("Excise TRN No."; Rec."Excise TRN No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Address 2")
        {
            field(Stamp; Rec."LIT Stamp")
            {
                ApplicationArea = all;
            }
        }
        addafter("Allow Blank Payment Info.")
        {
            field("Accounts E-Mail"; Rec."Accounts E-Mail")
            {
                ApplicationArea = all;
            }
        }

    }
}

