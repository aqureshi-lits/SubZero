tableextension 60043 ApprEntrExt extends "Approval Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Salespers./Purch. Code"(Field 7)".

        modify(Status)
        {
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved,Information,Cancel-Approved';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 9)".

            Description = 'APP - Added option Information';
        }

        //Unsupported feature: Property Deletion (DataClassification) on ""Approver ID"(Field 8)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Last Modified By User ID"(Field 12)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Record ID to Approve"(Field 22)".

        field(50000; "Information Entry"; Boolean)
        {
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Approver ID,Status,Due Date,Date-Time Sent for Approval"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Table ID,Document Type,Document No.,Date-Time Sent for Approval"(Key)".

        key(Key1; "Information Entry")
        //key(Key1; "Approver ID", Status)
        {
        }
        //key(Key2; "Document No.", "Last Date-Time Modified")
        //#Arham 18/11/2025
    }


    //Unsupported feature: Code Modification on "MarkAllWhereUserisApproverOrSender(PROCEDURE 9)".

    //procedure MarkAllWhereUserisApproverOrSender();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserSetup.GET(USERID) AND UserSetup."Approval Administrator" THEN
      EXIT;
    FILTERGROUP(-1); // Used to support the cross-column search
    #4..7
        MARK(TRUE);
      UNTIL NEXT = 0;
    MARKEDONLY(TRUE);
    FILTERGROUP(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //GSS
    EXIT;
    //GSS
    #1..10
    */
    //end;
}

