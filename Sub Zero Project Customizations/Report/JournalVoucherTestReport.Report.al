report 50017 "Journal Voucher - Test Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/JournalVoucherTestReport.rdlc';
    Caption = 'Journal Voucher - Test Report';

    dataset
    {
        dataitem(DataItem1000000011; 81)
        {
            DataItemTableView = SORTING("No. of Depreciation Days")
                                ORDER(Ascending);
            RequestFilterFields = "No. of Depreciation Days";
            column(ShowComments; ShowComments)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Addr2; 'Phone No.: ' + CompanyInformation."Phone No." + '; ' + 'Fax No.: ' + CompanyInformation."Fax No.")
            {
            }
            column(LineNo; "Line No.")
            {
            }
            column(Cash_Payment_Voucher_; Title)
            {
            }
            column(G_L_Entry1__Document_No__; "Document No.")
            {
            }
            column(TotalVAMT; TotalVAMT)
            {
            }
            column(FORMAT__Posting_Date__; FORMAT("Posting Date", 0, '<Day>-<Month text,3>-<Year4>'))
            {
            }
            column(RecVend_Name; RecVend.Name)
            {
            }
            column(BankName; Bank.Name)
            {
            }
            column(RecVend_Address; GLEntry."Document Date")
            {
            }
            column(RecVend_Contact; GLEntry."External Document No.")
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address + '  ' + CompanyInformation."Address 2")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_City______CompanyInformation__Country_Region_Code_; CompanyInformation.City + '  ' + CompanyInformation."Country/Region Code")
            {
            }
            column(PO_Box_________CompanyInformation__Post_Code_; 'PO Box :' + '  ' + CompanyInformation."Post Code")
            {
            }
            column(Phone_________CompanyInformation__Phone_No__; 'Phone :' + '  ' + CompanyInformation."Phone No.")
            {
            }
            column(Fax_________CompanyInformation__Fax_No__; 'Fax :' + '  ' + CompanyInformation."Fax No.")
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(Voucher_No_____Caption; Voucher_No_____CaptionLbl)
            {
            }
            column(Voucher_Date__Caption; Voucher_Date__CaptionLbl)
            {
            }
            column(Paid_to_M_S_Mr__Mrs_Caption; Paid_to_M_S_Mr__Mrs_CaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(Contact_DetailsCaption; Contact_DetailsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000072; EmptyStringCaption_Control1000000072Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000073; EmptyStringCaption_Control1000000073Lbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Account_NameCaption; Account_NameCaptionLbl)
            {
            }
            column(G_L_Entry__Global_Dimension_1_Code_Caption; FIELDCAPTION("Shortcut Dimension 1 Code"))
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(Checked_by_Caption; Checked_by_CaptionLbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(Received_by__Caption; Received_by__CaptionLbl)
            {
            }
            column(BankTotalCurr; BankTotal)
            {
            }
            column(BanktotalCurrLbl; 'Amount' + '  ' + '(' + GLSetup."LCY Code" + ')' + ':')
            {
            }
            column(G_L_Entry__Credit_Amount_; "Credit Amount")
            {
            }
            column(G_L_Entry__Debit_Amount_; "Debit Amount")
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(G_L_Entry__G_L_Account_No__; "Account No.")
            {
            }
            column(Type; "Account Type")
            {
            }
            column(G_L_Entry__Global_Dimension_1_Code_; "Shortcut Dimension 1 Code")
            {
            }
            column(G_L_Entry__G_L_Entry___Credit_Amount_; "Credit Amount")
            {
            }
            column(G_L_Entry__G_L_Entry___Debit_Amount_; "Debit Amount")
            {
            }
            column(TotalCredit; TotalCredit)
            {
            }
            column(TotalDebit; TotalDebit)
            {
            }
            column(Total___________GLSetup__LCY_Code_____; 'Total' + '  ' + '(' + GLSetup."LCY Code" + ')')
            {
            }
            column(GLSetup__LCY_Code_______NumberText_1_______NumberText_2_; GLSetup."LCY Code" + '  ' + NumberText[1] + ' ' + NumberText[2] + ' ' + ' ONLY')
            {
            }
            column(GLEntry_Narration; "LIT Narration")
            {
            }
            column(ChequeNo; "LIT Cheque No.")
            {
            }
            column(ChequeDate; "LIT Cheque Date")
            {
            }
            column(Sum_of__Caption; Sum_of__CaptionLbl)
            {
            }
            column(Narration__Caption; Narration__CaptionLbl)
            {
            }
            column(Continued______Caption; Continued______CaptionLbl)
            {
            }
            column(G_L_Entry_Document_No_; "Document No.")
            {
            }
            column(G_L_Entry_Document_Date_; FORMAT("Document Date"))
            {
            }
            column(BalText; BalText)
            {
            }
            column(UserSign1; UserSetupArray[1]."LIT Signature")
            {
            }
            column(UserSign2; UserSetupArray[2]."LIT Signature")
            {
            }
            column(UserSign3; UserSetupArray[3]."LIT Signature")
            {
            }
            column(UserSign4; UserSetupArray[4]."LIT Signature")
            {
            }
            column(UserSign5; UserSetupArray[5]."LIT Signature")
            {
            }
            column(UserSign6; UserSetupArray[6]."LIT Signature")
            {
            }
            column(UserSign7; UserSetupArray[7]."LIT Signature")
            {
            }
            column(UserSign8; UserSetupArray[8]."LIT Signature")
            {
            }
            column(UserDesignation1; UserSetupArray[1]."LIT Designation")
            {
            }
            column(UserDesignation2; UserSetupArray[2]."LIT Designation")
            {
            }
            column(UserDesignation3; UserSetupArray[3]."LIT Designation")
            {
            }
            column(UserDesignation4; UserSetupArray[4]."LIT Designation")
            {
            }
            column(UserDesignation5; UserSetupArray[5]."LIT Designation")
            {
            }
            column(UserDesignation6; UserSetupArray[6]."LIT Designation")
            {
            }
            column(UserDesignation7; UserSetupArray[7]."LIT Designation")
            {
            }
            column(UserDesignation8; UserSetupArray[8]."LIT Designation")
            {
            }
            column(User1; UserSetupArray[1]."User ID")
            {
            }
            column(User2; UserSetupArray[2]."User ID")
            {
            }
            column(User3; UserSetupArray[3]."User ID")
            {
            }
            column(User4; UserSetupArray[4]."User ID")
            {
            }
            column(User5; UserSetupArray[5]."User ID")
            {
            }
            column(User6; UserSetupArray[6]."User ID")
            {
            }
            column(User7; UserSetupArray[7]."User ID")
            {
            }
            column(User8; UserSetupArray[8]."User ID")
            {
            }
            column(UserDateTime1; FORMAT(AppDateTimeArray[1], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime2; FORMAT(AppDateTimeArray[2], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime3; FORMAT(AppDateTimeArray[3], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime4; FORMAT(AppDateTimeArray[4], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime5; FORMAT(AppDateTimeArray[5], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime6; FORMAT(AppDateTimeArray[6], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime7; FORMAT(AppDateTimeArray[7], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(UserDateTime8; FORMAT(AppDateTimeArray[8], 0, '<Day>-<Month text,3>-<Year4> <Hours12>:<Minutes>:<Seconds> <AM/PM>'))
            {
            }
            column(DimLabel; DimLabel)
            {
            }
            column(DimValue; DimValue)
            {
            }
            dataitem(DataItem10; 455)
            {
                column(UserId; "User ID")
                {
                }
                column(DateTime; "Date and Time")
                {
                }
                column(Comment; Comment)
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Record ID to Approve", RecRef.RECORDID);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(RecRef);
                RecRef.GETTABLE("DataItem1000000011");
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    RecVend.GET("Account No.");
                    RecVend.CALCFIELDS("Balance (LCY)");
                    BalText := STRSUBSTNO('Vendor Name : %1 with Outstanding Balance: %2', RecVend.Name, -RecVend."Balance (LCY)");
                    GLAccName := RecVend.Name;
                    TotalVAMT += Amount;
                END;
                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    Bank.GET("Account No.");
                    GLAccName := Bank.Name;
                    BankTotal += ("Credit Amount");
                    // CLEAR(CheckReport);
                    CLEAR(NumberText);
                    FormatNoText(NumberText, BankTotal, '');
                    //MESSAGE(NumberText[1]+''+NumberText[2]);
                END;
                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    GLAccount.GET("Account No.");
                    GLAccName := GLAccount.Name;
                END;
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    RecCust.GET("Account No.");
                    GLAccName := RecCust.Name;
                    //RecCust.CALCFIELDS("Balance (LCY)");
                END;
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    RecVend2.GET("Account No.");
                    GLAccName := RecVend2.Name;
                    //RecCust.CALCFIELDS("Balance (LCY)");
                END;

                //FormatNoText(NumberText,BankTotal,'');
                TotalDebit += "Debit Amount";
                TotalCredit += "Credit Amount";
                IF "LIT Cheque Date" = 0D THEN
                    "LIT Cheque Date" := "Posting Date";
                //ASH

                //MESSAGE(GLAccName);
                CLEAR(EmployeeName);
                CLEAR(DimMgt);
                CLEAR(TempDimSetEntry);
                CLEAR(DimLabel);
                CLEAR(DimValue);
                DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
                IF TempDimSetEntry.FINDFIRST THEN BEGIN
                    TempDimSetEntry.CALCFIELDS("Dimension Name", "Dimension Value Name");
                    IF DimLabel = '' THEN;
                    DimLabel := TempDimSetEntry."Dimension Name";
                    DimValue := TempDimSetEntry."Dimension Value Name";
                    //EmpLabel := 'Employee Name';
                END;
                //ASH

                GetApprovers;
                CLEAR(Util);
                Util.GetApprovers(UserSetupArray, AppDateTimeArray, RecRef);
                i := 0;
                FOR i := 1 TO 8 DO BEGIN
                    IF FORMAT(AppDateTimeArray[i]) <> '' THEN
                        UserSetupArray[i].CALCFIELDS("LIT Designation");
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show Comments"; ShowComments)
                {
                    ApplicationArea = all;
                }
                field("Reimbursement Claim"; Reimb)
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
        ShowComments := TRUE;
        Title := 'Journal Voucher';
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
        GLSetup.GET;
        InitTextVariable;
        IF Reimb THEN
            Title := 'Reimbursement Claim';
    end;

    var
        CompanyInformation: Record "Company Information";
        SourceCode: Record "Source Code";
        GLEntry: Record "G/L Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        GLAccName: Text[50];
        SourceDesc: Text[50];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[120];
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[20];
        ChequeDate: Date;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        PrintLineNarration: Boolean;
        GLSetup: Record "General Ledger Setup";
        BankName: Code[10];
        RecVLE: Record "Vendor Ledger Entry";
        RecVend: Record Vendor;
        RecVLE1: Record "Vendor Ledger Entry";
        Voucher_No_____CaptionLbl: Label 'Voucher No.   :';
        Voucher_Date__CaptionLbl: Label 'Posting Date :';
        Paid_to_M_S_Mr__Mrs_CaptionLbl: Label 'Paid to';
        AddressCaptionLbl: Label 'Document Date :';
        Contact_DetailsCaptionLbl: Label 'Transfer / Cheque No. :';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1000000072Lbl: Label ':';
        EmptyStringCaption_Control1000000073Lbl: Label ':';
        Credit_AmountCaptionLbl: Label 'Credit Amount';
        Debit_AmountCaptionLbl: Label 'Debit Amount';
        Account_No_CaptionLbl: Label 'Account No.';
        Account_NameCaptionLbl: Label 'Account Name';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        Checked_by_CaptionLbl: Label 'Checked by:';
        Approved_by_CaptionLbl: Label 'Approved by:';
        Received_by__CaptionLbl: Label 'Received by :';
        Sum_of__CaptionLbl: Label 'Sum of :';
        Narration__CaptionLbl: Label 'Narration :';
        Continued______CaptionLbl: Label 'Continued......';
        Applied_EntriesCaptionLbl: Label 'Applied Entries';
        Invoice_DateCaptionLbl: Label 'Invoice Date';
        Invoice_No_CaptionLbl: Label 'Invoice No.';
        Applied_AmountCaptionLbl: Label 'Applied Amount';
        Remaining_AmountCaptionLbl: Label 'Remaining Amount';
        Original_AmountCaptionLbl: Label 'Original Amount';
        decDebitTotal: Decimal;
        decAmtTotal: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text16526: Label 'ZERO';
        GLentry1: Record 17;
        BankTotal: Decimal;
        GL: Record "G/L Entry";
        Bank: Record "Bank Account";
        GLAccount: Record "G/L Account";
        EmployeeName: Text;
        DimMgt: Codeunit DimensionManagement;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        UserSetup: Record "User Setup";
        ApprovalEntry: Record "Approval Entry";
        BalText: Text;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        //CheckReport: Report "Union National Bank";
        RecRef: RecordRef;
        TotalVAMT: Decimal;
        ShowComments: Boolean;
        Preparedby: Text;
        FinCon: Text;
        CFO: Text;
        COO: Text;
        Dir1: Text;
        Dir2: Text;
        Dir3: Text;
        FinConUser: Record "User Setup";
        CFOUser: Record "User Setup";
        COOUser: Record "User Setup";
        DirDesignation: Text;
        Dir1User: Record "User Setup";
        Dir2User: Record "User Setup";
        Dir3User: Record "User Setup";
        FinConUserDateTime: DateTime;
        CFOUserDateTime: DateTime;
        COOUserDateTime: DateTime;
        Dir1UserDateTime: DateTime;
        Dir2UserDateTime: DateTime;
        Dir3UserDateTime: DateTime;
        DimLabel: Text;
        DimValue: Text;
        Reimb: Boolean;
        Title: Text;
        UserSetupArray: array[8] of Record "User Setup";
        AppDateTimeArray: array[8] of DateTime;
        Util: Codeunit Utilities;
        i: Integer;
        RecCust: Record Customer;
        RecVend2: Record Vendor;
        EmpLabel: Text;


    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]
    var
        AccName: Text[50];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
                Vend.GET("Source No.");
                AccName := Vend.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE
            IF "Source Type" = "Source Type"::Customer THEN
                IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                    Cust.GET("Source No.");
                    AccName := Cust.Name;
                END ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                END
            ELSE
                IF "Source Type" = "Source Type"::"Bank Account" THEN
                    IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                        Bank.GET("Source No.");
                        AccName := Bank.Name;
                    END ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END
                ELSE
                    IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
                        FALedgerEntry.RESET;
                        FALedgerEntry.SETCURRENTKEY("G/L Entry No.");
                        FALedgerEntry.SETRANGE("G/L Entry No.", "Entry No.");
                        IF FALedgerEntry.FINDFIRST THEN BEGIN
                            FA.GET("Source No.");
                            AccName := FA.Description;
                        END ELSE BEGIN
                            GLAccount.GET("G/L Account No.");
                            AccName := GLAccount.Name;
                        END;
                    END ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        EXIT(AccName);
    end;

    procedure FormatNoText(var NoText: array[2] of Text[120]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        OnesDec: Integer;
        TensDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';
        GLSetup.GET;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);


        IF GLSetup."Amount Rounding Precision" <> 0 THEN
            DecimalPosition := 1 / GLSetup."Amount Rounding Precision"
        ELSE
            DecimalPosition := 1;
        AddToNoText(NoText, NoTextIndex, PrintExponent, (FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);



        //O2Gen-Sushil Start
        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;

        IF CurrencyCode = '' THEN BEGIN
            IF TensDec >= 2 THEN BEGIN
                AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
                IF OnesDec > 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
            END ELSE
                IF (TensDec * 10 + OnesDec) > 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
                ELSE
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);

        END ELSE BEGIN
            GLSetup.GET;
            IF GLSetup."Amount Rounding Precision" <> 0 THEN
                DecimalPosition := 1 / GLSetup."Amount Rounding Precision"
            ELSE
                DecimalPosition := 1;
            AddToNoText(NoText, NoTextIndex, PrintExponent, (FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));
        END;
        //O2Gen-Sushil Stop
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;


    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    local procedure GetApprovers()
    begin
        //Approvers
        CLEAR(ApprovalEntry);
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Record ID to Approve", RecRef.RECORDID);
        ApprovalEntry.SETFILTER(Status, '<>%1', ApprovalEntry.Status::Canceled);
        IF ApprovalEntry.FINDFIRST THEN
            Preparedby := ApprovalEntry."Sender ID";

        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
        CLEAR(FinConUser);
        FinConUser.RESET;
        //FinConUser.SETRANGE(Designation, 'Financial Controller');
        FinConUser.SETRANGE("LIT Designation", 'Financial Controller');
        IF FinConUser.FINDFIRST THEN BEGIN
            FinCon := FinConUser."User ID";
            ApprovalEntry.SETRANGE("Approver ID", FinConUser."User ID");
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                FinConUser.CALCFIELDS("LIT Signature");
                FinConUserDateTime := ApprovalEntry."Last Date-Time Modified";
            END;
        END;
        CFOUser.SETRANGE("LIT Designation", 'Chief Financial Officer');
        IF CFOUser.FINDFIRST THEN BEGIN
            CFO := CFOUser."User ID";
            ApprovalEntry.SETRANGE("Approver ID", CFOUser."User ID");
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                CFOUser.CALCFIELDS("LIT Signature");
                CFOUserDateTime := ApprovalEntry."Last Date-Time Modified";
            END;
        END;
        COOUser.SETRANGE("LIT Designation", 'Chief Operating Officer');
        IF COOUser.FINDFIRST THEN BEGIN
            COO := COOUser."User ID";
            ApprovalEntry.SETRANGE("Approver ID", COOUser."User ID");
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                COOUser.CALCFIELDS("LIT Signature");
                COOUserDateTime := ApprovalEntry."Last Date-Time Modified";
            END;
        END;
        Dir1User.SETRANGE("LIT Designation", 'Executive Director');
        IF Dir1User.FINDFIRST THEN BEGIN
            Dir1 := Dir1User."User ID";
            ApprovalEntry.SETRANGE("Approver ID", Dir1User."User ID");
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                DirDesignation := Dir1User."LIT Designation";
                Dir1User.CALCFIELDS("LIT Signature");
                Dir1UserDateTime := ApprovalEntry."Last Date-Time Modified";
            END;
        END;
        Dir2User.SETRANGE("LIT Designation", 'Managing Director');
        IF Dir2User.FINDFIRST THEN BEGIN
            Dir2 := Dir1User."User ID";
            ApprovalEntry.SETRANGE("Approver ID", Dir2User."User ID");
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                DirDesignation := Dir1User."LIT Designation";
                Dir2User.CALCFIELDS("LIT Signature");
                Dir2UserDateTime := ApprovalEntry."Last Date-Time Modified";
            END;
        END;
        Dir3User.SETRANGE("LIT Designation", 'Director');
        IF Dir3User.FINDFIRST THEN BEGIN
            Dir3 := Dir1User."User ID";
            ApprovalEntry.SETRANGE("Approver ID", Dir3User."User ID");
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                DirDesignation := Dir3User."LIT Designation";
                Dir3User.CALCFIELDS("LIT Signature");
                Dir3UserDateTime := ApprovalEntry."Last Date-Time Modified";
            END;
        END;
    end;
}

