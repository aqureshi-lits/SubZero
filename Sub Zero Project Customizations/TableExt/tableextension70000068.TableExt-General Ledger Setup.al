tableextension 60067 GenLedSetExt extends "General Ledger Setup"
{
    fields
    {

        //Unsupported feature: Deletion on ""Allow Posting From"(Field 2).OnValidate".


        //Unsupported feature: Deletion on ""Allow Posting To"(Field 3).OnValidate".


        //Unsupported feature: Code Modification on ""Amount Rounding Precision"(Field 73).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Amount Rounding Precision" <> 0 THEN
          "Inv. Rounding Precision (LCY)" := ROUND("Inv. Rounding Precision (LCY)","Amount Rounding Precision");

        RoundingErrorCheck(FIELDCAPTION("Amount Rounding Precision"));

        IF HideDialog THEN
          MESSAGE(Text021);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Amount Rounding Precision" <> 0 THEN
          "Inv. Rounding Precision (LCY)" := ROUND("Inv. Rounding Precision (LCY)","Amount Rounding Precision");
        RoundingErrorCheck(FIELDCAPTION("Amount Rounding Precision"));
        IF HideDialog THEN
          MESSAGE(Text021);
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""SEPA Non-Euro Export"(Field 170)".


        //Unsupported feature: Deletion (FieldCollection) on ""SEPA Export w/o Bank Acc. Data"(Field 171)".

        field(50000; "Notional Interest Per Annum"; Decimal)
        {
            Description = 'GSS';
        }
    }
}

