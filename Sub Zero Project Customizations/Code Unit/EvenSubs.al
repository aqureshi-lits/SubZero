codeunit 60000 "Event Subs"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine_TransferFields(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin


    end;

    //Transfer Fields from General Journal to Customer Ledger Entries.
    [EventSubscriber(ObjectType::Table, database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine_TransferFields(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        // //MAQ IAX Added 27-08-2018 START.
        // CustLedgerEntry."LIT Remarks" := GenJournalLine."LIT Remarks";
        // CustLedgerEntry."LIT Check No." := GenJournalLine."LIT Check No.";
        // CustLedgerEntry."LIT Check Date" := GenJournalLine."LIT Check Date";
        // CustLedgerEntry."LIT Bank Date" := GenJournalLine."LIT Bank Date";
        // CustLedgerEntry."LIT Responsibility Center" := GenJournalLine."lit Responsibility Center";
        // CustLedgerEntry."LIT Posted By" := USERID;
        // CustLedgerEntry."LIT Posted Date" := CURRENTDATETIME;
        // //MAQ IAX Added 27-08-2018 END.

    end;


    [EventSubscriber(ObjectType::Table, database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(VAR GLEntry: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line");
    begin
        // //MAQ IAX Added 27-08-2018 START.
        // GLEntry."LIT Remarks" := GenJournalLine."LIT Remarks";
        // GLEntry."LIT Check No." := GenJournalLine."LIT Check No.";
        // GLEntry."LIT Check Date" := GenJournalLine."LIT Check Date";
        // GLEntry."LIT Bank Date" := GenJournalLine."LIT Bank Date";
        // GLEntry."LIT Responsibility Center" := GenJournalLine."lit Responsibility Center";
        // GLEntry."LIT Posted By" := USERID;
        // GLEntry."LIT Posted Date" := CURRENTDATETIME;
        // //MAQ IAX Added 27-08-2018 END.

        GLEntry."LIT Narration" := GenJournalLine."LIT Narration";
        GLEntry."LIT Cheque Date" := GenJournalLine."LIT Cheque Date";
        GLEntry."LIT Cheque No." := GenJournalLine."LIT Cheque No.";


    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; VAR GenJournalLine: Record "Gen. Journal Line");
    begin
        // GenJournalLine
        GenJournalLine."LIT Narration" := PurchaseHeader."LIT Narration";
        // GenJournalLine."LIT Responsibility Center" := PurchaseHeader."Responsibility Center";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; VAR GenJournalLine: Record "Gen. Journal Line");
    begin
        // // GenJournalLine."LIT Employee No." := SalesHeader.
        // GenJournalLine."LIT Responsibility Center" := SalesHeader."Responsibility Center";  //MAQ IAX Added 08-11-2018.
        // GenJournalLine."LIT Remarks" := SalesHeader."LIT Remarks"; //MAQ IAX Added 24-12-2018.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", 'OnAfterPrepareInvoicePostingBuffer', '', false, false)]
    local procedure OnAfterPrepareInvoicePostingBuffer(var SalesLine: Record "Sales Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin
        InvoicePostingBuffer."LIT Narration" := SalesLine."LIT Narration";
        // InvoicePostingBuffer.Description3 := SalesLine.Description3;

        //Message(Format(InvoicePostingBuffer."LIT Description 2"));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", 'OnPostLinesOnBeforeGenJnlLinePost', '', false, false)]
    local procedure OnPostLinesOnBeforeGenJnlLinePost(var GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; TempInvoicePostingBuffer: Record "Invoice Posting Buffer"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; SuppressCommit: Boolean)
    begin
        GenJnlLine."LIT Narration" := TempInvoicePostingBuffer."LIT Narration";
        // GenJnlLine.Description3 := TempInvoicePostingBuffer.Description3;
        // //Message('Wajahat1');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertGlobalGLEntry, '', false, false)]
    local procedure OnBeforeInsertGlobalGLEntry(var GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register");
    begin
        GlobalGLEntry."LIT Narration" := GenJournalLine."LIT Narration";
        GLRegister."LIT Document No." := GenJournalLine."Document No.";
        // GlobalGLEntry.Description3 := GenJournalLine.Description3;
        // //Message('Wajahat1');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnAfterPrepareInvoicePostingBuffer, '', false, false)] //debugger not coming here
    local procedure OnAfterPrepareInvoicePostingBuffer1(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin
        InvoicePostingBuffer."LIT Narration" := PurchaseLine."LIT Narration";
        // InvoicePostingBuffer.Description3 := PurchaseLine.Description3;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPostLinesOnBeforeGenJnlLinePost, '', false, false)] //debugger not coming here
    local procedure OnPostLinesOnBeforeGenJnlLinePost1(var GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header"; TempInvoicePostingBuffer: Record "Invoice Posting Buffer"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; SuppressCommit: Boolean)
    begin
        // GenJnlLine."LIT Description2" := TempInvoicePostingBuffer."LIT Description 2";
        // GenJnlLine.Description3 := TempInvoicePostingBuffer.Description3;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Jnl.-Post Line", 'OnBeforePostFixedAssetFromGenJnlLine', '', true, true)]
    local procedure OnBeforePostFixedAssetFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var FALedgerEntry: Record "FA Ledger Entry"; FAAmount: Decimal; VATAmount: Decimal; GLRegisterNo: Integer)
    begin
        // FALedgerEntry.Description := GenJournalLine.Description;
        // FALedgerEntry."Description 3" := GenJournalLine.Description3;
    end;

    // [EventSubscriber(ObjectType::Report, Report::"Calculate Depreciation", 'OnAfterCalculateDepreciation', '', true, true)]
    // local procedure OnAfterCalculateDepreciation(FANo: Code[20]; var TempGenJournalLine: Record "Gen. Journal Line" temporary; var TempFAJournalLine: Record "FA Journal Line" temporary; var DeprAmount: Decimal; var NumberOfDays: Integer; DeprBookCode: Code[10]; DeprUntilDate: Date; EntryAmounts: array[4] of Decimal; DaysInPeriod: Integer)
    // begin
    //     TempGenJournalLine.Description3 := TempGenJournalLine.Description;
    //     //TempFAJournalLine.Modify();
    // end;

    // [EventSubscriber(ObjectType::Report, Report::"Calculate Depreciation", 'OnBeforeGenJnlLineInsert', '', true, true)]
    // local procedure OnBeforeGenJnlLineInsert(var TempGenJournalLine: Record "Gen. Journal Line" temporary; var GenJournalLine: Record "Gen. Journal Line")
    // var
    // //A: report "Calculate FA Depreciation";
    // begin
    //     TempGenJournalLine.Description3 := TempGenJournalLine.Description;
    // end;

    // [EventSubscriber(ObjectType::Report, Report::"Calculate Depreciation", 'OnAfterFAInsertGLAccGetBalAcc', '', true, true)]
    // local procedure OnAfterFAInsertGLAccGetBalAcc(var GenJnlLine: Record "Gen. Journal Line"; var GenJnlNextLineNo: Integer; var BalAccount: Boolean; var TempGenJnlLine: Record "Gen. Journal Line")
    // begin
    //     GenJnlLine.Description3 := GenJnlLine.Description;
    //     GenJnlLine.Modify();
    // end;

    // [EventSubscriber(ObjectType::Report, Report::"Calculate FA Depreciation", 'OnAfterCalculateDepreciation', '', true, true)]
    // local procedure OnAfterCalculateDepreciation(FANo: Code[20]; var TempGenJournalLine: Record "Gen. Journal Line" temporary; var TempFAJournalLine: Record "FA Journal Line" temporary;
    //     var DeprAmount: Decimal;
    //     var NumberOfDays: Integer;
    //     DeprBookCode: Code[10];
    //     DeprUntilDate: Date;
    //     EntryAmounts: array[4] of Decimal;
    //     DaysInPeriod: Integer)
    // begin
    //     //TempGenJournalLine.Description3 := TempFAJournalLine.Description; //TempGenJournalLine.Description;
    //     //Message('Test');
    // end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseOnBeforeStartPosting', '', false, false)]
    local procedure OnReverseOnBeforeStartPosting(var GenJournalLine: Record "Gen. Journal Line"; var ReversalEntry: Record "Reversal Entry"; var GLEntry: Record "G/L Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var

        AA: Codeunit 179;
    begin
        // GenJournalLine.Description3 := GLEntry.Description3;
        // GenJournalLine.Modify();
        //Message('%1 :1', GLEntry.Description3);
        // Message('%1 :1', GLEntry2.Description3);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reversal-Post", 'OnAfterInsertReversedGLEntry', '', false, false)]
    // local procedure OnAfterInsertReversedGLEntry(
    // var NewGLEntry: Record "G/L Entry";
    // OldGLEntry: Record "G/L Entry")
    // begin
    //     // if NewGLEntry."LIT Custom Field" = '' then begin
    //     //     NewGLEntry."LIT Custom Field" := OldGLEntry."LIT Custom Field";
    //     //     NewGLEntry.Modify(true);
    //     // end;
    // end;




    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnAfterCopyGLeEntryOnReverse', '', true)]
    // local procedure HandleOnAfterCopyGLeEntryOnReverse(var SourceGLeEntry: Record "G/L Entry";var DestGLeEntry: Record "G/L Entry";
    //     var CopyCustomFields: Boolean
    // )
    // begin
    //     // 1. Read the custom field value from the original entry (SourceGLeEntry)
    //     // Assuming your custom field is called "MyCustomField" and is an Integer.
    //     // You must have extended the "G/L Entry" table for this to work.

    //     // 2. Assign the value to the new reversed entry (DestGLeEntry)
    //     DestGLeEntry."MyCustomField" := SourceGLeEntry."MyCustomField";

    //     // 3. (Crucial) Set the Boolean to true to indicate the custom fields were handled.
    //     // This prevents the system from generating a warning/error about uncopied fields
    //     // if it has logic to check for them.
    //     CopyCustomFields := true;
    // end;


    //151225
    //OnAfterCreateFAJnlLine
    //OnAfterInitFAJnlLine
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Jnl.-Post Line", 'OnAfterGenJnlPostLine', '', false, false)]
    // local procedure OnAfterGenJnlPostLine(var GenJournalLine: Record "Gen. Journal Line")
    // begin
    //     GenJournalLine.Description3 := GenJournalLine.Description;
    //     GenJournalLine.Modify();
    // end;

    //151225

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertGlobalGLEntry, '', false, false)] //3
    // local procedure OnBeforeInsertGlobalGLEntry1(var GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register");
    // begin
    //     // GlobalGLEntry.Memo := GenJournalLine.Memo;
    //     // GlobalGLEntry."Memo 2" := GenJournalLine."Memo 2";
    // end;

}
