pageextension 80079 CustomerList extends "Customer List"
{
    layout
    {
        addafter("Phone No.")
        {

            field(billingType; rec."WMS Billing Type")
            {
                ApplicationArea = all;
                Caption = 'Billing Type';
            }



        }

    }

}
