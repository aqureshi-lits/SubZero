tableextension 60048 SalHeaArcExt extends "Sales Header Archive"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Archived By"(Field 5046)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Assigned User ID"(Field 9000)".

        field(50001; "Creation User Id"; Code[50])
        {
            Description = 'ASH';
            TableRelation = User;
        }
        field(50010; "Term Start Date"; Date)
        {
            Description = 'GSS-STU';
        }
        field(50030; "Amount Excl. Excise"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line Archive"."Amount Excl. Excise" WHERE("Document No." = FIELD("No.")));
            Description = 'ATOS-EXC1.2';
            Editable = false;

        }
    }
}

