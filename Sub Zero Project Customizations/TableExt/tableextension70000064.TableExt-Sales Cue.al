tableextension 60063 SalCuExt extends "Sales Cue"
{
    fields
    {
        field(50001; "Collection Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Filter")));
            Description = 'ITOS';

        }
        field(50005; "Bank Filter"; Code[20])
        {
            Description = 'ITOS';
            FieldClass = FlowFilter;
            TableRelation = "Bank Account"."No.";
        }
    }
}

