tableextension 60015 GLEntrExt extends "G/L Entry"
{
    fields
    {
        field(60001; "LIT Narration"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60100; "LIT Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60101; "LIT Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(60600; "LIT Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
            OptionCaption = 'Cheque,Bank Transfer,Bank Charges,Credit Card';
            OptionMembers = Cheque,"Bank Transfer","Bank Charges","Credit Card";
        }
        field(60999; "LIT Pre-Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(61001; "LIT Source Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }
        field(61002; "LIT Paid To"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'LITS';
        }

    }
    keys
    {
        // key(Key1; "Lease Agreement No.", "Lease Agreement Charge Type", "Lease Agreement Charge No.", "G/L Account No.", "Posting Date")
        // {
        //     SumIndexFields = Amount;
        // }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    #4..26
    "User ID" := USERID;
    "No. Series" := GenJnlLine."Posting No. Series";
    "IC Partner Code" := GenJnlLine."IC Partner Code";

    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
    //GSS
    "Pre-Document No." := GenJnlLine."Document No.";
    //GSS
    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
}

