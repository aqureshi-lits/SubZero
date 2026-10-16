tableextension 60007 PurRcpLinExt extends "Purch. Rcpt. Line"
{
    fields
    {
        field(60100; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""IC Partner Ref. Type"(Field 107)".


        //Unsupported feature: Deletion (FieldCollection) on ""IC Partner Reference"(Field 108)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".

        // field(50101; "Excise Unit Cost"; Decimal)
        // {
        //     Description = 'EXC - Excise';
        // }
        // field(50103; "Excise Total Cost"; Decimal)
        // {
        //     Description = 'EXC - Excise';
        // }
        // field(50201; "Purch. Order Status"; Option)
        // {
        //     FieldClass = FlowField;

        //     CalcFormula = Lookup("Purchase Header".Status WHERE("Document Type" = CONST(Order),
        //                                                         "No." = FIELD("Document No.")
        //         )
        //     );
        //     Caption = 'Purch. Order Status';
        //     Description = 'POBGT1.0';
        //     Editable = false;

        //     OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
        //     OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        // }
        // field(50202; "Over Budget"; Boolean)
        // {
        //     Description = 'POBGT1.1';
        // }
    }


    //Unsupported feature: Code Modification on "InsertInvLineFromRcptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRcptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETRANGE("Document No.","Document No.");

    TempPurchLine := PurchLine;
    #4..26
      ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

      IF PurchOrderLine.GET(
           PurchOrderLine."Document Type"::Order,"Order No.","Order Line No.") AND
         NOT ExtTextLine
      THEN BEGIN
        IF (PurchOrderHeader."Document Type" <> PurchOrderLine."Document Type"::Order) OR
           (PurchOrderHeader."No." <> PurchOrderLine."Document No.")
    #35..137
      IF "Attached to Line No." = 0 THEN
        SETRANGE("Attached to Line No.","Line No.");
    UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
           PurchOrderLine."Document Type"::Order,"Order No.","Order Line No.")
    #32..140
    */
    //end;
}

