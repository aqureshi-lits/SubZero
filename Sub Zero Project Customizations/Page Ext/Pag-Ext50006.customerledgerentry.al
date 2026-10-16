pageextension 50006 "customer ledger entry" extends "Customer Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {

            field("LIT Narration"; Rec."LIT Narration")
            {
                ApplicationArea = all;
            }

            // field("Customer Name1"; Rec."Customer Name")
            // {
            //     ApplicationArea = all;
            // }

            field("Payment Date"; Rec."Payment Date")
            {
                ApplicationArea = all;
            }

        }
    }
}
