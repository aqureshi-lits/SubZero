tableextension 60037 PurHeaExt extends "Purchase Header"
{
    fields
    {

        field(60000; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 43)".


        // modify("Buy-from Vendor Name")
        // {
        //     TableRelation = Vendor.Name;
        // }

        //Unsupported feature: Property Insertion (Numeric) on ""Creditor No."(Field 170)".


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." = '' THEN
          InitRecord;
        TESTFIELD(Status,Status::Open);
        IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
           (xRec."Buy-from Vendor No." <> '')
        THEN BEGIN
          CheckDropShipmentLineExists;
          IF HideValidationDialog THEN
            Confirmed := TRUE
          ELSE
            Confirmed := CONFIRM(ConfirmChangeQst,FALSE,BuyFromVendorTxt);
          IF Confirmed THEN BEGIN
            IF InitFromVendor("Buy-from Vendor No.",FIELDCAPTION("Buy-from Vendor No.")) THEN
              EXIT;

            CheckReceiptInfo(PurchLine,FALSE);
            CheckPrepmtInfo(PurchLine);
            CheckReturnInfo(PurchLine,FALSE);

            PurchLine.RESET;
          END ELSE BEGIN
            Rec := xRec;
            EXIT;
          END;
        END;

        GetVend("Buy-from Vendor No.");
        Vend.CheckBlockedVendOnDocs(Vend,FALSE);
        Vend.TESTFIELD("Gen. Bus. Posting Group");
        "Buy-from Vendor Name" := Vend.Name;
        "Buy-from Vendor Name 2" := Vend."Name 2";
        CopyBuyFromVendorAddressFieldsFromVendor(Vend,FALSE);
        IF NOT SkipBuyFromContact THEN
          "Buy-from Contact" := Vend.Contact;
        "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
        "Tax Area Code" := Vend."Tax Area Code";
        "Tax Liable" := Vend."Tax Liable";
        "VAT Country/Region Code" := Vend."Country/Region Code";
        "VAT Registration No." := Vend."VAT Registration No.";
        VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
        "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
        ValidateEmptySellToCustomerAndLocation;

        IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN
          IF ReceivedPurchLinesExist OR ReturnShipmentExist THEN BEGIN
            TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
            TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
          END;

        "Buy-from IC Partner Code" := Vend."IC Partner Code";
        "Send IC Document" := ("Buy-from IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);

        IF Vend."Pay-to Vendor No." <> '' THEN
          VALIDATE("Pay-to Vendor No.",Vend."Pay-to Vendor No.")
        ELSE BEGIN
          IF "Buy-from Vendor No." = "Pay-to Vendor No." THEN
            SkipPayToContact := TRUE;
          VALIDATE("Pay-to Vendor No.","Buy-from Vendor No.");
          SkipPayToContact := FALSE;
        END;
        "Order Address Code" := '';

        CopyPayToVendorAddressFieldsFromVendor(Vend,FALSE);
        IF IsCreditDocType THEN BEGIN
          "Ship-to Name" := Vend.Name;
          "Ship-to Name 2" := Vend."Name 2";
          CopyShipToVendorAddressFieldsFromVendor(Vend,TRUE);
          "Ship-to Contact" := Vend.Contact;
          "Shipment Method Code" := Vend."Shipment Method Code";
          IF Vend."Location Code" <> '' THEN
            VALIDATE("Location Code",Vend."Location Code");
        END;

        IF (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") OR
           (xRec."Currency Code" <> "Currency Code") OR
           (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
           (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
        THEN
          RecreatePurchLines(BuyFromVendorTxt);

        IF NOT SkipBuyFromContact THEN
          UpdateBuyFromCont("Buy-from Vendor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..31
        CopyBuyFromVendorAddressFieldsFromVendor(Vend);
        #33..42
        VALIDATE("Sell-to Customer No.",'');
        VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
        #44..63
        VALIDATE("Order Address Code");
        #74..83
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND
           (xRec."Pay-to Vendor No." <> '')
        #4..24

        "Pay-to Name" := Vend.Name;
        "Pay-to Name 2" := Vend."Name 2";
        CopyPayToVendorAddressFieldsFromVendor(Vend,FALSE);
        IF NOT SkipPayToContact THEN
          "Pay-to Contact" := Vend.Contact;
        "Payment Terms Code" := Vend."Payment Terms Code";
        "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";

        IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN BEGIN
          "Payment Method Code" := '';
          IF PaymentTerms.GET("Payment Terms Code") THEN
            IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
              "Payment Method Code" := Vend."Payment Method Code"
        END ELSE
          "Payment Method Code" := Vend."Payment Method Code";

        IF "Buy-from Vendor No." = Vend."No." THEN
          "Shipment Method Code" := Vend."Shipment Method Code";
        "Vendor Posting Group" := Vend."Vendor Posting Group";
        GLSetup.GET;
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
        #47..52
        "Currency Code" := Vend."Currency Code";
        "Invoice Disc. Code" := Vend."Invoice Disc. Code";
        "Language Code" := Vend."Language Code";
        SetPurchaserCode(Vend."Purchaser Code","Purchaser Code");
        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        VALIDATE("Payment Method Code");
        #60..82
          UpdatePayToCont("Pay-to Vendor No.");

        "Pay-to IC Partner Code" := Vend."IC Partner Code";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..27
        CopyPayToVendorAddressFieldsFromVendor(Vend);
        #29..33
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
        #35..41
        "Shipment Method Code" := Vend."Shipment Method Code";
        #44..55
        "Purchaser Code" := Vend."Purchaser Code";
        #57..85
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Name"(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ShouldLookForVendorByName("Pay-to Vendor No.") THEN
          VALIDATE("Pay-to Vendor No.",Vendor.GetVendorNo("Pay-to Name"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Pay-to Vendor No.",Vendor.GetVendorNo("Pay-to Name"));
        */
        //end;

        //Unsupported feature: Deletion on ""Pay-to City"(Field 9).OnLookup".


        //Unsupported feature: Deletion on ""Ship-to City"(Field 17).OnLookup".



        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
          PurchLine.SETRANGE("Document Type","Document Type");
          PurchLine.SETRANGE("Document No.","No.");
          PurchLine.SETFILTER("Direct Unit Cost",'<>%1',0);
          PurchLine.SETFILTER("VAT %",'<>%1',0);
          IF PurchLine.FIND('-') THEN BEGIN
            RecalculatePrice :=
              CONFIRM(
                STRSUBSTNO(
                  Text025 +
                  Text027,
                  FIELDCAPTION("Prices Including VAT"),PurchLine.FIELDCAPTION("Direct Unit Cost")),
                TRUE);
            PurchLine.SetPurchHeader(Rec);

            IF "Currency Code" = '' THEN
              Currency.InitRoundingPrecision
            ELSE
              Currency.GET("Currency Code");

            PurchLine.FINDSET;
            REPEAT
              PurchLine.TESTFIELD("Quantity Invoiced",0);
              PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
              IF NOT RecalculatePrice THEN BEGIN
                PurchLine."VAT Difference" := 0;
                PurchLine.UpdateAmounts;
              END ELSE BEGIN
                VatFactor := 1 + PurchLine."VAT %" / 100;
                IF VatFactor = 0 THEN
                  VatFactor := 1;
                IF NOT "Prices Including VAT" THEN
                  VatFactor := 1 / VatFactor;
                PurchLine."Direct Unit Cost" :=
                  ROUND(PurchLine."Direct Unit Cost" * VatFactor,Currency."Unit-Amount Rounding Precision");
                PurchLine."Line Discount Amount" :=
                  ROUND(
                    PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100,
                    Currency."Amount Rounding Precision");
                LineInvDiscAmt := InvDiscRounding + PurchLine."Inv. Discount Amount" * VatFactor;
                PurchLine."Inv. Discount Amount" := ROUND(LineInvDiscAmt,Currency."Amount Rounding Precision");
                InvDiscRounding := LineInvDiscAmt - PurchLine."Inv. Discount Amount";
                IF "Prices Including VAT" THEN
                  PurchLine."Line Amount" := PurchLine."Amount Including VAT" + PurchLine."Inv. Discount Amount"
                ELSE
                  PurchLine."Line Amount" := PurchLine.Amount + PurchLine."Inv. Discount Amount";
              END;
              PurchLine.MODIFY;
            UNTIL PurchLine.NEXT = 0;
          END;
          OnAfterChangePricesIncludingVAT(Rec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..17
            IF RecalculatePrice AND "Prices Including VAT" THEN
              PurchLine.MODIFYALL(Amount,0,TRUE);

        #18..29
              END ELSE
                IF "Prices Including VAT" THEN BEGIN
                  PurchLine."Direct Unit Cost" :=
                    ROUND(
                      PurchLine."Direct Unit Cost" * (1 + PurchLine."VAT %" / 100),
                      Currency."Unit-Amount Rounding Precision");
                  IF PurchLine.Quantity <> 0 THEN BEGIN
                    PurchLine."Line Discount Amount" :=
                      ROUND(
                        PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    PurchLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        PurchLine."Inv. Discount Amount" * (1 + PurchLine."VAT %" / 100),
                        Currency."Amount Rounding Precision"));
                  END;
                END ELSE BEGIN
                  PurchLine."Direct Unit Cost" :=
                    ROUND(
                      PurchLine."Direct Unit Cost" / (1 + PurchLine."VAT %" / 100),
                      Currency."Unit-Amount Rounding Precision");
                  IF PurchLine.Quantity <> 0 THEN BEGIN
                    PurchLine."Line Discount Amount" :=
                      ROUND(
                        PurchLine.Quantity * PurchLine."Direct Unit Cost" * PurchLine."Line Discount %" / 100,
                        Currency."Amount Rounding Precision");
                    PurchLine.VALIDATE("Inv. Discount Amount",
                      ROUND(
                        PurchLine."Inv. Discount Amount" / (1 + PurchLine."VAT %" / 100),
                        Currency."Amount Rounding Precision"));
                  END;
                END;
        #50..52
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Purchaser Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidatePurchaserOnPurchHeader(Rec,FALSE,FALSE);

        ApprovalEntry.SETRANGE("Table ID",DATABASE::"Purchase Header");
        ApprovalEntry.SETRANGE("Document Type","Document Type");
        ApprovalEntry.SETRANGE("Document No.","No.");
        #6..11
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #3..14
        */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from Vendor Name"(Field 79).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ShouldLookForVendorByName("Pay-to Vendor No.") THEN
          VALIDATE("Buy-from Vendor No.",Vendor.GetVendorNo("Buy-from Vendor Name"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Buy-from Vendor No.",Vendor.GetVendorNo("Buy-from Vendor Name"));
        */
        //end;

        //Unsupported feature: Deletion on ""Buy-from City"(Field 83).OnLookup".


        //Unsupported feature: Deletion on ""Pay-to Post Code"(Field 85).OnLookup".


        //Unsupported feature: Deletion on ""Buy-from Post Code"(Field 88).OnLookup".


        //Unsupported feature: Deletion on ""Ship-to Post Code"(Field 91).OnLookup".



        //Unsupported feature: Code Modification on ""Order Address Code"(Field 95).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Order Address Code" <> '' THEN BEGIN
          OrderAddr.GET("Buy-from Vendor No.","Order Address Code");
          "Buy-from Vendor Name" := OrderAddr.Name;
        #4..19
          GetVend("Buy-from Vendor No.");
          "Buy-from Vendor Name" := Vend.Name;
          "Buy-from Vendor Name 2" := Vend."Name 2";
          CopyBuyFromVendorAddressFieldsFromVendor(Vend,TRUE);

          IF IsCreditDocType THEN BEGIN
            "Ship-to Name" := Vend.Name;
            "Ship-to Name 2" := Vend."Name 2";
            CopyShipToVendorAddressFieldsFromVendor(Vend,TRUE);
            "Ship-to Contact" := Vend.Contact;
            "Shipment Method Code" := Vend."Shipment Method Code";
            IF Vend."Location Code" <> '' THEN
              VALIDATE("Location Code",Vend."Location Code");
          END
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..22
          CopyPayToVendorAddressFieldsFromVendor(Vend);
        #24..27
            CopyShipToVendorAddressFieldsFromVendor(Vend);
        #29..34
        */
        //end;

        //Unsupported feature: Property Deletion (Editable) on "Status(Field 120)".



        //Unsupported feature: Code Insertion on ""Payment Reference"(Field 171)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from Contact No."(Field 5052).OnValidate".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Buy-from Contact No." <> '' THEN
          IF Cont.GET("Buy-from Contact No.") THEN
            Cont.CheckIfPrivacyBlockedGeneric;

        IF ("Buy-from Contact No." <> xRec."Buy-from Contact No.") AND
           (xRec."Buy-from Contact No." <> '')
        #9..31
        END;

        UpdateBuyFromVend("Buy-from Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        #6..34
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Contact No."(Field 5053).OnValidate".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);

        IF "Pay-to Contact No." <> '' THEN
          IF Cont.GET("Pay-to Contact No.") THEN
            Cont.CheckIfPrivacyBlockedGeneric;

        IF ("Pay-to Contact No." <> xRec."Pay-to Contact No.") AND
           (xRec."Pay-to Contact No." <> '')
        #9..31
        END;

        UpdatePayToVend("Pay-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        #6..34
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Partially Invoiced"(Field 5751)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Assigned User ID"(Field 9000)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50000)".

        field(50001; "Creation User Id"; Code[50])
        {
            Description = 'ASH';
            TableRelation = User;
        }
        field(50006; "Rcvd. Not Invoiced Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE("Document Type" = FIELD("Document Type"),
                                                                              "Document No." = FIELD("No."),
                                                                              "Amt. Rcd. Not Invoiced" = FILTER(<> 0)));
            Description = 'LITS';
            Editable = false;

        }
        field(50013; "Outstanding Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                          "Document No." = FIELD("No.")));
            Editable = false;

        }
        field(50021; "Terms & Conditions"; Code[20])
        {
            // Description = 'PO';
            // TableRelation = "TnC Header";
        }
        field(50050; "Vendor Reference Date"; Date)
        {
            Description = 'PO';
        }
        field(50051; "PO Details"; Text[250])
        {
            Description = 'GSS';
        }

        field(50061; "Over-Budget Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Purchase Line" WHERE("Document Type" = FIELD("Document Type"),
                                                       "Document No." = FIELD("No."),
                                                       "Over Budget" = CONST(true)));
            Description = 'POBGT';

        }
        field(50062; "Request No."; Code[20])
        {
            Description = 'PQREQ1.0';
        }
        field(50063; "Purch. Request"; Boolean)
        {
            Description = 'PQREQ1.0';
        }
        field(50064; "Port of Delivery"; Text[30])
        {
            Description = 'PREQ2.0';
        }
        field(50065; "Multiple Shipment"; Boolean)
        {
            Description = 'PREQ2.0';
        }
        field(50210; "Validity Date"; Date)
        {
            Description = 'PREQ2.0';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
      IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
        VALIDATE("Buy-from Vendor No.",GETRANGEMIN("Buy-from Vendor No."));

    IF "Purchaser Code" = '' THEN
      SetDefaultPurchaser;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT SkipInitialization THEN
      InitInsert;
    #2..5
    //GSS
    IF "Document Type" = "Document Type"::Quote THEN BEGIN
      IF "Buy-from Vendor No." = '' THEN
        VALIDATE("Buy-from Vendor No.",'Z');
    END;
    "Creation User Id" := USERID;
    //GSS
    */
    //end;


    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.GET;

    CASE "Document Type" OF
    #4..38
        END;
    END;

    IF "Document Type" = "Document Type"::Invoice THEN
      "Expected Receipt Date" := WORKDATE;

    #45..49
    IF PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" THEN
      "Posting Date" := 0D;

    "Order Date" := WORKDATE;
    "Document Date" := WORKDATE;

    ValidateEmptySellToCustomerAndLocation;

    IF IsCreditDocType THEN BEGIN
      GLSetup.GET;
    #60..66

    "Responsibility Center" := UserSetupMgt.GetRespCenter(1,"Responsibility Center");
    "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Purchase Header","Document Type","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..41
    IF "Document Type" IN
       ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Return Order","Document Type"::Quote]
    THEN
      "Order Date" := WORKDATE;

    #42..52
    "Document Date" := WORKDATE;

    VALIDATE("Sell-to Customer No.",'');
    #57..69
    */
    //end;


    //Unsupported feature: Code Modification on "TestNoSeries(PROCEDURE 6)".

    //procedure TestNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.GET;
    CASE "Document Type" OF
      "Document Type"::Quote:
        PurchSetup.TESTFIELD("Quote Nos.");
      "Document Type"::Order:
        PurchSetup.TESTFIELD("Order Nos.");
      "Document Type"::Invoice:
    #8..18
      "Document Type"::"Blanket Order":
        PurchSetup.TESTFIELD("Blanket Order Nos.");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PurchSetup.GET;
    CASE "Document Type" OF
       //ATOS
      { //commented based code
      "Document Type"::Quote:
        PurchSetup.TESTFIELD("Quote Nos.");
      } //commented base code
      "Document Type"::Quote:
        IF "Purch. Request" THEN
          PurchSetup.TESTFIELD("Request Nos.")
        ELSE
          PurchSetup.TESTFIELD("Quote Nos.");
      //ATOS
    #5..21
    */
    //end;


    //Unsupported feature: Code Modification on "GetNoSeriesCode(PROCEDURE 9)".

    //procedure GetNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE "Document Type" OF
      "Document Type"::Quote:
        NoSeriesCode := PurchSetup."Quote Nos.";
      "Document Type"::Order:
        NoSeriesCode := PurchSetup."Order Nos.";
      "Document Type"::Invoice:
    #7..12
        NoSeriesCode := PurchSetup."Blanket Order Nos.";
    END;
    EXIT(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode,SelectNoSeriesAllowed,"No. Series"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CASE "Document Type" OF
      //ATOS
      { //commented based code

      "Document Type"::Quote:
        NoSeriesCode := PurchSetup."Quote Nos.";
      } //commented base code
      "Document Type"::Quote:
        IF "Purch. Request" THEN
          NoSeriesCode := PurchSetup."Request Nos."
        ELSE
          NoSeriesCode := PurchSetup."Quote Nos.";
      //ATOS
    #4..15
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

    PostPurchDelete.InitDeleteHeader(
      Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
      ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt,SourceCode.Code);

    IF PurchRcptHeader."No." <> '' THEN
      IF NOT CONFIRM(Text009,TRUE,PurchRcptHeader."No.")
      THEN
    #12..30
      THEN
        EXIT;
    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #9..33
    */
    //end;


    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT PurchLinesExist THEN
      EXIT;

    IF HideValidationDialog OR NOT GUIALLOWED THEN
      Confirmed := TRUE
    ELSE BEGIN
      IF HasItemChargeAssignment THEN
        ConfirmText := ResetItemChargeAssignMsg
      ELSE
        ConfirmText := RecreatePurchLinesMsg;
      Confirmed := CONFIRM(ConfirmText,FALSE,ChangedFieldName);
    END;

    IF Confirmed THEN BEGIN
      PurchLine.LOCKTABLE;
      ItemChargeAssgntPurch.LOCKTABLE;
      MODIFY;

      PurchLine.RESET;
      PurchLine.SETRANGE("Document Type","Document Type");
      PurchLine.SETRANGE("Document No.","No.");
      IF PurchLine.FINDSET THEN BEGIN
        REPEAT
          PurchLine.TESTFIELD("Quantity Received",0);
          PurchLine.TESTFIELD("Quantity Invoiced",0);
          PurchLine.TESTFIELD("Return Qty. Shipped",0);
          PurchLine.CALCFIELDS("Reserved Qty. (Base)");
          PurchLine.TESTFIELD("Reserved Qty. (Base)",0);
          PurchLine.TESTFIELD("Receipt No.",'');
          PurchLine.TESTFIELD("Return Shipment No.",'');
          PurchLine.TESTFIELD("Blanket Order No.",'');
          IF PurchLine."Drop Shipment" OR PurchLine."Special Order" THEN BEGIN
            CASE TRUE OF
              PurchLine."Drop Shipment":
                SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Sales Order No.");
              PurchLine."Special Order":
                SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Special Order Sales No.");
            END;
            TESTFIELD("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
            TESTFIELD("Ship-to Code",SalesHeader."Ship-to Code");
          END;

          PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
          TempPurchLine := PurchLine;
          IF PurchLine.Nonstock THEN BEGIN
            PurchLine.Nonstock := FALSE;
            PurchLine.MODIFY;
          END;
          TempPurchLine.INSERT;
        UNTIL PurchLine.NEXT = 0;

        TransferItemChargeAssgntPurchToTemp(ItemChargeAssgntPurch,TempItemChargeAssgntPurch);

        PurchLine.DELETEALL(TRUE);

        PurchLine.INIT;
        PurchLine."Line No." := 0;
        TempPurchLine.FINDSET;
        ExtendedTextAdded := FALSE;
        REPEAT
          IF TempPurchLine."Attached to Line No." = 0 THEN BEGIN
            PurchLine.INIT;
            PurchLine."Line No." := PurchLine."Line No." + 10000;
            PurchLine.VALIDATE(Type,TempPurchLine.Type);
            IF TempPurchLine."No." = '' THEN BEGIN
              PurchLine.VALIDATE(Description,TempPurchLine.Description);
              PurchLine.VALIDATE("Description 2",TempPurchLine."Description 2");
            END ELSE BEGIN
              PurchLine.VALIDATE("No.",TempPurchLine."No.");
              IF PurchLine.Type <> PurchLine.Type::" " THEN
                CASE TRUE OF
                  TempPurchLine."Drop Shipment":
                    TransferSavedFieldsDropShipment(PurchLine,TempPurchLine);
                  TempPurchLine."Special Order":
                    TransferSavedFieldsSpecialOrder(PurchLine,TempPurchLine);
                  ELSE
                    TransferSavedFields(PurchLine,TempPurchLine);
                END;
            END;

            PurchLine.INSERT;
            ExtendedTextAdded := FALSE;

            IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
              ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
              TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",TempPurchLine."Document Type");
              TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",TempPurchLine."Document No.");
              TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.",TempPurchLine."Line No.");
              IF TempItemChargeAssgntPurch.FINDSET THEN
                REPEAT
                  IF NOT TempItemChargeAssgntPurch.MARK THEN BEGIN
                    TempItemChargeAssgntPurch."Applies-to Doc. Line No." := PurchLine."Line No.";
                    TempItemChargeAssgntPurch.Description := PurchLine.Description;
                    TempItemChargeAssgntPurch.MODIFY;
                    TempItemChargeAssgntPurch.MARK(TRUE);
                  END;
                UNTIL TempItemChargeAssgntPurch.NEXT = 0;
            END;
            IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
              TempInteger.INIT;
              TempInteger.Number := PurchLine."Line No.";
              TempInteger.INSERT;
            END;
          END ELSE
            IF NOT ExtendedTextAdded THEN BEGIN
              TransferExtendedText.PurchCheckIfAnyExtText(PurchLine,TRUE);
              TransferExtendedText.InsertPurchExtText(PurchLine);
              PurchLine.FINDLAST;
              ExtendedTextAdded := TRUE;
            END;
        UNTIL TempPurchLine.NEXT = 0;

        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempPurchLine.SETRANGE(Type,PurchLine.Type::"Charge (Item)");
        IF TempPurchLine.FINDSET THEN
          REPEAT
            TempItemChargeAssgntPurch.SETRANGE("Document Line No.",TempPurchLine."Line No.");
            IF TempItemChargeAssgntPurch.FINDSET THEN BEGIN
              REPEAT
                TempInteger.FINDFIRST;
                ItemChargeAssgntPurch.INIT;
                ItemChargeAssgntPurch := TempItemChargeAssgntPurch;
                ItemChargeAssgntPurch."Document Line No." := TempInteger.Number;
                ItemChargeAssgntPurch.VALIDATE("Unit Cost",0);
                ItemChargeAssgntPurch.INSERT;
              UNTIL TempItemChargeAssgntPurch.NEXT = 0;
              TempInteger.DELETE;
            END;
          UNTIL TempPurchLine.NEXT = 0;

        TempPurchLine.SETRANGE(Type);
        TempPurchLine.DELETEALL;
        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempItemChargeAssgntPurch.DELETEALL;
      END;
    END ELSE
      ERROR(
        Text018,ChangedFieldName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF PurchLinesExist THEN BEGIN
      IF HideValidationDialog THEN
        Confirmed := TRUE
      ELSE
        Confirmed :=
          CONFIRM(
            Text016 +
            ConfirmChangeQst,FALSE,ChangedFieldName);
      IF Confirmed THEN BEGIN
        PurchLine.LOCKTABLE;
        ItemChargeAssgntPurch.LOCKTABLE;
        MODIFY;

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        IF PurchLine.FINDSET THEN BEGIN
          REPEAT
            PurchLine.TESTFIELD("Quantity Received",0);
            PurchLine.TESTFIELD("Quantity Invoiced",0);
            PurchLine.TESTFIELD("Return Qty. Shipped",0);
            PurchLine.CALCFIELDS("Reserved Qty. (Base)");
            PurchLine.TESTFIELD("Reserved Qty. (Base)",0);
            PurchLine.TESTFIELD("Receipt No.",'');
            PurchLine.TESTFIELD("Return Shipment No.",'');
            PurchLine.TESTFIELD("Blanket Order No.",'');
            IF PurchLine."Drop Shipment" OR PurchLine."Special Order" THEN BEGIN
              CASE TRUE OF
                PurchLine."Drop Shipment":
                  SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Sales Order No.");
                PurchLine."Special Order":
                  SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Special Order Sales No.");
              END;
              TESTFIELD("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
              TESTFIELD("Ship-to Code",SalesHeader."Ship-to Code");
            END;

            PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
            TempPurchLine := PurchLine;
            IF PurchLine.Nonstock THEN BEGIN
              PurchLine.Nonstock := FALSE;
              PurchLine.MODIFY;
            END;
            TempPurchLine.INSERT;
          UNTIL PurchLine.NEXT = 0;

          ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
          ItemChargeAssgntPurch.SETRANGE("Document No.","No.");
          IF ItemChargeAssgntPurch.FINDSET THEN BEGIN
            REPEAT
              TempItemChargeAssgntPurch.INIT;
              TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
              TempItemChargeAssgntPurch.INSERT;
            UNTIL ItemChargeAssgntPurch.NEXT = 0;
            ItemChargeAssgntPurch.DELETEALL;
          END;

          PurchLine.DELETEALL(TRUE);

          PurchLine.INIT;
          PurchLine."Line No." := 0;
          TempPurchLine.FINDSET;
          ExtendedTextAdded := FALSE;
          REPEAT
            IF TempPurchLine."Attached to Line No." = 0 THEN BEGIN
              PurchLine.INIT;
              PurchLine."Line No." := PurchLine."Line No." + 10000;
              PurchLine.VALIDATE(Type,TempPurchLine.Type);
              IF TempPurchLine."No." = '' THEN BEGIN
                PurchLine.VALIDATE(Description,TempPurchLine.Description);
                PurchLine.VALIDATE("Description 2",TempPurchLine."Description 2");
              END ELSE BEGIN
                PurchLine.VALIDATE("No.",TempPurchLine."No.");
                IF PurchLine.Type <> PurchLine.Type::" " THEN
                  CASE TRUE OF
                    TempPurchLine."Drop Shipment":
                      TransferSavedFieldsDropShipment(PurchLine,TempPurchLine);
                    TempPurchLine."Special Order":
                      TransferSavedFieldsSpecialOrder(PurchLine,TempPurchLine);
                    ELSE
                      TransferSavedFields(PurchLine,TempPurchLine);
                  END;
              END;
              //A

              //A
              PurchLine.INSERT;
              ExtendedTextAdded := FALSE;

              IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
                ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",TempPurchLine."Document Type");
                TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",TempPurchLine."Document No.");
                TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.",TempPurchLine."Line No.");
                IF TempItemChargeAssgntPurch.FINDSET THEN
                  REPEAT
                    IF NOT TempItemChargeAssgntPurch.MARK THEN BEGIN
                      TempItemChargeAssgntPurch."Applies-to Doc. Line No." := PurchLine."Line No.";
                      TempItemChargeAssgntPurch.Description := PurchLine.Description;
                      TempItemChargeAssgntPurch.MODIFY;
                      TempItemChargeAssgntPurch.MARK(TRUE);
                    END;
                  UNTIL TempItemChargeAssgntPurch.NEXT = 0;
              END;
              IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
                TempInteger.INIT;
                TempInteger.Number := PurchLine."Line No.";
                TempInteger.INSERT;
              END;
            END ELSE
              IF NOT ExtendedTextAdded THEN BEGIN
                TransferExtendedText.PurchCheckIfAnyExtText(PurchLine,TRUE);
                TransferExtendedText.InsertPurchExtText(PurchLine);
                PurchLine.FINDLAST;
                ExtendedTextAdded := TRUE;
              END;
          UNTIL TempPurchLine.NEXT = 0;

          ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
          TempPurchLine.SETRANGE(Type,PurchLine.Type::"Charge (Item)");
          IF TempPurchLine.FINDSET THEN
            REPEAT
              TempItemChargeAssgntPurch.SETRANGE("Document Line No.",TempPurchLine."Line No.");
              IF TempItemChargeAssgntPurch.FINDSET THEN BEGIN
                REPEAT
                  TempInteger.FINDFIRST;
                  ItemChargeAssgntPurch.INIT;
                  ItemChargeAssgntPurch := TempItemChargeAssgntPurch;
                  ItemChargeAssgntPurch."Document Line No." := TempInteger.Number;
                  ItemChargeAssgntPurch.VALIDATE("Unit Cost",0);
                  ItemChargeAssgntPurch.INSERT;
                UNTIL TempItemChargeAssgntPurch.NEXT = 0;
                TempInteger.DELETE;
              END;
            UNTIL TempPurchLine.NEXT = 0;

          TempPurchLine.SETRANGE(Type);
          TempPurchLine.DELETEALL;
          ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
          TempItemChargeAssgntPurch.DELETEALL;
        END;
      END ELSE
        ERROR(
          Text018,ChangedFieldName);
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "TransferSavedFields(PROCEDURE 72)".

    //procedure TransferSavedFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DestinationPurchaseLine.VALIDATE("Unit of Measure Code",SourcePurchaseLine."Unit of Measure Code");
    DestinationPurchaseLine.VALIDATE("Variant Code",SourcePurchaseLine."Variant Code");
    DestinationPurchaseLine."Prod. Order No." := SourcePurchaseLine."Prod. Order No.";
    #4..23
    DestinationPurchaseLine."Work Center No." := SourcePurchaseLine."Work Center No.";
    DestinationPurchaseLine."Prod. Order Line No." := SourcePurchaseLine."Prod. Order Line No.";
    DestinationPurchaseLine."Overhead Rate" := SourcePurchaseLine."Overhead Rate";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
    //A
    DestinationPurchaseLine.Narration := SourcePurchaseLine.Narration;
    DestinationPurchaseLine.VALIDATE("Direct Unit Cost",SourcePurchaseLine."Direct Unit Cost");
    //A
    */
    //end;


    //Unsupported feature: Code Modification on "MessageIfPurchLinesExist(PROCEDURE 5)".

    //procedure MessageIfPurchLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PurchLinesExist AND NOT HideValidationDialog THEN BEGIN
      MessageText := STRSUBSTNO(LinesNotUpdatedMsg,ChangedFieldName);
      MessageText := STRSUBSTNO(SplitMessageTxt,MessageText,Text020);
      MESSAGE(MessageText);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF PurchLinesExist AND NOT HideValidationDialog THEN
      MESSAGE(
        Text019 +
        Text020,
        ChangedFieldName);
    */
    //end;


    //Unsupported feature: Code Modification on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".

    //procedure PriceMessageIfPurchLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PurchLinesExist AND NOT HideValidationDialog THEN BEGIN
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
    IF PurchLinesExist AND NOT HideValidationDialog THEN
      MESSAGE(
        Text019 +
        Text021,ChangedFieldName);
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBuyFromCont(PROCEDURE 24)".

    //procedure UpdateBuyFromCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF OfficeMgt.GetContact(OfficeContact,VendorNo) THEN BEGIN
      SetHideValidationDialog(TRUE);
      UpdateBuyFromVend(OfficeContact."No.");
    #4..17
        END;
        "Buy-from Contact" := Vend.Contact;
      END;

    IF "Buy-from Contact No." <> '' THEN
      IF OfficeContact.GET("Buy-from Contact No.") THEN
        OfficeContact.CheckIfPrivacyBlockedGeneric;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
    */
    //end;


    //Unsupported feature: Code Modification on "UpdatePayToCont(PROCEDURE 27)".

    //procedure UpdatePayToCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Vend.GET(VendorNo) THEN BEGIN
      IF Vend."Primary Contact No." <> '' THEN
        "Pay-to Contact No." := Vend."Primary Contact No."
    #4..12
      END;
      "Pay-to Contact" := Vend.Contact;
    END;

    IF "Pay-to Contact No." <> '' THEN
      IF Contact.GET("Pay-to Contact No.") THEN
        Contact.CheckIfPrivacyBlockedGeneric;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    */
    //end;


    //Unsupported feature: Code Modification on "IsApprovedForPosting(PROCEDURE 50)".

    //procedure IsApprovedForPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
      IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
        ERROR(STRSUBSTNO(PrepaymentInvoicesNotPaidErr,"Document Type","No."));
      IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
        IF NOT CONFIRM(STRSUBSTNO(Text054,"Document Type","No."),TRUE) THEN
          EXIT(FALSE);
      EXIT(TRUE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
      IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
        ERROR(STRSUBSTNO(Text053,"Document Type","No."));
    #4..8
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PurchLine3) (VariableCollection) on "AddSpecialOrderToAddress(PROCEDURE 80)".


    //Unsupported feature: Variable Insertion (Variable: LocationCode) (VariableCollection) on "AddSpecialOrderToAddress(PROCEDURE 80)".



    //Unsupported feature: Code Modification on "AddSpecialOrderToAddress(PROCEDURE 80)".

    //procedure AddSpecialOrderToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ShowError THEN
      IF PurchLinesExist THEN BEGIN
        PurchaseHeader := Rec;
        PurchaseHeader.SetShipToForSpecOrder;
        IF "Ship-to Name" <> PurchaseHeader."Ship-to Name" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Name"),"No.",SalesHeader."No.");
        IF "Ship-to Name 2" <> PurchaseHeader."Ship-to Name 2" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Name 2"),"No.",SalesHeader."No.");
        IF "Ship-to Address" <> PurchaseHeader."Ship-to Address" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Address"),"No.",SalesHeader."No.");
        IF "Ship-to Address 2" <> PurchaseHeader."Ship-to Address 2" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Address 2"),"No.",SalesHeader."No.");
        IF "Ship-to Post Code" <> PurchaseHeader."Ship-to Post Code" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Post Code"),"No.",SalesHeader."No.");
        IF "Ship-to City" <> PurchaseHeader."Ship-to City" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to City"),"No.",SalesHeader."No.");
        IF "Ship-to Contact" <> PurchaseHeader."Ship-to Contact" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Contact"),"No.",SalesHeader."No.");
      END ELSE
        SetShipToForSpecOrder;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ShowError THEN BEGIN
      PurchLine3.RESET;
      PurchLine3.SETRANGE("Document Type","Document Type"::Order);
      PurchLine3.SETRANGE("Document No.","No.");
      IF NOT PurchLine3.ISEMPTY THEN BEGIN
        LocationCode.GET("Location Code");
        IF "Ship-to Name" <> LocationCode.Name THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Name"),"No.",SalesHeader."No.");
        IF "Ship-to Name 2" <> LocationCode."Name 2" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Name 2"),"No.",SalesHeader."No.");
        IF "Ship-to Address" <> LocationCode.Address THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Address"),"No.",SalesHeader."No.");
        IF "Ship-to Address 2" <> LocationCode."Address 2" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Address 2"),"No.",SalesHeader."No.");
        IF "Ship-to Post Code" <> LocationCode."Post Code" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Post Code"),"No.",SalesHeader."No.");
        IF "Ship-to City" <> LocationCode.City THEN
          ERROR(Text052,FIELDCAPTION("Ship-to City"),"No.",SalesHeader."No.");
        IF "Ship-to Contact" <> LocationCode.Contact THEN
    #18..20
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Local) on "OnCheckPurchaseReleaseRestrictions(PROCEDURE 55)".



    //Unsupported feature: Code Modification on "UpdateVendorAddress(PROCEDURE 89)".

    //procedure UpdateVendorAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.GET;
    IF PurchSetup."Ignore Updated Addresses" THEN
      EXIT;

    IF Vendor.GET("Buy-from Vendor No.") THEN
      IF NOT Vendor.HasAddress THEN
        CopyBuyFromVendorAddressFieldsFromPurchaseDocument(Vendor);

    IF "Pay-to Vendor No." <> "Buy-from Vendor No." THEN
      IF Vendor.GET("Pay-to Vendor No.") THEN
        IF NOT Vendor.HasAddress THEN
          CopyPayToVendorAddressFieldsFromPurchaseDocument(Vendor);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #5..12
    */
    //end;


    //Unsupported feature: Code Modification on "CopyBuyFromVendorAddressFieldsFromVendor(PROCEDURE 62)".

    //procedure CopyBuyFromVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) OR ForceCopy THEN BEGIN
      "Buy-from Address" := BuyFromVendor.Address;
      "Buy-from Address 2" := BuyFromVendor."Address 2";
      "Buy-from City" := BuyFromVendor.City;
      "Buy-from Post Code" := BuyFromVendor."Post Code";
      "Buy-from County" := BuyFromVendor.County;
      "Buy-from Country/Region Code" := BuyFromVendor."Country/Region Code";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
    #2..8
    */
    //end;


    //Unsupported feature: Code Modification on "CopyShipToVendorAddressFieldsFromVendor(PROCEDURE 98)".

    //procedure CopyShipToVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) OR ForceCopy THEN BEGIN
      "Ship-to Address" := BuyFromVendor.Address;
      "Ship-to Address 2" := BuyFromVendor."Address 2";
      "Ship-to City" := BuyFromVendor.City;
      "Ship-to Post Code" := BuyFromVendor."Post Code";
      "Ship-to County" := BuyFromVendor.County;
      VALIDATE("Ship-to Country/Region Code",BuyFromVendor."Country/Region Code");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
    #2..8
    */
    //end;


    //Unsupported feature: Code Modification on "CopyPayToVendorAddressFieldsFromVendor(PROCEDURE 63)".

    //procedure CopyPayToVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PayToVendorIsReplaced OR ShouldCopyAddressFromPayToVendor(PayToVendor) OR ForceCopy THEN BEGIN
      "Pay-to Address" := PayToVendor.Address;
      "Pay-to Address 2" := PayToVendor."Address 2";
      "Pay-to City" := PayToVendor.City;
      "Pay-to Post Code" := PayToVendor."Post Code";
      "Pay-to County" := PayToVendor.County;
      "Pay-to Country/Region Code" := PayToVendor."Country/Region Code";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF PayToVendorIsReplaced OR ShouldCopyAddressFromPayToVendor(PayToVendor) THEN BEGIN
    #2..8
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DummyReportSelections) (VariableCollection) on "SendRecords(PROCEDURE 75)".



    //Unsupported feature: Code Modification on "SendRecords(PROCEDURE 75)".

    //procedure SendRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetReportSelectionsUsageFromDocumentType(ReportSelections.Usage,DocTxt);
    DocumentSendingProfile.SendVendorRecords(
      ReportSelections.Usage,Rec,DocTxt,"Buy-from Vendor No.","No.",
      FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocumentSendingProfile.SendVendorRecords(
      DummyReportSelections.Usage::"P.Order",Rec,DocTxt,"Buy-from Vendor No.","No.",
      FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    */
    //end;


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 74)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentSendingProfile.TrySendToPrinterVendor(
      DummyReportSelections.Usage::"P.Order",Rec,FIELDNO("Buy-from Vendor No."),ShowRequestForm);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocumentSendingProfile.TrySendToPrinterVendor(
      DummyReportSelections.Usage::"P.Order",Rec,"Buy-from Vendor No.",ShowRequestForm);
    */
    //end;


    //Unsupported feature: Code Modification on "SendProfile(PROCEDURE 73)".

    //procedure SendProfile();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentSendingProfile.SendVendor(
      DummyReportSelections.Usage::"P.Order",Rec,"No.","Buy-from Vendor No.",
      PurchOrderDocTxt,FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DocumentSendingProfile.SendVendor(
      DummyReportSelections.Usage::"P.Order",Rec,"No.","Buy-from Vendor No.",
      DocTxt,FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "SkipInitialization(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Name) on "ValidateEmptySellToCustomerAndLocation(PROCEDURE 42)".



    //Unsupported feature: Code Modification on "ValidateEmptySellToCustomerAndLocation(PROCEDURE 42)".

    //procedure ValidateEmptySellToCustomerAndLocation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VALIDATE("Sell-to Customer No.",'');
    VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "No." = '' THEN
      EXIT(FALSE);

    IF "Buy-from Vendor No." = '' THEN
      EXIT(FALSE);

    IF xRec."Document Type" <> "Document Type" THEN
      EXIT(FALSE);

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
      IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
        IF "Buy-from Vendor No." = GETRANGEMIN("Buy-from Vendor No.") THEN
          EXIT(FALSE);

    EXIT(TRUE);
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).SourceCode(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).SourceCodeSetup(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ConfirmDeletion(PROCEDURE 11).PostPurchDelete(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).ConfirmText(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "MessageIfPurchLinesExist(PROCEDURE 5).MessageText(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "PriceMessageIfPurchLinesExist(PROCEDURE 7).MessageText(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePayToCont(PROCEDURE 27).Contact(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "AddSpecialOrderToAddress(PROCEDURE 80).PurchaseHeader(Variable 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "CopyBuyFromVendorAddressFieldsFromVendor(PROCEDURE 62).ForceCopy(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CopyShipToVendorAddressFieldsFromVendor(PROCEDURE 98).ForceCopy(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CopyPayToVendorAddressFieldsFromVendor(PROCEDURE 63).ForceCopy(Parameter 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "SendRecords(PROCEDURE 75).ReportSelections(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "SendRecords(PROCEDURE 75).DocTxt(Variable 1002)".


    var
        Text016: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\';

    var
        Text019: Label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\';

    var
        Text021: Label 'The change may affect the exchange rate used on the price calculation of the purchase lines.';

    var
        Text053: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';

    var
        DocTxt: Label 'Purchase Order';
}

