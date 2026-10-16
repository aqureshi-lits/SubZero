tableextension 60058 RetRecLiExt extends "Return Receipt Line"
{
    fields
    {
        field(50005; Margin; Decimal)
        {
            Description = 'GSS';
        }
        field(50010; "Margin %"; Decimal)
        {
            Description = 'GSS';
        }
        field(50100; Narration; Text[250])
        {
            Description = 'ASH';
        }
    }


    //Unsupported feature: Code Modification on "InsertInvLineFromRetRcptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRetRcptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETRANGE("Document No.","Document No.");

    TempSalesLine := SalesLine;
    #4..13
      SalesLine."Line No." := NextLineNo;
      SalesLine."Document Type" := TempSalesLine."Document Type";
      SalesLine."Document No." := TempSalesLine."Document No.";
      LanguageManagement.SetGlobalLanguageByCode(SalesHeader."Language Code");
      SalesLine.Description := STRSUBSTNO(Text000,"Document No.");
      LanguageManagement.RestoreGlobalLanguage;
      SalesLine.INSERT;
      NextLineNo := NextLineNo + 10000;
    END;
    #23..115
      SalesOrderHeader."Get Shipment Used" := TRUE;
      SalesOrderHeader.MODIFY;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
      SalesLine.Description := STRSUBSTNO(Text000,"Document No.");
    #20..118
    */
    //end;
}

