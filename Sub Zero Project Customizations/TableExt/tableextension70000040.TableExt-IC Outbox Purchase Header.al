tableextension 60039 ICOutPurHeadExt extends "IC Outbox Purchase Header"
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Ship-to County"(Field 92)".


        //Unsupported feature: Deletion (FieldCollection) on ""Ship-to Country/Region Code"(Field 93)".

        field(50000; Narration; Text[250])
        {
            Description = 'ASH';
        }
    }
}

