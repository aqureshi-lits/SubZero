tableextension 60045 PosAppEntExt extends "Posted Approval Entry"
{
    fields
    {
        modify(Status)
        {
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved,Information,Cancel-Approved';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 9)".

        }

        //Unsupported feature: Property Deletion (DataClassification) on ""Approver ID"(Field 8)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Posted Record ID"(Field 22)".

    }
}

