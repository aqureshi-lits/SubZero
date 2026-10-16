tableextension 60024 VenLedEntExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(60101; "LIT Narration"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."LIT Narration" WHERE("Document No." = FIELD("Document No."),
                                                              "Posting Date" = FIELD("Posting Date")));
            Description = 'LITS';

        }

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 25)".


        //Unsupported feature: Property Insertion (Numeric) on ""Creditor No."(Field 170)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 27)".


        //Unsupported feature: Code Insertion on ""Payment Reference"(Field 171)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;
        field(60000; "Vendor Name flow"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            Description = 'GSS-ASH';

        }
    }


    //Unsupported feature: Code Modification on "DrillDownOnEntries(PROCEDURE 1)".

    //procedure DrillDownOnEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VendLedgEntry.RESET;
    DtldVendLedgEntry.COPYFILTER("Vendor No.",VendLedgEntry."Vendor No.");
    DtldVendLedgEntry.COPYFILTER("Currency Code",VendLedgEntry."Currency Code");
    DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 1",VendLedgEntry."Global Dimension 1 Code");
    DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 2",VendLedgEntry."Global Dimension 2 Code");
    DtldVendLedgEntry.COPYFILTER("Initial Entry Due Date",VendLedgEntry."Due Date");
    VendLedgEntry.SETCURRENTKEY("Vendor No.","Posting Date");
    VendLedgEntry.SETRANGE(Open,TRUE);
    PAGE.RUN(0,VendLedgEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    #7..9
    */
    //end;
}

