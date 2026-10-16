tableextension 60032 ResEntrExt extends "Reservation Entry"
{
    fields
    {

        //Unsupported feature: Property Deletion (DataClassification) on ""Created By"(Field 25)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Changed By"(Field 27)".


        //Unsupported feature: Deletion (FieldCollection) on ""Untracked Surplus"(Field 6511)".

        field(50900; "Manufacturing Date"; Date)
        {
            Description = 'GSS';
            Editable = false;
        }
        field(50901; "New Manufacturing Date"; Date)
        {
            Description = 'GSS';
            Editable = false;
        }
    }
}

