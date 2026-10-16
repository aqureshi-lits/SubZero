tableextension 60044 AppCommLinExt extends "Approval Comment Line"
{
    fields
    {

        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 5)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Record ID to Approve"(Field 8)".

    }

    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
    /*
    //GSS-ASH
    IF USERID <> "User ID" THEN
      ERROR('This comment can only be Modified by User',"User ID");
    //GSS-ASH
    */
    //end;
}

