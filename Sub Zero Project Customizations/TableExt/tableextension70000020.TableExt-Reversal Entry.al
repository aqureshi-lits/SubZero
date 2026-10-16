tableextension 60019 RevEntrExt extends "Reversal Entry"
{
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Entry Type,Entry No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Transaction No."(Key)".

    }

    //Unsupported feature: Code Modification on "CheckBankAcc(PROCEDURE 18)".

    //procedure CheckBankAcc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BankAcc.GET(BankAccLedgEntry."Bank Account No.");
    CheckPostingDate(
      BankAccLedgEntry."Posting Date",BankAccLedgEntry.TABLECAPTION,BankAccLedgEntry."Entry No.");
    #4..9
    IF BankAccLedgEntry."Statement No." <> '' THEN
      ERROR(
        Text007,BankAccLedgEntry.TABLECAPTION,BankAccLedgEntry."Entry No.");
    CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.",BankAccLedgEntry."Entry No.");
    IF NOT CheckLedgEntry.ISEMPTY THEN
      ERROR(
        Text003,BankAccLedgEntry.TABLECAPTION,BankAccLedgEntry."Entry No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    //GSS
    { commented base
    #13..16
    }
    //GSS
    */
    //end;


    //Unsupported feature: Code Modification on "SetReverseFilter(PROCEDURE 1)".

    //procedure SetReverseFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF RevType = RevType::Transaction THEN BEGIN
      GLEntry.SETCURRENTKEY("Transaction No.");
      CustLedgEntry.SETCURRENTKEY("Transaction No.");
    #4..10
      VendLedgEntry.SETRANGE("Transaction No.",Number);
      BankAccLedgEntry.SETRANGE("Transaction No.",Number);
      FALedgEntry.SETRANGE("Transaction No.",Number);
      FALedgEntry.SETFILTER("G/L Entry No.",'<>%1',0);
      MaintenanceLedgEntry.SETRANGE("Transaction No.",Number);
      VATEntry.SETRANGE("Transaction No.",Number);
    END ELSE BEGIN
    #18..25
      MaintenanceLedgEntry.SETRANGE("G/L Entry No.",GLReg."From Entry No.",GLReg."To Entry No.");
      VATEntry.SETRANGE("Entry No.",GLReg."From VAT Entry No.",GLReg."To VAT Entry No.");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    #15..28
    */
    //end;
}

