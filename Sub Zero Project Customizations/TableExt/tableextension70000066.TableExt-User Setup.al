tableextension 60065 UserSetExt extends "User Setup"
{
    fields
    {
        field(60001; "LIT Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Designation';
        }
        field(60005; "LIT Signature"; BLOB)
        {
            DataClassification = ToBeClassified;
            Description = 'Signature';
            SubType = Bitmap;
            Enabled = true;
        }

        field(60006; "LIT Signature2"; Media)
        {
            DataClassification = ToBeClassified;
            Description = 'Signature2';
            // SubType = Bitmap;
            Enabled = true;
        }

        //Unsupported feature: Property Modification (Data type) on ""Salespers./Purch. Code"(Field 10)".


        //Unsupported feature: Property Deletion (DataClassification) on ""User ID"(Field 1)".


        //Unsupported feature: Deletion on ""Allow Posting From"(Field 2).OnValidate".


        //Unsupported feature: Deletion on ""Allow Posting To"(Field 3).OnValidate".


        //Unsupported feature: Code Modification on ""Salespers./Purch. Code"(Field 10).OnValidate".

        //trigger /Purch()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Salespers./Purch. Code" <> '' THEN BEGIN
          ValidateSalesPersonPurchOnUserSetup(Rec);
          UserSetup.SETCURRENTKEY("Salespers./Purch. Code");
          UserSetup.SETRANGE("Salespers./Purch. Code","Salespers./Purch. Code");
          IF UserSetup.FINDFIRST THEN
            ERROR(Text001,"Salespers./Purch. Code",UserSetup."User ID");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Salespers./Purch. Code" <> '' THEN BEGIN
        #3..7
        */
        //end;

        //Unsupported feature: Property Deletion (DataClassification) on ""Approver ID"(Field 11)".


        //Unsupported feature: Property Deletion (DataClassification) on "Substitute(Field 16)".


        //Unsupported feature: Property Deletion (DataClassification) on "Designation(Field 50001)".


        //Unsupported feature: Property Deletion (DataClassification) on "Signature(Field 50005)".

        field(50010; "Reopen Allowed"; Boolean)
        {
            Description = 'T008201';
        }
        field(50500; "Sign Lease Agreement"; Boolean)
        {
            Description = 'T006180';
        }
        field(50501; "Amend Lease Agreement"; Boolean)
        {
            Description = 'T006180';
        }
        field(50505; "Send Approval"; Boolean)
        {
            Description = 'APP';
        }
        field(50515; "Manual Approval"; Boolean)
        {
            Description = 'APP';
        }
        field(50525; "Manual Approval Authority"; Boolean)
        {
            Description = 'APP';
        }
        field(50531; "Hide Cost"; Boolean)
        {
            Description = 'TS151020';
        }
        field(50651; "Salesperson Filter"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
        }
        field(50701; "Batch - User Filter"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
        }
        field(50705; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(50901; "Collection Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
            TableRelation = "Payment Method";
        }
        field(50999; "Allow WORKDATE Change"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'ITOS';
        }
    }
}

