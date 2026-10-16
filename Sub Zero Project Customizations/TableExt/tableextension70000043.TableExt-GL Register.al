tableextension 60042 GLRegisExt extends "G/L Register"
{
    fields
    {
        field(60000; "LIT Document No."; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."Document No." WHERE("Entry No." = FIELD("From Entry No.")));
            Description = 'LITS';

        }
        field(60010; "LIT Pre-Document No."; Code[50])
        {
            CalcFormula = Lookup("G/L Entry"."LIT Pre-Document No." WHERE("Entry No." = FIELD("From Entry No.")));
            Description = 'LITS';
            FieldClass = FlowField;
        }
        field(60520; "LIT External Document No."; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."External Document No." WHERE("Entry No." = FIELD("From Entry No.")));
            Description = 'LITS';

        }

    }
}