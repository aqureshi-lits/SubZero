codeunit 50001 Utilities
{
    Permissions = TableData 112 = rimd;

    trigger OnRun()
    var
        MiscArt: Record 5213;
        MiscArtInfo: Record 5214;
        MiscArtInfo2: Record 5214;
        Emp: Record 5200;
        SubTxt: Text;
        BodyTxt: Text;
        EmailTxt: Text;
    begin
        //ATOS
        //MESSAGE(STRSUBSTNO('%1..%2',0D,CALCDATE('-30D',WORKDATE)));
        CLEAR(MiscArtInfo);
        MiscArtInfo.SETFILTER("To Date", '%1..%2', 20010101D, CALCDATE('30D', WORKDATE));
        MiscArtInfo.SETRANGE("Expiry Warning Sent", FALSE);
        IF MiscArtInfo.FINDFIRST THEN
            REPEAT
                Emp.GET(MiscArtInfo."Employee No.");
                MiscArt.GET(MiscArtInfo."Misc. Article Code");
                CLEAR(SubTxt);
                SubTxt := MiscArtInfo.Description + ' expiry warning.' + ' Company: ' + Emp.Company;
                /*
                BodyTxt := 'Sharif Bedrampalla  working for Company/ person MIR HASHEM KHOORY LLC is expiring on 07/11/20.'
                BodyTxt := STRSUBSTNO('%1 working for Company/Person %2 is expiring on %3.'
                        ,Emp.FullName,Emp.Company,FORMAT(MiscArtInfo."To Date",0,'<Day,2>/<Month Text,3>/<Year>'));
                */
                CLEAR(BodyTxt);
                BodyTxt := STRSUBSTNO('%1 Document %6 for Employee/person %2 - %3 belonging to Company %4 is expiring on %5.'
                        , MiscArtInfo.Description, Emp."No.", Emp.FullName, Emp.Company, FORMAT(MiscArtInfo."To Date", 0, 7), MiscArtInfo."Serial No.");

                CLEAR(EmailTxt);
                IF Emp."Reporting To Email" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."Reporting To Email"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."Reporting To Email";
                END;

                IF Emp."PRO Email" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."PRO Email"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."PRO Email";
                END;

                IF Emp."E-Mail" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."E-Mail"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."E-Mail";
                END;

                IF Emp."Company E-Mail" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."Company E-Mail"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."Company E-Mail";
                END;
                IF EmailTxt <> '' THEN BEGIN
                    //EmailTxt := Emp."Reporting To Email" + ';' + Emp."PRO Email" + ';' + Emp."Company E-Mail" + ';' + Emp."E-Mail";
                    //MESSAGE(EmailTxt);
                    //MESSAGE(BodyTxt);
                    //SendMail(EmailTxt, '', SubTxt, BodyTxt);
                    MiscArtInfo2 := MiscArtInfo;
                    MiscArtInfo2."Expiry Warning Sent" := TRUE;
                    MiscArtInfo2.MODIFY;
                END;
            UNTIL MiscArtInfo.NEXT = 0;

        CLEAR(MiscArtInfo);
        MiscArtInfo.SETFILTER("To Date", '%1..%2', 20010101D, CALCDATE('15D', WORKDATE));
        MiscArtInfo.SETRANGE("Expiry Warning Sent", TRUE);
        MiscArtInfo.SETRANGE("Expiry 2 Warning Sent", FALSE);
        IF MiscArtInfo.FINDFIRST THEN
            REPEAT
                Emp.GET(MiscArtInfo."Employee No.");
                MiscArt.GET(MiscArtInfo."Misc. Article Code");
                CLEAR(SubTxt);
                SubTxt := MiscArtInfo.Description + ' expiry warning.' + ' Company: ' + Emp.Company;
                /*
                BodyTxt := 'Sharif Bedrampalla  working for Company/ person MIR HASHEM KHOORY LLC is expiring on 07/11/20.'
                BodyTxt := STRSUBSTNO('%1 working for Company/Person %2 is expiring on %3.'
                        ,Emp.FullName,Emp.Company,FORMAT(MiscArtInfo."To Date",0,'<Day,2>/<Month Text,3>/<Year>'));
                */
                CLEAR(BodyTxt);
                BodyTxt := STRSUBSTNO('%1 Document %6 for Employee/person %2 - %3 belonging to Company %4 is expiring on %5.'
                        , MiscArtInfo.Description, Emp."No.", Emp.FullName, Emp.Company, FORMAT(MiscArtInfo."To Date", 0, 7), MiscArtInfo."Serial No.");

                CLEAR(EmailTxt);
                IF Emp."Reporting To Email" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."Reporting To Email"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."Reporting To Email";
                END;

                IF Emp."PRO Email" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."PRO Email"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."PRO Email";
                END;

                IF Emp."E-Mail" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."E-Mail"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."E-Mail";
                END;

                IF Emp."Company E-Mail" <> '' THEN BEGIN
                    IF EmailTxt = '' THEN
                        EmailTxt := Emp."Company E-Mail"
                    ELSE
                        EmailTxt := EmailTxt + ';' + Emp."Company E-Mail";
                END;
                IF EmailTxt <> '' THEN BEGIN
                    //EmailTxt := Emp."Reporting To Email" + ';' + Emp."PRO Email" + ';' + Emp."Company E-Mail" + ';' + Emp."E-Mail";
                    //MESSAGE(EmailTxt);
                    //MESSAGE(BodyTxt);
                    //SendMail(EmailTxt, '', SubTxt, BodyTxt);
                    MiscArtInfo2 := MiscArtInfo;
                    MiscArtInfo2."Expiry 2 Warning Sent" := TRUE;
                    MiscArtInfo2.MODIFY;
                END;
            UNTIL MiscArtInfo.NEXT = 0;

    end;

    var
        CompInfo: Record 79;
        GLSetup: Record 98;
        OnesText: array[20] of Text;
        TensText: array[10] of Text;
        ExponentText: array[5] of Text;
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
        DecText: Text;
        Text50001: Label 'Do you want to Create Invoices?';
        StandardSalesCode: Record 170;
        StdCustSalesCode: Record 172;


    procedure DectoStr(Amt: Decimal): Text
    var
        AmtText: Text;
        DecText: Text;
    begin
        AmtText := (FORMAT(Amt, 0, '<Integer Thousand><Decimals>'));
        IF STRPOS(AmtText, '.') = 0 THEN BEGIN
            AmtText := AmtText + '.00';
        END ELSE BEGIN
            DecText := (COPYSTR(AmtText, STRPOS(AmtText, '.') + 1, STRLEN(AmtText)));
            IF STRLEN(DecText) = 1 THEN
                AmtText := AmtText + '0';
        END;
        EXIT(AmtText);
    end;


    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        GLSetup: Record 98;
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        InitTextVariable;
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        /*
        IF CurrencyCode <> '' THEN BEGIN
          NoText[1] := CurrencyCode;//CP
        END ELSE BEGIN
          GLSetup.GET;
          NoText[1] := GLSetup."LCY Code";//CP
        END;
        */

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
        DecimalPosition := GetAmtDecimalPosition(CurrencyCode);
        DecText := FormatDecText(No * DecimalPosition);
        //AddToNoText(NoText,NoTextIndex,PrintExponent,(FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition))); //CP
        AddToNoText(NoText, NoTextIndex, PrintExponent, (DecText + ' FILS ONLY')); //CP

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > 70 DO BEGIN
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

    local procedure GetAmtDecimalPosition(CurrCode: Code[10]): Decimal
    var
        Currency: Record 4;
    begin
        IF CurrCode = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            Currency.GET(CurrCode);
            Currency.TESTFIELD("Amount Rounding Precision");
        END;
        EXIT(1 / Currency."Amount Rounding Precision");
    end;

    local procedure FormatDecText(Fils: Decimal) FilsText: Text
    var
        FilsTens: Decimal;
        FilsOnes: Decimal;
    begin
        CLEAR(FilsText);
        //Fils := ROUND(Fils,1);
        IF Fils = 0 THEN BEGIN
            FilsText := 'ZERO';
            EXIT;
        END;
        IF Fils > 99 THEN
            ERROR('Fils greater than 99 not allowed.');
        FilsTens := (Fils MOD 100) DIV 10;
        FilsOnes := Fils MOD 10;
        IF FilsTens >= 2 THEN BEGIN
            FilsText := TensText[FilsTens];
            IF FilsOnes <> 0 THEN
                FilsText := FilsText + ' ' + OnesText[FilsOnes]
        END ELSE BEGIN
            FilsText := OnesText[Fils]
        END;
    end;

    procedure GetEmployeeName(EmpCode: Code[20]): Text
    var
        DimValue: Record 349;
        GLSetup: Record 98;
    begin
        CLEAR(DimValue);
        GLSetup.GET;
        IF DimValue.GET(GLSetup."Shortcut Dimension 8 Code", EmpCode) THEN;
        EXIT(DimValue.Name);
    end;


    // procedure SendMail(Email: Text; CC: Text; Subject: Text; Body: Text)
    // var
    //     SMTPRec: Record 409;
    //     SMTP: Codeunit 400;
    // begin
    //     SMTPRec.GET;
    //     SMTP.CreateMessage('Dynamics NAV', SMTPRec."User ID", Email, Subject, CC, TRUE);

    //     SMTP.AppendBody('Dear Sir/Madam,');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody(Body);
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Regards,');
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('NAV Administrator');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<HR>');
    //     SMTP.AppendBody('This is a system generated mail. Please donot reply to this mail ID.');
    //     SMTP.Send;
    // end;


    // procedure SendMailAttach(Email: Text; CC: Text; Subject: Text; Body: Text; FilePath: Text)
    // var
    //     SMTPRec: Record 409;
    //     SMTP: Codeunit 400;
    // begin
    //     SMTPRec.GET;
    //     SMTP.CreateMessage('Dynamics NAV', SMTPRec."User ID", Email, Subject, CC, TRUE);
    //     IF FilePath <> '' THEN
    //         SMTP.AddAttachment(FilePath, 'Statement.pdf');

    //     SMTP.AppendBody('Dear Sir/Madam,');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody(Body);
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Regards,');
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('NAV Administrator');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<HR>');
    //     SMTP.AppendBody('This is a system generated mail. Please donot reply to this mail ID.');
    //     SMTP.Send;
    // end;


    // procedure SendMailAttachMHKTSInvoice(Email: Text; CC: Text; Subject: Text; Body: Text; FilePath: Text; AttachmentName: Text)
    // var
    //     SMTPRec: Record 409;
    //     SMTP: Codeunit 400;
    // begin
    //     CompInfo.GET;
    //     CompInfo.TESTFIELD("Accounts E-Mail");
    //     SMTPRec.GET;
    //     //SMTP.CreateMessage(CompInfo.Name,SMTPRec."User ID",Email,Subject,CC,TRUE);
    //     SMTP.CreateMessage(CompInfo.Name, CompInfo."Accounts E-Mail", Email, Subject, CC, TRUE);
    //     IF FilePath <> '' THEN
    //         SMTP.AddAttachment(FilePath, AttachmentName);

    //     SMTP.AppendBody('Dear Sir/Madam,');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody(STRSUBSTNO('Greetings from %1 !!!', CompInfo.Name));
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Please find the Invoice as attached.');
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Thanks & Regards,');
    //     //SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('Accounts Department');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody(CompInfo."E-Mail");
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<HR>');
    //     SMTP.AppendBody('This is a system generated mail. Please donot reply to this mail ID.');
    //     SMTP.Send;
    // end;


    // procedure SendMailAttachMHKTSSOA(Email: Text; CC: Text; Subject: Text; Body: Text; FilePath: Text; AttachmentName: Text)
    // var
    //     SMTPRec: Record 409;
    //     SMTP: Codeunit 400;
    // begin
    //     CompInfo.GET;
    //     CompInfo.TESTFIELD("Accounts E-Mail");
    //     SMTPRec.GET;
    //     //SMTP.CreateMessage('MHK Trading & Ship Chandlers',SMTPRec."User ID",Email,Subject,CC,TRUE);
    //     SMTP.CreateMessage(CompInfo.Name, CompInfo."Accounts E-Mail", Email, Subject, CC, TRUE);
    //     IF FilePath <> '' THEN
    //         SMTP.AddAttachment(FilePath, AttachmentName);

    //     SMTP.AppendBody('Dear Sir/Madam,');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody(STRSUBSTNO('Greetings from %1!!!', CompInfo.Name));
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Please find the Outstanding Statement as attached.');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody(STRSUBSTNO('Kindly confirm the discrepancies by %1 else, the statement would be considered as final.', FORMAT(WORKDATE + 10)));
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Please update on the payment status of the outstanding balance');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Waiting for your positive response over the same.');
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Thanks & Regards,');
    //     //SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('Accounts Department');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody(CompInfo."E-Mail");
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<HR>');
    //     SMTP.AppendBody('This is a system generated mail. Please donot reply to this mail ID.');
    //     SMTP.Send;
    // end;


    // procedure CreateSalesInvoicesTUI(MultiInvoicingHeader: Record 50009)
    // var
    //     MultiInvoicingLines: Record 50011;
    //     SH: Record 36;
    //     SL: Record 37;
    //     MultiInvoicingLines2: Record 50011;
    //     Cust: Record 18;
    //     InvGen: Boolean;
    // begin
    //     IF NOT CONFIRM(Text50001, FALSE) THEN
    //         EXIT;
    //     IF MultiInvoicingHeader."Processed Date" <> 0D THEN
    //         ERROR('This Document is already processed.');

    //     IF NOT MultiInvoicingHeader."Generate Tuition Invoices" THEN
    //         EXIT;

    //     MultiInvoicingHeader.TESTFIELD(Quantity);
    //     MultiInvoicingHeader.TESTFIELD("Invoice Date");

    //     CLEAR(InvGen);
    //     CLEAR(MultiInvoicingLines);
    //     MultiInvoicingLines.SETRANGE("Document No.", MultiInvoicingHeader."Document No.");
    //     //MultiInvoicingLines.SETRANGE(Posted,FALSE);
    //     MultiInvoicingLines.SETRANGE("Sales Invoice No.", '');
    //     IF MultiInvoicingLines.FINDFIRST THEN
    //         REPEAT
    //             InvGen := TRUE;
    //             MultiInvoicingLines.TESTFIELD("No.");

    //             CLEAR(SH);
    //             SH.INIT;
    //             SH."Document Type" := SH."Document Type"::Invoice;
    //             SH."No." := '';
    //             SH.INSERT(TRUE);
    //             SH.SetHideValidationDialog(TRUE);
    //             SH.VALIDATE("Sell-to Customer No.", MultiInvoicingLines."No.");
    //             Cust.GET(MultiInvoicingLines."No.");
    //             //IF( Cust."Customer Disc. Group" = 'TUI-EMI') --commented as per Kents's request
    //             IF (Cust."Customer Disc. Group" = 'TUI-EMI') AND (Cust."Student Grade" <> 'TUI-FS1') THEN //GSS- changed condition for billing FS1 Students to parent and not emirates
    //                 SH.VALIDATE("Bill-to Customer No.", 'EMI');

    //             SH.VALIDATE("Posting Date", MultiInvoicingHeader."Invoice Date");
    //             IF MultiInvoicingHeader."Due Date" <> 0D THEN //ITOS
    //                 SH.VALIDATE("Due Date", MultiInvoicingHeader."Due Date"); //ITOS
    //             SH.VALIDATE("Term Start Date", MultiInvoicingHeader."Term Start Date"); //ATOS
    //             SH.VALIDATE("External Document No.", MultiInvoicingHeader."Document No.");
    //             SH.VALIDATE("Shortcut Dimension 1 Code", Cust."Global Dimension 1 Code");
    //             SH.MODIFY(TRUE);

    //             CLEAR(SL);
    //             SL.INIT;
    //             SL."Document Type" := SH."Document Type";
    //             SL."Document No." := SH."No.";
    //             SL."Line No." := 10000;
    //             SL.INSERT(TRUE);
    //             SL.Type := SL.Type::Item;
    //             Cust.TESTFIELD("Student Grade");
    //             Cust.TESTFIELD("Student Status", Cust."Student Status"::Current);
    //             SL.VALIDATE("No.", Cust."Student Grade");
    //             Cust."Next Invoice Date" := GetNextInvoiceDate(MultiInvoicingHeader."Invoice Date");
    //             Cust.MODIFY(TRUE);
    //             SL.VALIDATE(Description, MultiInvoicingHeader.Description);
    //             SL.VALIDATE(Narration, MultiInvoicingHeader.Description); //ITOS
    //             SL.VALIDATE(Quantity, MultiInvoicingHeader.Quantity);
    //             SL.MODIFY(TRUE);

    //             //ATOS NURS
    //             IF Cust."Wrap Around Care" <> '' THEN BEGIN
    //                 CLEAR(SL);
    //                 SL.INIT;
    //                 SL."Document Type" := SH."Document Type";
    //                 SL."Document No." := SH."No.";
    //                 SL."Line No." := 20000;
    //                 SL.INSERT(TRUE);
    //                 SL.Type := SL.Type::Item;
    //                 SL.VALIDATE("No.", Cust."Wrap Around Care");
    //                 SL.VALIDATE(Quantity, MultiInvoicingHeader.Quantity);
    //                 SL.VALIDATE(Narration, MultiInvoicingHeader.Description); //ITOS
    //                 SL.MODIFY(TRUE);
    //             END;
    //             //ATOS NURS

    //             MultiInvoicingLines2.GET(MultiInvoicingLines."Document No.", MultiInvoicingLines."Line No.");
    //             MultiInvoicingLines2.Quantity := SL.Quantity;

    //             MultiInvoicingLines2."Sales Invoice No." := SH."No.";
    //             SH.CALCFIELDS(Amount, "Amount Including VAT");
    //             MultiInvoicingLines2.Amount := SH.Amount;
    //             MultiInvoicingLines2."Amount with VAT" := SH."Amount Including VAT";
    //             MultiInvoicingLines2.MODIFY;

    //         UNTIL MultiInvoicingLines.NEXT = 0;

    //     IF InvGen THEN BEGIN
    //         MultiInvoicingHeader."Processed By" := USERID;
    //         MultiInvoicingHeader."Processed Date" := WORKDATE;
    //         MultiInvoicingHeader."Processed Time" := TIME;
    //         MultiInvoicingHeader.MODIFY;
    //         MESSAGE('Invoices Generated.')
    //     END ELSE
    //         MESSAGE('No Invoices Generated.');
    // end;


    // procedure CreateSalesInvoicesOthers(MultiInvoicingHeader: Record 50009)
    // var
    //     MultiInvoicingLines: Record 50011;
    //     SH: Record 36;
    //     SL: Record 37;
    //     MultiInvoicingLines2: Record 50011;
    //     Cust: Record 18;
    //     InvGen: Boolean;
    // begin
    //     IF NOT CONFIRM(Text50001, FALSE) THEN
    //         EXIT;
    //     IF MultiInvoicingHeader."Processed Date" <> 0D THEN
    //         ERROR('This Document is already processed.');

    //     IF MultiInvoicingHeader."Generate Tuition Invoices" THEN
    //         EXIT;


    //     MultiInvoicingHeader.TESTFIELD(Quantity);
    //     MultiInvoicingHeader.TESTFIELD("Invoice Date");
    //     MultiInvoicingHeader.TESTFIELD("Order Code");

    //     CLEAR(InvGen);
    //     CLEAR(MultiInvoicingLines);
    //     MultiInvoicingLines.SETRANGE("Document No.", MultiInvoicingHeader."Document No.");
    //     //MultiInvoicingLines.SETRANGE(Posted,FALSE);
    //     MultiInvoicingLines.SETRANGE("Sales Invoice No.", '');
    //     IF MultiInvoicingLines.FINDFIRST THEN
    //         REPEAT
    //             InvGen := TRUE;
    //             MultiInvoicingLines.TESTFIELD("No.");

    //             CLEAR(SH);
    //             SH.INIT;
    //             SH."Document Type" := SH."Document Type"::Invoice;
    //             SH."No." := '';
    //             SH.INSERT(TRUE);

    //             SH.SetHideValidationDialog(TRUE);
    //             SH.VALIDATE("Sell-to Customer No.", MultiInvoicingLines."No.");
    //             SH.VALIDATE("Posting Date", MultiInvoicingHeader."Invoice Date");
    //             SH.VALIDATE("External Document No.", MultiInvoicingHeader."Document No.");
    //             StandardSalesCode.GET(MultiInvoicingHeader."Order Code");
    //             SH.VALIDATE("Payment Method Code", StandardSalesCode."Payment Method Code");
    //             IF MultiInvoicingHeader."Due Date" <> 0D THEN //ITOS
    //                 SH.VALIDATE("Due Date", MultiInvoicingHeader."Due Date"); //ITOS
    //             SH.MODIFY(TRUE);

    //             SH.GET(SH."Document Type", SH."No.");

    //             CLEAR(StdCustSalesCode);
    //             StdCustSalesCode."Customer No." := MultiInvoicingLines."No.";
    //             StdCustSalesCode.Code := StandardSalesCode.Code;
    //             StdCustSalesCode.ApplyStdCodesToSalesLines(SH, StdCustSalesCode);
    //             /*
    //             CLEAR(SL);
    //             SL.INIT;
    //             SL."Document Type" := SH."Document Type";
    //             SL."Document No." := SH."No.";
    //             SL."Line No." := 10000;
    //             SL.INSERT(TRUE);
    //             SL.Type := SL.Type::Item;
    //             Cust.GET(MultiInvoicingLines."No.");
    //             Cust.TESTFIELD("Student Grade");
    //             Cust.TESTFIELD("Student Status",Cust."Student Status"::Current);
    //             SL.VALIDATE("No.",Cust."Student Grade");
    //             Cust."Next Invoice Date" := MultiInvoicingHeader."Invoice Date";
    //             SL.VALIDATE(Description,MultiInvoicingHeader.Description);
    //             SL.VALIDATE(Quantity,MultiInvoicingHeader.Quantity);
    //             //SL.VALIDATE("Unit Price",LMSalesLines.Amount);
    //             SL.MODIFY(TRUE);

    //             MultiInvoicingLines2.GET(MultiInvoicingLines."Document No.",MultiInvoicingLines."Line No.");
    //             MultiInvoicingLines2.Quantity := SL.Quantity;

    //             MultiInvoicingLines2."Sales Invoice No." := SH."No.";
    //             SH.CALCFIELDS(Amount,"Amount Including VAT" );
    //             MultiInvoicingLines2.Amount := SH.Amount;
    //             MultiInvoicingLines2."Amount with VAT" := SH."Amount Including VAT";
    //             MultiInvoicingLines2.MODIFY;
    //             */
    //             MultiInvoicingLines2.GET(MultiInvoicingLines."Document No.", MultiInvoicingLines."Line No.");
    //             MultiInvoicingLines2.Quantity := SL.Quantity;
    //             MultiInvoicingLines2."Sales Invoice No." := SH."No.";
    //             SH.CALCFIELDS(Amount, "Amount Including VAT");
    //             MultiInvoicingLines2.Amount := SH.Amount;
    //             MultiInvoicingLines2."Amount with VAT" := SH."Amount Including VAT";
    //             MultiInvoicingLines2.MODIFY;
    //         UNTIL MultiInvoicingLines.NEXT = 0;

    //     IF InvGen THEN BEGIN
    //         MultiInvoicingHeader."Processed By" := USERID;
    //         MultiInvoicingHeader."Processed Date" := WORKDATE;
    //         MultiInvoicingHeader."Processed Time" := TIME;
    //         MultiInvoicingHeader.MODIFY;
    //         MESSAGE('Invoices Generated.')
    //     END ELSE
    //         MESSAGE('No Invoices Generated.');

    // end;

    local procedure GetNextInvoiceDate(InvDate: Date): Date
    begin
        IF DATE2DMY(InvDate, 2) IN [9, 10, 11] THEN
            EXIT(DMY2DATE(1, 12, DATE2DMY(InvDate, 3)));
        IF DATE2DMY(InvDate, 2) IN [12] THEN
            EXIT(DMY2DATE(1, 3, DATE2DMY(InvDate, 3) + 1));
        IF DATE2DMY(InvDate, 2) IN [1, 2] THEN
            EXIT(DMY2DATE(1, 3, DATE2DMY(InvDate, 3)));
        IF DATE2DMY(InvDate, 2) IN [3, 4, 5, 6, 7, 8] THEN
            EXIT(DMY2DATE(1, 9, DATE2DMY(InvDate, 3)));
    end;


    procedure CreateRecJnl()
    begin
    end;

    local procedure GetTerm(InvDate: Date; var AcademicYear: Integer): Text
    var
        YearofentryInt: Integer;
    begin
        IF DATE2DMY(InvDate, 2) IN [9, 10, 11] THEN
            EXIT('AUTUMN');
        IF DATE2DMY(InvDate, 2) IN [12, 1, 2] THEN
            EXIT('SPRING');
        IF DATE2DMY(InvDate, 2) IN [3, 4, 5] THEN
            EXIT('SUMMER');
    end;


    // procedure SendMailInvoice(Email: Text; CC: Text; Subject: Text; Body: Text; var SalesInvHeader: Record 112)
    // var
    //     SMTPRec: Record 409;
    //     SMTP: Codeunit 400;
    //     FilePath: Text;
    //     FileMgt: Codeunit "419";
    //     RecordVariant: Variant;
    // begin
    //     SMTPRec.GET;
    //     SMTP.CreateMessage('Kent College', SMTPRec."User ID", Email, Subject, '', TRUE);
    //     IF CC <> '' THEN
    //         SMTP.AddCC := CC;

    //     FilePath := COPYSTR(FileMgt.ServerTempFileName('pdf'), 1, 250);

    //     REPORT.SAVEASPDF(50035, FilePath, SalesInvHeader);
    //     IF FilePath <> '' THEN
    //         SMTP.AddAttachment(FilePath, 'Invoice.pdf');

    //     SMTP.AppendBody('Dear Parent,');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Greetings!');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody(Body);
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br><br>');
    //     SMTP.AppendBody('Regards,');
    //     SMTP.AppendBody('</br></br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('Kent College Dubai');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<br>');
    //     SMTP.AppendBody('</br>');
    //     SMTP.AppendBody('<HR>');
    //     SMTP.AppendBody('This is a system generated mail. Please do not reply to this mail ID.');
    //     SMTP.Send;
    // end;


    procedure GetApprovers(var UserSetup: array[8] of Record 91; var ApprovedDateTime: array[8] of DateTime; RecRef: RecordRef)
    var
        ApprovalEntry: Record 454;
        i: Integer;
        UserSetup2: Record 91;
        j: Integer;
        Skip: Boolean;
    begin
        //Approvers
        i := 0;
        CLEAR(ApprovalEntry);
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Record ID to Approve", RecRef.RECORDID);
        ApprovalEntry.SETFILTER(Status, '%1|%2|%3', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created, ApprovalEntry.Status::Approved);
        IF ApprovalEntry.FINDFIRST THEN
            REPEAT
                i += 1;
                CLEAR(UserSetup2);
                IF UserSetup2.GET(ApprovalEntry."Approver ID") THEN;
                //ITOS
                Skip := FALSE;
                j := 0;
                FOR j := 1 TO 8 DO BEGIN
                    IF UserSetup[j]."User ID" = UserSetup2."User ID" THEN BEGIN
                        Skip := TRUE;
                        IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN
                            ApprovedDateTime[j] := ApprovalEntry."Last Date-Time Modified";
                    END;
                END;
                IF NOT Skip THEN BEGIN
                    UserSetup[i] := UserSetup2;
                    IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN
                        ApprovedDateTime[i] := ApprovalEntry."Last Date-Time Modified";
                END;
            //ITOS
            UNTIL ApprovalEntry.NEXT = 0;
    end;


    procedure GetApproversPosted(var UserSetup: array[8] of Record 91; var ApprovedDateTime: array[8] of DateTime; DocNo: Code[20])
    var
        PostedApprovalEntry: Record 456;
        i: Integer;
        UserSetup2: Record 91;
    begin
        //Approvers
        i := 0;
        CLEAR(PostedApprovalEntry);
        PostedApprovalEntry.RESET;
        PostedApprovalEntry.SETRANGE("Table ID", 17);
        PostedApprovalEntry.SETRANGE("Document No.", DocNo);
        PostedApprovalEntry.SETRANGE(Status, PostedApprovalEntry.Status::Approved);
        IF PostedApprovalEntry.FINDFIRST THEN
            REPEAT
                i += 1;
                CLEAR(UserSetup2);
                IF UserSetup2.GET(PostedApprovalEntry."Approver ID") THEN;
                UserSetup[i] := UserSetup2;
                IF PostedApprovalEntry.Status = PostedApprovalEntry.Status::Approved THEN
                    ApprovedDateTime[i] := PostedApprovalEntry."Last Date-Time Modified";
            UNTIL PostedApprovalEntry.NEXT = 0;
    end;


    procedure GetLotNo(SourceType: Integer; SourceSubType: Integer; SourceID: Code[20]; SourceRefNo: Integer) LotNo: Code[200]
    var
        ReservationEntry: Record 337;
    begin
        CLEAR(ReservationEntry);
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source Type", SourceType);
        ReservationEntry.SETRANGE("Source Subtype", SourceSubType);
        ReservationEntry.SETRANGE("Source ID", SourceID);
        ReservationEntry.SETRANGE("Source Ref. No.", SourceRefNo);
        IF ReservationEntry.FINDFIRST THEN
            REPEAT
                IF LotNo = '' THEN
                    LotNo += ReservationEntry."Lot No." + STRSUBSTNO('(%1)', FORMAT(ABS(ReservationEntry.Quantity)))
                ELSE BEGIN
                    IF STRLEN(LotNo + ',' + ReservationEntry."Lot No." + STRSUBSTNO('(%1)', FORMAT(ABS(ReservationEntry.Quantity)))) <= MAXSTRLEN(LotNo) THEN
                        LotNo += ',' + ReservationEntry."Lot No." + STRSUBSTNO('(%1)', FORMAT(ABS(ReservationEntry.Quantity)));
                END;
            UNTIL ReservationEntry.NEXT = 0;
        EXIT(LotNo);
    end;


    // procedure PostRevenue(RevenueBooking: Record "50010")
    // var
    //     SalesSetup: Record "311";
    //     GenJnlLine: Record "81";
    //     InterBULineNo: Integer;
    //     TempGenJnlLine: Record "81";
    //     GenJnlLineNo: Integer;
    //     LMLine1: Record "50001";
    //     JnlDesc: Text[250];
    //     LeaseUnit: Record "50022";
    // begin
    //     /*
    //     SalesSetup.GET;
    //     //SalesSetup.TESTFIELD(Template);
    //     //SalesSetup.TESTFIELD(Batch);
    //     //SalesSetup.TESTFIELD("Basic Rent Acc. Dr.");
    //     //SalesSetup.TESTFIELD("Basic Rent Acc. Cr.");
    //     //GSS
    //     //GSS
    //     //LMSetup.TESTFIELD("Accrual Sales Acc. Dr.");
    //     //LMSetup.TESTFIELD("Accrual Sales Acc. Cr.");

    //     //LocRec.TESTFIELD("Shortcut Dimension 1 Code");

    //     TempGenJnlLine.RESET;
    //     TempGenJnlLine.SETRANGE("Journal Template Name",LMSetup.Template);
    //     TempGenJnlLine.SETRANGE("Journal Batch Name",LMSetup.Batch);
    //     IF TempGenJnlLine.FIND('+') THEN
    //       GenJnlLineNo := TempGenJnlLine."Line No." + 10000
    //     ELSE
    //       GenJnlLineNo := 10000;

    //     GenJnlLine.INIT;
    //     GenJnlLine.VALIDATE("Journal Template Name",LMSetup.Template);
    //     GenJnlLine.VALIDATE("Journal Batch Name",LMSetup.Batch);
    //     GenJnlLine."Line No." := GenJnlLineNo;
    //     GenJnlLineNo += 10000;
    //     SetUpNewLine(GenJnlLine,0,TRUE,LMLine);
    //     IF GenJnlLine."Document No." = '' THEN
    //       GenJnlLine."Document No." := LMHeader."No.";
    //     //GenJnlLine."Document No." := GenJnlLine."Document No." + '-' + FORMAT(JnlDocNo);
    //     GenJnlLine.INSERT;
    //     GenJnlLine."Posting Date" := LMLine."End Date";
    //     GenJnlLine."Document Date" := LMLine."End Date";
    //     GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
    //     GenJnlLine.VALIDATE("Account No.",LMSetup."Basic Rent Acc. Dr.");
    //     GenJnlLine.VALIDATE(Amount,LMLine.Amount);
    //     //GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",LocRec."Shortcut Dimension 1 Code");
    //     //T007395 - Replaced Location Name to Location Code
    //     JnlDesc := STRSUBSTNO('Rent for %1 (%2-%3)',LocRec.Code,LMLine."Start Date",LMLine."End Date");
    //     GenJnlLine.Description := COPYSTR(JnlDesc,1,50);
    //     GenJnlLine."Lease Agreement No." :=  LMHeader."No.";
    //     GenJnlLine.MODIFY;

    //     GenJnlLine.INIT;
    //     GenJnlLine.VALIDATE("Journal Template Name",LMSetup.Template);
    //     GenJnlLine.VALIDATE("Journal Batch Name",LMSetup.Batch);
    //     GenJnlLine."Line No." := GenJnlLineNo;
    //     GenJnlLineNo += 10000;
    //     SetUpNewLine(GenJnlLine,0,TRUE,LMLine);
    //     IF GenJnlLine."Document No." = '' THEN
    //       GenJnlLine."Document No." := LMHeader."No.";
    //     //GenJnlLine."Document No." := GenJnlLine."Document No." + '-' + FORMAT(JnlDocNo);
    //     GenJnlLine.INSERT;
    //     GenJnlLine."Posting Date" := LMLine."End Date";
    //     GenJnlLine."Document Date" := LMLine."End Date";
    //     GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
    //     GenJnlLine.VALIDATE("Account No.",LMSetup."Basic Rent Acc. Cr.");
    //     GenJnlLine.VALIDATE(Amount,-LMLine.Amount);
    //     //GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",LocRec."Shortcut Dimension 1 Code");
    //     //T007395 - Replaced Location Name to Location Code
    //     JnlDesc := STRSUBSTNO('Rent for %1 (%2-%3)',LocRec.Code,LMLine."Start Date",LMLine."End Date");
    //     GenJnlLine.Description := COPYSTR(JnlDesc,1,50);
    //     GenJnlLine."Lease Agreement No." :=  LMHeader."No.";
    //     GenJnlLine.MODIFY;

    //     LMLine1.RESET;
    //     LMLine1.SETRANGE("Document Type",LMLine."Document Type");
    //     LMLine1.SETRANGE("Document No.",LMLine."Document No.");
    //     LMLine1.SETRANGE("Line No.",LMLine."Line No.");
    //     IF LMLine1.FIND('-') THEN BEGIN
    //       LMLine1."Journal No." := GenJnlLine."Document No.";
    //       LMLine1."Line Created" := TRUE;
    //       LMLine1.MODIFY;
    //     END;
    //     //COMMIT;
    //     */

    // end;


    // procedure UpdateTermStartDate(SIH: Record 112)
    // var
    //     TermDateTxt: Text;


    //     TermDate: Text;
    // begin
    //     TermDateTxt := Window.InputBox('Input Term Date (DD/MM/YYYY):', 'INPUT', '', 100, 100);
    //     IF TermDateTxt = '' THEN
    //         ERROR('Invalid Date.');
    //     TermDate := COPYSTR(TermDateTxt, 1, 2) + COPYSTR(TermDateTxt, 4, 2) + COPYSTR(TermDateTxt, 7, 4);
    //     EVALUATE(SIH."Term Start Date", TermDate);
    //     SIH.MODIFY;
    // end;


    procedure UpdateSalesLineExciseDutyPerUnit(SalesLine: Record 37; TrackingSpecification: Record 336)
    var
        SalesLine2: Record 37;
        TrackingSpecification2: Record 336;
        ILE: Record 32;
        ValueEntries: Record 5802;
        SalesReceivableSetup: Record 311;
        ExcisePerQty: Decimal;
        ItemUnitofMeasure: Record 5404;
        ExciseFound: Boolean;
    begin
        SalesLine2.SETCURRENTKEY("Document Type", "Document No.");
        SalesLine2.SETRANGE("Document No.", SalesLine."Document No.");
        SalesLine2.SETRANGE("Document Type", SalesLine."Document Type");
        SalesLine2.SETRANGE("Line No.", SalesLine."Line No.");

        IF SalesLine2.FINDFIRST THEN;


        CLEAR(ILE);
        CLEAR(ValueEntries);
        CLEAR(ExcisePerQty);

        SalesReceivableSetup.GET;
        SalesReceivableSetup.TESTFIELD("Excise - Item Charges");
        //IF SalesReceivableSetup."Excise - Item Charges" = '' THEN
        //ERROR(Text50002);

        //TS-26-12-2020-
        CLEAR(ExciseFound);
        ExciseFound := FALSE;
        //TS-26-12-2020+

        IF (TrackingSpecification."Item No." <> '') AND (TrackingSpecification."Lot No." <> '') THEN BEGIN
            ILE.SETCURRENTKEY("Item No.", "Lot No.");
            ILE.SETRANGE("Item No.", TrackingSpecification."Item No.");
            ILE.SETRANGE("Lot No.", TrackingSpecification."Lot No.");

            //TS-26-12-2020-
            /*
            IF ILE.FINDFIRST THEN BEGIN
              ValueEntries.SETCURRENTKEY("Item Ledger Entry No.","Item Charge No.");
              ValueEntries.SETRANGE("Item Ledger Entry No.",ILE."Entry No.");
              ValueEntries.SETRANGE("Item Charge No.", SalesReceivableSetup."Excise - Item Charges");

              IF ValueEntries.FINDFIRST THEN REPEAT
                ExcisePerQty += (ValueEntries."Cost Amount (Actual)" / ValueEntries."Valued Quantity");
              UNTIL ValueEntries.NEXT=0;
            END;
            */
            IF ILE.FINDFIRST THEN
                REPEAT
                    ValueEntries.SETCURRENTKEY("Item Ledger Entry No.", "Item Charge No.");
                    ValueEntries.SETRANGE("Item Ledger Entry No.", ILE."Entry No.");
                    ValueEntries.SETRANGE("Item Charge No.", SalesReceivableSetup."Excise - Item Charges");

                    IF ValueEntries.FINDFIRST THEN
                        REPEAT
                            ExciseFound := TRUE;
                            ExcisePerQty += (ValueEntries."Cost Amount (Actual)" / ValueEntries."Valued Quantity");
                        UNTIL ValueEntries.NEXT = 0;
                UNTIL (ILE.NEXT = 0) OR ExciseFound;

            //TS-26-12-2020+
        END;

        //ATOS-EXC1.1 -
        /*
        SalesLine2."Excise Duty Per Unit" := ExcisePerQty;
        */

        SalesLine2."Excise Duty Per Unit" := ExcisePerQty;

        CLEAR(ItemUnitofMeasure);
        IF SalesLine2."Unit of Measure Code" <> '' THEN BEGIN
            IF ItemUnitofMeasure.GET(SalesLine."No.", SalesLine."Unit of Measure Code") THEN BEGIN
                SalesLine2."Excise Duty Per Line UOM" := ItemUnitofMeasure."Qty. per Unit of Measure" * ExcisePerQty;
            END;
        END;

        //ATOS-EXC1.1 +
        SalesLine2.MODIFY;

    end;


    procedure PrintCheck(var GenJnlLine: Record 81; BankAcc2: Record 270; UseCheckNo: Code[10]; BalancingType: Integer; BalancingNo: Code[20]; TotalLineAmount: Decimal; RecordIdToPrint: RecordID)
    var
        CheckLedgEntry: Record 272;
        CheckManagement: Codeunit 367;
        Currency: Record 4;
        Decimals: Decimal;
        CheckAmountText: Text;
        Utilities: Codeunit 50001;
        GenJnlLine2: Record 81;
    begin
        //ITOS
        WITH GenJnlLine DO BEGIN
            CheckLedgEntry.INIT;
            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
            CheckLedgEntry."Posting Date" := "Posting Date";
            CheckLedgEntry."Document Type" := "Document Type";
            CheckLedgEntry."Document No." := UseCheckNo;
            CheckLedgEntry.Description := Description;
            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
            CheckLedgEntry."Bal. Account Type" := BalancingType;
            CheckLedgEntry."Bal. Account No." := BalancingNo;
            CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
            CheckLedgEntry.Amount := TotalLineAmount;
            CheckLedgEntry."Check Date" := "Posting Date";
            IF "LIT Cheque No." = '' THEN                       //GSS-ASH
                CheckLedgEntry."Check No." := UseCheckNo
            ELSE
                CheckLedgEntry."Check No." := "LIT Cheque No.";   //GSS-ASH

            CheckManagement.InsertCheck(CheckLedgEntry, RecordIdToPrint);

            CLEAR(GenJnlLine2);
            IF GenJnlLine2.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", GenJnlLine."Line No.") THEN BEGIN
                GenJnlLine2."Check Printed" := TRUE;
                // GenJnlLine2."LITCheque Printed By" := USERID;
                // GenJnlLine2."Cheque Printed Date" := CURRENTDATETIME;
                GenJnlLine2.MODIFY;
            END;
        END;
    end;
}

