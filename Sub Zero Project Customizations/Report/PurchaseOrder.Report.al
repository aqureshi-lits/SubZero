report 50015 "Purchase Order"
{
    // NC-101 CODE MODIFIED
    // NC-102 CODE ADDED
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/PurchaseOrder.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1000000000; 38)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(SignAuth; SignAuth)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(Name; CompInfo.Name)
            {
            }
            column(Address; CompInfo.Address + ' Tel: ' + CompInfo."Phone No." + ' Fax : ' + CompInfo."Fax No.")
            {
            }
            column(Phone; CompInfo."Phone No.")
            {
            }
            column(Fax; CompInfo."Fax No.")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(TRNNo; CompInfo."VAT Registration No.")
            {
            }
            column(Vendname; "DataItem1000000000"."Buy-from Vendor Name")
            {
            }
            column(VendAddre; "Buy-from Address" + ', ' + "Buy-from Address 2" + ', ' + "Buy-from City" + ', ' + "Buy-from Country/Region Code")
            {
            }
            column(Stamp; CompInfo."LIT Stamp")
            {
            }
            column(VendPhone; VendPhone)
            {
            }
            column(Vendfax; "Vend Fax")
            {
            }
            column(VendEmail; VendEmail1)
            {
            }
            column(VendTRN; VendTRN)
            {
            }
            column(Purchaseorder; "No.")
            {
            }
            column(Date; "Posting Date")
            {
            }
            column(VendorRefNo; "Vendor Order No.")
            {
            }
            column(VendorRefDate; FORMAT("Vendor Reference Date", 0, '<Day>-<Month text,3>-<Year4>'))
            {
            }
            column(Attend; "Buy-from Contact")
            {
            }
            column(PaymentTerms; PayTerms.Description)
            {
            }
            column(Incoterms; "DataItem1000000000"."Shipment Method Code")
            {
            }
            column(ShiptoName; "DataItem1000000000"."Ship-to Name")
            {
            }
            column(ShiptoAddress; "DataItem1000000000"."Ship-to Address" + ' ' + "DataItem1000000000"."Ship-to Address 2")
            {
            }
            column(ShiptoCity; "DataItem1000000000"."Ship-to City")
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(SalesPersonNam; SalesPersonNam)
            {
            }
            column(CompanyShortcode; CompanyShortcode)
            {
            }
            column(AuthSign; LastApprover."LIT Signature")
            {
            }
            column(expectedReceiptDate; "DataItem1000000000"."Requested Receipt Date")
            {
            }
            column(PrintTnC; PrintTnC)
            {
            }
            dataitem(DataItem1000000015; 39)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(SNo; SNo)
                {
                }
                column(Partno; ItemCode)
                {
                }
                column(Description; Descr)
                {
                }
                column(Qty; FORMAT("DataItem1000000015".Quantity) + ' ' + "Unit of Measure Code")
                {
                }
                column(UnitPrice; "DataItem1000000015"."Direct Unit Cost")
                {
                }
                column(Total; "DataItem1000000015"."Line Amount")
                {
                }
                column(TotalAED; TotalAED)
                {
                }
                column(AmountInwords; amountInwords)
                {
                }
                column(SalesOrderNo; "Sales Order No.")
                {
                }
                column(VATRate; "VAT %")
                {
                }
                column(AmtwithVAT; AmtInclVAT)
                {
                }
                column(LineDiscountAmount; "Line Discount Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(ItemCode);
                    IF Type <> Type::" " THEN
                        SNo += 1;
                    IF Type <> Type::" " THEN BEGIN
                        ItemCode := "No.";
                        Descr := "DataItem1000000015".Description + ' ' + "DataItem1000000015"."Description 2";
                    END;

                    //NC-102
                    IF Type <> Type::Item THEN BEGIN
                        Descr := "DataItem1000000015".Description + ' ' + "DataItem1000000015"."Description 2";
                    END;
                    //NC-102
                    IF PrintNarration THEN BEGIN
                        Descr := "LIT Narration";
                    END;
                    //GSS-ASH
                    CLEAR(AmtInclVAT);
                    IF "Amount Including VAT" = 0 THEN BEGIN
                        AmtInclVAT := "Outstanding Amount";
                    END ELSE
                        AmtInclVAT := "Amount Including VAT";
                    //GSS-ASH
                    TotalAED := 0;
                    RecPurchLine.RESET;
                    RecPurchLine.SETRANGE(RecPurchLine."Document No.", "DataItem1000000000"."No.");
                    IF RecPurchLine.FINDFIRST THEN BEGIN
                        REPEAT
                            TotalAED += RecPurchLine."Amount Including VAT"; //GSS
                            IF RecPurchLine."Amount Including VAT" = 0 THEN
                                TotalAED += RecPurchLine."Outstanding Amount";
                        UNTIL RecPurchLine.NEXT = 0;
                    END;
                    "Line Amount" := "Line Amount" - "DataItem1000000015"."Inv. Discount Amount";
                    IF CurrencyToPrint <> "DataItem1000000000"."Currency Code" THEN BEGIN
                        IF CurrencyToPrint <> GLSetup."LCY Code" THEN BEGIN
                            "DataItem1000000015"."Direct Unit Cost" := CurrecnyExch.ExchangeAmtFCYToFCY(TODAY, OrderCurrency, CurrencyToPrint, "DataItem1000000015"."Direct Unit Cost");
                            "DataItem1000000015"."Line Amount" := CurrecnyExch.ExchangeAmtFCYToFCY(TODAY, OrderCurrency, CurrencyToPrint, "DataItem1000000015"."Line Amount");
                            TotalAED := CurrecnyExch.ExchangeAmtFCYToFCY(TODAY, OrderCurrency, CurrencyToPrint, TotalAED);
                            AmtInclVAT := CurrecnyExch.ExchangeAmtFCYToFCY(TODAY, OrderCurrency, CurrencyToPrint, AmtInclVAT);
                        END;
                    END;
                    IF amountInwords = '' THEN BEGIN
                        Check.FormatNoText(Amt, ROUND(TotalAED, 0.01, '='), '');
                        amountInwords := Amt[2] + Amt[1] + ' ' + CurrencyCode;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(SNo);
                end;
            }
            dataitem(DataItem9; 43)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    ORDER(Ascending);
                column(No; "DataItem9"."No.")
                {
                }
                column(Comment; "DataItem9".Comment)
                {
                }
            }
            // dataitem(DataItem20; 50028)
            // {
            //     DataItemLink = TnC No.=FIELD(Terms & Conditions);
            //     column(TnCDesc; Description)
            //     {
            //     }
            //     column(Bold; Bold)
            //     {
            //     }
            // }

            trigger OnAfterGetRecord()
            begin
                CLEAR(PayTerms); //GSS-ASH
                IF PayTerms.GET("DataItem1000000000"."Payment Terms Code") THEN; //GSS-ASH

                PurchasesPayable.GET;

                Vend.RESET;
                Vend.SETRANGE(Vend."No.", "DataItem1000000000"."Buy-from Vendor No.");
                IF Vend.FINDFIRST THEN BEGIN
                    VendPhone := Vend."Phone No.";
                    "Vend Fax" := Vend."Fax No.";
                END;
                SalesPersonNam := '';
                IF SalesPerson.GET("DataItem1000000000"."Purchaser Code") THEN
                    SalesPersonNam := SalesPerson.Name;
                RecGLSetup.GET;
                IF "DataItem1000000000"."Currency Code" = '' THEN
                    CurrencyCode := RecGLSetup."LCY Code"
                ELSE
                    CurrencyCode := "DataItem1000000000"."Currency Code";


                //NC-101
                Vend.RESET;
                IF Vend.GET("DataItem1000000000"."Buy-from Vendor No.") THEN
                    VendEmail1 := Vend."E-Mail";
                IF "DataItem1000000000"."Buy-from Contact No." <> '' THEN BEGIN
                    RecContact.GET("DataItem1000000000"."Buy-from Contact No.");
                    //RecContact.TESTFIELD(RecContact."E-Mail");
                    VendEmail1 := RecContact."E-Mail";
                END;
                VendTRN := Vend."VAT Registration No.";
                //NC-101
                RecContact.RESET;
                IF RecContact.GET("DataItem1000000000"."Buy-from Contact No.") THEN;
                IF ("DataItem1000000000".Status = "DataItem1000000000".Status::Released) OR
                ("DataItem1000000000".Status = "DataItem1000000000".Status::Released) THEN
                    ReportName := 'Purchase Order'
                ELSE
                    ReportName := 'Purchase Order-Pending For Approval';
                GLSetup.GET;

                OrderCurrency := "DataItem1000000000"."Currency Code";
                IF OrderCurrency = '' THEN
                    OrderCurrency := GLSetup."LCY Code";
                IF CurrencyToPrint = '' THEN
                    CurrencyToPrint := GLSetup."LCY Code";

                CurrencyCode := CurrencyToPrint;
                IF "DataItem1000000000"."Currency Code" = '' THEN
                    CurrencyCode := RecGLSetup."LCY Code"
                ELSE
                    CurrencyCode := "DataItem1000000000"."Currency Code";

                IF Status = Status::Released THEN
                    GetApprovers("No.");
                CLEAR(PrintTnC);
                IF "Terms & Conditions" <> '' THEN
                    PrintTnC := TRUE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Print Narration as Description"; PrintNarration)
                {
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture, "LIT Stamp");
        Check.InitTextVariable;
    end;

    var
        CompInfo: Record "Company Information";
        Vend: Record Vendor;
        VendPhone: Code[100];
        "Vend Fax": Text;
        VendEmail: Text;
        VendTRN: Text;
        SalesOrder: Text;
        TotalAED: Decimal;
        Check: Report Check;
        Amt: array[2] of Text;
        amountInwords: Text;
        CurrencyCode: Code[20];
        RecGLSetup: Record "General Ledger Setup";
        RecContact: Record Contact;
        ItemRec: Record Item;
        Descr: Text;
        ReportName: Text;
        CurrencyToPrint: Code[10];
        GLSetup: Record "General Ledger Setup";
        CurrecnyExch: Record "Currency Exchange Rate";
        OrderCurrency: Code[10];
        CompanyShortcode: Code[20];
        SalesPerson: Record "Salesperson/Purchaser";
        SalesPersonNam: Text;
        VendEmail1: Text[80];
        RecPurchLine: Record "Purchase Line";
        PurchasesPayable: Record "Purchases & Payables Setup";
        SignAuth: Text;
        PayTerms: Record "Payment Terms";
        ItemCode: Code[50];
        SNo: Integer;
        AmtInclVAT: Decimal;
        PrintNarration: Boolean;
        LastApprover: Record "User Setup";
        PrintTnC: Boolean;

    local procedure GetApprovers(DocNo: Code[20])
    var
        ApprovalEntry: Record 454;
    begin
        CLEAR(ApprovalEntry);
        ApprovalEntry.SETCURRENTKEY("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.");
        ApprovalEntry.SETRANGE("Document No.", DocNo);
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
        IF ApprovalEntry.FINDLAST THEN BEGIN
            LastApprover.GET(ApprovalEntry."Approver ID");
            LastApprover.CALCFIELDS("LIT Signature");
        END;

    end;
}

