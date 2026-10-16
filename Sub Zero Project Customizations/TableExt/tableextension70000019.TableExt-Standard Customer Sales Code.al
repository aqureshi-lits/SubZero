tableextension 60018 StanCusSalCodExt extends "Standard Customer Sales Code"
{

    //Unsupported feature: Code Modification on "ApplyStdCodesToSalesLines(PROCEDURE 2)".

    //procedure ApplyStdCodesToSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SalesHeader."Currency Code" = '' THEN
      Currency.InitRoundingPrecision
    ELSE
    #4..46

        SalesLine."Shortcut Dimension 1 Code" := StdSalesLine."Shortcut Dimension 1 Code";
        SalesLine."Shortcut Dimension 2 Code" := StdSalesLine."Shortcut Dimension 2 Code";

        CombineDimensions(SalesLine,StdSalesLine);

        IF StdSalesLine.InsertLine THEN BEGIN
    #54..56
          InsertExtendedText(SalesLine);
        END;
      UNTIL StdSalesLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..49
        //ITOS
        SalesLine.Narration := StdSalesLine.Narration;
        //ITOS
    #51..59
    */
    //end;
}

