pageextension 50000 UserSetup extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("LIT Designation"; Rec."LIT Designation")
            {
                ApplicationArea = all;

            }

            field("LIT Signature"; Rec."LIT Signature")
            {
                ApplicationArea = Basic, Suite;
            }

            field("LIT Signature2"; Rec."LIT Signature2")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    CurrPage.SaveRecord();
                end;
            }


        }


        addlast(factboxes)
        {
            field("LIT Signature1"; Rec."LIT Signature2")
            {
                ApplicationArea = all;
            }

        }

    }

    actions
    {
        addfirst(Navigation)
        {
            action(Signature)
            {
                image = Signature;
                ApplicationArea = all;
                RunObject = page 50000;
                RunPageLink = "User ID" = field("User ID");

            }
        }
    }



    var

        Compinfo: page "Company Information";
}
