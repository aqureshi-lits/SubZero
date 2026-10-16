tableextension 60034 IteAppEntrExt extends "Item Application Entry"
{
    fields
    {

        //Unsupported feature: Property Deletion (DataClassification) on ""Created By User"(Field 26)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Last Modified By User"(Field 28)".

        field(50000; "Completely Updated"; Boolean)
        {
            Description = 'GSS';
        }
    }


    //Unsupported feature: Code Modification on "AppliedInbndTransEntryExists(PROCEDURE 45)".

    //procedure AppliedInbndTransEntryExists();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    SETCURRENTKEY("Inbound Item Entry No.","Item Ledger Entry No.");
    SETRANGE("Inbound Item Entry No.",InbndItemLedgEntryNo);
    IF ISEMPTY THEN
      EXIT(FALSE);

    RESET;
    SETCURRENTKEY("Transferred-from Entry No.","Cost Application");
    SETRANGE("Transferred-from Entry No.",InbndItemLedgEntryNo);
    IF CostApplication THEN
      SETRANGE("Cost Application",TRUE);
    EXIT(FINDSET);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #7..12
    */
    //end;
}

