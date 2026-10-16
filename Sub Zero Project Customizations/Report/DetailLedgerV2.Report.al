report 50072 "Detail Ledger V2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout//DetailLedgerV2.rdlc';
    Caption = 'Detail Ledger';
    ApplicationArea = all;
    UsageCategory = Administration;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(PeriodGLDtFilter; STRSUBSTNO(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            dataitem(PageCounter; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = FIELD("No."),
                                   "Posting Date" = FIELD("Date Filter"),
                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                   "Business Unit Code" = FIELD("Business Unit Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING("G/L Account No.", "Posting Date");
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    column(GLBalance; GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "Entry No.")
                    {
                    }
                    column(ExternalDocNo; "External Document No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    column(Cheq; "LIT Cheque No.")
                    {
                    }
                    dataitem(GLEntry2; "G/L Entry")
                    {
                        DataItemLink = "Document No." = FIELD("Document No."),
                                       "Posting Date" = FIELD("Posting Date");
                        column(BalAccName; Desc)
                        {
                        }
                        column(DrAmt; DrAmt)
                        {
                        }
                        column(CrAmt; CrAmt)
                        {
                        }
                        column(Narration; "LIT Narration")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //GSS
                            IF Desc = '' THEN BEGIN
                                GetSourceAccName(GLEntry2, Desc);
                            END;

                            IF NOT NoDetails THEN BEGIN
                                CrAmt := "Debit Amount";
                                DrAmt := "Credit Amount";
                            END ELSE BEGIN
                                DrAmt := "Debit Amount";
                                CrAmt := "Credit Amount";
                            END;
                            IF "LIT Narration" = '' THEN
                                "LIT Narration" := Description;
                            //GSS
                        end;

                        trigger OnPreDataItem()
                        begin
                            //GSS
                            IF NOT NoDetails THEN
                                SETFILTER("G/L Account No.", '<>%1', "G/L Entry"."G/L Account No.")
                            ELSE
                                SETRANGE("G/L Account No.");

                            IF NoDetails THEN
                                SETRANGE("Entry No.", "G/L Entry"."Entry No.")
                            ELSE
                                SETRANGE("Entry No.");
                            //GSS
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        GLEntryCheck: Record 17;
                        Dr: Integer;
                        Cr: Integer;
                    begin
                        DrAmt := 0;
                        CrAmt := 0;
                        Desc := '';
                        NoDetails := FALSE;
                        IF PrintOnlyCorrections THEN
                            IF NOT (("Debit Amount" < 0) OR ("Credit Amount" < 0)) THEN
                                CurrReport.SKIP;
                        IF NOT PrintReversedEntries AND Reversed THEN
                            CurrReport.SKIP;

                        GLBalance := GLBalance + Amount;
                        IF ("Posting Date" = CLOSINGDATE("Posting Date")) AND
                           NOT PrintClosingEntries
                        THEN BEGIN
                            "Debit Amount" := 0;
                            "Credit Amount" := 0;
                        END;

                        IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                            ClosingEntry := TRUE
                        ELSE
                            ClosingEntry := FALSE;

                        //GSS
                        CLEAR(GLEntryCheck);
                        GLEntryCheck.RESET;
                        GLEntryCheck.SETCURRENTKEY("Document No.");
                        GLEntryCheck.SETRANGE("Document No.", "Document No.");
                        GLEntryCheck.SETFILTER("Debit Amount", '<>%1', 0);
                        Dr := GLEntryCheck.COUNT;
                        GLEntryCheck.SETRANGE("Debit Amount");
                        GLEntryCheck.SETFILTER("Credit Amount", '<>%1', 0);
                        Cr := GLEntryCheck.COUNT;
                        GLEntryCheck.SETRANGE("Credit Amount");
                        IF "Debit Amount" <> 0 THEN BEGIN
                            IF Dr > 1 THEN BEGIN
                                NoDetails := TRUE;
                                GLEntryCheck.SETFILTER("Credit Amount", '<>%1', 0);
                                IF GLEntryCheck.FINDFIRST THEN BEGIN
                                    GetSourceAccName(GLEntryCheck, Desc);
                                END;
                            END;
                        END;
                        IF "Credit Amount" <> 0 THEN BEGIN
                            IF Cr > 1 THEN BEGIN
                                NoDetails := TRUE;
                                GLEntryCheck.SETFILTER("Debit Amount", '<>%1', 0);
                                IF GLEntryCheck.FINDFIRST THEN BEGIN
                                    GetSourceAccName(GLEntryCheck, Desc);
                                END;
                            END;
                        END;
                        //GSS
                    end;

                    trigger OnPreDataItem()
                    begin
                        GLBalance := StartBalance;
                        CurrReport.CREATETOTALS(Amount, "Debit Amount", "Credit Amount", "VAT Amount");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record 17;
                Date: Record 2000000007;
            begin
                StartBalance := 0;
                IF GLDateFilter <> '' THEN BEGIN
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    IF Date.FINDFIRST THEN BEGIN
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS("Net Change");
                        StartBalance := "Net Change";
                        SETFILTER("Date Filter", GLDateFilter);
                    END;
                END;

                IF PrintOnlyOnePerPage THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETRANGE("G/L Account No.", "No.");
                    IF CurrReport.PRINTONLYIFDETAIL AND GLEntry.FINDFIRST THEN
                        PageGroupNo := PageGroupNo + 1;
                END;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;

                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per G/L Acc.';
                        ToolTip = 'Specifies if each G/L account information is printed on a new page if you have chosen two or more G/L accounts to be included in the report.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for G/L accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the report to include closing entries. This is useful if the report covers an entire fiscal year. Closing entries are listed on a fictitious date between the last day of one fiscal year and the first day of the next one. They have a C before the date, such as C123194. If you do not select this field, no closing entries are shown.';
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Corrections Only';
                        ToolTip = 'Specifies if you want the report to show only the entries that have been reversed and their matching correcting entries.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GETFILTERS;
        GLDateFilter := "G/L Account".GETFILTER("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        GLDateFilter: Text;
        GLFilter: Text;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        DrAmt: Decimal;
        CrAmt: Decimal;
        Desc: Text;
        NoDetails: Boolean;

    [Scope('Internal')]
    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;

    local procedure GetSourceAccName(GLE: Record 17; var BalAccountName: Text)
    var
        Cust: Record 18;
        Vend: Record 23;
    begin
        //GSS
        GLE.CALCFIELDS("G/L Account Name");
        IF STRPOS(UPPERCASE(GLE."G/L Account Name"), 'RECEIVABLE') <> 0 THEN BEGIN
            IF GLE."Source Type" = GLE."Source Type"::Customer THEN BEGIN
                CLEAR(Cust);
                IF Cust.GET(GLE."Source No.") THEN BEGIN
                    BalAccountName := 'Customer: ' + Cust.Name;
                END;
            END;
        END;
        IF STRPOS(UPPERCASE(GLE."G/L Account Name"), 'PAYABLE') <> 0 THEN BEGIN
            IF GLE."Source Type" = GLE."Source Type"::Vendor THEN BEGIN
                CLEAR(Vend);
                IF Vend.GET(GLE."Source No.") THEN BEGIN
                    BalAccountName := 'Vendor: ' + Vend.Name;
                END;
            END;
        END;

        IF BalAccountName = '' THEN
            BalAccountName := 'Account: ' + GLE."G/L Account Name";
        IF STRPOS(GLE."G/L Account Name", 'VAT') <> 0 THEN
            BalAccountName := 'Account: ' + GLE."G/L Account Name";
    end;
}

