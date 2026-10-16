page 50000 UserCard
{
    ApplicationArea = All;
    Caption = 'UserCard';
    PageType = Card;
    SourceTable = "User Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    ApplicationArea = all;
                }
                field("LIT Signature"; Rec."LIT Signature")
                {
                    ToolTip = 'Specifies the value of the LIT Signature field.', Comment = '%';
                    ApplicationArea = all;
                }
            }
        }
    }
}
