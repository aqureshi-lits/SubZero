tableextension 60000 SalShipHeaExt extends "Sales Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 112)".

        field(60001; "Creation User Id"; Code[50])
        {
            Description = 'ASH';
            TableRelation = User;
        }
        field(60010; "Term Start Date"; Date)
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
    WITH SalesShptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(
        ReportSelection.Usage::"S.Shipment",SalesShptHeader,ShowRequestForm,FIELDNO("Bill-to Customer No."));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH SalesShptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"S.Shipment",SalesShptHeader,ShowRequestForm,"Bill-to Customer No.");
    END;
    */
    //end;
}

