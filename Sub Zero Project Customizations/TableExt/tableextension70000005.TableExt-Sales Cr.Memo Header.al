tableextension 60004 SalCreMemHeaExt extends "Sales Cr.Memo Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 112)".

        // field(50001; "Creation User Id"; Code[50])
        // {
        //     Description = 'ASH';
        //     TableRelation = User;
        // }
        // field(50010; "Term Start Date"; Date)
        // {
        //     Description = 'GSS-STU';
        // }
        // field(50030; "Amount Excl. Excise"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Sales Cr.Memo Line"."Amount Excl. Excise" WHERE("Document No." = FIELD("No.")));
        //     Description = 'ATOS-EXC1.2';
        //     Editable = false;

        // }
    }


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentSendingProfile.TrySendToPrinter(
      DummyReportSelections.Usage::"S.Cr.Memo",Rec,FIELDNO("Bill-to Customer No."),ShowRequestForm);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocumentSendingProfile.TrySendToPrinter(
      DummyReportSelections.Usage::"S.Cr.Memo",Rec,"Bill-to Customer No.",ShowRequestForm);
    */
    //end;
}

