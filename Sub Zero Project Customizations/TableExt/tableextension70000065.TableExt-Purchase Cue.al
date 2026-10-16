tableextension 60064 PurCueExt extends "Purchase Cue"
{
    fields
    {
        field(50011; "Requests for Approval"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Approval Entry" WHERE(Status = CONST(Open),
                                                        "Information Entry" = CONST(false),
                                                        "Approver ID" = FIELD(FILTER("User Filter"))));

        }
        field(50051; "User Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
    }


    //Unsupported feature: Code Modification on "CountOrders(PROCEDURE 5)".

    //procedure CountOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE FieldNumber OF
      FIELDNO("Outstanding Purchase Orders"):
        BEGIN
          CountPurchOrders.SETRANGE(Status,CountPurchOrders.Status::Released);
          CountPurchOrders.SETRANGE(Completely_Received,FALSE);
        END;
      FIELDNO("Not Invoiced"):
        BEGIN
          CountPurchOrders.SETRANGE(Completely_Received,TRUE);
          CountPurchOrders.SETRANGE(Partially_Invoiced,FALSE);
        END;
      FIELDNO("Partially Invoiced"):
        BEGIN
          CountPurchOrders.SETRANGE(Completely_Received,TRUE);
          CountPurchOrders.SETRANGE(Partially_Invoiced,TRUE);
        END;
    END;
    FILTERGROUP(2);
    CountPurchOrders.SETFILTER(Responsibility_Center,GETFILTER("Responsibility Center Filter"));
    FILTERGROUP(0);

    CountPurchOrders.OPEN;
    CountPurchOrders.READ;
    Result := CountPurchOrders.Count_Orders;

    EXIT(Result);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
          CountPurchOrders.SETRANGE(Invoice);
    #6..8
          CountPurchOrders.SETRANGE(Status);
          CountPurchOrders.SETRANGE(Completely_Received,TRUE);
          CountPurchOrders.SETRANGE(Invoice,FALSE);
    #11..13
          CountPurchOrders.SETRANGE(Status);
          CountPurchOrders.SETRANGE(Completely_Received,TRUE);
          CountPurchOrders.SETRANGE(Invoice,TRUE);
    #16..20
    CountPurchOrders.OPEN;
    CountPurchOrders.READ;
    EXIT(CountPurchOrders.Count_Orders);
    */
    //end;


    //Unsupported feature: Code Modification on "ShowOrders(PROCEDURE 2)".

    //procedure ShowOrders();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchHeader.SETRANGE("Document Type",PurchHeader."Document Type"::Order);
    CASE FieldNumber OF
      FIELDNO("Outstanding Purchase Orders"):
    #4..21
    FILTERGROUP(2);
    PurchHeader.SETFILTER("Responsibility Center",GETFILTER("Responsibility Center Filter"));
    FILTERGROUP(0);

    PAGE.RUN(PAGE::"Purchase Order List",PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24
    PAGE.RUN(PAGE::"Purchase Order List",PurchHeader);
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CountOrders(PROCEDURE 5).Result(Variable 1002)".

}

