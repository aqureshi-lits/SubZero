tableextension 60057 RetRecHeaExt extends "Return Receipt Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 112)".

        field(50001; "Creation User Id"; Code[50])
        {
            Description = 'ASH';
            TableRelation = User;
        }
        field(50010; "Term Start Date"; Date)
        {
            Description = 'GSS-STU';
        }
    }


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 3)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH ReturnRcptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(
        ReportSelection.Usage::"S.Ret.Rcpt.",ReturnRcptHeader,ShowRequestForm,FIELDNO("Bill-to Customer No."));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
        ReportSelection.Usage::"S.Ret.Rcpt.",ReturnRcptHeader,ShowRequestForm,"Bill-to Customer No.");
    END;
    */
    //end;
}

