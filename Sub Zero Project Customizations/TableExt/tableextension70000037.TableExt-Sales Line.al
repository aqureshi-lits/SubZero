tableextension 60036 SalLinExt extends "Sales Line"
{
    fields
    {
        field(60005; "LIT Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60010; "LIT Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60100; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := TypeHelper.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestJobPlanningLine;
        #4..172
          UpdateUnitPrice(FIELDNO("No."));
        END;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        IF "No." <> xRec."No." THEN BEGIN
          IF Type = Type::Item THEN
        #183..191
        END;

        UpdateItemCrossRef;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..175
        IF NOT ISTEMPORARY THEN
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center");
      
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

        #4..37
                END;
            END;
          ELSE
            IF "No." = '' THEN BEGIN
              ReturnValue := TypeHelper.FindNoByDescription(Type,Description,TRUE);
              IF ReturnValue <> '' THEN BEGIN
                CurrFieldNo := FIELDNO("No.");
                VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
              END;
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..40
            IF "No." = '' THEN
              IF TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
        #44..46
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Price"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        VALIDATE("Line Discount %");
        */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount Amount"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD(Quantity);
        IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
          UpdateLineDiscPct;
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        //IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN //commented base code //ITOS
          IF ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") <> 0 THEN
            "Line Discount %" :=
              ROUND(
                "Line Discount Amount" / ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") * 100,
                0.00001)
          ELSE
            "Line Discount %" := 0;
        #8..10
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
          UpdateAmounts;
        END;
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
        #7..18
            END;
        END;
        IF SalesHeader."Prices Including VAT" AND (Type IN [Type::Item,Type::Resource]) THEN
          VALIDATE("Unit Price",
            ROUND(
              "Unit Price" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision"));
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        #4..21
          "Unit Price" :=
            ROUND(
              "Unit Price" * (100 + "VAT %") / (100 + xRec."VAT %"),
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
        TESTFIELD("Quantity Shipped",0);
        IF "Blanket Order Line No." <> 0 THEN BEGIN
          SalesLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
          SalesLine2.TESTFIELD(Type,Type);
          SalesLine2.TESTFIELD("No.","No.");
          SalesLine2.TESTFIELD("Bill-to Customer No.","Bill-to Customer No.");
          SalesLine2.TESTFIELD("Sell-to Customer No.","Sell-to Customer No.");
          IF "Drop Shipment" THEN BEGIN
            SalesLine2.TESTFIELD("Variant Code","Variant Code");
            SalesLine2.TESTFIELD("Location Code","Location Code");
            SalesLine2.TESTFIELD("Unit of Measure Code","Unit of Measure Code");
          END ELSE BEGIN
            VALIDATE("Variant Code",SalesLine2."Variant Code");
            VALIDATE("Location Code",SalesLine2."Location Code");
            VALIDATE("Unit of Measure Code",SalesLine2."Unit of Measure Code");
          END;
          VALIDATE("Unit Price",SalesLine2."Unit Price");
          VALIDATE("Line Discount %",SalesLine2."Line Discount %");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          VALIDATE("Variant Code",SalesLine2."Variant Code");
          VALIDATE("Location Code",SalesLine2."Location Code");
          VALIDATE("Unit of Measure Code",SalesLine2."Unit of Measure Code");
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
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD("Quantity Shipped",0);
        #4..56
            "Qty. per Unit of Measure" := 1;
        END;
        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..59

        //ATOS-EXC1.2-
        VALIDATE("Excise Duty Per Line UOM", "Excise Duty Per Unit" * "Qty. per Unit of Measure");
        //ATOS-EXC1.2+
        */
        //end;

        //Unsupported feature: Property Deletion (TableRelation) on ""Unit of Measure Code"(Field 5407)".



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Field 5705).OnValidate".

        //trigger "(Field 5705)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        "Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        ReturnedCrossRef.INIT;
        IF "Cross-Reference No." <> '' THEN BEGIN
          DistIntegration.ICRLookupSalesItem(Rec,ReturnedCrossRef,CurrFieldNo <> 0);
          IF "No." <> ReturnedCrossRef."Item No." THEN
            VALIDATE("No.",ReturnedCrossRef."Item No.");
          IF ReturnedCrossRef."Variant Code" <> '' THEN
        #9..21

        UpdateUnitPrice(FIELDNO("Cross-Reference No."));
        UpdateICPartner;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          DistIntegration.ICRLookupSalesItem(Rec,ReturnedCrossRef);
        #6..24
        */
        //end;


        //Unsupported feature: Code Modification on ""Planned Delivery Date"(Field 5794).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Planned Delivery Date" <> 0D THEN BEGIN
          PlannedDeliveryDateCalculated := TRUE;

          VALIDATE("Planned Shipment Date",CalcPlannedDate);

          IF "Planned Shipment Date" > "Planned Delivery Date" THEN
            "Planned Delivery Date" := "Planned Shipment Date";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          IF FORMAT("Shipping Time") <> '' THEN
            VALIDATE("Planned Shipment Date",CalcPlannedDeliveryDate(FIELDNO("Planned Delivery Date")))
          ELSE
            VALIDATE("Planned Shipment Date",CalcPlannedShptDate(FIELDNO("Planned Delivery Date")));
        #6..9
        */
        //end;


        //Unsupported feature: Code Modification on ""Planned Shipment Date"(Field 5795).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Planned Shipment Date" <> 0D THEN BEGIN
          PlannedShipmentDateCalculated := TRUE;

          VALIDATE("Shipment Date",CalcShipmentDate);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          IF FORMAT("Outbound Whse. Handling Time") <> '' THEN
            VALIDATE(
              "Shipment Date",
              CalendarMgmt.CalcDateBOC2(
                FORMAT("Outbound Whse. Handling Time"),
                "Planned Shipment Date",
                CalChange."Source Type"::Location,
                "Location Code",
                '',
                CalChange."Source Type"::"Shipping Agent",
                "Shipping Agent Code",
                "Shipping Agent Service Code",
                FALSE))
          ELSE
            VALIDATE(
              "Shipment Date",
              CalendarMgmt.CalcDateBOC(
                FORMAT(FORMAT('')),
                "Planned Shipment Date",
                CalChange."Source Type"::"Shipping Agent",
                "Shipping Agent Code",
                "Shipping Agent Service Code",
                CalChange."Source Type"::Location,
                "Location Code",
                '',
                FALSE));
        END;
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Copied From Posted Doc."(Field 6610)".


        //Unsupported feature: Property Deletion (DataClassification) on "Margin(Field 50005)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Margin %"(Field 50010)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".

        field(50000; "System Unit Price"; Decimal)
        {
            Description = 'GSS';
            Enabled = false;
        }
        field(50110; "Excise Duty Per Unit"; Decimal)
        {
            Description = 'ATOS';
            Editable = false;

            trigger OnValidate()
            begin
                //ATOSEXC1.2-
                VALIDATE("Excise Duty Per Line UOM", "Excise Duty Per Unit" * "Qty. per Unit of Measure");
                //ATOSEXC1.2+
            end;
        }
        field(50111; "Excise Duty Per Line UOM"; Decimal)
        {
            Description = 'ATOS-EXC1.1';
        }
        field(50120; "Excise Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ATOS-EXC1.2';
            Editable = false;
        }
        field(50121; "Amount Excl. Excise"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ATOS-EXC1.2';
            Editable = false;
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
      ReserveSalesLine.DeleteLine(Rec);
      CALCFIELDS("Reserved Qty. (Base)");
      TESTFIELD("Reserved Qty. (Base)",0);
      IF "Shipment No." = '' THEN
        TESTFIELD("Qty. Shipped Not Invoiced",0);
      IF "Return Receipt No." = '' THEN
        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
      WhseValidateSourceLine.SalesLineDelete(Rec);
    END;

    IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
      TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

    CleanDropShipmentFields;
    CleanSpecialOrderFieldsAndCheckAssocPurchOrder;
    NonstockItemMgt.DelNonStockSales(Rec);

    IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      SalesLine2.SETRANGE("Blanket Order No.","Document No.");
      SalesLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF SalesLine2.FINDFIRST THEN
        SalesLine2.TESTFIELD("Blanket Order Line No.",0);
    END;

    IF Type = Type::Item THEN BEGIN
      ATOLink.DeleteAsmFromSalesLine(Rec);
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
    END;

    IF Type = Type::"Charge (Item)" THEN
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    CapableToPromise.RemoveReqLines("Document No.","Line No.",0,FALSE);

    IF "Line No." <> 0 THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETRANGE("Document Type","Document Type");
      SalesLine2.SETRANGE("Document No.","Document No.");
      SalesLine2.SETRANGE("Attached to Line No.","Line No.");
      SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      SalesLine2.DELETEALL(TRUE);
    END;

    IF "Job Contract Entry No." <> 0 THEN
      JobCreateInvoice.DeleteSalesLine(Rec);

    SalesCommentLine.SETRANGE("Document Type","Document Type");
    SalesCommentLine.SETRANGE("No.","Document No.");
    SalesCommentLine.SETRANGE("Document Line No.","Line No.");
    IF NOT SalesCommentLine.ISEMPTY THEN
      SalesCommentLine.DELETEALL;

    // In case we have roundings on VAT or Sales Tax, we should update some other line
    IF (Type <> Type::" ") AND ("Line No." <> 0) AND ("Attached to Line No." = 0) AND ("Job Contract Entry No." = 0 ) AND
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
        DeferralUtilities.GetSalesDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    IF NOT StatusCheckSuspended AND (SalesHeader.Status = SalesHeader.Status::Released) AND
       (Type IN [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
    THEN
      VALIDATE(Quantity,0);
    #2..16
    #18..57
    IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
      SalesLine2.COPY(Rec);
      IF SalesLine2.FIND('<>') THEN BEGIN
        SalesLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
        SalesLine2.MODIFY;
      END;
    #68..73
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateUnitPrice(PROCEDURE 2)".

    //procedure UpdateUnitPrice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 0) THEN
      EXIT;

    #4..6
    CASE Type OF
      Type::Item,Type::Resource:
        BEGIN
          IF NOT ("Copied From Posted Doc." AND IsCreditDocType) THEN
            PriceCalcMgt.FindSalesLineLineDisc(SalesHeader,Rec);
          PriceCalcMgt.FindSalesLinePrice(SalesHeader,Rec,CalledByFieldNo);
        END;
    END;

    IF "Copied From Posted Doc." AND IsCreditDocType AND ("Appl.-from Item Entry" <> 0) THEN
      IF xRec."Unit Price" <> "Unit Price" THEN
        IF GUIALLOWED THEN
          ShowMessageOnce(STRSUBSTNO(UnitPriceChangedMsg,Type,"No."));

    VALIDATE("Unit Price");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
          PriceCalcMgt.FindSalesLineLineDisc(SalesHeader,Rec);
    #12..14
    VALIDATE("Unit Price");
    //GSS
    VALIDATE("System Unit Price","Unit Price");
    //GSS
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
    #4..12
        VATPostingSetup.TESTFIELD("VAT Calculation Type","VAT Calculation Type");
      END ELSE
        CLEAR(VATPostingSetup);
      IF ("Prepayment VAT %" <> 0) AND ("Prepayment VAT %" <> VATPostingSetup."VAT %") AND ("Prepmt. Amt. Inv." <> 0) THEN
        ERROR(CannotChangePrepmtAmtDiffVAtPctErr);
      "Prepayment VAT %" := VATPostingSetup."VAT %";
      "Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
      "Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
    #21..23
        "Prepayment VAT %" := 0;
      "Prepayment Tax Group Code" := GLAcc."Tax Group Code";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    #18..26
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateAmounts(PROCEDURE 3)".

    //procedure UpdateAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type = Type::" " THEN
      EXIT;
    GetSalesHeader;
    #4..65
      UpdateDeferralAmounts;
      LineAmountChanged := FALSE;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..68
    //GSS
    IF (Quantity <> 0) AND ("Line Amount" <> 0) THEN BEGIN
      Margin := "Line Amount" - "Unit Cost"*Quantity;
      "Margin %" := ROUND(("Line Amount"/Quantity - "Unit Cost")/("Line Amount"/Quantity)*100,0.01);
    END ELSE BEGIN
      Margin := 0;
      "Margin %" := 0;
    END;
    //GSS

    //ATOS-EXC1.2-
    UpdateExciseAmount;
    //ATOS-EXC1.2+
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateVATAmounts(PROCEDURE 38)".

    //procedure UpdateVATAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetSalesHeader;
    SalesLine2.SETRANGE("Document Type","Document Type");
    SalesLine2.SETRANGE("Document No.","Document No.");
    SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
    SalesLine2.SETRANGE("VAT Identifier","VAT Identifier");
    SalesLine2.SETRANGE("Tax Group Code","Tax Group Code");

    IF "Line Amount" = "Inv. Discount Amount" THEN BEGIN
      Amount := 0;
      "VAT Base Amount" := 0;
      "Amount Including VAT" := 0;
      IF (Quantity = 0) AND (xRec.Quantity <> 0) AND (xRec.Amount <> 0) THEN BEGIN
        IF "Line No." <> 0 THEN
          MODIFY;
        SalesLine2.SETFILTER(Amount,'<>0');
        IF SalesLine2.FIND('<>') THEN BEGIN
          SalesLine2.VALIDATE("Line Discount %");
          SalesLine2.MODIFY;
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
        IF NOT SalesLine2.ISEMPTY THEN BEGIN
          SalesLine2.CALCSUMS("Line Amount","Inv. Discount Amount",Amount,"Amount Including VAT","Quantity (Base)");
          TotalLineAmount := SalesLine2."Line Amount";
          TotalInvDiscAmount := SalesLine2."Inv. Discount Amount";
          TotalAmount := SalesLine2.Amount;
          TotalAmountInclVAT := SalesLine2."Amount Including VAT";
          TotalQuantityBase := SalesLine2."Quantity (Base)";
        END;

      IF SalesHeader."Prices Including VAT" THEN
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
                  Amount * (1 - SalesHeader."VAT Base Discount %" / 100),
                  Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalLineAmount + "Line Amount" -
                ROUND(
                  (TotalAmount + Amount) * (SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
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
              SalesHeader.TESTFIELD("VAT Base Discount %",0);
              Amount :=
                SalesTaxCalculate.ReverseCalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                  TotalAmountInclVAT + "Amount Including VAT",TotalQuantityBase + "Quantity (Base)",
                  SalesHeader."Currency Factor") -
                TotalAmount;
              IF Amount <> 0 THEN
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - Amount) / Amount,0.00001)
              ELSE
                "VAT %" := 0;
              Amount := ROUND(Amount,Currency."Amount Rounding Precision");
              "VAT Base Amount" := Amount;
            END;
        END
      ELSE
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                TotalAmount + Amount +
                ROUND(
                  (TotalAmount + Amount) * (1 - SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100,
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
              "Amount Including VAT" :=
                TotalAmount + Amount +
                ROUND(
                  SalesTaxCalculate.CalculateTax(
                    "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                    TotalAmount + Amount,TotalQuantityBase + "Quantity (Base)",
                    SalesHeader."Currency Factor"),Currency."Amount Rounding Precision") -
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
        SalesLine2.SETFILTER(Amount,'>%1',0)
      ELSE
        SalesLine2.SETFILTER(Amount,'<%1',0)
    ELSE
      IF "Line Amount" > 0 THEN
        SalesLine2.SETFILTER(Amount,'>%1',0)
      ELSE
        SalesLine2.SETFILTER(Amount,'<%1',0);
    #5..11
    #21..124
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SalesHeader2) (VariableCollection) on "GetCaptionClass(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "GetCaptionClass(PROCEDURE 34)".

    //procedure GetCaptionClass();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(CaptionManagement.GetSalesLineCaptionClass(Rec,FieldNumber));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF SalesHeader2.GET("Document Type","Document No.") THEN;
    CASE FieldNumber OF
      FIELDNO("No."):
        BEGIN
          IF ApplicationAreaSetup.IsFoundationEnabled THEN
            EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
          EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
        END;
      ELSE BEGIN
        IF SalesHeader2."Prices Including VAT" THEN
          EXIT('2,1,' + GetFieldCaption(FieldNumber));
        EXIT('2,0,' + GetFieldCaption(FieldNumber));
      END;
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 36)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LineWasModified := FALSE;
    IF QtyType = QtyType::Shipping THEN
      EXIT;
    #4..113
                ELSE
                  "VAT Difference" := ROUND(VATDifference,Currency."Amount Rounding Precision");
              END;
              IF QtyType = QtyType::General THEN
                UpdateBaseAmounts(NewAmount,ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision"),NewVATBaseAmount);
              InitOutstanding;
              IF Type = Type::"Charge (Item)" THEN
                UpdateItemChargeAssgnt;
    #122..133
          END;
        UNTIL NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..116
              IF QtyType = QtyType::General THEN BEGIN
                Amount := NewAmount;
                "Amount Including VAT" := ROUND(NewAmountIncludingVAT,Currency."Amount Rounding Precision");
                "VAT Base Amount" := NewVATBaseAmount;
              END;
    #119..136
    */
    //end;


    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 35)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Currency.Initialize(SalesHeader."Currency Code");

    VATAmountLine.DELETEALL;
    #4..8
        REPEAT
          IF NOT ZeroAmountLine(QtyType) THEN BEGIN
            IF (Type = Type::"G/L Account") AND NOT "Prepayment Line" THEN
              RoundingLineInserted := (("No." = GetCPGInvRoundAcc(SalesHeader)) AND "System-Created Entry") OR RoundingLineInserted;
            IF "VAT Calculation Type" IN
               ["VAT Calculation Type"::"Reverse Charge VAT","VAT Calculation Type"::"Sales Tax"]
            THEN
    #16..53
                      VATAmountLine.Quantity += "Qty. to Invoice (Base)";
                    END;
                  END;
                  AmtToHandle := GetLineAmountToHandleInclPrepmt(QtyToHandle);
                  IF SalesHeader."Invoice Discount Calculation" <> SalesHeader."Invoice Discount Calculation"::Amount THEN
                    VATAmountLine.SumLine(
                      AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
    #61..73
                    QtyToHandle := "Qty. to Ship";
                    VATAmountLine.Quantity += "Qty. to Ship (Base)";
                  END;
                  AmtToHandle := GetLineAmountToHandleInclPrepmt(QtyToHandle);
                  VATAmountLine.SumLine(
                    AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                    "VAT Difference","Allow Invoice Disc.","Prepayment Line");
    #81..97
        VATAmountLine."Calculated VAT Amount" += TotalVATAmount;
        VATAmountLine.MODIFY;
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
              RoundingLineInserted := ("No." = GetCPGInvRoundAcc(SalesHeader)) OR RoundingLineInserted;
    #13..56
                  AmtToHandle := GetLineAmountToHandle(QtyToHandle);
    #58..76
                  AmtToHandle := GetLineAmountToHandle(QtyToHandle);
    #78..100
    */
    //end;


    //Unsupported feature: Code Modification on "CalcPrepaymentToDeduct(PROCEDURE 63)".

    //procedure CalcPrepaymentToDeduct();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Qty. to Invoice" <> 0) AND ("Prepmt. Amt. Inv." <> 0) THEN BEGIN
      GetSalesHeader;
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

    GetSalesHeader;

    IF "Prepmt Amt to Deduct" = 0 THEN
      LineAmount := ROUND(QtyToHandle * "Unit Price",Currency."Amount Rounding Precision")
    ELSE BEGIN
      LineAmount := ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision");
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
    LineAmount := ROUND(QtyToHandle * "Unit Price",Currency."Amount Rounding Precision");
    LineDiscAmount :=
      ROUND(
        LineAmount * "Line Discount %" / 100,Currency."Amount Rounding Precision");
    EXIT(LineAmount - LineDiscAmount);
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "HasTypeToFillMandatoryFields(PROCEDURE 103)".


    //Unsupported feature: Property Modification (Name) on "CleanDropShipmentFields(PROCEDURE 112)".



    //Unsupported feature: Code Modification on "CleanDropShipmentFields(PROCEDURE 112)".

    //procedure CleanDropShipmentFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Purch. Order Line No." <> 0) AND IsFullyInvoiced THEN
      IF CleanPurchaseLineDropShipmentFields THEN BEGIN
        "Purchase Order No." := '';
        "Purch. Order Line No." := 0;
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //ATOS-EXC1.2
    VALIDATE("Excise Amount", Quantity * "Excise Duty Per Line UOM");
    VALIDATE("Amount Excl. Excise", "Line Amount" - "Excise Amount");
    */
    //end;


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


    //Unsupported feature: Code Modification on "InsertFreightLine(PROCEDURE 121)".

    //procedure InsertFreightLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FreightAmount <= 0 THEN BEGIN
      FreightAmount := 0;
      EXIT;
    END;

    FreightAmountQuantity := 1;

    SalesSetup.GET;
    SalesSetup.TESTFIELD("Freight G/L Acc. No.");

    #11..15

    SalesLine.SETRANGE(Type,SalesLine.Type::"G/L Account");
    SalesLine.SETRANGE("No.",SalesSetup."Freight G/L Acc. No.");
    // "Quantity Shipped" will be equal to 0 until FreightAmount line successfully shipped
    SalesLine.SETRANGE("Quantity Shipped",0);
    IF SalesLine.FINDFIRST THEN BEGIN
      SalesLine.VALIDATE(Quantity,FreightAmountQuantity);
      SalesLine.VALIDATE("Unit Price",FreightAmount);
      SalesLine.MODIFY;
    END ELSE BEGIN
      SalesLine.SETRANGE(Type);
      SalesLine.SETRANGE("No.");
      SalesLine.SETRANGE("Quantity Shipped");
      SalesLine.FINDLAST;
      SalesLine."Line No." += 10000;
      SalesLine.INIT;
      SalesLine.VALIDATE(Type,SalesLine.Type::"G/L Account");
      SalesLine.VALIDATE("No.",SalesSetup."Freight G/L Acc. No.");
      SalesLine.VALIDATE(Description,FreightLineDescriptionTxt);
      SalesLine.VALIDATE(Quantity,FreightAmountQuantity);
      SalesLine.VALIDATE("Unit Price",FreightAmount);
      SalesLine.INSERT;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    #8..18
    IF SalesLine.FINDFIRST THEN BEGIN
      SalesLine.VALIDATE(Quantity,1);
    #23..27
      SalesLine.FINDLAST;
      SalesLine."Line No." += 10000;

    #31..34
      SalesLine.VALIDATE(Quantity,1);
    #36..38
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemUnitOfMeasure) (VariableCollection) on "LookupUnitOfMeasureCode(PROCEDURE 118)".


    //Unsupported feature: Variable Insertion (Variable: ResourceUnitOfMeasure) (VariableCollection) on "LookupUnitOfMeasureCode(PROCEDURE 118)".


    //Unsupported feature: Variable Insertion (Variable: UnitOfMeasure) (VariableCollection) on "LookupUnitOfMeasureCode(PROCEDURE 118)".


    //Unsupported feature: Property Modification (Name) on "CalcPlannedDate(PROCEDURE 118)".



    //Unsupported feature: Code Modification on "CalcPlannedDate(PROCEDURE 118)".

    //procedure CalcPlannedDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FORMAT("Shipping Time") <> '' THEN
      EXIT(CalcPlannedDeliveryDate(FIELDNO("Planned Delivery Date")));

    EXIT(CalcPlannedShptDate(FIELDNO("Planned Delivery Date")));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT CanEditUnitOfMeasureCode THEN
      EXIT;

    CASE TRUE OF
      (Type = Type::Item) AND ("No." <> ''):
        BEGIN
          ItemUnitOfMeasure.SETRANGE("Item No.","No.");
          IF PAGE.RUNMODAL(0,ItemUnitOfMeasure) = ACTION::LookupOK THEN
            VALIDATE("Unit of Measure Code",ItemUnitOfMeasure.Code);
        END;
      (Type = Type::Resource) AND ("No." <> ''):
        BEGIN
          ResourceUnitOfMeasure.SETRANGE("Resource No.","No.");
          IF PAGE.RUNMODAL(0,ResourceUnitOfMeasure) = ACTION::LookupOK THEN
            VALIDATE("Unit of Measure Code",ResourceUnitOfMeasure.Code);
        END;
      ELSE
        IF PAGE.RUNMODAL(0,UnitOfMeasure) = ACTION::LookupOK THEN
          VALIDATE("Unit of Measure Code",UnitOfMeasure.Code);
    END;
    */
    //end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record Field;
    begin
        Field.GET(DATABASE::"Sales Line", FieldNumber);
        EXIT(Field."Field Caption");
    end;

    //Unsupported feature: Deletion (VariableCollection) on "GetCaptionClass(PROCEDURE 34).CaptionManagement(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "InsertFreightLine(PROCEDURE 121).FreightAmountQuantity(Variable 1002)".


    var
        ApplicationAreaSetup: Record "Application Area Setup";

    var
        ItemNoFieldCaptionTxt: Label 'Item';
}

