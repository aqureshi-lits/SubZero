tableextension 60006 tableextension70000007 extends "Purch. Rcpt. Header"
{
    fields
    {

        field(60000; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 112)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50000)".

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
    WITH PurchRcptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNoVendor(
        ReportSelection.Usage::"P.Receipt",PurchRcptHeader,ShowRequestForm,FIELDNO("Buy-from Vendor No."));
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH PurchRcptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"P.Receipt",PurchRcptHeader,ShowRequestForm,'');
    END;
    */
    //end;
}

