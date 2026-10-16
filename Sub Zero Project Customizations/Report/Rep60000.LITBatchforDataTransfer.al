// report 60000 "LIT Batch for Data Transfer"
// {
//     ApplicationArea = All;
//     Caption = 'LIT - Batch for data transfer of extended fields';
//     UsageCategory = Administration;
//     ProcessingOnly = true;
//     Permissions = tabledata "Cust. Ledger Entry" = RIMD,
//                   tabledata "Company Information" = RIMD,
//                   tabledata Customer = RIMD,
//                   tabledata "Gen. Journal Line" = RIMD,
//                   tabledata "Gen. Journal Batch" = RIMD,
//                   tabledata "G/L Entry" = RIMD,
// tabledata "Item Journal Line" = RIMD,
// tabledata "Item Ledger Entry" = RIMD,
// tabledata "Purchase Header Archive" = RIMD,
//     tabledata "Purch. Cr. Memo Line" = RIMD,
// tabledata "Purch. Inv. Header" = RIMD,
// tabledata "Purch. Inv. Line" = RIMD,
// tabledata "Purch. Rcpt. Header" = RIMD,
// tabledata "Purch. Rcpt. Line" = RIMD,
// tabledata "Sales Cr.Memo Header" = RIMD,

// tabledata "Sales Cr.Memo Line" = rimd,
//     tabledata "Resource" = RIMD,
// tabledata "Resources Setup" = RIMD,
// tabledata "Job" = RIMD,
// tabledata "Job Journal Line" = RIMD,
// tabledata "Purchases & Payables Setup" = RIMD,
//                   tabledata "Purchase Line" = RIMD,
//                   tabledata "Accounting Period" = RIMD,
//                   tabledata "Purchase Header" = RIMD,
//                   tabledata "User Setup" = RIMD;

//     dataset
//     {
//         dataitem("Company Information"; "Company Information")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Company Information"."LIT Stamp" := "Company Information"."Stamp";
//                 "Company Information".Modify();
//             end;
//         }
//         dataitem(Customer; Customer)
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Customer"."LIT E-Mail2" := Customer."E-Mail2";
//                 "Customer".Modify();
//             end;
//         }

//         dataitem("Gen. Journal Line"; "Gen. Journal Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Gen. Journal Line"."LIT Narration" := "Gen. Journal Line"."Narration";
//                 "Gen. Journal Line"."LIT Cheque No." := "Gen. Journal Line"."Cheque No.";
//                 "Gen. Journal Line"."LIT Cheque Date" := "Gen. Journal Line"."Cheque Date";
//                 "Gen. Journal Line"."LIT Payment Type" := "Gen. Journal Line"."Payment Type";
//                 "Gen. Journal Line"."LIT Pre-Document No." := "Gen. Journal Line"."Pre-Document No.";
//                 "Gen. Journal Line".Modify();
//             end;
//         }
//         dataitem("Gen. Journal Batch"; "Gen. Journal Batch")
//         {
//             trigger OnAfterGetRecord()
//             begin

//                 "Gen. Journal Batch"."LIT User" := "Gen. Journal Batch"."LIT User";
//                 "Gen. Journal Batch".Modify();
//             end;
//         }
//         dataitem("G/L Entry"; "G/L Entry")
//         {
//             trigger OnAfterGetRecord()
//             begin

//                 "G/L Entry"."LIT Narration" := "G/L Entry"."Narration";
//                 "G/L Entry"."LIT Cheque No." := "G/L Entry"."Cheque No.";
//                 "G/L Entry"."LIT Cheque Date" := "G/L Entry"."Cheque Date";
//                 "G/L Entry"."LIT Payment Type" := "G/L Entry"."Payment Type";
//                 "G/L Entry"."LIT Pre-Document No." := "G/L Entry"."Pre-Document No.";

//                 "G/L Entry"."LIT Source Name" := "G/L Entry"."Source Name";
//                 "G/L Entry"."LIT Paid To" := "G/L Entry"."Paid To";
//                 "G/L Entry".Modify();
//             end;
//         }
//         dataitem("Item Journal Line"; "Item Journal Line")
//         {
//             trigger OnAfterGetRecord()
//             begin

