tableextension 60027 BanAccLedEntExt extends "Bank Account Ledger Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Our Contact Code"(Field 25)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 27)".

        // field(50001; "Customer Name"; Text[100])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("Sales Invoice Header"."Sell-to Customer Name" WHERE("No." = FIELD("Document No.")));
        //     Description = 'ITOS';
        //     Editable = false;

        // }
        // field(50011; "Sell-to Address"; Text[100])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("Sales Invoice Header"."Sell-to Address" WHERE("No." = FIELD("Document No.")));
        //     Description = 'ITOS';
        //     Editable = false;

        // }
    }
}

