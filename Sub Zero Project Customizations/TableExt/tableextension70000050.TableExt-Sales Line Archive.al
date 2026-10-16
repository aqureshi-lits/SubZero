tableextension 60049 SaleLinArchExt extends "Sales Line Archive"
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

        //Unsupported feature: Deletion (FieldCollection) on ""VAT Clause Code"(Field 88)".


        //Unsupported feature: Property Deletion (DataClassification) on "Margin(Field 50005)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Margin %"(Field 50010)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".

        field(50110; "Excise Duty Per Unit"; Decimal)
        {
            Description = 'ATOS';
            Editable = false;
        }
        field(50111; "Excise Duty Per Line UOM"; Decimal)
        {
            Description = 'ATOS-EXC1.1';
        }
        field(50120; "Excise Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ATOS-EXC1.2';
            Editable = false;
        }
        field(50121; "Amount Excl. Excise"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ATOS-EXC1.2';
            Editable = false;
        }
    }
}

