tableextension 60001 SalShipLinExt extends "Sales Shipment Line"
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

        //Unsupported feature: Deletion (FieldCollection) on ""IC Partner Ref. Type"(Field 107)".


        //Unsupported feature: Deletion (FieldCollection) on ""IC Partner Reference"(Field 108)".


        //Unsupported feature: Property Deletion (DataClassification) on "Margin(Field 50005)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Margin %"(Field 50010)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50100)".
    }
}

