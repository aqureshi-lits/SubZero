tableextension 60055 RetShiHeaExt extends "Return Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 112)".

        field(50050; "Vendor Reference Date"; Date)
        {
            Description = 'GSS';
        }
    }


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH ReturnShptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(
        ReportSelection.Usage::"P.Ret.Shpt.",ReturnShptHeader,ShowRequestForm,FIELDNO("Buy-from Vendor No."));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH ReturnShptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"P.Ret.Shpt.",ReturnShptHeader,ShowRequestForm,'');
    END;
    */
    //end;
}

