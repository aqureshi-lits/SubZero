table 80009 "Storage Condition_Customer"
{
    Caption = 'Storage Condition_Customer';
    LookupPageID = "Storage Condition";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            tableRelation = "Storage Condition";

            trigger OnValidate()
            var
                StorageConditionRec: Record "Storage Condition";
            begin
                if StorageConditionRec.Get(Rec."Code") then
                    Rec.Description := StorageConditionRec.Description;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            tableRelation = Customer;


            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Customer No.") then
                    Rec."Customer Name" := CustomerRec.Name;
            end;
        }
        field(4; "Rent Pallet/Day"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Pallet/Day';
        }

        field(5; "Customer Name"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
            editable = false;
        }

    }
    keys
    {
        key(PK; "Code", "Customer No.")
        {
            Clustered = true;
        }

    }
    var
        P: Page 112;
}
