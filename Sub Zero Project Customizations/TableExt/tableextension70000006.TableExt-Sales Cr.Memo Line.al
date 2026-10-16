tableextension 60005 SalCreMemLinExt extends "Sales Cr.Memo Line"
{
    fields
    {

        field(60005; "LIT Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60010; "LIT Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60100; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Property Deletion (DataClassification) on "Margin(Field 50005)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Margin %"(Field 50010)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".

        // field(50110; "Excise Duty Per Unit"; Decimal)
        // {
        //     Description = 'ATOS';
        //     Editable = false;
        // }
        // field(50111; "Excise Duty Per Line UOM"; Decimal)
        // {
        //     Description = 'ATOS-EXC1.1';
        // }
        // field(50120; "Excise Amount"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'ATOS-EXC1.2';
        //     Editable = false;
        // }
        // field(50121; "Amount Excl. Excise"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'ATOS-EXC1.2';
        //     Editable = false;
        // }
    }


    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 8)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    TRANSFERFIELDS(SalesLine);
    IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
      Type := Type::" ";
    "Posting Date" := SalesCrMemoHeader."Posting Date";
    "Document No." := SalesCrMemoHeader."No.";
    Quantity := SalesLine."Qty. to Invoice";
    "Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8

    //ATOS-EXC1.2-
    "Excise Amount" := "Excise Duty Per Line UOM" * Quantity;
    "Amount Excl. Excise" := Amount - "Excise Amount";
    //ATOS-EXC1.2+
    */
    //end;
}

