tableextension 60062 IteJourLinExt extends "Item Journal Line"
{
    fields
    {

        field(60000; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Property Modification (Data type) on ""Salespers./Purch. Code"(Field 23)".


        //Unsupported feature: Code Modification on ""Applies-to Entry"(Field 29).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Applies-to Entry" <> 0 THEN BEGIN
          ItemLedgEntry.GET("Applies-to Entry");

        #4..6

            IF "Inventory Value Per" = "Inventory Value Per"::" " THEN
              IF NOT RevaluationPerEntryAllowed("Item No.") THEN
                ERROR(RevaluationPerEntryNotAllowedErr);

            InitRevalJnlLine(ItemLedgEntry);
            ItemLedgEntry.TESTFIELD(Positive,TRUE);
        #14..45
            "Bin Code" := '';
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
                ERROR(Text034);
        #11..48
        */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 5403).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Code" <> xRec."Bin Code" THEN BEGIN
          TESTFIELD("Location Code");
          IF "Bin Code" <> '' THEN BEGIN
        #4..29
                   ProdOrderComp."Bin Code",
                   "Order No.")
              THEN
                ERROR(UpdateInterruptedErr);
          END;
        END;

        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..32
                ERROR(Text012);
        #34..37
        */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 5831).OnValidate".

        //trigger "(Field 5831)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Resource THEN
          TESTFIELD("Entry Type","Entry Type"::"Assembly Output")
        ELSE
        #4..38
          Type::Resource:
            BEGIN
              Resource.GET("No.");
              Resource.CheckResourcePrivacyBlocked(FALSE);
              Resource.TESTFIELD(Blocked,FALSE);
            END;
        END;
        #46..50

        IF "Work Center No." <> '' THEN
          CreateDimWithProdOrderLine;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..41
        #43..53
        */
        //end;


        //Unsupported feature: Code Modification on ""Operation No."(Field 5838).OnValidate".

        //trigger "(Field 5838)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        IF "Operation No." = '' THEN
          EXIT;

        TESTFIELD("Order Type","Order Type"::Production);
        TESTFIELD("Order No.");
        TESTFIELD("Item No.");

        ConfirmOutputOnFinishedOperation;
        GetProdOrderRtngLine(ProdOrderRtngLine);

        CASE ProdOrderRtngLine.Type OF
        #13..16
        END;
        VALIDATE("No.",ProdOrderRtngLine."No.");
        Description := ProdOrderRtngLine.Description;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        #10..19
        */
        //end;


        //Unsupported feature: Code Modification on ""Output Quantity"(Field 5846).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Entry Type","Entry Type"::Output);
        IF SubcontractingWorkCenterUsed AND ("Output Quantity" <> 0) THEN
          ERROR(STRSUBSTNO(SubcontractedErr,FIELDCAPTION("Output Quantity"),"Line No."));

        ConfirmOutputOnFinishedOperation;

        IF LastOutputOperation(Rec) THEN
          WhseValidateSourceLine.ItemLineVerifyChange(Rec,xRec);

        "Output Quantity (Base)" := CalcBaseQty("Output Quantity");

        VALIDATE(Quantity,"Output Quantity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        #7..12
        */
        //end;

        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50000)".

        field(50900; "Item Manufacturing Date"; Date)
        {
            Description = 'LITS';
        }
        field(50901; "New Item Manu. Date"; Date)
        {
            Description = 'LITS';
        }
    }

    var
        Text012: Label 'The update has been interrupted to respect the warning.';

    var
        Text034: Label 'You cannot revalue individual item ledger entries for items that use the average costing method.';
}

