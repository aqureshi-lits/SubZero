tableextension 60038 PurLinext extends "Purchase Line"
{
    fields
    {
        field(60100; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60203; "LIT Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Code Modification on "Type(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;

        #4..46
        TempPurchLine := Rec;
        INIT;

        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;

        #53..57
          "Allow Item Charge Assignment" := TRUE
        ELSE
          "Allow Item Charge Assignment" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..49
        //TS27072020-
        IF "Document Type" = "Document Type"::Quote THEN
          IF PurchHeader."Request No."<>'' THEN
            IF xRec.Narration <> '' THEN
              Narration := xRec.Narration;
        //TS27072020+

        #50..60
        */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := TypeHelper.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestStatusOpen;
        #4..100
              "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
              "Tax Group Code" := GLAcc."Tax Group Code";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
              InitDeferralCode;
            END;
        #108..115
                "Posting Group" := Item."Inventory Posting Group";
              END;
              Description := Item.Description;
              "Description 2" := Item."Description 2";
              "Unit Price (LCY)" := Item."Unit Price";
              "Units per Parcel" := Item."Units per Parcel";
        #122..130
              "Allow Item Charge Assignment" := TRUE;
              PrepmtMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");

              IF Item."Price Includes VAT" THEN BEGIN
                IF NOT VATPostingSetup.GET(
                     Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group")
        #137..209
          END;
        END;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");

        PurchHeader.GET("Document Type","Document No.");
        UpdateItemReference;
        #221..223
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
          UpdateDimensionsFromJobTask;
        END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..103
              //"Allow Invoice Disc." := FALSE; //GSS-ASH commented base code
              "Allow Invoice Disc." := TRUE; //GSS-ASH
        #105..118
              //GSS-EXC
              //TS - Code commented , because of field not  found error
              //"Excise Unit Cost" := Item."Excise Amount";
              //TS+
              //GSS-EXC
        #119..133
              //TS27072020-
              IF "Document Type" = "Document Type"::Quote THEN
                IF PurchHeader."Request No."<>'' THEN
                  IF xRec.Narration <> '' THEN
                    Narration := xRec.Narration;
              //TS27072020+

        #134..212
        IF NOT ISTEMPORARY THEN
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center",
            DATABASE::"Work Center","Work Center No.");
        #218..226
        END
        */
        //end;


        //Unsupported feature: Code Modification on ""Expected Receipt Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT TrackingBlocked THEN
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);

        IF "Expected Receipt Date" <> 0D THEN
          VALIDATE(
            "Planned Receipt Date",
            CalendarMgmt.CalcDateBOC2(ReversedInternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
              CalChange."Source Type"::Location,"Location Code",'',
              CalChange."Source Type"::Location,"Location Code",'',FALSE))
        ELSE
          VALIDATE("Planned Receipt Date","Expected Receipt Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
            CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
        #8..11
        */
        //end;


        //Unsupported feature: Code Modification on "Description(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::" " THEN
          EXIT;

        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
          IF (STRLEN(Description) <= MAXSTRLEN(Item."No.")) AND ("No." <> '') THEN
            DescriptionIsNo := Item.GET(Description)
          ELSE
            DescriptionIsNo := FALSE;

          IF NOT DescriptionIsNo THEN BEGIN
            Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
            IF NOT Item.FINDFIRST THEN
              EXIT;
            IF Item."No." = "No." THEN
              EXIT;
            IF IsReceivedFromOcr THEN
              EXIT;
            IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
              VALIDATE("No.",Item."No.");
            EXIT;
          END;

          IF Item.TryGetItemNoOpenCard(ReturnValue,Description,FALSE,FALSE) THEN
            CASE ReturnValue OF
              '',"No.":
                Description := xRec.Description;
              ELSE
                VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
            END;
        END ELSE
          IF "No." = '' THEN BEGIN
            ReturnValue := TypeHelper.FindNoByDescription(Type,Description,TRUE);
            IF ReturnValue <> '' THEN BEGIN
              CurrFieldNo := FIELDNO("No.");
              VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
            END;
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
          IF NOT Item.FINDFIRST THEN
            EXIT;
          IF Item."No." = "No." THEN
            EXIT;
          IF IsReceivedFromOcr THEN
            EXIT;
          IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
            VALIDATE("No.",Item."No.");
        END ELSE
          IF "No." = '' THEN
            IF TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
        #34..36
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
        #4..80
        END;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..83
        //GSS-EXC
        VALIDATE("Excise Unit Cost");
        //GSS-EXC
        */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Receive"(Field 18).OnValidate".

        //trigger  to Receive"(Field 18)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
        #4..35

        IF "Job Planning Line No." <> 0 THEN
          VALIDATE("Job Planning Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..38
        //GSS-EXC
        "Excise Total Cost" := "Qty. to Receive" * "Excise Unit Cost";
        //GSS-EXC
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Cost (LCY)"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD("No.");
        TESTFIELD(Quantity);
        #4..28
              GLSetup."Unit-Amount Rounding Precision");
        END;

        "Indirect Cost %" := 0;
        IF ("Direct Unit Cost" <> 0) AND
           ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
        THEN BEGIN
          IndirectCostPercent :=
            ROUND(
              (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
              ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001);
          IF IndirectCostPercent >= 0 THEN
            "Indirect Cost %" := IndirectCostPercent;
        END;

        UpdateSalesCost;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdateJobPrices;
        END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..31
        #33..39
          IF IndirectCostPercentCheck(IndirectCostPercent) THEN
            "Indirect Cost %" := IndirectCostPercent
          ELSE
            ERROR(CannotBeNegativeErr,FIELDCAPTION("Indirect Cost %"));
        END ELSE
          "Indirect Cost %" := 0;
        #43..50
        */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount Amount"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
        TestStatusOpen;
        TESTFIELD(Quantity);
        IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
          UpdateLineDiscPct;
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          IF ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") <> 0 THEN
            "Line Discount %" :=
              ROUND(
                "Line Discount Amount" /
                ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
                0.00001)
          ELSE
            "Line Discount %" := 0;
        #7..10
        */
        //end;


        //Unsupported feature: Code Modification on ""Allow Invoice Disc."(Field 32).OnValidate".

        //trigger "(Field 32)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Allow Invoice Disc." <> xRec."Allow Invoice Disc." THEN BEGIN
          IF NOT "Allow Invoice Disc." THEN BEGIN
            "Inv. Discount Amount" := 0;
            "Inv. Disc. Amount to Invoice" := 0;
          END;
          UpdateAmounts;
          UpdateUnitCost;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") AND
           (NOT "Allow Invoice Disc.")
        THEN BEGIN
          "Inv. Discount Amount" := 0;
          "Inv. Disc. Amount to Invoice" := 0;
        #7..9
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 90).OnValidate".

        //trigger  Posting Group"(Field 90)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Prepmt. Amt. Inv." <> 0 THEN
          ERROR(CannotChangeVATGroupWithPrepmInvErr);
        VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
        "VAT Difference" := 0;
        "VAT %" := VATPostingSetup."VAT %";
        #7..17
            END;
        END;
        IF PurchHeader."Prices Including VAT" AND (Type = Type::Item) THEN
          VALIDATE("Direct Unit Cost",
            ROUND(
              "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision"));
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        #4..20
          "Direct Unit Cost" :=
            ROUND(
              "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision");
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: Code Modification on ""Blanket Order Line No."(Field 98).OnValidate".

        //trigger "(Field 98)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Received",0);
        IF "Blanket Order Line No." <> 0 THEN BEGIN
          PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
          PurchLine2.TESTFIELD(Type,Type);
          PurchLine2.TESTFIELD("No.","No.");
          PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
          PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
          IF "Drop Shipment" THEN BEGIN
            PurchLine2.TESTFIELD("Variant Code","Variant Code");
            PurchLine2.TESTFIELD("Location Code","Location Code");
            PurchLine2.TESTFIELD("Unit of Measure Code","Unit of Measure Code");
          END ELSE BEGIN
            VALIDATE("Variant Code",PurchLine2."Variant Code");
            VALIDATE("Location Code",PurchLine2."Location Code");
            VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
          END;
          VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
          VALIDATE("Line Discount %",PurchLine2."Line Discount %");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          VALIDATE("Variant Code",PurchLine2."Variant Code");
          VALIDATE("Location Code",PurchLine2."Location Code");
          VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
        #17..19
        */
        //end;


        //Unsupported feature: Code Modification on ""Prepayment %"(Field 109).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePrepmtSetupFields;

        IF Type <> Type::" " THEN
          UpdateAmounts;
        UpdateBaseAmounts(Amount,"Amount Including VAT","VAT Base Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        */
        //end;


        //Unsupported feature: Code Modification on ""Variant Code"(Field 5402).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Variant Code" <> '' THEN
          TESTFIELD(Type,Type::Item);
        TestStatusOpen;
        #4..26
        UpdateLeadTimeFields;
        UpdateDates;
        GetDefaultBin;
        IF Type = Type::Item THEN
          UpdateItemReference;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..29
        UpdateItemReference;
        #32..36
        */
        //end;


        //Unsupported feature: Code Insertion on ""Unit of Measure Code"(Field 5407)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        LookupUnitOfMeasureCode;
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Field 5407).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD("Quantity Received",0);
        TESTFIELD("Qty. Received (Base)",0);
        #4..27
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          END;
        END;
        IF Type = Type::Item THEN
          UpdateItemReference;
        IF "Prod. Order No." = '' THEN BEGIN
          IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            GetItem;
        #36..46
          "Qty. per Unit of Measure" := 0;

        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..30
        UpdateItemReference;
        #33..49
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger "(Field 5705)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";

        ReturnedCrossRef.INIT;
        IF "Cross-Reference No." <> '' THEN BEGIN
          DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedCrossRef,CurrFieldNo <> 0);
          VALIDATE("No.",ReturnedCrossRef."Item No.");
          SetVendorItemNo;
          IF ReturnedCrossRef."Variant Code" <> '' THEN
        #10..21
          Description := ReturnedCrossRef.Description;

        UpdateICPartner;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
          DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedCrossRef);
        #7..24
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Copied From Posted Doc."(Field 6610)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Container No."(Field 50203)".

        field(50101; "Excise Unit Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                //GSS-EXC
                VALIDATE("Excise Total Cost");
                //GSS-EXC
            end;
        }
        field(50103; "Excise Total Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                //GSS-EXC
                "Excise Total Cost" := "Qty. to Receive" * "Excise Unit Cost";
                //GSS-EXCe
            end;
        }
        field(50201; "Purch. Order Status"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header".Status WHERE("Document Type" = CONST(Order),
                                                                 "No." = FIELD("Document No.")));
            Caption = 'Purch. Order Status';
            Description = 'POBGT1.0';
            Editable = false;

            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(50202; "Over Budget"; Boolean)
        {
            Description = 'POBGT1.1';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Recalculate Invoice Disc."(Key)".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      ReservePurchLine.DeleteLine(Rec);
      IF "Receipt No." = '' THEN
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
      IF "Return Shipment No." = '' THEN
        TESTFIELD("Return Qty. Shipped Not Invd.",0);

      CALCFIELDS("Reserved Qty. (Base)");
      TESTFIELD("Reserved Qty. (Base)",0);
      WhseValidateSourceLine.PurchaseLineDelete(Rec);
    END;

    IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
      TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

    IF "Sales Order Line No." <> 0 THEN BEGIN
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");
      SalesOrderLine."Purchase Order No." := '';
      SalesOrderLine."Purch. Order Line No." := 0;
      SalesOrderLine.MODIFY;
    END;

    IF ("Special Order Sales Line No." <> 0) AND ("Quantity Invoiced" = 0) THEN BEGIN
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      IF SalesOrderLine.GET(
           SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.")
      THEN BEGIN
        SalesOrderLine."Special Order Purchase No." := '';
        SalesOrderLine."Special Order Purch. Line No." := 0;
        SalesOrderLine.MODIFY;
      END;
    END;

    NonstockItemMgt.DelNonStockPurch(Rec);

    IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
      PurchLine2.RESET;
      PurchLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      PurchLine2.SETRANGE("Blanket Order No.","Document No.");
      PurchLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF PurchLine2.FINDFIRST THEN
        PurchLine2.TESTFIELD("Blanket Order Line No.",0);
    END;

    IF Type = Type::Item THEN
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");

    IF Type = Type::"Charge (Item)" THEN
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    IF "Line No." <> 0 THEN BEGIN
      PurchLine2.RESET;
      PurchLine2.SETRANGE("Document Type","Document Type");
      PurchLine2.SETRANGE("Document No.","Document No.");
      PurchLine2.SETRANGE("Attached to Line No.","Line No.");
      PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      PurchLine2.DELETEALL(TRUE);
    END;

    PurchCommentLine.SETRANGE("Document Type","Document Type");
    PurchCommentLine.SETRANGE("No.","Document No.");
    PurchCommentLine.SETRANGE("Document Line No.","Line No.");
    IF NOT PurchCommentLine.ISEMPTY THEN
      PurchCommentLine.DELETEALL;

    // In case we have roundings on VAT or Sales Tax, we should update some other line
    IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND
       (Quantity <> 0) AND (Amount <> 0) AND (Amount <> "Amount Including VAT") AND NOT StatusCheckSuspended
    THEN BEGIN
      Quantity := 0;
      "Quantity (Base)" := 0;
      "Line Discount Amount" := 0;
      "Inv. Discount Amount" := 0;
      "Inv. Disc. Amount to Invoice" := 0;
      UpdateAmounts;
    END;

    IF "Deferral Code" <> '' THEN
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetPurchDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    IF NOT StatusCheckSuspended AND (PurchHeader.Status = PurchHeader.Status::Released) AND
       (Type IN [Type::"G/L Account",Type::"Charge (Item)"])
    THEN
      VALIDATE(Quantity,0);

    #2..25
    IF "Special Order Sales Line No." <> 0 THEN BEGIN
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      IF "Document Type" = "Document Type"::Order THEN BEGIN
        SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.");
    #32..34
      END ELSE
        IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.") THEN
          BEGIN
          SalesOrderLine."Special Order Purchase No." := '';
          SalesOrderLine."Special Order Purch. Line No." := 0;
          SalesOrderLine.MODIFY;
        END;
    #36..69
    IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
      PurchLine2.COPY(Rec);
      IF PurchLine2.FIND('<>') THEN BEGIN
        PurchLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
        PurchLine2.MODIFY;
    #35..37
    #82..85
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateDirectUnitCost(PROCEDURE 2)".

    //procedure UpdateDirectUnitCost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (CurrFieldNo <> 0) AND ("Prod. Order No." <> '') THEN
      UpdateAmounts;

    #4..8
    IF Type = Type::Item THEN BEGIN
      GetPurchHeader;
      PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader,Rec,CalledByFieldNo);
      IF NOT ("Copied From Posted Doc." AND IsCreditDocType) THEN
        PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
      VALIDATE("Direct Unit Cost");

      IF CalledByFieldNo IN [FIELDNO("No."),FIELDNO("Variant Code"),FIELDNO("Location Code")] THEN
        UpdateItemReference;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
      PurchPriceCalcMgt.FindPurchLineLineDisc(PurchHeader,Rec);
    #14..18
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: POBudgetCodeUnit) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: GLBudgetName) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: GLAccNo) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: YearBudget) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: YearToDateBudget) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: ActualValue) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: PuchHeader) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: Committed) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: POLineAmount) (VariableCollection) on "UpdateAmounts(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 3)".

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type = Type::" " THEN
      EXIT;
    GetPurchHeader;
    #4..59
      UpdateItemChargeAssgnt;

    CalcPrepaymentToDeduct;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..62


    //POBGT1.1 -
    CLEAR(PurchHeader);
    PurchHeader.SETCURRENTKEY("Document Type","No.");
    PurchHeader.SETRANGE("No.","Document No.");
    PurchHeader.SETRANGE("Document Type","Document Type");
    IF PurchHeader.FINDFIRST THEN;

    CLEAR(POBudgetCodeUnit);
    CLEAR(GLBudgetName);
    VALIDATE("Over Budget",TRUE);
    GLBudgetName.SETRANGE(Blocked,FALSE);
    IF GLBudgetName.FINDLAST THEN  BEGIN
      GLAccNo := POBudgetCodeUnit.GetPurchLinePurchaseAccount(Rec);
      IF GLAccNo<>'' THEN BEGIN
          YearBudget := POBudgetCodeUnit.GetFullBudget(GLBudgetName.Name,GLAccNo);
          YearToDateBudget := POBudgetCodeUnit.GetBudgetAsOfDate(GLBudgetName.Name,GLAccNo,PurchHeader."Posting Date");
          ActualValue := POBudgetCodeUnit.GetAccountActual(GLAccNo,PurchHeader."Posting Date");

          Committed := POBudgetCodeUnit.GetCommittedAmount(Rec);
          POLineAmount := POBudgetCodeUnit.GetPurchLineOutstandingAmount(Rec);

          IF (YearToDateBudget - (ActualValue + Committed) + POLineAmount) > 0 THEN
            VALIDATE("Over Budget",FALSE)
          ELSE
            VALIDATE("Over Budget",TRUE);

      END;
    END ELSE;
      VALIDATE("Over Budget",TRUE);

    //POBGT1.1 +
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetPurchHeader;
    PurchLine2.SETRANGE("Document Type","Document Type");
    PurchLine2.SETRANGE("Document No.","Document No.");
    PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
    PurchLine2.SETRANGE("VAT Identifier","VAT Identifier");
    PurchLine2.SETRANGE("Tax Group Code","Tax Group Code");

    IF "Line Amount" = "Inv. Discount Amount" THEN BEGIN
      Amount := 0;
      "VAT Base Amount" := 0;
      "Amount Including VAT" := 0;
      IF (Quantity = 0) AND (xRec.Quantity <> 0) AND (xRec.Amount <> 0) THEN BEGIN
        IF "Line No." <> 0 THEN
          MODIFY;
        PurchLine2.SETFILTER(Amount,'<>0');
        IF PurchLine2.FIND('<>') THEN BEGIN
          PurchLine2.VALIDATE("Line Discount %");
          PurchLine2.MODIFY;
        END;
      END;
    END ELSE BEGIN
      TotalLineAmount := 0;
      TotalInvDiscAmount := 0;
      TotalAmount := 0;
      TotalAmountInclVAT := 0;
      TotalQuantityBase := 0;
      IF ("VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax") OR
         (("VAT Calculation Type" IN
           ["VAT Calculation Type"::"Normal VAT","VAT Calculation Type"::"Reverse Charge VAT"]) AND ("VAT %" <> 0))
      THEN
        IF NOT PurchLine2.ISEMPTY THEN BEGIN
          PurchLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)");
          TotalLineAmount := PurchLine2."Line Amount";
          TotalInvDiscAmount := PurchLine2."Inv. Discount Amount";
          TotalAmount := PurchLine2.Amount;
          TotalAmountInclVAT := PurchLine2."Amount Including VAT";
          TotalQuantityBase := PurchLine2."Quantity (Base)";
        END;

      IF PurchHeader."Prices Including VAT" THEN
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              Amount :=
                ROUND(
                  (TotalLineAmount - TotalInvDiscAmount + "Line Amount" - "Inv. Discount Amount") / (1 + "VAT %" / 100),
                  Currency."Amount Rounding Precision") -
                TotalAmount;
              "VAT Base Amount" :=
                ROUND(
                  Amount * (1 - PurchHeader."VAT Base Discount %" / 100),
                  Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalLineAmount + "Line Amount" -
                ROUND(
                  (TotalAmount + Amount) * (PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                  Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                TotalAmountInclVAT - TotalInvDiscAmount - "Inv. Discount Amount";
            END;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              Amount := 0;
              "VAT Base Amount" := 0;
            END;
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              PurchHeader.TESTFIELD("VAT Base Discount %",0);
              "Amount Including VAT" :=
                ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              IF "Use Tax" THEN
                Amount := "Amount Including VAT"
              ELSE
                Amount :=
                  ROUND(
                    SalesTaxCalculate.ReverseCalculateTax(
                      "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                      TotalAmountInclVAT + "Amount Including VAT",TotalQuantityBase + "Quantity (Base)",
                      PurchHeader."Currency Factor"),
                    Currency."Amount Rounding Precision") -
                  TotalAmount;
              "VAT Base Amount" := Amount;
              IF "VAT Base Amount" <> 0 THEN
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
              ELSE
                "VAT %" := 0;
            END;
        END
      ELSE
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalAmount + Amount +
                ROUND(
                  (TotalAmount + Amount) * (1 - PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
                  Currency."Amount Rounding Precision",Currency.VATRoundingDirection) -
                TotalAmountInclVAT;
            END;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              Amount := 0;
              "VAT Base Amount" := 0;
              "Amount Including VAT" := "Line Amount" - "Inv. Discount Amount";
            END;
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              "VAT Base Amount" := Amount;
              IF "Use Tax" THEN
                "Amount Including VAT" := Amount
              ELSE
                "Amount Including VAT" :=
                  TotalAmount + Amount +
                  ROUND(
                    SalesTaxCalculate.CalculateTax(
                      "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                      TotalAmount + Amount,TotalQuantityBase + "Quantity (Base)",
                      PurchHeader."Currency Factor"),
                    Currency."Amount Rounding Precision") -
                  TotalAmountInclVAT;
              IF "VAT Base Amount" <> 0 THEN
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
              ELSE
                "VAT %" := 0;
            END;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    IF "Line Amount" = 0 THEN
      IF xRec."Line Amount" >= 0 THEN
        PurchLine2.SETFILTER(Amount,'>%1',0)
      ELSE
        PurchLine2.SETFILTER(Amount,'<%1',0)
    ELSE
      IF "Line Amount" > 0 THEN
        PurchLine2.SETFILTER(Amount,'>%1',0)
      ELSE
        PurchLine2.SETFILTER(Amount,'<%1',0);
    #5..11
    #21..134
    */
    //end;


    //Unsupported feature: Code Modification on "UpdatePrepmtSetupFields(PROCEDURE 102)".

    //procedure UpdatePrepmtSetupFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Prepayment %" <> 0) AND (Type <> Type::" ") THEN BEGIN
      TESTFIELD("Document Type","Document Type"::Order);
      TESTFIELD("No.");
    #4..7
        VATPostingSetup.TESTFIELD("VAT Calculation Type","VAT Calculation Type");
      END ELSE
        CLEAR(VATPostingSetup);
      IF ("Prepayment VAT %" <> 0) AND ("Prepayment VAT %" <> VATPostingSetup."VAT %") AND ("Prepmt. Amt. Inv." <> 0) THEN
        ERROR(CannotChangePrepmtAmtDiffVAtPctErr);
      "Prepayment VAT %" := VATPostingSetup."VAT %";
      "Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
      "Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
    #16..18
        "Prepayment VAT %" := 0;
      "Prepayment Tax Group Code" := GLAcc."Tax Group Code";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    #13..21
    */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetCaptionClass(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 34)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(CaptionManagement.GetPurchaseLineCaptionClass(Rec,FieldNumber));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT PurchHeader.GET("Document Type","Document No.") THEN BEGIN
      PurchHeader."No." := '';
      PurchHeader.INIT;
    END;
    CASE FieldNumber OF
      FIELDNO("No."):
        BEGIN
          IF ApplicationAreaSetup.IsFoundationEnabled THEN
            EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
          EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
        END;
      ELSE BEGIN
        IF PurchHeader."Prices Including VAT" THEN
          EXIT('2,1,' + GetFieldCaption(FieldNumber));
        EXIT('2,0,' + GetFieldCaption(FieldNumber));
      END
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 32)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LineWasModified := FALSE;
    IF QtyType = QtyType::Shipping THEN
      EXIT;
    #4..118
                  "VAT Difference" := ROUND(VATDifference,Currency."Amount Rounding Precision");
              END;

              IF QtyType = QtyType::General THEN
                UpdateBaseAmounts(NewAmount,ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision"),NewVATBaseAmount);
              InitOutstanding;
              IF NOT ((Type = Type::"Charge (Item)") AND ("Quantity Invoiced" <> "Qty. Assigned")) THEN BEGIN
                SetUpdateFromVAT(TRUE);
    #127..142
          END;
        UNTIL NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..121
              IF QtyType = QtyType::General THEN BEGIN
                Amount := NewAmount;
                "Amount Including VAT" := ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
                "VAT Base Amount" := NewVATBaseAmount;
              END;
    #124..145
    */
    //end;


    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 24)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Currency.Initialize(PurchHeader."Currency Code");

    VATAmountLine.DELETEALL;
    #4..8
        REPEAT
          IF NOT ZeroAmountLine(QtyType) THEN BEGIN
            IF (Type = Type::"G/L Account") AND NOT "Prepayment Line" THEN
              RoundingLineInserted := (("No." = GetVPGInvRoundAcc(PurchHeader)) AND "System-Created Entry") OR RoundingLineInserted;
            IF "VAT Calculation Type" IN
               ["VAT Calculation Type"::"Reverse Charge VAT","VAT Calculation Type"::"Sales Tax"]
            THEN
    #16..52
                      VATAmountLine.Quantity += "Qty. to Invoice (Base)";
                    END;
                  END;
                  AmtToHandle := GetLineAmountToHandleInclPrepmt(QtyToHandle);
                  IF PurchHeader."Invoice Discount Calculation" <> PurchHeader."Invoice Discount Calculation"::Amount THEN
                    VATAmountLine.SumLine(
                      AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
    #60..72
                    QtyToHandle := "Qty. to Receive";
                    VATAmountLine.Quantity += "Qty. to Receive (Base)";
                  END;
                  AmtToHandle := GetLineAmountToHandleInclPrepmt(QtyToHandle);
                  VATAmountLine.SumLine(
                    AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                    "VAT Difference","Allow Invoice Disc.","Prepayment Line");
    #80..96
        VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
        VATAmountLine.MODIFY;
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
              RoundingLineInserted := ("No." = GetVPGInvRoundAcc(PurchHeader)) OR RoundingLineInserted;
    #13..55
                  AmtToHandle := GetLineAmountToHandle(QtyToHandle);
    #57..75
                  AmtToHandle := GetLineAmountToHandle(QtyToHandle);
    #77..99
    */
    //end;


    //Unsupported feature: Code Modification on "CalcPrepaymentToDeduct(PROCEDURE 59)".

    //procedure CalcPrepaymentToDeduct();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Qty. to Invoice" <> 0) AND ("Prepmt. Amt. Inv." <> 0) THEN BEGIN
      GetPurchHeader;
      IF ("Prepayment %" = 100) AND NOT IsFinalInvoice THEN
        "Prepmt Amt to Deduct" := GetLineAmountToHandle("Qty. to Invoice") - "Inv. Disc. Amount to Invoice"
      ELSE
        "Prepmt Amt to Deduct" :=
          ROUND(
            ("Prepmt. Amt. Inv." - "Prepmt Amt Deducted") *
            "Qty. to Invoice" / (Quantity - "Quantity Invoiced"),Currency."Amount Rounding Precision")
    END ELSE
      "Prepmt Amt to Deduct" := 0
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
        "Prepmt Amt to Deduct" := GetLineAmountToHandle("Qty. to Invoice")
    #5..11
    */
    //end;


    //Unsupported feature: Code Modification on "GetLineAmountToHandle(PROCEDURE 117)".

    //procedure GetLineAmountToHandle();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Line Discount %" = 100 THEN
      EXIT(0);

    GetPurchHeader;

    IF "Prepmt Amt to Deduct" = 0 THEN
      LineAmount := ROUND(QtyToHandle * "Direct Unit Cost",Currency."Amount Rounding Precision")
    ELSE BEGIN
      LineAmount := ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision");
      LineAmount := ROUND(QtyToHandle * LineAmount / Quantity,Currency."Amount Rounding Precision");
    END;

    IF QtyToHandle <> Quantity THEN
      LineDiscAmount := ROUND(LineAmount * "Line Discount %" / 100,Currency."Amount Rounding Precision")
    ELSE
      LineDiscAmount := "Line Discount Amount";

    EXIT(LineAmount - LineDiscAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    LineAmount := ROUND(QtyToHandle * "Direct Unit Cost",Currency."Amount Rounding Precision");
    LineDiscAmount :=
      ROUND(
        LineAmount * "Line Discount %" / 100,Currency."Amount Rounding Precision");
    EXIT(LineAmount - LineDiscAmount);
    */
    //end;


    //Unsupported feature: Code Modification on "InitQtyToReceive2(PROCEDURE 57)".

    //procedure InitQtyToReceive2();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Qty. to Receive" := "Outstanding Quantity";
    "Qty. to Receive (Base)" := "Outstanding Qty. (Base)";

    "Qty. to Invoice" := MaxQtyToInvoice;
    "Qty. to Invoice (Base)" := MaxQtyToInvoiceBase;
    "VAT Difference" := 0;

    CalcInvDiscToInvoice;

    CalcPrepaymentToDeduct;

    IF "Job Planning Line No." <> 0 THEN
      VALIDATE("Job Planning Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //GSS-EXC
    "Excise Total Cost" := "Excise Unit Cost" * "Qty. to Receive";
    //GSS_EXC
    #8..13
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateDimensionsFromJobTask(PROCEDURE 60)".

    //procedure UpdateDimensionsFromJobTask();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceCodeSetup.GET;
    DimSetArrID[1] := "Dimension Set ID";
    DimSetArrID[2] :=
      DimMgt.CreateDimSetFromJobTaskDim("Job No.",
        "Job Task No.",DimValue1,DimValue2);
    DimMgt.CreateDimForPurchLineWithHigherPriorities(
      Rec,DimSetArrID[3],DimValue1,DimValue2,SourceCodeSetup.Purchases,DATABASE::Job);

    "Dimension Set ID" :=
      DimMgt.GetCombinedDimensionSetID(
        DimSetArrID,DimValue1,DimValue2);

    "Shortcut Dimension 1 Code" := DimValue1;
    "Shortcut Dimension 2 Code" := DimValue2;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimSetArrID[1] := "Dimension Set ID";
    DimSetArrID[2] := DimMgt.CreateDimSetFromJobTaskDim("Job No.","Job Task No.",DimValue1,DimValue2);
    "Dimension Set ID" := DimMgt.GetCombinedDimensionSetID(DimSetArrID,DimValue1,DimValue2);
    "Shortcut Dimension 1 Code" := DimValue1;
    "Shortcut Dimension 2 Code" := DimValue2;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateItemReference(PROCEDURE 85)".

    //procedure UpdateItemReference();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateItemCrossRef;
    IF Type <> Type::Item THEN
      EXIT;

    IF "Cross-Reference No." = '' THEN
      SetVendorItemNo
    ELSE
      VALIDATE("Vendor Item No.","Cross-Reference No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..4
    UpdateItemCrossRef;
    #5..8
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".



    //Unsupported feature: Code Modification on "CanEditUnitOfMeasureCode(PROCEDURE 115)".

    //procedure CanEditUnitOfMeasureCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
      ItemUnitOfMeasure.SETRANGE("Item No.","No.");
      EXIT(ItemUnitOfMeasure.COUNT > 1);
    END;
    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //ITOS
    EXIT(TRUE);
    //ITOS
    #1..5
    */
    //end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record Field;
    begin
        Field.GET(DATABASE::"Purchase Line", FieldNumber);
        EXIT(Field."Field Caption");
    end;

    procedure LookupUnitOfMeasureCode()
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT CanEditUnitOfMeasureCode THEN
            EXIT;

        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            ItemUnitOfMeasure.SETRANGE("Item No.", "No.");
            IF PAGE.RUNMODAL(0, ItemUnitOfMeasure) = ACTION::LookupOK THEN
                VALIDATE("Unit of Measure Code", ItemUnitOfMeasure.Code);
        END ELSE
            IF PAGE.RUNMODAL(0, UnitOfMeasure) = ACTION::LookupOK THEN
                VALIDATE("Unit of Measure Code", UnitOfMeasure.Code);
    end;

    local procedure IndirectCostPercentCheck(IndirectCostPercent: Decimal): Boolean
    begin
        EXIT(
          (IndirectCostPercent >= 0) AND
          ("Document Type" IN
           ["Document Type"::Quote, "Document Type"::Order, "Document Type"::Invoice, "Document Type"::"Blanket Order"]) OR
          (IndirectCostPercent <= 0) AND
          ("Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"])
          );
    end;

    //Unsupported feature: Deletion (VariableCollection) on "GetCaptionClass(PROCEDURE 34).CaptionManagement(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdateDimensionsFromJobTask(PROCEDURE 60).SourceCodeSetup(Variable 1003)".


    var
        ApplicationAreaSetup: Record "Application Area Setup";

    var
        ItemNoFieldCaptionTxt: Label 'Item';
        CannotBeNegativeErr: Label 'The %1 field cannot be negative on the purchase line.', Comment = '%1 - Field Caption';
}

