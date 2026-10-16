tableextension 60060 CompaInfoExt extends "Company Information"
{
    fields
    {

        //Unsupported feature: Deletion on "City(Field 6).OnLookup".


        //Unsupported feature: Deletion on ""Post Code"(Field 30).OnLookup".


        //Unsupported feature: Deletion on ""Country/Region Code"(Field 36).OnValidate".


        //Unsupported feature: Deletion (FieldCollection) on ""EORI Number"(Field 92)".


        //Unsupported feature: Deletion (FieldCollection) on ""Use GLN in Electronic Document"(Field 95)".


        //Unsupported feature: Deletion (FieldCollection) on ""Intrastat Contact Type"(Field 101)".


        //Unsupported feature: Deletion (FieldCollection) on ""Intrastat Contact No."(Field 102)".


        //Unsupported feature: Property Deletion (DataClassification) on "Stamp(Field 50001)".

        field(50002; "Excise TRN No."; Text[30])
        {
            Description = 'EXC';
        }
        field(50010; Nursery; Boolean)
        {
            Description = 'ATOS Kent Nursery';
        }
        field(50101; Prefix; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
        }
        field(60501; "Accounts E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
        }
        field(60502; "LIT Stamp"; Blob)
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
        }
    }
}

