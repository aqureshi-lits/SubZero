codeunit 80088 "WMS Billing Subscribers"
{
    Permissions = tabledata "Item Ledger Entry" = rimd;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure ValidatePurchaseHeaderOnInsert(var Rec: Record "Purchase Header";
    RunTrigger: Boolean)
    begin
        //NormalizePurchaseHeader(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeModifyEvent', '', false, false)]
    local procedure ValidatePurchaseHeaderOnModify(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        //NormalizePurchaseHeader(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure UpdateItemLedgerWMSCharges(var Rec: Record "Purch. Rcpt. Header"; var xRec: Record "Purch. Rcpt. Header"; RunTrigger: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        if (Rec."Over Time" = xRec."Over Time") and
           (Rec."WMS Management Fee" = xRec."WMS Management Fee") And (rec."DM Inspection" = xRec."DM Inspection") and
           (Rec."Plug In" = xRec."Plug In") and (Rec."Container Type" = xRec."Container Type")

            then
            exit;

        ItemLedgerEntry.SetRange("Document No.", Rec."No.");
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
        ItemLedgerEntry.SetFilter(Quantity, '>%1', 0);
        if ItemLedgerEntry.FindSet() then
            repeat
                // ItemLedgerEntry."WMS Fixed Monthly Charge" := Rec."WMS Fixed Monthly Charge";
                ItemLedgerEntry."WMS Management Fee" := Rec."WMS Management Fee";
                ItemLedgerEntry."WMS Over time" := Rec."Over Time";
                ItemLedgerEntry."WMS DM Inspection" := Rec."DM Inspection";
                ItemLedgerEntry."WMS Plug In" := Rec."Plug In";
                itemLedgerEntry."Container Type" := Rec."Container Type";
                ItemLedgerEntry.Modify(false);
            until ItemLedgerEntry.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnBeforeInsertEvent', '', false, false)]
    local procedure CopyBillingToItemLedgerEntry(var Rec: Record "Item Ledger Entry"; RunTrigger: Boolean)
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        if Rec."Entry Type" <> Rec."Entry Type"::Purchase then
            exit;
        if Rec.Quantity <= 0 then
            exit;
        if Rec."Document No." = '' then
            exit;
        if not PurchRcptHeader.Get(Rec."Document No.") then
            exit;

        // Rec."WMS Billing Type" := PurchRcptHeader."WMS Billing Type";
        // Rec."WMS Allocated Pallets" := PurchRcptHeader."WMS Allocated Pallets";
        // Rec."WMS Minimum Storage Days" := PurchRcptHeader."WMS Minimum Storage Days";
        // Rec."WMS Storage Rate" := PurchRcptHeader."WMS Storage Rate";
        // Rec."WMS Fixed Monthly Charge" := PurchRcptHeader."WMS Fixed Monthly Charge";
        // Rec."WMS Management Fee" := PurchRcptHeader."WMS Management Fee";
        Rec."WMS Purchase Order No." := PurchRcptHeader."Order No.";
        Rec."WMS Purchase Receipt No." := PurchRcptHeader."No.";
    end;

    // local procedure NormalizePurchaseHeader(var PurchaseHeader: Record "Purchase Header")
    // begin
    //     if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
    //         exit;

    //     case PurchaseHeader."WMS Billing Type" of
    //         PurchaseHeader."WMS Billing Type"::Normal:
    //             begin
    //                 PurchaseHeader."WMS Allocated Pallets" := 0;
    //                 PurchaseHeader."WMS Minimum Storage Days" := 0;
    //                 PurchaseHeader."WMS Fixed Monthly Charge" := 0;
    //             end;
    //         PurchaseHeader."WMS Billing Type"::"Fixed Location":
    //             PurchaseHeader."WMS Minimum Storage Days" := 0;
    //         PurchaseHeader."WMS Billing Type"::"Fixed Days":
    //             begin
    //                 PurchaseHeader."WMS Allocated Pallets" := 0;
    //                 PurchaseHeader."WMS Fixed Monthly Charge" := 0;
    //             end;
    //     end;
    // end;
}
