tableextension 60013 NotEntExt extends "Notification Entry"
{
    fields
    {

        //Unsupported feature: Property Deletion (DataClassification) on ""Recipient User ID"(Field 4)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Triggered By Record"(Field 5)".


        //Unsupported feature: Property Deletion (DataClassification) on ""Created By"(Field 10)".


        //Unsupported feature: Property Deletion (Editable) on ""Created By"(Field 10)".


        //Unsupported feature: Deletion (FieldCollection) on ""Error Message 2"(Field 15)".


        //Unsupported feature: Deletion (FieldCollection) on ""Error Message 3"(Field 16)".


        //Unsupported feature: Deletion (FieldCollection) on ""Error Message 4"(Field 17)".


        //Unsupported feature: Deletion (FieldCollection) on ""Sender User ID"(Field 18)".

        field(50000; Subject; Text[150])
        {
            Description = 'APP';
        }
    }

    //Unsupported feature: Variable Insertion (Variable: PurchaseHeader) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: SalesHeader) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: GenJnlLine) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: IncomingDocument) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: GenJournalBatch) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: Customer) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: AppEntry) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: RecRef) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: TypeTxt) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: PrefixTxt) (VariableCollection) on "CreateNew(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: GenJnlTemplate) (VariableCollection) on "CreateNew(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "CreateNew(PROCEDURE 1)".

    //procedure CreateNew();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT DataTypeManagement.GetRecordRef(NewRecord,NewRecRef) THEN
      EXIT;

    InsertRec(NewType,NewUserID,NewRecRef.RECORDID,NewLinkTargetPage,NewCustomLink,'');
    NotificationSchedule.ScheduleNotification(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT DataTypeManagement.GetRecordRef(NewRecord,NewRecRef) THEN
      EXIT;
    CLEAR(Rec);
    Type := NewType;
    "Recipient User ID" := NewUserID;
    "Triggered By Record" := NewRecRef.RECORDID;
    "Link Target Page" := NewLinkTargetPage;
    "Custom Link" := NewCustomLink;

    //GSS-ASH
    CompInfo.GET; //ITOS
    CLEAR(TypeTxt);
    CLEAR(PrefixTxt);
    CLEAR(AppEntry);
    //ts-
    NewRecRef.SETTABLE(AppEntry);
    //ts+
    RecRef.GET(AppEntry."Record ID to Approve");
    PrefixTxt := 'APPROVAL REQUIRED';
    TypeTxt := 'requires approval';
    IF AppEntry.Status IN [AppEntry.Status::Approved,AppEntry.Status::"Cancel-Approved"] THEN BEGIN
      PrefixTxt := '';
      TypeTxt := 'has been approved';
    END;
    IF AppEntry.Status = AppEntry.Status::Canceled THEN BEGIN
      PrefixTxt := '';
      TypeTxt := 'approval has been canceled';
    END;
    IF AppEntry.Status = AppEntry.Status::Rejected THEN BEGIN
      PrefixTxt := '';
      TypeTxt := 'approval has been rejected.';
    END;
    IF AppEntry."Information Entry" AND (AppEntry.Status = AppEntry.Status::Open) THEN BEGIN
      PrefixTxt := '';
      TypeTxt := 'requires Information';
    END;
    CASE RecRef.NUMBER OF
    DATABASE::"Purchase Header":
      BEGIN
        RecRef.SETTABLE(PurchaseHeader);
        Subject := STRSUBSTNO(SubjectTxt,PrefixTxt,PurchaseHeader."No.",AppEntry.Amount,TypeTxt,CompInfo.Prefix);
      END;
    DATABASE::"Sales Header":
      BEGIN
        RecRef.SETTABLE(SalesHeader);
        Subject := STRSUBSTNO(SubjectTxt,PrefixTxt,SalesHeader."No.",SalesHeader.Amount,TypeTxt,CompInfo.Prefix);
      END;
    DATABASE::Customer:
      BEGIN
        NewRecRef.SETTABLE(Customer);
        Subject := STRSUBSTNO(SubjectTxtMaster,Customer."No.");
      END;
    DATABASE::"Gen. Journal Batch":
      BEGIN
        RecRef.SETTABLE(GenJournalBatch);
        Subject := STRSUBSTNO(SubjectTxtMaster,GenJournalBatch.Name);
      END;
    DATABASE::"Gen. Journal Line":
      BEGIN
        RecRef.SETTABLE(GenJnlLine);
        CLEAR(GenJnlTemplate);
        IF GenJnlTemplate.GET(GenJnlLine."Journal Template Name") THEN BEGIN
          IF GenJnlTemplate.Type = GenJnlTemplate.Type::Payments THEN BEGIN
          END;
        END;
        Subject := STRSUBSTNO(SubjectTxt,(PrefixTxt + ' ' + FORMAT(GenJnlLine."Payment Type"))+'-',GenJnlLine."Document No.",ABS(GenJnlLine.Amount),TypeTxt,CompInfo.Prefix);
      END;
    DATABASE::"Incoming Document":
      BEGIN
        RecRef.SETTABLE(IncomingDocument);
        Subject := STRSUBSTNO(SubjectTxtMaster,IncomingDocument.Description);
      END;
    END;
    //GSS-ASH

    INSERT(TRUE);

    NotificationSchedule.ScheduleNotification(Rec);
    */
    //end;

    var
        SubjectTxt: Label '%5 ERP NAV - Document %1 - No. %2 of Amount %3 %4.';
        SubjectTxtMaster: Label 'No. %1 requires Approval.';
        CompInfo: Record 79;
}

