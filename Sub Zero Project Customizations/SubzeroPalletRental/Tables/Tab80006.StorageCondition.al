table 80006 "Storage Condition"
{
    Caption = 'Storage Condition';
    LookupPageID = "Storage Condition";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Use for Warehouse Rents"; Boolean)
        {
            Caption = 'Use for Warehouse Rents';
            DataClassification = ToBeClassified;
        }
        field(4; "Rent Pallet/Day"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Pallet/Day';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        P: Page 112;
}
