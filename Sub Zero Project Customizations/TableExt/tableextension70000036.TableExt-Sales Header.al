tableextension 60035 SalHeaExt extends "Sales Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 43)".

        modify("Sell-to Customer Name")
        {
            TableRelation = Customer.Name;
        }

        //Unsupported feature: Code Insertion (VariableCollection) on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger (Variable: UserSetupRec)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        IF "No." = '' THEN
          InitRecord;
        TESTFIELD(Status,Status::Open);
        IF ("Sell-to Customer No." <> xRec."Sell-to Customer No.") AND
           (xRec."Sell-to Customer No." <> '')
        THEN BEGIN
          IF ("Opportunity No." <> '') AND ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) THEN
            ERROR(
              Text062,
        #11..105

        IF NOT SkipSellToContact THEN
          UpdateSellToCont("Sell-to Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          //ITOS
          IF (UserSetupRec.GET(USERID)) AND (UserSetupRec."Salesperson Filter") THEN
            ERROR('User cannot change the customer. Request your manager.');
          //ITOS
        #8..108
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        IF BilltoCustomerNoChanged THEN
        #4..33
        "Payment Terms Code" := Cust."Payment Terms Code";
        "Prepmt. Payment Terms Code" := Cust."Payment Terms Code";

        IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN BEGIN
          "Payment Method Code" := '';
          IF PaymentTerms.GET("Payment Terms Code") THEN
            IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
        #41..56
        "Invoice Disc. Code" := Cust."Invoice Disc. Code";
        "Customer Disc. Group" := Cust."Customer Disc. Group";
        "Language Code" := Cust."Language Code";
        SetSalespersonCode(Cust."Salesperson Code","Salesperson Code");
        "Combine Shipments" := Cust."Combine Shipments";
        Reserve := Cust.Reserve;
        IF "Document Type" = "Document Type"::Order THEN
          "Prepayment %" := Cust."Prepayment %";

        IF NOT BilltoCustomerNoChanged THEN
          IF ShippedSalesLinesExist THEN BEGIN
            TESTFIELD("Customer Disc. Group",xRec."Customer Disc. Group");
            TESTFIELD("Currency Code",xRec."Currency Code");
          END;

        CreateDim(
          DATABASE::Customer,"Bill-to Customer No.",
        #74..92

        "Bill-to IC Partner Code" := Cust."IC Partner Code";
        "Send IC Document" := ("Bill-to IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..36
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
        #38..59
        "Salesperson Code" := Cust."Salesperson Code";
        //ITOS
        CLEAR(UserSetup);
        IF UserSetup.GET("Creation User Id") THEN BEGIN
          IF UserSetup."Location Code" <> '' THEN
            VALIDATE("Location Code",UserSetup."Location Code");
          IF "Payment Terms Code" = 'CASH' THEN
              VALIDATE("Payment Method Code",UserSetup."Collection Bank Account");
        END;
        //ITOS
        #61..65
        IF NOT BilltoCustomerNoChanged THEN BEGIN
        #67..70
        END;
        #71..95
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Name"(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ShouldLookForCustomerByName("Bill-to Customer No.") THEN
          VALIDATE("Bill-to Customer No.",Customer.GetCustNo("Bill-to Name"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Bill-to Customer No.",Customer.GetCustNo("Bill-to Name"));
        */
        //end;

        //Unsupported feature: Deletion on ""Bill-to City"(Field 9).OnLookup".


        //Unsupported feature: Deletion on ""Ship-to City"(Field 17).OnLookup".



        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Posting Date");
        TestNoSeriesDate(
          "Posting No.","Posting No. Series",
          FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
        #5..26
          IF DeferralHeadersExist THEN
            ConfirmUpdateDeferralDate;
        SynchronizeAsmHeader;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #2..29
        */
        //end;


        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","No.");
          SalesLine.SETFILTER("Job Contract Entry No.",'<>%1',0);
          IF SalesLine.FIND('-') THEN BEGIN
            SalesLine.TESTFIELD("Job No.",'');
            SalesLine.TESTFIELD("Job Contract Entry No.",0);
          END;

          SalesLine.RESET;
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","No.");
          SalesLine.SETFILTER("Unit Price",'<>%1',0);
          SalesLine.SETFILTER("VAT %",'<>%1',0);
          IF SalesLine.FINDFIRST THEN BEGIN
            RecalculatePrice :=
              CONFIRM(
                STRSUBSTNO(
                  Text024,
                  FIELDCAPTION("Prices Including VAT"),SalesLine.FIELDCAPTION("Unit Price")),
                TRUE);
            SalesLine.SetSalesHeader(Rec);

            IF "Currency Code" = '' THEN
              Currency.InitRoundingPrecision
            ELSE
              Currency.GET("Currency Code");
            SalesLine.LOCKTABLE;
            LOCKTABLE;
            SalesLine.FINDSET;
            REPEAT
              SalesLine.TESTFIELD("Quantity Invoiced",0);
              SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
              IF NOT RecalculatePrice THEN BEGIN
                SalesLine."VAT Difference" := 0;
                SalesLine.UpdateAmounts;
              END ELSE BEGIN
                VatFactor := 1 + SalesLine."VAT %" / 100;
                IF VatFactor = 0 THEN
                  VatFactor := 1;
                IF NOT "Prices Including VAT" THEN
                  VatFactor := 1 / VatFactor;
                SalesLine."Unit Price" :=
                  ROUND(SalesLine."Unit Price" * VatFactor,Currency."Unit-Amount Rounding Precision");
                SalesLine."Line Discount Amount" :=
                  ROUND(
                    SalesLine.Quantity * SalesLine."Unit Price" * SalesLine."Line Discount %" / 100,
                    Currency."Amount Rounding Precision");
                LineInvDiscAmt := InvDiscRounding + SalesLine."Inv. Discount Amount" * VatFactor;
                SalesLine."Inv. Discount Amount" := ROUND(LineInvDiscAmt,Currency."Amount Rounding Precision");
                InvDiscRounding := LineInvDiscAmt - SalesLine."Inv. Discount Amount";
                IF "Prices Including VAT" THEN
                  SalesLine."Line Amount" := SalesLine."Amount Including VAT" + SalesLine."Inv. Discount Amount"
                ELSE
                  SalesLine."Line Amount" := SalesLine.Amount + SalesLine."Inv. Discount Amount";
              END;
              SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
          END;
          OnAfterChangePricesIncludingVAT(Rec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..25
            IF RecalculatePrice AND "Prices Including VAT" THEN
              SalesLine.MODIFYALL(Amount,0,TRUE);

        #26..38
              END ELSE
                IF "Prices Including VAT" THEN BEGIN
                  SalesLine."Unit Price" :=
                    ROUND(
                      SalesLine."Unit Price" * (1 + (SalesLine."VAT %" / 100)),
                      Currency."Unit-Amount Rounding Precision");
                  IF SalesLine.Quantity <> 0 THEN BEGIN
                    SalesLine."Line Discount Amount" :=
                      ROUND(
                        SalesLine.Quantity * SalesLine."Unit Price" * SalesLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    SalesLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        SalesLine."Inv. Discount Amount" * (1 + (SalesLine."VAT %" / 100)),
                        Currency."Amount Rounding Precision"));
                  END;
                END ELSE BEGIN
                  SalesLine."Unit Price" :=
                    ROUND(
                      SalesLine."Unit Price" / (1 + (SalesLine."VAT %" / 100)),
                      Currency."Unit-Amount Rounding Precision");
                  IF SalesLine.Quantity <> 0 THEN BEGIN
                    SalesLine."Line Discount Amount" :=
                      ROUND(
                        SalesLine.Quantity * SalesLine."Unit Price" * SalesLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    SalesLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        SalesLine."Inv. Discount Amount" / (1 + (SalesLine."VAT %" / 100)),
                        Currency."Amount Rounding Precision"));
                  END;
                END;
        #59..61
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Salesperson Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateSalesPersonOnSalesHeader(Rec,FALSE,FALSE);

        ApprovalEntry.SETRANGE("Table ID",DATABASE::"Sales Header");
        ApprovalEntry.SETRANGE("Document Type","Document Type");
        ApprovalEntry.SETRANGE("Document No.","No.");
        #6..12
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #3..15
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer Name"(Field 79).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ShouldLookForCustomerByName("Sell-to Customer No.") THEN
          VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
        GetShippingTime(FIELDNO("Sell-to Customer Name"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
        GetShippingTime(FIELDNO("Sell-to Customer Name"));
        */
        //end;

        //Unsupported feature: Deletion on ""Sell-to City"(Field 83).OnLookup".


        //Unsupported feature: Deletion on ""Bill-to Post Code"(Field 85).OnLookup".


        //Unsupported feature: Deletion on ""Sell-to Post Code"(Field 88).OnLookup".


        //Unsupported feature: Deletion on ""Ship-to Post Code"(Field 91).OnLookup".


        //Unsupported feature: Property Deletion (Editable) on "Status(Field 120)".



        //Unsupported feature: Code Modification on ""Sell-to Contact No."(Field 5052).OnValidate".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Sell-to Contact No." <> '' THEN
          IF Cont.GET("Sell-to Contact No.") THEN
            Cont.CheckIfPrivacyBlockedGeneric;

        IF ("Sell-to Contact No." <> xRec."Sell-to Contact No.") AND
           (xRec."Sell-to Contact No." <> '')
        #9..47

        UpdateSellToCust("Sell-to Contact No.");
        UpdateSellToCustTemplateCode;
        UpdateShipToContact;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        #6..50
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Contact No."(Field 5053).OnValidate".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Bill-to Contact No." <> '' THEN
          IF Cont.GET("Bill-to Contact No.") THEN
            Cont.CheckIfPrivacyBlockedGeneric;

        IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
           (xRec."Bill-to Contact No." <> '')
        #9..31
        END;

        UpdateBillToCust("Bill-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        #6..34
        */
        //end;

        //Unsupported feature: Property Deletion (DataClassification) on ""Assigned User ID"(Field 9000)".

        field(50001; "Creation User Id"; Code[50])
        {
            Description = 'ASH';
            TableRelation = "User Setup";

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                //ITOS
                CLEAR(UserSetup);
                IF UserSetup.GET("Creation User Id") THEN BEGIN
                    IF UserSetup."Location Code" <> '' THEN
                        VALIDATE("Location Code", UserSetup."Location Code");
                    IF "Payment Terms Code" = 'CASH' THEN
                        VALIDATE("Payment Method Code", UserSetup."Collection Bank Account");
                END;
                //ITOS
            end;
        }
        field(50010; "Term Start Date"; Date)
        {
            Description = 'GSS-STU';
        }
        field(50025; "Customer GLN"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.GLN WHERE("No." = FIELD("Sell-to Customer No.")));
            Description = 'ITOS';

        }
        field(50030; "Amount Excl. Excise"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("No.")));
            Description = 'ATOS-EXC1.2';
            Editable = false;

        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;
    InsertMode := TRUE;

    SetSellToCustomerFromFilter;

    IF GetFilterContNo <> '' THEN
      VALIDATE("Sell-to Contact No.",GetFilterContNo);

    IF "Salesperson Code" = '' THEN
      SetDefaultSalesperson;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    //GSS
    "Creation User Id" := USERID;
    //GSS
    //ITOS
    CLEAR(UserSetup);
    IF UserSetup.GET("Creation User Id") THEN BEGIN
      IF UserSetup."Location Code" <> '' THEN
        VALIDATE("Location Code",UserSetup."Location Code");
    END;
    //ITOS
    */
    //end;


    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;

    CASE "Document Type" OF
    #4..39
    END;

    IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::Quote] THEN
      "Shipment Date" := WORKDATE;

    IF NOT ("Document Type" IN ["Document Type"::"Blanket Order","Document Type"::Quote]) AND
       ("Posting Date" = 0D)
    #47..49
    IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN
      "Posting Date" := 0D;

    "Order Date" := WORKDATE;
    "Document Date" := WORKDATE;

    VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));
    #57..65

    "Responsibility Center" := UserSetupMgt.GetRespCenter(0,"Responsibility Center");
    "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..42
      BEGIN
      "Shipment Date" := WORKDATE;
      "Order Date" := WORKDATE;
    END;
    IF "Document Type" = "Document Type"::"Return Order" THEN
      "Order Date" := WORKDATE;
    #44..52
    #54..68
    */
    //end;


    //Unsupported feature: Code Modification on "ConfirmDeletion(PROCEDURE 11)".

    //procedure ConfirmDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceCodeSetup.GET;
    SourceCodeSetup.TESTFIELD("Deleted Document");
    SourceCode.GET(SourceCodeSetup."Deleted Document");

    PostSalesDelete.InitDeleteHeader(
      Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
      SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt,SourceCode.Code);

    IF SalesShptHeader."No." <> '' THEN
      IF NOT CONFIRM(Text009,TRUE,SalesShptHeader."No.") THEN
        EXIT;
    #12..24
      IF NOT CONFIRM(Text057,TRUE,SalesCrMemoHeaderPrepmt."No.") THEN
        EXIT;
    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #9..27
    */
    //end;


    //Unsupported feature: Code Modification on "RecreateSalesLines(PROCEDURE 4)".

    //procedure RecreateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SalesLinesExist THEN BEGIN
      IF HideValidationDialog OR NOT GUIALLOWED THEN
        Confirmed := TRUE
      ELSE BEGIN
        IF HasItemChargeAssignment THEN
          ConfirmText := ResetItemChargeAssignMsg
        ELSE
          ConfirmText := RecreateSalesLinesMsg;
        Confirmed := CONFIRM(ConfirmText,FALSE,ChangedFieldName);
      END;

      IF Confirmed THEN BEGIN
        SalesLine.LOCKTABLE;
        ItemChargeAssgntSales.LOCKTABLE;
    #15..19
        IF SalesLine.FINDSET THEN BEGIN
          TempReservEntry.DELETEALL;
          RecreateReservEntryReqLine(TempSalesLine,TempATOLink,ATOLink);
          TransferItemChargeAssgntSalesToTemp(ItemChargeAssgntSales,TempItemChargeAssgntSales);
          SalesLine.DELETEALL(TRUE);
          SalesLine.INIT;
    #26..64

            IF TempATOLink.AsmExistsForSalesLine(TempSalesLine) THEN BEGIN
              ATOLink := TempATOLink;
              ATOLink."Document Line No." := SalesLine."Line No.";
              ATOLink.INSERT;
              ATOLink.UpdateAsmFromSalesLineATOExist(SalesLine);
              TempATOLink.DELETE;
    #72..83
        ERROR(
          Text017,ChangedFieldName);
    END;

    SalesLine.BlockDynamicTracking(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      ELSE
        Confirmed :=
          CONFIRM(
            Text015,FALSE,ChangedFieldName);
    #12..22
          ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
          ItemChargeAssgntSales.SETRANGE("Document No.","No.");
    #23..67
    #69..86
    SalesLine.BlockDynamicTracking(FALSE);
    */
    //end;


    //Unsupported feature: Code Modification on "MessageIfSalesLinesExist(PROCEDURE 5)".

    //procedure MessageIfSalesLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SalesLinesExist AND NOT HideValidationDialog THEN BEGIN
      MessageText := STRSUBSTNO(LinesNotUpdatedMsg,ChangedFieldName);
      MessageText := STRSUBSTNO(SplitMessageTxt,MessageText,Text019);
      MESSAGE(MessageText);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF SalesLinesExist AND NOT HideValidationDialog THEN
      MESSAGE(
        Text018 +
        Text019,
        ChangedFieldName);
    */
    //end;


    //Unsupported feature: Code Modification on "PriceMessageIfSalesLinesExist(PROCEDURE 7)".

    //procedure PriceMessageIfSalesLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SalesLinesExist AND NOT HideValidationDialog THEN BEGIN
      MessageText := STRSUBSTNO(LinesNotUpdatedMsg,ChangedFieldName);
      IF "Currency Code" <> '' THEN
        MessageText := STRSUBSTNO(SplitMessageTxt,MessageText,AffectExchangeRateMsg);
      MESSAGE(MessageText);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF SalesLinesExist AND NOT HideValidationDialog THEN
      MESSAGE(
        Text018 +
        Text020,ChangedFieldName);
    */
    //end;

    //Unsupported feature: Property Deletion (Local) on "ValidateShortcutDimCode(PROCEDURE 19)".



    //Unsupported feature: Code Modification on "UpdateSellToCont(PROCEDURE 24)".

    //procedure UpdateSellToCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF OfficeMgt.GetContact(OfficeContact,CustomerNo) THEN BEGIN
      HideValidationDialog := TRUE;
      UpdateSellToCust(OfficeContact."No.");
    #4..17
        END;
        "Sell-to Contact" := Cust.Contact;
      END;
    IF "Sell-to Contact No." <> '' THEN
      IF OfficeContact.GET("Sell-to Contact No.") THEN
        OfficeContact.CheckIfPrivacyBlockedGeneric;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBillToCont(PROCEDURE 27)".

    //procedure UpdateBillToCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Cust.GET(CustomerNo) THEN BEGIN
      IF Cust."Primary Contact No." <> '' THEN
        "Bill-to Contact No." := Cust."Primary Contact No."
    #4..12
      END;
      "Bill-to Contact" := Cust.Contact;
    END;
    IF "Bill-to Contact No." <> '' THEN
      IF Contact.GET("Bill-to Contact No.") THEN
        Contact.CheckIfPrivacyBlockedGeneric;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    */
    //end;


    //Unsupported feature: Code Modification on "IsApprovedForPosting(PROCEDURE 53)".

    //procedure IsApprovedForPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
      IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
        ERROR(STRSUBSTNO(PrepaymentInvoicesNotPaidErr,"Document Type","No."));
      IF "Document Type" = "Document Type"::Order THEN
        IF PrepaymentMgt.TestSalesPayment(Rec) THEN
          ERROR(STRSUBSTNO(Text072,"Document Type","No."));
      EXIT(TRUE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
      IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
        ERROR(STRSUBSTNO(Text071,"Document Type","No."));
    #4..8
    */
    //end;


    //Unsupported feature: Code Modification on "CheckShippingAdvice(PROCEDURE 55)".

    //procedure CheckShippingAdvice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.SETRANGE("Document Type","Document Type");
    SalesLine.SETRANGE("Document No.","No.");
    SalesLine.SETRANGE("Drop Shipment",FALSE);
    SalesLine.SETRANGE(Type,SalesLine.Type::Item);
    Result := TRUE;
    IF SalesLine.FINDSET THEN
      REPEAT
        Item.GET(SalesLine."No.");
        IF SalesLine.IsShipment AND (Item.Type = Item.Type::Inventory) THEN BEGIN
          QtyToShipBaseTotal += SalesLine."Qty. to Ship (Base)";
          IF SalesLine."Quantity (Base)" <>
             SalesLine."Qty. to Ship (Base)" + SalesLine."Qty. Shipped (Base)"
    #13..17
      Result := TRUE;
    IF NOT Result THEN
      ERROR(ShippingAdviceErr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    #5..7
        IF SalesLine.IsShipment THEN BEGIN
    #10..20
    */
    //end;


    //Unsupported feature: Code Modification on "TransferItemChargeAssgntSalesToTemp(PROCEDURE 69)".

    //procedure TransferItemChargeAssgntSalesToTemp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
    ItemChargeAssgntSales.SETRANGE("Document No.","No.");
    IF ItemChargeAssgntSales.FINDSET THEN BEGIN
      REPEAT
        TempItemChargeAssgntSales.INIT;
        TempItemChargeAssgntSales := ItemChargeAssgntSales;
        TempItemChargeAssgntSales.INSERT;
      UNTIL ItemChargeAssgntSales.NEXT = 0;
      ItemChargeAssgntSales.DELETEALL;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #3..10
    */
    //end;

    //Unsupported feature: Property Deletion (Local) on "OnCheckSalesReleaseRestrictions(PROCEDURE 81)".



    //Unsupported feature: Code Modification on "UpdateCustomerAddress(PROCEDURE 89)".

    //procedure UpdateCustomerAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;
    IF SalesSetup."Ignore Updated Addresses" THEN
      EXIT;

    IF Customer.GET("Sell-to Customer No.") THEN
      IF NOT Customer.HasAddress THEN
        CASE TRUE OF
    #8..14
      IF Customer.GET("Bill-to Customer No.") THEN
        IF NOT Customer.HasAddress THEN
          CopyBillToCustomerAddressFieldsFromSalesDocument(Customer);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #5..17
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateShipToAddressFromSellToAddress(PROCEDURE 50)".

    //procedure UpdateShipToAddressFromSellToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Ship-to Code" = '') AND ShipToAddressEqualsOldSellToAddress THEN
      CASE FieldNumber OF
        FIELDNO("Ship-to Address"):
          "Ship-to Address" := "Sell-to Address";
        FIELDNO("Ship-to Address 2"):
          "Ship-to Address 2" := "Sell-to Address 2";
        FIELDNO("Ship-to City"),FIELDNO("Ship-to Post Code"):
          BEGIN
            "Ship-to City" := "Sell-to City";
            "Ship-to Post Code" := "Sell-to Post Code";
            "Ship-to County" := "Sell-to County";
            "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
          END;
        FIELDNO("Ship-to County"):
          "Ship-to County" := "Sell-to County";
        FIELDNO("Ship-to Country/Region Code"):
          "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
          IF xRec."Sell-to Address" = "Ship-to Address" THEN
            "Ship-to Address" := "Sell-to Address";
        FIELDNO("Ship-to Address 2"):
          IF xRec."Sell-to Address 2" = "Ship-to Address 2" THEN
            "Ship-to Address 2" := "Sell-to Address 2";
        FIELDNO("Ship-to City"),FIELDNO("Ship-to Post Code"):
          BEGIN
            IF xRec."Sell-to City" = "Ship-to City" THEN
              "Ship-to City" := "Sell-to City";
            IF xRec."Sell-to Post Code" = "Ship-to Post Code" THEN
              "Ship-to Post Code" := "Sell-to Post Code";
            IF xRec."Sell-to County" = "Ship-to County" THEN
              "Ship-to County" := "Sell-to County";
            IF xRec."Sell-to Country/Region Code" = "Ship-to Country/Region Code" THEN
              "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
          END;
        FIELDNO("Ship-to County"):
          IF xRec."Sell-to County" = "Ship-to County" THEN
            "Ship-to County" := "Sell-to County";
        FIELDNO("Ship-to Country/Region Code"):
          IF  xRec."Sell-to Country/Region Code" = "Ship-to Country/Region Code" THEN
            "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
      END;
    */
    //end;


    //Unsupported feature: Code Modification on "LookupContact(PROCEDURE 122)".

    //procedure LookupContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
    ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
    ContactBusinessRelation.SETRANGE("No.",CustomerNo);
    IF ContactBusinessRelation.FINDFIRST THEN
      Contact.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
    ELSE
      IF "Document Type" = "Document Type"::Quote THEN
        FilterByContactCompany := TRUE
      ELSE
        Contact.SETRANGE("Company No.",'');
    IF ContactNo <> '' THEN
      IF Contact.GET(ContactNo) THEN
        IF FilterByContactCompany THEN
          Contact.SETRANGE("Company No.",Contact."Company No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
      Contact.SETRANGE("Company No.",'');
    IF ContactNo <> '' THEN
      IF Contact.GET(ContactNo) THEN ;
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).SourceCode(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).SourceCodeSetup(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).PostSalesDelete(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreateSalesLines(PROCEDURE 4).ConfirmText(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "MessageIfSalesLinesExist(PROCEDURE 5).MessageText(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "PriceMessageIfSalesLinesExist(PROCEDURE 7).MessageText(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateBillToCont(PROCEDURE 27).Contact(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckShippingAdvice(PROCEDURE 55).Item(Variable 1003)".


    //Unsupported feature: Move on "CheckShippingAdvice(PROCEDURE 55).QtyToShipBaseTotal(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "LookupContact(PROCEDURE 122).FilterByContactCompany(Variable 1004)".


    var
        UserSetupRec: Record "User Setup";

    var
        Text015: Label 'If you change %1, the existing sales lines will be deleted and new sales lines based on the new information on the header will be created.\\Do you want to change %1?';

    var
        Text018: Label 'You have changed %1 on the sales header, but it has not been changed on the existing sales lines.\';

    var
        Text020: Label 'The change may affect the exchange rate used in the price calculation of the sales lines.';

    var
        Text071: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';

    var
        UserSetup: Record "User Setup";
}

