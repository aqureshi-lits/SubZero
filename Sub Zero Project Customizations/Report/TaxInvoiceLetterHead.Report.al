report 50038 "Tax Invoice - Letter Head"
{
    // //nc-101 :: code added for customer phone and city
    // APPR1.0 ADDED PREPARED BY AND APPROVED BY SIGNATURES IN THE REPORT
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/TaxInvoiceLetterHead.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.", "Posting Date";
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompName; CompName)
            {
            }
            column(CompAddre; CompInfo.Address + '  ' + CompInfo."Address 2" + ' Phone No. : ' + CompInfo."Phone No." + ' Fax No. : ' + CompInfo."Fax No.")
            {
            }
            column(CompTel; CompInfo."Phone No.")
            {
            }
            column(CompFax; CompInfo."Fax No.")
            {
            }
            column(CompTRNNo; CompInfo."VAT Registration No.")
            {
            }
            column(BankName; BankAccName)
            {
            }
            column(BankAdd; BankAddress)
            {
            }
            column(BankAcc; BankAccNo)
            {
            }
            column(IBAN; BankIBAN)
            {
            }
            column(Swift; BankSWIFT)
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(CustomerName; CustLegal)
            {
            }
            column(Addresse; CustAddress)
            {
            }
            column(Phone; CustPhone)
            {
            }
            column(InvoiceNo; "No.")
            {
            }
            column(CustomerNo; "Sell-to Customer No.")
            {
            }
            column(Deliveryref; ShipmentNo)
            {
            }
            column(DeliveryDate; ShipmentDate)
            {
            }
            column(ShiptoName; SalesShip."Ship-to Name")
            {
            }
            column(ShiptoAddress; SalesShip."Ship-to Address")
            {
            }
            column(ShiptoCity; SalesShip."Ship-to City")
            {
            }
            column(CustTRNNo; "VAT Registration No.")
            {
            }
            column(Date; "Posting Date")
            {
            }
            column(CustomerPO; "Order No.")
            {
            }
            column(PayDueDate; "Due Date")
            {
            }
            column(PaymentMethod; "Payment Method Code")
            {
            }
            column(TotalINaed; TTAmnt)
            {
            }
            column(AmountInwords; AmountInwords)
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(ExtDocNo; "External Document No.")
            {
            }
            column(ContactPerson; ContactPerson)
            {
            }
            column(RevCh; RevCh)
            {
            }
            column(RemAmt; "Remaining Amount")
            {
            }
            column(Title; Title)
            {
            }
            column(PrepSignature; USF."LIT Signature")
            {
            }
            column(PrepName; USF."User ID")
            {
            }
            column(AppSignature; USL."LIT Signature")
            {
            }
            column(AppName; USL."User ID")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0));
                column(Sno; Slno)
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(ItemDescription; Descr)
                {
                }
                column(Quantity; FORMAT(Quantity) + ' ' + "Unit of Measure Code")
                {
                }
                column(Unit; "Unit of Measure Code")
                {
                }
                column(Total; UnitPrice * Quantity)
                {
                }
                column(UnitPrice; UnitPrice)
                {
                }
                column(Discount; Discount)
                {
                }
                column(DiscAmt; DiscAmt)
                {
                }
                column(AmtInclVAT; AmntInclVAT)
                {
                }
                column(VATRate; "VAT %")
                {
                }
                column(TotalExclVAT; UnitPrice * Quantity - DiscAmt)
                {
                }
                column(VATAmt; AmntInclVAT - (UnitPrice * Quantity - DiscAmt))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Slno := Slno + 1;

                    RecContact.RESET;
                    RecContact.SETRANGE(RecContact."No.", "Sales Invoice Header"."Sell-to Contact No.");
                    IF RecContact.FINDFIRST THEN
                        ContactPerson := RecContact.Name;


                    RecGLSetup.RESET;
                    IF RecGLSetup.GET THEN
                        LocalCurr := RecGLSetup."LCY Code";
                    IF CurrencyFilter <> '' THEN BEGIN
                        RecCurrency.RESET;
                        RecCurrency.SETRANGE(RecCurrency."Currency Code", CurrencyFilter);
                        IF RecCurrency.FIND('+') THEN BEGIN
                            //   Amnt := ("Sales Invoice Line".Amount) * (RecCurrency."Exchange Rate Amount"/RecCurrency."Relational Exch. Rate Amount");
                            Amnt := Amount * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount");
                            AmntInclVAT := "Amount Including VAT" * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount");
                            DiscAmt := ("Line Discount Amount" + "Inv. Discount Amount") * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount");
                            UnitPrice := "Sales Invoice Line"."Unit Price" * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount");
                        END
                    END ELSE BEGIN
                        //  Amnt := "Sales Invoice Line".Amount;
                        Amnt := Amount;
                        AmntInclVAT := "Amount Including VAT";
                        DiscAmt := "Line Discount Amount" + "Inv. Discount Amount";
                        UnitPrice := "Sales Invoice Line"."Unit Price";
                    END;


                    IF "LIT Narration" <> '' THEN
                        Descr := "LIT Narration"
                    else
                        Descr := "Sales Invoice Line".Description;
                end;



                trigger OnPreDataItem()
                begin
                    Amnt := 0;
                    Discount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Title);
                IF Reimb THEN
                    Title := 'Reimbursement Claim'
                ELSE
                    Title := 'Tax Invoice';

                //RecGLSetup.RESET;
                IF RecGLSetup.GET THEN
                    LocalCurr := RecGLSetup."LCY Code";

                IF CurrencyFilter = '' THEN BEGIN
                    CurrCode := LocalCurr
                END ELSE BEGIN
                    CurrCode := CurrencyFilter
                END;


                "Sales Invoice Header".CALCFIELDS("Sales Invoice Header".Amount, "Sales Invoice Header"."Amount Including VAT");
                "Total Amount" := "Sales Invoice Header"."Amount Including VAT"; //GSS changed from amount to amount including vat

                IF CurrencyFilter <> '' THEN BEGIN
                    RecCurrency.RESET;
                    RecCurrency.SETRANGE(RecCurrency."Currency Code", CurrencyFilter);
                    IF RecCurrency.FIND('+') THEN
                        TTAmnt := ROUND(("Total Amount") * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount"), 0.01, '=');
                END ELSE BEGIN
                    TTAmnt := "Total Amount";
                END;
                SalesShip.RESET;
                SalesShip.SETRANGE("Posting Date", "Posting Date");
                SalesShip.SETFILTER("Posting Description", STRSUBSTNO('*%1*', "Pre-Assigned No."));
                IF SalesShip.FINDFIRST THEN BEGIN
                    ShipmentNo := SalesShip."No.";
                    ShipmentDate := SalesShip."Posting Date";
                END;



                //nc-101 begins
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", "Sales Invoice Header"."Sell-to Customer No.");
                IF Cust.FINDFIRST THEN BEGIN
                    CustPhone := Cust."Phone No.";
                    CustAddress := Cust.Address + ', ' + Cust.City + ' ' + Cust."Country/Region Code";
                    //IF Cust."Legal Name" = '' THEN
                    CustLegal := Cust.Name
                    //ELSE
                    //  CustLegal := Cust."Legal Name";
                END;
                //nc-101 ends



                Util.FormatNoText(Amt, TTAmnt, '');
                AmountInwords := CurrCode + ' ' + Amt[1] + ' ' + Amt[2];

                CALCFIELDS("Remaining Amount");

                //TAR30062020.1 -

                //Atos Gj
                CompName := CompInfo.Name;
                IF CompName = 'Mir Hashem Khoory LLC (Branch)' THEN
                    CompName := 'Mir Hashem Khoory (L.L.C)';
                //Atos Gj
                BankAccName := CompInfo."Bank Name";
                BankAccNo := CompInfo."Bank Account No.";
                BankAddress := CompInfo."Bank Branch No.";
                BankIBAN := CompInfo.IBAN;
                BankSWIFT := CompInfo."SWIFT Code";

                IF SelltoCust.GET("Sales Invoice Header"."Sell-to Customer No.") THEN
                    IF SelltoCust."Preferred Bank Account Code" <> '' THEN
                        IF BankAcc.GET(SelltoCust."Preferred Bank Account Code") THEN BEGIN
                            BankAccName := BankAcc.Name;
                            BankAccNo := BankAcc."Bank Account No.";
                            BankAddress := BankAcc."Bank Branch No.";
                            BankIBAN := BankAcc.IBAN;
                            BankSWIFT := BankAcc."SWIFT Code";
                        END;
                //TAR30062020.1 +


                //ITOS-CH Signature Print
                CLEAR(USF);
                CLEAR(USL);
                CLEAR(PAE);
                PAE.RESET;
                PAE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                PAE.SETRANGE(Status, PAE.Status::Approved);
                IF PAE.FINDFIRST THEN BEGIN
                    //SET USER FOR FIRST APPROVER
                    USF.GET(PAE."Sender ID");
                    USF.CALCFIELDS("LIT Signature");
                END;

                IF PAE.FINDLAST THEN BEGIN
                    //SET USER FOR LAST APPROVER
                    USL.GET(PAE."Approver ID");
                    USL.CALCFIELDS("LIT Signature");
                END;
                //ITOS-CH
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Reimbursement; Reimb)
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

    trigger OnInitReport()
    begin
        RevCh := 'No';
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
        Util.InitTextVariable;
    end;

    var
        Cust: Record Customer;
        CustPhone: Code[30];
        Slno: Integer;
        CompInfo: Record "Company Information";
        "Total Amount": Decimal;
        Amt: array[2] of Text;
        AmountInwords: Text;
        Util: Codeunit Utilities;
        RecCurrency: Record "Currency Exchange Rate";
        RecCurr: Record Currency;
        CurrencyFilter: Code[10];
        Amnt: Decimal;
        AmntInclVAT: Decimal;
        DiscAmt: Decimal;
        RecGLSetup: Record "General Ledger Setup";
        LocalCurr: Code[20];
        TTAmnt: Decimal;
        CurrCode: Code[20];
        ItemRec: Record Item;
        Descr: Text;
        ContactPerson: Text[100];
        RecContact: Record Contact;
        SalesShip: Record "Sales Shipment Header";
        ShipmentNo: Code[20];
        CustAddress: Text[100];
        UnitPrice: Decimal;
        RecSalesInv: Record "Sales Invoice Line";
        Discount: Decimal;
        ShipmentDate: Date;
        RevCh: Text;
        CustLegal: Code[250];
        PurchSetup: Record "Purchases & Payables Setup";
        TotNoPages: Integer;
        Reimb: Boolean;
        Title: Text;
        BankAccName: Text[250];
        BankAccNo: Text[250];
        BankAddress: Text[250];
        BankIBAN: Text[250];
        BankSWIFT: Text[250];
        SelltoCust: Record Customer;
        BankAcc: Record 270;
        CompName: Text[250];
        PAE: Record "Posted Approval Entry";
        USF: Record "User Setup";
        USL: Record "User Setup";

}

