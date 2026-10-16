tableextension 60022 VenExt extends Vendor
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 29)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due"(Field 66)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due (LCY)"(Field 67)".


        //Unsupported feature: Property Insertion (Numeric) on ""Creditor No."(Field 170)".


        //Unsupported feature: Deletion on "City(Field 7).OnLookup".


        //Unsupported feature: Code Modification on "Contact(Field 8).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Vendor);
        ContactBusinessRelation.SETRANGE("No.","No.");
        #4..7

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          TempVend.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempVend,FALSE);
          VALIDATE("Primary Contact No.",Cont."No.");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
          VALIDATE("Primary Contact No.",Cont."No.");
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on "Contact(Field 8).OnValidate".

        //trigger (Variable: Cont)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Contact(Field 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF RMSetup.GET THEN
          IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN BEGIN
            IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') AND (Contact <> '') THEN BEGIN
        #4..7
            END;
            EXIT;
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10

        IF Cont.GET("Primary Contact No.") THEN
          IF Cont.Name = Contact THEN
            EXIT;

        VALIDATE("Primary Contact No.",'');
        */
        //end;

        //Unsupported feature: Deletion on ""Purchaser Code"(Field 29).OnValidate".



        //Unsupported feature: Code Modification on ""Country/Region Code"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCountryCode(City,"Post Code",County,"Country/Region Code");
        */
        //end;

        //Unsupported feature: Deletion on "Blocked(Field 39).OnValidate".


        //Unsupported feature: Deletion on ""Post Code"(Field 91).OnLookup".


        //Unsupported feature: Deletion (FieldCollection) on ""EORI Number"(Field 93)".


        //Unsupported feature: Deletion (FieldCollection) on ""Privacy Blocked"(Field 150)".


        //Unsupported feature: Deletion (FieldCollection) on ""Disable Search by Name"(Field 160)".

        // field(50800; "Legal Name"; Text[250])
        // {
        //     Description = 'GSS';
        // }
        // field(50801; "Send Statement Via Email"; Boolean)
        // {
        // }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);

    MoveEntries.MoveVendorEntries(Rec);
    #4..17
    ItemCrossReference.DELETEALL;

    PurchOrderLine.SETCURRENTKEY("Document Type","Pay-to Vendor No.");
    PurchOrderLine.SETRANGE("Pay-to Vendor No.","No.");
    IF PurchOrderLine.FINDFIRST THEN
      ERROR(
    #24..63
    PurchPrepmtPct.DELETEALL(TRUE);

    VATRegistrationLogMgt.DeleteVendorLog(Rec);

    CompanyInformation.CheckDeleteIntrastatContact(CompanyInformation."Intrastat Contact Type"::Vendor,"No.");

    CalendarManagement.DeleteCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Vendor,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
    PurchOrderLine.SETFILTER(
      "Document Type",'%1|%2',
      PurchOrderLine."Document Type"::Order,
      PurchOrderLine."Document Type"::"Return Order");
    #21..66
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF IsContactUpdateNeeded THEN BEGIN
      MODIFY;
      UpdateContFromVend.OnModify(Rec);
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
       ("Purchaser Code" <> xRec."Purchaser Code") OR
       ("Country/Region Code" <> xRec."Country/Region Code") OR
       ("Fax No." <> xRec."Fax No.") OR
       ("Telex Answer Back" <> xRec."Telex Answer Back") OR
       ("VAT Registration No." <> xRec."VAT Registration No.") OR
       ("Post Code" <> xRec."Post Code") OR
       (County <> xRec.County) OR
       ("E-Mail" <> xRec."E-Mail") OR
       ("Home Page" <> xRec."Home Page")
    THEN BEGIN
    #4..10
    */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    "Last Date Modified" := TODAY;
    IF xRec."Invoice Disc. Code" = xRec."No." THEN
      "Invoice Disc. Code" := "No.";

    CalendarManagement.RenameCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Vendor,"No.",xRec."No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    */
    //end;


    //Unsupported feature: Code Modification on "ShowContact(PROCEDURE 1)".

    //procedure ShowContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF OfficeMgt.GetContact(OfficeContact,"No.") AND (OfficeContact.COUNT = 1) THEN
      PAGE.RUN(PAGE::"Contact Card",OfficeContact)
    ELSE BEGIN
    #4..14
      END;
      COMMIT;

      Cont.FILTERGROUP(2);
      Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
      Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
      PAGE.RUN(PAGE::"Contact List",Cont);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    #19..22
    */
    //end;


    //Unsupported feature: Code Modification on "CheckBlockedVendOnDocs(PROCEDURE 4)".

    //procedure CheckBlockedVendOnDocs();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Vend2."Privacy Blocked" THEN
      VendPrivacyBlockedErrorMessage(Vend2,Transaction);

    IF Vend2.Blocked = Vend2.Blocked::All THEN
      VendBlockedErrorMessage(Vend2,Transaction);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Vend2.Blocked = Vend2.Blocked::All THEN
      VendBlockedErrorMessage(Vend2,Transaction);
    */
    //end;


    //Unsupported feature: Code Modification on "CheckBlockedVendOnJnls(PROCEDURE 5)".

    //procedure CheckBlockedVendOnJnls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH Vend2 DO BEGIN
      IF "Privacy Blocked" THEN
        VendPrivacyBlockedErrorMessage(Vend2,Transaction);

      IF (Blocked = Blocked::All) OR
         (Blocked = Blocked::Payment) AND (DocType = DocType::Payment)
      THEN
        VendBlockedErrorMessage(Vend2,Transaction);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH Vend2 DO BEGIN
    #5..9
    */
    //end;


    //Unsupported feature: Code Modification on "GetVendorNo(PROCEDURE 56)".

    //procedure GetVendorNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF VendorText = '' THEN
      EXIT('');

    #4..48
            EXIT(CreateNewVendor(COPYSTR(VendorText,1,MAXSTRLEN(Vendor.Name))));
        END;
      Vendor.RESET;
      NoFiltersApplied := TRUE;
    END;

    VendorNo := PickVendor(Vendor,NoFiltersApplied);
    IF VendorNo <> '' THEN
      EXIT(VendorNo);

    ERROR(SelectVendorErr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..51
    END;

    VendorNo := PickVendor(Vendor);
    #56..59
    */
    //end;


    //Unsupported feature: Code Modification on "PickVendor(PROCEDURE 58)".

    //procedure PickVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT NoFiltersApplied THEN
      MarkVendorsByFilters(Vendor);

    VendorList.SETTABLEVIEW(Vendor);
    VendorList.SETRECORD(Vendor);
    #6..9
      CLEAR(Vendor);

    EXIT(Vendor."No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Vendor.FINDSET THEN
      REPEAT
        Vendor.MARK(TRUE);
      UNTIL Vendor.NEXT = 0;
    IF Vendor.FINDFIRST THEN;
    Vendor.MARKEDONLY := TRUE;
    #3..12
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "GetVendorNo(PROCEDURE 56).NoFiltersApplied(Variable 1007)".


    //Unsupported feature: Deletion (ParameterCollection) on "PickVendor(PROCEDURE 58).NoFiltersApplied(Parameter 1002)".


    var
        Cont: Record Contact;
}

