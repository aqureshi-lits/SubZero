tableextension 60020 CustExt extends Customer
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 29)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due"(Field 66)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due (LCY)"(Field 67)".


        //Unsupported feature: Deletion on "City(Field 7).OnLookup".


        //Unsupported feature: Code Modification on "Contact(Field 8).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE("No.","No.");
        #4..7

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          TempCust.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempCust,FALSE);
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

        //Unsupported feature: Deletion on ""Salesperson Code"(Field 29).OnValidate".



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



        //Unsupported feature: Code Modification on "GLN(Field 90).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF GLN <> '' THEN
          GLNCalculator.AssertValidCheckDigit13(GLN);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //ITOS commented base code
        {
        IF GLN <> '' THEN
          GLNCalculator.AssertValidCheckDigit13(GLN);
        }
        //ITOS commented base code
        */
        //end;

        //Unsupported feature: Deletion on ""Post Code"(Field 91).OnLookup".


        //Unsupported feature: Deletion (FieldCollection) on ""EORI Number"(Field 93)".


        //Unsupported feature: Deletion (FieldCollection) on ""Use GLN in Electronic Document"(Field 95)".


        //Unsupported feature: Deletion (FieldCollection) on ""Privacy Blocked"(Field 150)".


        //Unsupported feature: Deletion (FieldCollection) on ""Disable Search by Name"(Field 160)".

        // field(50000; "Mobile No."; Code[50])
        // {
        // }
        // field(50001; "Ageing Days"; Decimal)
        // {
        //     Editable = false;
        // }
        // field(50510; "Vendor Code"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'ITOS';
        // }
        // field(50800; "Legal Name"; Text[250])
        // {
        // }
        // field(50801; "Customer Stmt. via Email"; Boolean)
        // {
        // }
        // field(51000; "Student Grade"; Code[20])
        // {
        //     Description = 'GSS-STU';
        //     TableRelation = Item;
        // }
        // field(51005; "Wrap Around Care"; Code[20])
        // {
        //     Description = 'GSS-STU';
        //     TableRelation = Item;
        // }
        // field(51009; Nursery; Code[50])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51020; "Student Status"; Option)
        // {
        //     Description = 'GSS-STU';
        //     OptionCaption = 'Prospect,Current,Left,Completed,Parent';
        //     OptionMembers = Prospect,Current,Left,Completed,Parent;
        // }
        // field(51050; "Next Invoice Date"; Date)
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51071; "Linked Students"; Code[150])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51081; "Admission Status"; Text[50])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51082; "Enrol Term"; Code[20])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51083; "Year of Entry"; Code[4])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51084; "Enrol Date"; Date)
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51085; Nationality; Code[30])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51086; Religiion; Code[30])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51087; "Date of Birth"; Date)
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51088; Gender; Code[10])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51089; "KHDA ID"; Code[20])
        // {
        //     Description = 'GSS-STU';
        // }
        // field(51100; "Bank Account No."; Code[20])
        // {
        //     Description = 'TAR300620.1';
        //     TableRelation = "Bank Account"."No.";
        // }

        field(61500; "LIT E-Mail2"; Text[80])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
            Description = 'LITS';
            ExtendedDatatype = EMail;
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);

    ServiceItem.SETRANGE("Customer No.","No.");
    #4..55
    END;

    SalesOrderLine.SETCURRENTKEY("Document Type","Bill-to Customer No.");
    SalesOrderLine.SETRANGE("Bill-to Customer No.","No.");
    IF SalesOrderLine.FINDFIRST THEN
      ERROR(
    #62..123
    VATRegistrationLogMgt.DeleteCustomerLog(Rec);

    DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");

    CalendarManagement.DeleteCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Customer,"No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..58
    SalesOrderLine.SETFILTER(
      "Document Type",'%1|%2',
      SalesOrderLine."Document Type"::Order,
      SalesOrderLine."Document Type"::"Return Order");
    #59..126
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
      UpdateContFromCust.OnModify(Rec);
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
       ("Salesperson Code" <> xRec."Salesperson Code") OR
       ("Country/Region Code" <> xRec."Country/Region Code") OR
       ("Fax No." <> xRec."Fax No.") OR
       ("Telex Answer Back" <> xRec."Telex Answer Back") OR
       ("VAT Registration No." <> xRec."VAT Registration No.") OR
       ("Post Code" <> xRec."Post Code") OR
       (County <> xRec.County) OR
       ("E-Mail" <> xRec."E-Mail") OR
       ("Home Page" <> xRec."Home Page") OR
       (Contact <> xRec.Contact)
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
    CustomerTemplate.SETRANGE("Invoice Disc. Code",xRec."No.");
    CustomerTemplate.MODIFYALL("Invoice Disc. Code","No.");

    CalendarManagement.RenameCustomizedBaseCalendarData(CustomizedCalendarChange."Source Type"::Customer,"No.",xRec."No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
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


    //Unsupported feature: Code Modification on "CheckBlockedCustOnDocs(PROCEDURE 5)".

    //procedure CheckBlockedCustOnDocs();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH Cust2 DO BEGIN
      IF "Privacy Blocked" THEN
        CustPrivacyBlockedErrorMessage(Cust2,Transaction);

      IF ((Blocked = Blocked::All) OR
          ((Blocked = Blocked::Invoice) AND
           (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"])) OR
    #8..11
      THEN
        CustBlockedErrorMessage(Cust2,Transaction);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH Cust2 DO BEGIN
    #5..14
    */
    //end;


    //Unsupported feature: Code Modification on "CheckBlockedCustOnJnls(PROCEDURE 7)".

    //procedure CheckBlockedCustOnJnls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH Cust2 DO BEGIN
      IF "Privacy Blocked" THEN
        CustPrivacyBlockedErrorMessage(Cust2,Transaction);

      IF (Blocked = Blocked::All) OR
         ((Blocked = Blocked::Invoice) AND (DocType IN [DocType::Invoice,DocType::" "]))
      THEN
        CustBlockedErrorMessage(Cust2,Transaction)
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH Cust2 DO BEGIN
    #5..9
    */
    //end;


    //Unsupported feature: Code Modification on "GetTotalAmountLCYCommon(PROCEDURE 17)".

    //procedure GetTotalAmountLCYCommon();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment("No.");
    ServOutstandingAmountFromShipment := ServiceLine.OutstandingInvoiceAmountFromShipment("No.");
    InvoicedPrepmtAmountLCY := GetInvoicedPrepmtAmountLCY;
    RetRcdNotInvAmountLCY := GetReturnRcdNotInvAmountLCY;

    EXIT("Balance (LCY)" + "Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" +
      "Outstanding Serv. Orders (LCY)" + "Serv Shipped Not Invoiced(LCY)" + "Outstanding Serv.Invoices(LCY)" -
      SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY - RetRcdNotInvAmountLCY);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    #5..7
      SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY);
    */
    //end;


    //Unsupported feature: Code Modification on "GetCustNoOpenCard(PROCEDURE 36)".

    //procedure GetCustNoOpenCard();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CustomerText = '' THEN
      EXIT('');

    #4..52
            EXIT(CreateNewCustomer(COPYSTR(CustomerText,1,MAXSTRLEN(Customer.Name)),ShowCustomerCard));
        END;
      Customer.RESET;
      NoFiltersApplied := TRUE;
    END;

    IF ShowCustomerCard THEN
      CustomerNo := PickCustomer(Customer,NoFiltersApplied)
    ELSE BEGIN
      LookupRequested := TRUE;
      EXIT('');
    #64..66
      EXIT(CustomerNo);

    ERROR(SelectCustErr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..55
    #57..59
      CustomerNo := PickCustomer(Customer)
    #61..69
    */
    //end;


    //Unsupported feature: Code Modification on "PickCustomer(PROCEDURE 51)".

    //procedure PickCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT NoFiltersApplied THEN
      MarkCustomersByFilters(Customer);

    CustomerList.SETTABLEVIEW(Customer);
    CustomerList.SETRECORD(Customer);
    #6..9
      CLEAR(Customer);

    EXIT(Customer."No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Customer.FINDSET THEN
      REPEAT
        Customer.MARK(TRUE);
      UNTIL Customer.NEXT = 0;
    IF Customer.FINDFIRST THEN;
    Customer.MARKEDONLY := TRUE;
    #3..12
    */
    //end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    //Unsupported feature: Deletion (VariableCollection) on "GetTotalAmountLCYCommon(PROCEDURE 17).RetRcdNotInvAmountLCY(Variable 1006)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCustNoOpenCard(PROCEDURE 36).NoFiltersApplied(Variable 1008)".


    //Unsupported feature: Deletion (ParameterCollection) on "PickCustomer(PROCEDURE 51).NoFiltersApplied(Parameter 1002)".

}

