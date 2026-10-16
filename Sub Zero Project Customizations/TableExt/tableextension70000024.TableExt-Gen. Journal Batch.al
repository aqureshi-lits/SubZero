tableextension 60023 GenJouBatExt extends "Gen. Journal Batch"
{
    fields
    {

        field(60001; "LIT User"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
            TableRelation = "User Setup";
        }

        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 6).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
          CheckGLAcc("Bal. Account No.");
        CheckJnlIsNotRecurring;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
          CheckGLAcc("Bal. Account No.");
        */
        //end;
    }
}

