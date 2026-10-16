table 80008 Charges
{
    Caption = 'Charges';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; text[100])
        {
            Caption = 'Description';
        }
        field(3; "Customer no."; Code[20])
        {
            Caption = 'Customer no.';
            tableRelation = Customer;
        }

        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
    }
    keys
    {
        key(PK; "Code", "Customer no.")
        {
            Clustered = true;
        }
    }
}
