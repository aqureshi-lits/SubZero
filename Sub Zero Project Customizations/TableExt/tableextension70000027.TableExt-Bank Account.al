tableextension 60026 BanAccExt extends "Bank Account"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Our Contact Code"(Field 29)".


        //Unsupported feature: Deletion on "City(Field 7).OnLookup".


        //Unsupported feature: Deletion on ""Country/Region Code"(Field 35).OnValidate".


        //Unsupported feature: Deletion on ""Post Code"(Field 91).OnLookup".


        //Unsupported feature: Property Deletion (DataClassification) on ""Bank Stmt. Service Record ID"(Field 121)".

        // field(50000; "Check Template Path"; Text[250])
        // {
        //     Description = 'ASH';
        // }
        // field(50010; "Check Layout"; Text[100])
        // {
        //     Description = 'ASH';
        //     TableRelation = "Custom Report Layout".Code WHERE("Report ID" = FIELD("Check Report ID"));
        // }
        // field(50501; Internal; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'ITOS';
        // }
    }


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF IsContactUpdateNeeded THEN BEGIN
      MODIFY;
      UpdateContFromBank.OnModify(Rec);
      IF NOT FIND THEN BEGIN
        RESET;
        IF FIND THEN;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF (Name <> xRec.Name) OR
       ("Search Name" <> xRec."Search Name") OR
       ("Name 2" <> xRec."Name 2") OR
       (Address <> xRec.Address) OR
       ("Address 2" <> xRec."Address 2") OR
       (City <> xRec.City) OR
       ("Phone No." <> xRec."Phone No.") OR
       ("Telex No." <> xRec."Telex No.") OR
       ("Territory Code" <> xRec."Territory Code") OR
       ("Currency Code" <> xRec."Currency Code") OR
       ("Language Code" <> xRec."Language Code") OR
       ("Our Contact Code" <> xRec."Our Contact Code") OR
       ("Country/Region Code" <> xRec."Country/Region Code") OR
       ("Fax No." <> xRec."Fax No.") OR
       ("Telex Answer Back" <> xRec."Telex Answer Back") OR
       ("Post Code" <> xRec."Post Code") OR
       (County <> xRec.County) OR
       ("E-Mail" <> xRec."E-Mail") OR
       ("Home Page" <> xRec."Home Page")
    THEN BEGIN
    #4..10
    */
    //end;


    //Unsupported feature: Code Modification on "ShowContact(PROCEDURE 1)".

    //procedure ShowContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN
      EXIT;

    #4..11
    END;
    COMMIT;

    Cont.FILTERGROUP(2);
    Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
    Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
    PAGE.RUN(PAGE::"Contact List",Cont);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    #16..18
    */
    //end;
}

