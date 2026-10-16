tableextension 60061 GenJouLinExt extends "Gen. Journal Line"
{
    fields
    {

        field(60001; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60100; "LIT Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60101; "LIT Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60600; "LIT Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
            OptionCaption = 'Cheque,Bank Transfer,Direct Debit,Credit Card';
            OptionMembers = Cheque,"Bank Transfer","Direct Debit","Credit Card";
        }
        field(60999; "LIT Pre-Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

    }

    //         //Unsupported feature: Code Modification on ""Posting Date"(Field 5).OnValidate".

    //         //trigger OnValidate()
    //         //Parameters and return type have not been exported.
    //         //>>>> ORIGINAL CODE:
    //         //begin
    //         /*
    //         VALIDATE("Document Date","Posting Date");
    //         VALIDATE("Currency Code");

    //         IF ("Posting Date" <> xRec."Posting Date") AND (Amount <> 0) THEN
    //         #5..12

    //         IF "Deferral Code" <> '' THEN
    //           VALIDATE("Deferral Code");
    //         */
    //         //end;
    //         //>>>> MODIFIED CODE:
    //         //begin
    //         /*
    //         //GSS
    //         //VALIDATE("Document Date","Posting Date");
    //         //GSS
    //         #2..15
    //         */
    //         //end;


    //         //Unsupported feature: Code Modification on ""Bal. Account No."(Field 11).OnValidate".

    //         //trigger  Account No()
    //         //Parameters and return type have not been exported.
    //         //>>>> ORIGINAL CODE:
    //         //begin
    //         /*
    //         VALIDATE("Job No.",'');

    //         IF xRec."Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
    //         #4..20
    //             "Bal. Tax Area Code" := '';
    //             "Bal. Tax Liable" := FALSE;
    //             "Bal. Tax Group Code" := '';
    //             ClearCurrencyCode;
    //           END;
    //           EXIT;
    //         END;
    //         #28..53

    //         VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
    //         ValidateApplyRequirements(Rec);
    //         */
    //         //end;
    //         //>>>> MODIFIED CODE:
    //         //begin
    //         /*
    //         #1..23
    //         #25..56
    //         */
    //         //end;

    //         //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50001)".


    //         //Unsupported feature: Property Deletion (DataClassification) on ""Cheque No."(Field 50100)".


    //         //Unsupported feature: Property Deletion (DataClassification) on ""Cheque Date"(Field 50101)".


    //         //Unsupported feature: Property Deletion (DataClassification) on ""Payment Type"(Field 50600)".


    //         //Unsupported feature: Property Deletion (DataClassification) on ""Pre-Document No."(Field 50999)".

    //         field(50500; "Lease Agreement No."; Code[20])
    //         {
    //             Description = 'ASH-LM1.0';
    //             TableRelation = "Lease Management Header-V2".No.;

    //             trigger OnValidate()
    //             begin
    //                 //APNT-LM1.0 -
    //                 /*
    //                 GLSetup.GET;
    //                 IF "Lease Agreement No." <> '' THEN BEGIN
    //                   TESTFIELD("Account Type","Account Type"::"G/L Account");
    //                   DocDim.RESET;
    //                   DocDim.SETRANGE("Table ID",DATABASE::"Lease Management Header");
    //                   DocDim.SETRANGE("Document No.","Lease Agreement No.");
    //                   IF DocDim.FINDFIRST THEN REPEAT
    //                     JnlLineDim.RESET;
    //                     JnlLineDim.SETRANGE("Table ID",DATABASE::"Gen. Journal Line");
    //                     JnlLineDim.SETRANGE("Journal Template Name","Journal Template Name");
    //                     JnlLineDim.SETRANGE("Journal Batch Name","Journal Batch Name");
    //                     JnlLineDim.SETRANGE("Journal Line No.","Line No.");
    //                     JnlLineDim.SETRANGE("Dimension Code",DocDim."Dimension Code");
    //                     IF NOT JnlLineDim.FINDFIRST THEN BEGIN
    //                       JnlLineDim.INIT;
    //                       JnlLineDim."Table ID" := DATABASE::"Gen. Journal Line";
    //                       JnlLineDim."Journal Template Name" := "Journal Template Name";
    //                       JnlLineDim."Journal Batch Name" := "Journal Batch Name";
    //                       JnlLineDim."Journal Line No." := "Line No.";
    //                       JnlLineDim."Dimension Code" := DocDim."Dimension Code";
    //                       JnlLineDim."Dimension Value Code" := DocDim."Dimension Value Code";
    //                       JnlLineDim.INSERT;
    //                       IF DocDim."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
    //                         "Shortcut Dimension 1 Code" := DocDim."Dimension Value Code";
    //                       IF DocDim."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
    //                         "Shortcut Dimension 2 Code" := DocDim."Dimension Value Code";
    //                     END;
    //                   UNTIL DocDim.NEXT = 0;
    //                 END;
    //                 CLEAR("Posted Lease Agmt. No.");
    //                 CLEAR("Posted Lease Agmt. Charge No.");
    //                 */
    //                 //APNT-LM1.0 +

    //             end;
    //         }
    //         field(50501; "Lease Agreement Charge No."; Code[20])
    //         {
    //             Description = 'ASH-LM1.0';
    //             TableRelation = "Charges/ Deposits-V2";

    //             trigger OnValidate()
    //             var
    //                 AgreeChargeAmt: Record "Lease Charges/ Deposits-V2";
    //             begin
    //                 //APNT-LM1.0
    //                 AgreeChargeAmt.RESET;
    //                 AgreeChargeAmt.SETRANGE("Document Type", AgreeChargeAmt."Document Type"::"Lease Agreement");
    //                 AgreeChargeAmt.SETRANGE("Document No.", "Lease Agreement No.");
    //                 AgreeChargeAmt.SETRANGE("Charge No.", "Lease Agreement Charge No.");
    //                 IF NOT AgreeChargeAmt.FIND('-') THEN
    //                     ERROR('Agreement Charge Amount not found with Charge No. %1', "Lease Agreement Charge No.");
    //                 CLEAR("Posted Lease Agmt. No.");
    //                 CLEAR("Posted Lease Agmt. Charge No.");
    //                 //APNT-LM1.0
    //             end;
    //         }
    //         field(50502; "Posted Lease Agmt. No."; Code[20])
    //         {
    //             Description = 'ASH-LM1.0';
    //             TableRelation = "Posted Lease Mgt. Header-V2".No.;

    //             trigger OnValidate()
    //             begin
    //                 //APNT-LM1.0 -
    //                 /*
    //                 GLSetup.GET;
    //                 IF "Posted Lease Agmt. No." <> '' THEN BEGIN
    //                   TESTFIELD("Account Type","Account Type"::"G/L Account");
    //                   DocDim.RESET;
    //                   DocDim.SETRANGE("Table ID",DATABASE::"Posted Lease Mgt. Header");
    //                   DocDim.SETRANGE("Document No.","Posted Lease Agmt. No.");
    //                   IF DocDim.FINDFIRST THEN REPEAT
    //                     JnlLineDim.RESET;
    //                     JnlLineDim.SETRANGE("Table ID",DATABASE::"Gen. Journal Line");
    //                     JnlLineDim.SETRANGE("Journal Template Name","Journal Template Name");
    //                     JnlLineDim.SETRANGE("Journal Batch Name","Journal Batch Name");
    //                     JnlLineDim.SETRANGE("Journal Line No.","Line No.");
    //                     JnlLineDim.SETRANGE("Dimension Code",DocDim."Dimension Code");
    //                     IF NOT JnlLineDim.FINDFIRST THEN BEGIN
    //                       JnlLineDim.INIT;
    //                       JnlLineDim."Table ID" := DATABASE::"Gen. Journal Line";
    //                       JnlLineDim."Journal Template Name" := "Journal Template Name";
    //                       JnlLineDim."Journal Batch Name" := "Journal Batch Name";
    //                       JnlLineDim."Journal Line No." := "Line No.";
    //                       JnlLineDim."Dimension Code" := DocDim."Dimension Code";
    //                       JnlLineDim."Dimension Value Code" := DocDim."Dimension Value Code";
    //                       JnlLineDim.INSERT;
    //                       IF DocDim."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN
    //                         "Shortcut Dimension 1 Code" := DocDim."Dimension Value Code";
    //                       IF DocDim."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
    //                         "Shortcut Dimension 2 Code" := DocDim."Dimension Value Code";
    //                     END;
    //                   UNTIL DocDim.NEXT = 0;
    //                 END;
    //                 CLEAR("Lease Agreement No.");
    //                 CLEAR("Lease Agreement Charge No.");
    //                 */
    //                 //APNT-LM1.0 +

    //             end;
    //         }
    //         field(50503; "Posted Lease Agmt. Charge No."; Code[20])
    //         {
    //             Description = 'ASH-LM1.0';
    //             TableRelation = "Lease Charges/ Deposits-V2"."Charge No." WHERE("Document No." = FIELD("Posted Lease Agmt. No."),
    //                                                                              "Document Type" = CONST("Lease Agreement"));

    //             trigger OnValidate()
    //             var
    //                 AgreeChargeAmt: Record "50004";
    //             begin
    //                 //APNT-LM1.0
    //                 AgreeChargeAmt.RESET;
    //                 AgreeChargeAmt.SETRANGE("Document Type", AgreeChargeAmt."Document Type"::"Lease Agreement");
    //                 AgreeChargeAmt.SETRANGE("Document No.", "Posted Lease Agmt. No.");
    //                 AgreeChargeAmt.SETRANGE("Charge No.", "Posted Lease Agmt. Charge No.");
    //                 IF NOT AgreeChargeAmt.FIND('-') THEN
    //                     ERROR('Agreement Charge Amount not found with Charge No. %1', "Posted Lease Agmt. Charge No.");
    //                 CLEAR("Lease Agreement No.");
    //                 CLEAR("Lease Agreement Charge No.");
    //                 //APNT-LM1.0
    //             end;
    //         }
    //         field(50504; "Lease Agreement Charge Type"; Option)
    //         {
    //             Description = 'ASH-LM1.0';
    //             OptionCaption = 'Deposit,Charge';
    //             OptionMembers = Deposit,Charge;
    //         }
    //         field(51501; "Unit Name"; Text[50])
    //         {
    //             FieldClass = FlowField;
    //             CalcFormula = Lookup("Lease Agreement Units-V2"."Unit Name" WHERE("Document No." = FIELD("Lease Agreement No.")));
    //             Description = 'LM';

    //         }
    //         field(51502; "Term Revenue Entry"; Boolean)
    //         {
    //             Description = 'GSS-STUY';
    //         }
    //         field(51503; "Cheque Printed By"; Code[20])
    //         {
    //             Description = 'GSS-NAW';
    //         }
    //         field(51504; "Cheque Printed Date"; DateTime)
    //         {
    //             Description = 'GSS-NAW';
    //         }
    //     }


    //     //Unsupported feature: Code Modification on "OnInsert".

    //     //trigger OnInsert()
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     GenJnlAlloc.LOCKTABLE;
    //     LOCKTABLE;
    //     GenJnlTemplate.GET("Journal Template Name");
    //     GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
    //     "Copy VAT Setup to Jnl. Lines" := GenJnlBatch."Copy VAT Setup to Jnl. Lines";
    //     "Posting No. Series" := GenJnlBatch."Posting No. Series";
    //     "Check Printed" := FALSE;

    //     ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
    //     ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     #1..7
    //     //GSS-ASH
    //     //"Pre-Document No." := "Document No.";
    //     //GSS-ASH
    //     #8..10
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "OnModify".

    //     //trigger OnModify()
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     TESTFIELD("Check Printed",FALSE);
    //     IF ("Applies-to ID" = '') AND (xRec."Applies-to ID" <> '') THEN
    //       ClearCustVendApplnEntry;
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     #1..3

    //     //GSS-ASH
    //     //"Pre-Document No." := "Document No.";
    //     //GSS-ASH
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "UpdateLineBalance(PROCEDURE 2)".

    //     //procedure UpdateLineBalance();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     "Debit Amount" := 0;
    //     "Credit Amount" := 0;

    //     IF ((Amount > 0) AND (NOT Correction)) OR
    //        ((Amount < 0) AND Correction)
    //     THEN
    //       "Debit Amount" := Amount
    //     ELSE
    //       IF Amount <> 0 THEN
    //         "Credit Amount" := -Amount;

    //     IF "Currency Code" = '' THEN
    //       "Amount (LCY)" := Amount;
    //     CASE TRUE OF
    //       ("Account No." <> '') AND ("Bal. Account No." <> ''):
    //         "Balance (LCY)" := 0;
    //       "Bal. Account No." <> '':
    //         "Balance (LCY)" := -"Amount (LCY)";
    //       ELSE
    //         "Balance (LCY)" := "Amount (LCY)";
    //     END;

    //     CLEAR(GenJnlAlloc);
    //     GenJnlAlloc.UpdateAllocations(Rec);

    //     UpdateSalesPurchLCY;

    //     IF ("Deferral Code" <> '') AND (Amount <> xRec.Amount) AND ((Amount <> 0) AND (xRec.Amount <> 0)) THEN
    //       VALIDATE("Deferral Code");
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     IF ((Amount > 0) AND (NOT Correction)) OR
    //        ((Amount < 0) AND Correction)
    //     THEN BEGIN
    //       "Debit Amount" := Amount;
    //       "Credit Amount" := 0
    //     END ELSE BEGIN
    //       "Debit Amount" := 0;
    //       "Credit Amount" := -Amount;
    //     END;
    //     #12..29
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 9)".

    //     //procedure SetUpNewLine();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     GenJnlTemplate.GET("Journal Template Name");
    //     GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
    //     GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    //     #4..41
    //       "Account Type" := "Account Type"::"G/L Account";
    //     VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
    //     Description := '';
    //     IF GenJnlBatch."Suggest Balancing Amount" THEN
    //       SuggestBalancingAmount(LastGenJnlLine,BottomLine);
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     #1..44
    //     //GSS-ASH
    //     //"Pre-Document No." := "Document No.";
    //     //GSS-ASH
    //     IF GenJnlBatch."Suggest Balancing Amount" THEN
    //       SuggestBalancingAmount(LastGenJnlLine,BottomLine);
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "ExportPaymentFile(PROCEDURE 81)".

    //     //procedure ExportPaymentFile();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     IF NOT FINDSET THEN
    //       ERROR(NothingToExportErr);
    //     SETRANGE("Journal Template Name","Journal Template Name");
    //     SETRANGE("Journal Batch Name","Journal Batch Name");
    //     TESTFIELD("Check Printed",FALSE);

    //     CheckDocNoOnLines;
    //     IF IsExportedToPaymentFile THEN
    //       IF NOT CONFIRM(ExportAgainQst) THEN
    //     #10..12
    //       CODEUNIT.RUN(BankAcc.GetPaymentExportCodeunitID,Rec)
    //     ELSE
    //       CODEUNIT.RUN(CODEUNIT::"Exp. Launcher Gen. Jnl.",Rec);
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     #1..6
    //     GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
    //     GenJnlBatch.TESTFIELD("Bal. Account Type",GenJnlBatch."Bal. Account Type"::"Bank Account");
    //     GenJnlBatch.TESTFIELD("Bal. Account No.");

    //     #7..15
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "CopyFromSalesHeader(PROCEDURE 103)".

    //     //procedure CopyFromSalesHeader();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     "Source Currency Code" := SalesHeader."Currency Code";
    //     "Currency Factor" := SalesHeader."Currency Factor";
    //     "VAT Base Discount %" := SalesHeader."VAT Base Discount %";
    //     #4..10
    //     "Source No." := SalesHeader."Bill-to Customer No.";
    //     "Posting No. Series" := SalesHeader."Posting No. Series";
    //     "Ship-to/Order Address Code" := SalesHeader."Ship-to Code";
    //     "IC Partner Code" := SalesHeader."Bill-to IC Partner Code";
    //     "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
    //     "On Hold" := SalesHeader."On Hold";
    //     IF "Account Type" = "Account Type"::Customer THEN
    //       "Posting Group" := SalesHeader."Customer Posting Group";
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     #1..13
    //     "IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    //     #15..18
    //     */
    //     //end;

    //     //Unsupported feature: Variable Insertion (Variable: DocNo) (VariableCollection) on "IncrementDocumentNo(PROCEDURE 120)".



    //     //Unsupported feature: Code Modification on "IncrementDocumentNo(PROCEDURE 120)".

    //     //procedure IncrementDocumentNo();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     IF GenJnlBatch."No. Series" <> '' THEN BEGIN
    //       NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine,GenJnlBatch."No. Series","Posting Date");
    //       IF NoSeriesLine."Increment-by No." > 1 THEN
    //         NoSeriesMgt.IncrementNoText("Document No.",NoSeriesLine."Increment-by No.")
    //       ELSE
    //         "Document No." := INCSTR("Document No.");
    //     END ELSE
    //       "Document No." := INCSTR("Document No.");
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     #1..8
    //     //GSS
    //     IF GenJnlBatch."No. Series" <> '' THEN BEGIN
    //       CLEAR(DocNo);
    //       DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series","Posting Date");
    //       IF DocNo > "Document No." THEN
    //         "Document No." := DocNo;
    //     END;
    //     //GSS
    //     */
    //     //end;

    //     //Unsupported feature: Property Deletion (Local) on "GetGLAccount(PROCEDURE 146)".


    //     //Unsupported feature: Property Deletion (Local) on "GetGLBalAccount(PROCEDURE 121)".


    //     //Unsupported feature: Property Deletion (Local) on "GetCustomerAccount(PROCEDURE 47)".


    //     //Unsupported feature: Property Deletion (Local) on "GetVendorAccount(PROCEDURE 115)".


    //     //Unsupported feature: Property Deletion (Local) on "GetBankAccount(PROCEDURE 116)".



    //     //Unsupported feature: Code Modification on "SetSalespersonPurchaserCode(PROCEDURE 933)".

    //     //procedure SetSalespersonPurchaserCode();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     IF SalesperPurchCodeToCheck <> '' THEN
    //       IF SalespersonPurchaser.GET(SalesperPurchCodeToCheck) THEN
    //         IF SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) THEN
    //           SalesperPuchCodeToAssign := ''
    //         ELSE
    //           SalesperPuchCodeToAssign := SalesperPurchCodeToCheck;
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     {IF SalesperPurchCodeToCheck <> '' THEN
    //     #2..5
    //           SalesperPuchCodeToAssign := SalesperPurchCodeToCheck;}
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "ValidateSalesPersonPurchaserCode(PROCEDURE 298)".

    //     //procedure ValidateSalesPersonPurchaserCode();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     IF GenJournalLine2."Salespers./Purch. Code" <> '' THEN
    //       IF SalespersonPurchaser.GET(GenJournalLine2."Salespers./Purch. Code") THEN
    //         IF SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) THEN
    //           ERROR(SalespersonPurchPrivacyBlockErr,GenJournalLine2."Salespers./Purch. Code");
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     {IF GenJournalLine2."Salespers./Purch. Code" <> '' THEN
    //       IF SalespersonPurchaser.GET(GenJournalLine2."Salespers./Purch. Code") THEN
    //         IF SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) THEN
    //           ERROR(SalespersonPurchPrivacyBlockErr,GenJournalLine2."Salespers./Purch. Code");}
    //     */
    //     //end;


    //     //Unsupported feature: Code Modification on "CheckIfPrivacyBlocked(PROCEDURE 208)".

    //     //procedure CheckIfPrivacyBlocked();
    //     //Parameters and return type have not been exported.
    //     //>>>> ORIGINAL CODE:
    //     //begin
    //     /*
    //     IF FIND('-') THEN BEGIN
    //       REPEAT
    //         CASE "Account Type" OF
    //           "Account Type"::Customer:
    //     #5..18
    //             END;
    //         END;
    //       UNTIL NEXT <= 0;
    //     END;
    //     */
    //     //end;
    //     //>>>> MODIFIED CODE:
    //     //begin
    //     /*
    //     {IF FIND('-') THEN BEGIN
    //     #2..21
    //     END;}
    //     */
    //     //end;
}

