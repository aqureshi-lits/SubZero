pageextension 50007 SalesInvoiceSubForm extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Line Discount %")
        {
            field("LIT Narration"; Rec."LIT Narration") { ApplicationArea = All; }
        }
    }
}
