tableextension 60012 GLAccExt extends "G/L Account"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Account Subcategory Entry No."(Field 80).OnValidate".

        //trigger "(Field 80)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Subcategory Entry No." = 0 THEN
          EXIT;
        GLAccountCategory.GET("Account Subcategory Entry No.");
        TESTFIELD("Income/Balance",GLAccountCategory."Income/Balance");
        "Account Category" := GLAccountCategory."Account Category";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        //GSS
        VALIDATE("Parent Acc. Sub Cat. No.",GLAccountCategory."Parent Entry No.");
        //GSS
        */
        //end;
        // field(50000; "Parent Acc. Sub Cat. No."; Integer)
        // {
        //     Description = 'GSS';
        //     TableRelation = "G/L Account Category";
        // }
        // field(50001; "Parent Acc Sub. Descript."; Text[80])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("G/L Account Category".Description WHERE("Entry No." = FIELD("Parent Acc. Sub Cat. No.")));
        //     Caption = 'Account Subcategory Descript.';
        //     Description = 'GSS';
        //     Editable = false;

        // }
    }


    //Unsupported feature: Code Modification on "ValidateAccountSubCategory(PROCEDURE 6)".

    //procedure ValidateAccountSubCategory();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NewValue = "Account Subcategory Descript." THEN
      EXIT;
    IF NewValue = '' THEN
    #4..10
          ERROR(NoAccountCategoryMatchErr,"Account Category",NewValue);
      END;
      VALIDATE("Account Subcategory Entry No.",GLAccountCategory."Entry No.");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
      //GSS
      VALIDATE("Parent Acc. Sub Cat. No.",GLAccountCategory."Parent Entry No.");
      //GSS
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "LookupAccountSubCategory(PROCEDURE 5)".

    //procedure LookupAccountSubCategory();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Account Subcategory Entry No." <> 0 THEN
      IF GLAccountCategory.GET("Account Subcategory Entry No.") THEN
        GLAccountCategories.SETRECORD(GLAccountCategory);
    #4..9
      GLAccountCategories.GETRECORD(GLAccountCategory);
      VALIDATE("Account Category",GLAccountCategory."Account Category");
      "Account Subcategory Entry No." := GLAccountCategory."Entry No.";
    END;
    CALCFIELDS("Account Subcategory Descript.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
      //GSS
      VALIDATE("Parent Acc. Sub Cat. No.",GLAccountCategory."Parent Entry No.");
      //GSS
    END;
    CALCFIELDS("Account Subcategory Descript.");
    */
    //end;
}

