report 50027 "JV - GL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layout/JVGL.rdlc';
    Caption = 'JV - GL';

    dataset
    {
        dataitem("G/L Entry1"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Journal Batch Name" = FILTER(<> ''));
            MaxIteration = 1;
            RequestFilterFields = "Entry No.", "Document No.", "Posting Date";
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cash_Payment_Voucher_; 'Journal Voucher')
            {
            }
            column(G_L_Entry1__Document_No__; "Document No.")
            {
            }
            column(FORMAT__Posting_Date__; FORMAT("Posting Date"))
            {
            }
            column(RecVend_Name; RecVend.Name)
            {
            }
            column(RecVend_Address; GLEntry."Document Date")
            {
            }
            column(RecVend_Contact; GLEntry."External Document No.")
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
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
            column(G_L_Entry__Global_Dimension_1_Code_Caption; "G/L Entry".FIELDCAPTION("Global Dimension 1 Code"))
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
            column(G_L_Entry1_Entry_No_; "Entry No.")
            {
            }
            column(BankTotalCurr; BankTotal)
            {
            }
            column(BanktotalCurrLbl; 'Bank Total' + '  ' + '(' + GLSetup."LCY Code" + ')' + ':')
            {
            }
            column(DimLabel1; DimLabel)
            {
            }
            column(DimValue1; DimValue)
            {
            }
            column(EmployeeCode; ShortcutDim8Code)
            {
            }
            column(EmployeeName; ShortcutDim8Desc)
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Journal Batch Name" = FILTER(<> ''));
                column(G_L_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(G_L_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(GLAccName; GLAccName)
                {
                }
                column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                {
                }
                column(G_L_Entry__Global_Dimension_1_Code_; "Global Dimension 1 Code")
                {
                }
                column(G_L_Entry__G_L_Entry___Credit_Amount_; "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry__G_L_Entry___Debit_Amount_; "G/L Entry"."Debit Amount")
                {
                }
                column(Total___________GLSetup__LCY_Code_____; 'Total' + '  ' + '(' + GLSetup."LCY Code" + ')')
                {
                }
                column(GLSetup__LCY_Code_______NumberText_1_______NumberText_2_; GLSetup."LCY Code" + '  ' + NumberText[1] + ' ' + NumberText[2] + ' ' + ' ONLY')
                {
                }
                column(GLEntry_Narration; "G/L Entry"."lit Narration")
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
                column(G_L_Entry_Entry_No_; "Entry No.")
                {
                }
                column(G_L_Entry_Document_No_; "Document No.")
                {
                }
                column(G_L_Entry_Document_Date_; FORMAT("Document Date"))
                {
                }
                column(DimLabel; DimLabel)
                {
                }
                column(DimValue; DimValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GLAccName := FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                    IF Amount < 0 THEN BEGIN
                        CrText := 'To';
                        DrText := '';
                    END ELSE BEGIN
                        CrText := '';
                        DrText := 'Dr';
                    END;

                    SourceDesc := '';
                    IF "Source Code" <> '' THEN BEGIN
                        SourceCode.GET("Source Code");
                        SourceDesc := SourceCode.Description;
                    END;

                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;

                    ChequeNo := '';
                    ChequeDate := 0D;
                    IF ("Source No." <> '') AND ("Source Type" = "Source Type"::"Bank Account") THEN BEGIN
                        IF BankAccLedgEntry.GET("Entry No.") THEN BEGIN
                            // ChequeNo := BankAccLedgEntry."Check No.";
                            //   ChequeDate := BankAccLedgEntry."Check Date";
                        END;
                    END;

                    //decDebitTotal += ABS("Debit Amount");

                    decDebitTotal := 0;
                    GLentry1.RESET;
                    GLentry1.SETRANGE("Document No.", "Document No.");
                    IF GLentry1.FINDSET THEN
                        REPEAT
                            decDebitTotal += ABS(GLentry1."Debit Amount");
                        UNTIL GLentry1.NEXT = 0;

                    CLEAR(BankTotal);
                    GLentry1.RESET;
                    GLentry1.SETRANGE("Document No.", "Document No.");
                    GLentry1.SETRANGE("Source Type", GLentry1."Source Type"::"Bank Account");
                    IF GLentry1.FINDSET THEN
                        REPEAT
                            BankTotal += ABS(GLentry1.Amount);
                        UNTIL GLentry1.NEXT = 0;

                    InitTextVariable;
                    FormatNoText(NumberText, decDebitTotal, '');
                    //ASH
                    CLEAR(DimMgt);
                    CLEAR(TempDimSetEntry);
                    CLEAR(DimLabel);
                    CLEAR(DimValue);
                    DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
                    IF TempDimSetEntry.FINDFIRST THEN BEGIN
                        TempDimSetEntry.CALCFIELDS("Dimension Name", "Dimension Value Name");
                        DimLabel := TempDimSetEntry."Dimension Name";
                        DimValue := TempDimSetEntry."Dimension Value Name";
                    END;
                    //ASH

                    //ATOS//Gj
                    CLEAR(ShortcutDim8Code);
                    CLEAR(ShortcutDim8Desc);
                    //DimMgt.ValidateShortcutDimValues(6,ShortcutDim6Code,"Dimension Set ID");
                    DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
                    ShortcutDim8Code := ShortcutDimCode[8];
                    IF DimVal.GET('EMPLOYEE', ShortcutDim8Code) THEN
                        ShortcutDim8Desc := DimVal.Name;
                    //ATOS//Gj
                    //FormatNoText(NumberText,BankTotal,'');
                end;

                trigger OnPreDataItem()
                begin
                    NUMLines := 13;
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RecVLE.RESET;
                RecVLE.SETRANGE("Document No.", "Document No.");
                IF RecVLE.FINDFIRST THEN
                    IF RecVend.GET(RecVLE."Vendor No.") THEN;

                BankAccLedgEntry.RESET;
                BankAccLedgEntry.SETRANGE("Document No.", "Document No.");
                IF BankAccLedgEntry.FINDFIRST THEN;

                //ASH
                CLEAR(DimMgt);
                CLEAR(TempDimSetEntry);
                CLEAR(DimLabel);
                CLEAR(DimValue);
                DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
                IF TempDimSetEntry.FINDFIRST THEN BEGIN
                    TempDimSetEntry.CALCFIELDS("Dimension Name", "Dimension Value Name");
                    DimLabel := TempDimSetEntry."Dimension Name";
                    DimValue := TempDimSetEntry."Dimension Value Name";
                END;
                //ASH
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Document No.",GL."Document No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
        GLSetup.GET;
    end;

    var
        CompanyInformation: Record 79;
        SourceCode: Record 230;
        GLEntry: Record 17;
        BankAccLedgEntry: Record 271;
        GLAccName: Text[50];
        SourceDesc: Text[50];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[80];
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[20];
        ChequeDate: Date;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        PrintLineNarration: Boolean;
        GLSetup: Record 98;
        BankName: Code[10];
        RecVLE: Record 25;
        RecVend: Record 23;
        RecVLE1: Record 25;
        Voucher_No_____CaptionLbl: Label 'Voucher No.   :';
        Voucher_Date__CaptionLbl: Label 'Posting Date :';
        Paid_to_M_S_Mr__Mrs_CaptionLbl: Label 'Paid to M/S/Mr./Mrs.';
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
        GL: Record 17;
        UserSetupArray: array[8] of Record 91;
        AppDateTimeArray: array[8] of DateTime;
        Util: Codeunit 50001;
        i: Integer;
        DimMgt: Codeunit 408;
        TempDimSetEntry: Record 480 temporary;
        DimLabel: Text;
        DimValue: Text;
        ShortcutDimCode: array[8] of Code[20];
        ShortcutDim8Code: Code[20];
        ShortcutDim8Desc: Text[50];
        DimVal: Record 349;


    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]
    var
        AccName: Text[50];
        VendLedgerEntry: Record 25;
        Vend: Record 23;
        CustLedgerEntry: Record 21;
        Cust: Record 18;
        BankLedgerEntry: Record 271;
        Bank: Record 270;
        FALedgerEntry: Record 5601;
        FA: Record 5600;
        GLAccount: Record 15;
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
                Vend.GET("Source No.");
                AccName := Vend.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF "Source Type" = "Source Type"::Customer THEN
            IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                Cust.GET("Source No.");
                AccName := Cust.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF "Source Type" = "Source Type"::"Bank Account" THEN
            IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                Bank.GET("Source No.");
                AccName := Bank.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
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


    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
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


        /*
        //O2Gen-Sushil Start
        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        
        IF CurrencyCode = '' THEN BEGIN
          IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText,NoTextIndex,PrintExponent,TensText[TensDec]);
            IF OnesDec > 0 THEN
              AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[OnesDec]);
          END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
              AddToNoText(NoText,NoTextIndex,PrintExponent,OnesText[TensDec * 10 + OnesDec])
            ELSE
              AddToNoText(NoText,NoTextIndex,PrintExponent,Text16526);
        
        END ELSE BEGIN
          GLSetup.GET;
          IF GLSetup."Amount Rounding Precision" <> 0 THEN
            DecimalPosition := 1 / GLSetup."Amount Rounding Precision"
          ELSE
            DecimalPosition := 1;
          AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));
        END;
        //O2Gen-Sushil Stop
         */

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
}

