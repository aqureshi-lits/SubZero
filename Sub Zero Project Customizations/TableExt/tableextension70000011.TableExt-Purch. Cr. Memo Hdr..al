tableextension 60010 PurCrMeHdExt extends "Purch. Cr. Memo Hdr."
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 112)".

        field(60000; "LIT Narration"; Text[250])
        {
            Description = 'GSS';
        }
        // field(50050; "Vendor Reference Date"; Date)
        // {
        //     Description = 'GSS';
        // }
    }


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchCrMemoHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNoVendor(
        ReportSelection.Usage::"P.Cr.Memo",PurchCrMemoHeader,ShowRequestForm,FIELDNO("Buy-from Vendor No."));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH PurchCrMemoHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"P.Cr.Memo",PurchCrMemoHeader,ShowRequestForm,'');
    END;
    */
    //end;
}

