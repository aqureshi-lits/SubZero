tableextension 60003 SalInvLinExt extends "Sales Invoice Line"
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
        // field(50112; "Order No. FlowField"; Code[20])
        // {
        //     AccessByPermission = TableData 110 = R;
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("Sales Invoice Header"."Order No." WHERE("No." = FIELD("Document No."),
        //                                                                    "Posting Date" = FIELD("Posting Date")));
        //     Caption = 'Order No.';
        //     Description = 'ATOS GJ';
        //     Editable = true;

        // }
        // field(50113; "Sell-to Customer Name"; Text[100])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("Sales Invoice Header"."Sell-to Customer Name" WHERE("No." = FIELD("Document No."),
        //                                                                                "Posting Date" = FIELD("Posting Date")));
        //     Caption = 'Sell-to Customer Name';
        //     Description = 'ATOS GJ';
        //     Editable = false;

        // }
        // field(50114; "Bill-to Name"; Text[100])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = Lookup("Sales Invoice Header"."Bill-to Name" WHERE("No." = FIELD("Document No."),
        //                                                                       "Posting Date" = FIELD("Posting Date")));
        //     Caption = 'Bill-to Name';
        //     Description = 'ATOS GJ';
        //     Editable = false;

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


    //Unsupported feature: Code Modification on "InitFromSalesLine(PROCEDURE 12)".

    //procedure InitFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    TRANSFERFIELDS(SalesLine);
    IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
      Type := Type::" ";
    "Posting Date" := SalesInvHeader."Posting Date";
    "Document No." := SalesInvHeader."No.";
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

