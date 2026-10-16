tableextension 60030 IteLedentExt extends "Item Ledger Entry"
{
    fields
    {

        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50952)".

        field(50100; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Source No.")));
            Description = 'GSS';
            Editable = false;

        }
        // field(50105; Grade; Code[20])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup(Customer."Student Grade" WHERE("No." = FIELD("Source No.")));
        //     Description = 'GSS';
        //     Editable = false;

        // }
        field(50200; "Vendor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Source No.")));
            Description = 'GSS';
            Editable = false;
        }
        field(50900; "Manufacturing Date"; Date)
        {
            Description = 'GSS';
        }
        field(50950; "Discount Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Discount Amount" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Description = 'GSS';
            Editable = false;

        }
        field(50951; "Reason Code"; Code[10])
        {
            Description = 'GSS';
        }
        field(50991; "User ID"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Value Entry"."User ID" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Description = 'ITOS';
            Editable = false;

        }

        field(60952; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
    }
}

