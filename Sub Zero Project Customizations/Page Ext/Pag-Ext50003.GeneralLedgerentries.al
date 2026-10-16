pageextension 50003 GeneralLedgerentries extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("LIT Narration"; Rec."LIT Narration")
            {
                ApplicationArea = all;
            }

            field("LIT Cheque No."; Rec."LIT Cheque No.")
            {
                ApplicationArea = all;
            }

            field("LIT Cheque Date"; Rec."LIT Cheque Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action("Journal Voucher")
            {
                Image = Report;
                ApplicationArea = all;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    CLEAR(GL);
                    GL.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUN(50027, TRUE, FALSE, GL);
                end;
            }

            action("Payment Voucher")
            {
                Image = Report;
                ApplicationArea = all;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    CLEAR(GL);
                    GL.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUN(50021, TRUE, FALSE, GL);
                end;
            }

            action("Receipt Voucher")
            {
                Image = Report;
                ApplicationArea = all;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    CLEAR(GL);
                    GL.SETRANGE("Document No.", Rec."Document No.");
                    REPORT.RUN(50098, TRUE, FALSE, GL);
                end;
            }
        }

        addafter("&Navigate_Promoted")
        {
            group(CategoryCategory4)
            {
                Caption = 'Reports';
                actionref("JournalVoucher"; "Journal Voucher") { }
                actionref("PaymentVoucher"; "Payment Voucher") { }
                actionref("ReceiptVoucher"; "Receipt Voucher") { }
            }
        }
    }

    var

        GL: Record "G/L Entry";
}
