report 50002 "Tax Credit Note"
{
    // //nc-101 :: code added for customer phone and city
    // GSS-NAW      27/11/2018   Increased Field size in layout External Doc No.
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/TaxCreditNote.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1000000000; 114)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.", "Posting Date";
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddre; CompInfo.Address + ' Phone No. : ' + CompInfo."Phone No." + ' Fax No. : ' + CompInfo."Fax No.")
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
            column(CustomerPO; "Return Order No.")
            {
            }
            column(PaymentTerms; "Payment Terms Code")
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
            dataitem(DataItem1000000010; 115)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Sno; Slno)
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(ItemDescription; Descr)
                {
                }
                column(Quantity; Quantity)
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
                column(Narration; "LIT Narration")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Slno := Slno + 1;
                    RecContact.RESET;
                    RecContact.SETRANGE(RecContact."No.", "DataItem1000000000"."Sell-to Contact No.");
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
                            UnitPrice := "Unit Price" * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount");
                        END
                    END ELSE BEGIN
                        //  Amnt := "Sales Invoice Line".Amount;
                        Amnt := Amount;
                        AmntInclVAT := "Amount Including VAT";
                        DiscAmt := "Line Discount Amount" + "Inv. Discount Amount";
                        UnitPrice := "Unit Price";
                    END;

                    Descr := Description;

                    //GJ ATOS
                    IF PrintNarration THEN BEGIN
                        Descr := "LIT Narration";
                    END;
                    //GJ ATOS

                    IF HideDiscount = TRUE THEN BEGIN
                        AmntInclVAT := AmntInclVAT + DiscAmt;
                        DiscAmt := 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    Amnt := 0;
                    Discount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CALCFIELDS(Amount, "Amount Including VAT");
                "Total Amount" := "Amount Including VAT"; //GSS changed from amount to amount including vat

                IF CurrencyFilter <> '' THEN BEGIN
                    RecCurrency.RESET;
                    RecCurrency.SETRANGE(RecCurrency."Currency Code", CurrencyFilter);
                    IF RecCurrency.FIND('+') THEN
                        TTAmnt := ROUND(("Total Amount") * (RecCurrency."Exchange Rate Amount" / RecCurrency."Relational Exch. Rate Amount"), 0.01, '=');
                END ELSE BEGIN
                    TTAmnt := "Total Amount";
                END;
                /*
                SalesShip.RESET;
                SalesShip.SETRANGE(SalesShip."Order No.","Return Order No.");
                IF SalesShip.FINDFIRST THEN BEGIN
                  ShipmentNo:=SalesShip."No.";
                  ShipmentDate := SalesShip."Posting Date";
                END;
                */
                RecGLSetup.RESET;
                IF RecGLSetup.GET THEN
                    LocalCurr := RecGLSetup."LCY Code";

                //nc-101 begins
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", "Sell-to Customer No.");
                IF Cust.FINDFIRST THEN BEGIN
                    CustPhone := Cust."Phone No.";
                    CustAddress := Cust.City + ' ' + Cust."Country/Region Code";
                    //IF Cust."Legal Name" = '' THEN
                    CustLegal := Cust.Name
                    //ELSE
                    //  CustLegal := Cust."Legal Name";
                END;
                //nc-101 ends


                IF CurrencyFilter = '' THEN BEGIN
                    CurrCode := LocalCurr
                END ELSE BEGIN
                    CurrCode := CurrencyFilter
                END;


                Check.FormatNoText(Amt, TTAmnt, '');
                AmountInwords := Amt[2] + Amt[1];

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Hide Discount"; HideDiscount)
                {
                    ApplicationArea = all;
                }
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

    trigger OnInitReport()
    begin
        RevCh := 'No';
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
        Check.InitTextVariable;
    end;

    var
        Cust: Record Customer;
        CustPhone: Code[30];
        Slno: Integer;
        CompInfo: Record "Company Information";
        "Total Amount": Decimal;
        Amt: array[2] of Text;
        AmountInwords: Text;
        Check: Report Check;
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
        HideDiscount: Boolean;
        PrintNarration: Boolean;
}

