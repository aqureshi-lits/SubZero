tableextension 60017 StaSalLinExt extends "Standard Sales Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Quantity := 0;
        "Amount Excl. VAT" := 0;
        "Unit of Measure Code" := '';
        #4..31
          Type::Resource:
            BEGIN
              Res.GET("No.");
              Res.CheckResourcePrivacyBlocked(FALSE);
              Res.TESTFIELD(Blocked,FALSE);
              Res.TESTFIELD("Gen. Prod. Posting Group");
              "Unit of Measure Code" := Res."Base Unit of Measure";
        #39..50
              Description := ItemCharge.Description;
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..34
        #36..53
        */
        //end;
        // field(50001; Narration; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'GSS';
        // }
    }
}

