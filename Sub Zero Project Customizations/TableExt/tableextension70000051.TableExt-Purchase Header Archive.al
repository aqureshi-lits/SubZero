tableextension 60050 PurHeaArchExt extends "Purchase Header Archive"
{
    fields
    {
        field(60000; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

        //Unsupported feature: Property Modification (Data type) on ""Purchaser Code"(Field 43)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Archived By"(Field 5046)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Assigned User ID"(Field 9000)".


        //Unsupported feature: Property Deletion (DataClassification) on "Narration(Field 50000)".

        field(50050; "Vendor Reference Date"; Date)
        {
            Description = 'GSS';
        }
    }
}