//                 "Item Journal Line"."LIT Narration" := "Item Journal Line"."Narration";
//                 "Item Journal Line".Modify();
//             end;
//         }
//         dataitem("Item Ledger Entry"; "Item Ledger Entry")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Item Ledger Entry"."LIT Narration" := "Item Ledger Entry"."Narration";
//                 "Item Ledger Entry".Modify();
//             end;
//         }
//         dataitem("Purchase Header1"; "Purchase Header")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purchase Header1"."LIT Narration" := "Purchase Header1"."Narration";
//                 "Purchase Header1".Modify();
//             end;
//         }
//         dataitem("Purchase Header Archive"; "Purchase Header Archive")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purchase Header Archive"."LIT Narration" := "Purchase Header Archive"."Narration";
//                 "Purchase Header Archive".Modify();
//             end;
//         }

//         dataitem("Purchase Line1"; "Purchase Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purchase Line1"."LIT Narration" := "Purchase Line1"."Narration";
//                 "Purchase Line1"."LIT Container No." := "Purchase Line1"."Container No.";
//                 "Purchase Line1".Modify();
//             end;
//         }

//         dataitem("Purch. Inv. Header1"; "Purch. Inv. Header")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purch. Inv. Header1"."LIT Narration" := "Purch. Inv. Header1"."Narration";

//                 "Purch. Inv. Header1".Modify();
//             end;
//         }

//         dataitem("Purch. Inv. Line1"; "Purch. Inv. Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purch. Inv. Line1"."LIT Narration" := "Purch. Inv. Line1"."Narration";
//                 "Purch. Inv. Line1".Modify();
//             end;
//         }

//         dataitem("Purch. Rcpt. Header1"; "Purch. Rcpt. Header")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purch. Rcpt. Header1"."LIT Narration" := "Purch. Rcpt. Header1"."Narration";
//                 "Purch. Rcpt. Header1".Modify();
//             end;
//         }

//         dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Sales Cr.Memo Line"."LIT Margin" := "Sales Cr.Memo Line"."Margin";
//                 "Sales Cr.Memo Line"."LIT Margin %" := "Sales Cr.Memo Line"."Margin %";
//                 "Sales Cr.Memo Line"."LIT Narration" := "Sales Cr.Memo Line"."Narration";
//                 "Sales Cr.Memo Line".Modify();
//             end;
//         }

//         dataitem("Sales Invoice Line"; "Sales Invoice Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Sales Invoice Line"."LIT Margin" := "Sales Invoice Line"."Margin";
//                 "Sales Invoice Line"."LIT Margin %" := "Sales Invoice Line"."Margin %";
//                 "Sales Invoice Line"."LIT Narration" := "Sales Invoice Line"."Narration";
//                 "Sales Invoice Line".Modify();
//             end;
//         }

//         dataitem("Sales Line"; "Sales Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Sales Line"."LIT Margin" := "Sales Line"."Margin";
//                 "Sales Line"."LIT Margin %" := "Sales Line"."Margin %";
//                 "Sales Line"."LIT Narration" := "Sales Line"."Narration";
//                 "Sales Line".Modify();
//             end;
//         }

//         dataitem("Sales Line Archive"; "Sales Line Archive")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Sales Line Archive"."LIT Margin" := "Sales Line Archive"."margin";
//                 "Sales Line Archive"."LIT Margin %" := "Sales Line Archive"."Margin %";
//                 "Sales Line Archive"."LIT Narration" := "Sales Line Archive"."Narration";
//                 "Sales Line Archive".Modify();
//             end;
//         }

//         dataitem("Sales Shipment Line"; "Sales Shipment Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Sales Shipment Line"."LIT Margin" := "Sales Shipment Line"."Margin";
//                 "Sales Shipment Line"."LIT Margin %" := "Sales Shipment Line"."Margin %";
//                 "Sales Shipment Line"."LIT Narration" := "Sales Shipment Line"."Narration";
//                 "Sales Shipment Line".Modify();
//             end;
//         }

//         dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "Purch. Rcpt. Line"."LIT Narration" := "Purch. Rcpt. Line"."Narration";
//                 "Purch. Rcpt. Line".Modify();
//             end;
//         }




//         dataitem("User Setup"; "User Setup")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 "User Setup"."LIT Designation" := "User Setup"."Designation";
//                 "User Setup"."LIT Signature" := "User Setup"."Signature";
//                 "User Setup".Modify();

//                 // Message('Completed');
//             end;
//         }



//     }




//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(Processing)
//             {
//             }
//         }
//     }

//     trigger OnPostReport()
//     var
//         myInt: Integer;
//     begin
//         Message('Completed');
//     end;
// }
