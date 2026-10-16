tableextension 60009 PurInvLinExt extends "Purch. Inv. Line"
{
    fields
    {
        field(60100; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".

        // field(50101; "Excise Unit Cost"; Decimal)
        // {
        //     Description = 'EXC - Excise';
        // }
        // field(50103; "Excise Total Cost"; Decimal)
        // {
        //     Description = 'EXC - Excise';
        // }
        // field(50201; "Purch. Order Status"; Option)
        // {
        //     FieldClass = FlowField;

        //     CalcFormula = Lookup("Purchase Header".Status WHERE("Document Type" = CONST(Order),
        //                                                         "No." = FIELD("Document No.")
        //         )
        //     );
        //     Caption = 'Purch. Order Status';
        //     Description = 'POBGT1.0';
        //     Editable = false;

        //     OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
        //     OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        // }
        // field(50202; "Over Budget"; Boolean)
        // {
        //     Description = 'POBGT1.1';
        // }
    }
}

