pageextension 50001 CashreceiptJournalExt extends "Cash Receipt Journal"
{
    layout

    {
        addafter("Credit Amount")
        {
            field("LIT Cheque Date"; Rec."LIT Cheque Date")
            {
                ApplicationArea = all;
            }

            field("LIT Cheque No."; Rec."LIT Cheque No.")
            {
                ApplicationArea = all;
            }
            field("LIT Narration"; Rec."LIT Narration")
            {
                ApplicationArea = all;
            }
        }
    }
}
