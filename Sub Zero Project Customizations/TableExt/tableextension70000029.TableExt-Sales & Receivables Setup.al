tableextension 60028 SalRecSetExt extends "Sales & Receivables Setup"
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Prepmt. Auto Update Frequency"(Field 33)".


        //Unsupported feature: Deletion (FieldCollection) on ""Ignore Updated Addresses"(Field 61)".

        field(50000; "Revenue Account"; Code[20])
        {
            Description = 'GSS-STU';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50010; "Discount Account"; Code[20])
        {
            Description = 'GSS-STU';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50020; "Invoice Account"; Code[20])
        {
            Description = 'GSS-STU';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50025; "Revenue Template"; Code[10])
        {
            Description = 'GSS-STU';
            TableRelation = "Gen. Journal Template";
        }
        field(50026; "Revenue Batch"; Code[10])
        {
            Description = 'GSS-STU';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Revenue Template"));
        }
        field(50027; "Invoice Advance Account"; Code[20])
        {
            Description = 'GSS-NAW';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50028; "Income Account"; Code[20])
        {
            Description = 'GSS-NAW';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50029; "Discount Income Account"; Code[20])
        {
            Description = 'GSS-NAW';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50030; "Discount Control Account"; Code[20])
        {
            Description = 'GSS-NAW';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(50031; "Excise - Item Charges"; Code[10])
        {
            TableRelation = "Item Charge"."No.";
        }
    }
}

