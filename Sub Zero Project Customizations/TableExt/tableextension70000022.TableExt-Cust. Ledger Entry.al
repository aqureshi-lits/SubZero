tableextension 60021 CusLedEntExt extends "Cust. Ledger Entry"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""Sell-to Customer No."(Field 21)".


        //Unsupported feature: Property Modification (Data type) on ""Salesperson Code"(Field 25)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 27)".


        //Unsupported feature: Deletion (FieldCollection) on ""Payment Reference"(Field 171)".

        field(60000; "Customer Name flow"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Description = 'GSS-ASH';
            Editable = false;

        }
        field(60001; "Payment Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Detailed Cust. Ledg. Entry"."Posting Date" WHERE("Entry Type" = CONST(Application),
                                                                                    "Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                    "Customer No." = FIELD("Customer No.")));
            Editable = false;

        }
        field(60100; "Sell-to Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Sell-to Customer No.")));
            Description = 'GSS-ASH';
            Editable = false;

        }
        field(60101; "LIT Narration"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Entry"."LIT Narration" WHERE("Document No." = FIELD("Document No."),
                                                              "Posting Date" = FIELD("Posting Date")));
            Description = 'GJ-ATOS';

        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Document Type,Customer No.,Open"(Key)".

    }


    //Unsupported feature: Code Modification on "DrillDownOnEntries(PROCEDURE 1)".

    //procedure DrillDownOnEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustLedgEntry.RESET;
    DtldCustLedgEntry.COPYFILTER("Customer No.",CustLedgEntry."Customer No.");
    DtldCustLedgEntry.COPYFILTER("Currency Code",CustLedgEntry."Currency Code");
    DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1",CustLedgEntry."Global Dimension 1 Code");
    DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2",CustLedgEntry."Global Dimension 2 Code");
    DtldCustLedgEntry.COPYFILTER("Initial Entry Due Date",CustLedgEntry."Due Date");
    CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date");
    CustLedgEntry.SETRANGE(Open,TRUE);
    PAGE.RUN(0,CustLedgEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    #7..9
    */
    //end;
}

