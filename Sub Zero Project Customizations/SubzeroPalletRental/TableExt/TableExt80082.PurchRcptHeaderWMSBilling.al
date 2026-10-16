tableextension 80082 "Purch. Rcpt. WMS Billing" extends "Purch. Rcpt. Header"
{
    fields
    {
        Field(80001; "Over Time"; Decimal)
        {
            Caption = 'Over Time';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }

        Field(80002; "Plug In"; Decimal)
        {
            Caption = 'Plug In';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }

        Field(80003; "DM Inspection"; Decimal)
        {
            Caption = 'DM Inspection';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(80004; "WMS Management Fee"; Decimal)
        {
            Caption = 'Management Fee';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }

        field(80005; "Container Type"; Enum containerType)
        {
            Caption = 'Container Type';
            DataClassification = CustomerContent;
        }
    }
}
