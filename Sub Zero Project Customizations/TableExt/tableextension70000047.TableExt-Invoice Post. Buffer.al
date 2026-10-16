tableextension 60046 InvPosBuffExt extends "Invoice Post. Buffer"
{
    fields
    {

        //Unsupported feature: Property Deletion (DataClassification) on "Type(Field 1)".


        //Unsupported feature: Property Deletion (DataClassification) on ""G/L Account"(Field 2)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Global Dimension 1 Code"(Field 4)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Global Dimension 2 Code"(Field 5)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Job No."(Field 6)".


        //Unsupported feature: Property Deletion (DataClassification) on "Amount(Field 7)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Amount"(Field 8)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Gen. Bus. Posting Group"(Field 10)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Gen. Prod. Posting Group"(Field 11)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Calculation Type"(Field 12)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Base Amount"(Field 14)".


        //Unsupported feature: Property Deletion (DataClassification) on ""System-Created Entry"(Field 17)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Tax Area Code"(Field 18)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Tax Liable"(Field 19)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Tax Group Code"(Field 20)".


        //Unsupported feature: Property Deletion (DataClassification) on "Quantity(Field 21)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Use Tax"(Field 22)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Bus. Posting Group"(Field 23)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Prod. Posting Group"(Field 24)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Amount (ACY)"(Field 25)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Amount (ACY)"(Field 26)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Base Amount (ACY)"(Field 29)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT Difference"(Field 31)".


        //Unsupported feature: Property Deletion (DataClassification) on ""VAT %"(Field 32)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Dimension Set ID"(Field 480)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Deferral Code"(Field 1700)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Deferral Line No."(Field 1701)".


        //Unsupported feature: Property Deletion (DataClassification) on ""FA Posting Date"(Field 5600)".


        //Unsupported feature: Property Deletion (DataClassification) on ""FA Posting Type"(Field 5601)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Depreciation Book Code"(Field 5602)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Salvage Value"(Field 5603)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Depr. until FA Posting Date"(Field 5605)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Depr. Acquisition Cost"(Field 5606)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Maintenance Code"(Field 5609)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Insurance No."(Field 5610)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Budgeted FA No."(Field 5611)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Duplicate in Depreciation Book"(Field 5612)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Use Duplication List"(Field 5613)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Fixed Asset Line No."(Field 5614)".

        field(50000; Narration; Text[250])
        {
            Description = 'LITS';
        }
    }


    //Unsupported feature: Code Modification on "Update(PROCEDURE 12)".

    //procedure Update();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Rec := InvoicePostBuffer;
    IF FIND THEN BEGIN
      Amount += InvoicePostBuffer.Amount;
    #4..9
      Quantity += InvoicePostBuffer.Quantity;
      IF NOT InvoicePostBuffer."System-Created Entry" THEN
        "System-Created Entry" := FALSE;
      AdjustRoundingForUpdate;
      MODIFY;
      InvDefLineNo := "Deferral Line No.";
    END ELSE BEGIN
    #17..20
      END;
      INSERT;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    #14..23
    */
    //end;
}

