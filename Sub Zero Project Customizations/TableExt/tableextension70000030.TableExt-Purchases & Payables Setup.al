tableextension 60029 PurPaySetext extends "Purchases & Payables Setup"
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Prepmt. Auto Update Frequency"(Field 33)".


        //Unsupported feature: Deletion (FieldCollection) on ""Ignore Updated Addresses"(Field 56)".

        field(50000; "Request Nos."; Code[10])
        {
            Caption = 'Request Nos.';
            Description = 'ATOS';
            TableRelation = "No. Series";
        }
    }
}

