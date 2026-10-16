tableextension 60025 ItemExt extends Item
{
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on ""Planning Transfer Ship. (Qty)."(Field 5449)".


        //Unsupported feature: Code Modification on ""Price Includes VAT"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Price Includes VAT" THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("VAT Bus. Posting Gr. (Price)");
          "VAT Bus. Posting Gr. (Price)" := SalesSetup."VAT Bus. Posting Gr. (Price)";
          VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)","VAT Prod. Posting Group");
        END;
        VALIDATE("Price/Profit Calculation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Price Includes VAT" THEN BEGIN
          SalesSetup.GET;
          IF SalesSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN
            "VAT Bus. Posting Gr. (Price)" := SalesSetup."VAT Bus. Posting Gr. (Price)";
        #5..7
        */
        //end;

        //Unsupported feature: Property Deletion (DataClassification) on ""Application Wksh. User ID"(Field 521)".

        // field(50001; "Excise Amount"; Decimal)
        // {
        //     DecimalPlaces = 2 : 5;
        //     Description = 'GSS-NAW';
        // }
    }


    //Unsupported feature: Code Modification on "TryGetItemNoOpenCard(PROCEDURE 43)".

    //procedure TryGetItemNoOpenCard();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReturnValue := COPYSTR(ItemText,1,MAXSTRLEN(ReturnValue));
    IF ItemText = '' THEN
      EXIT(DefaultCreate);
    #4..31
    IF NOT GUIALLOWED THEN
      ERROR(SelectItemErr);

    IF FoundRecordCount > 0 THEN BEGIN
      ItemWithoutQuote := CONVERTSTR(ItemText,'''','?');
      ItemFilterContains := '''@*' + ItemWithoutQuote + '*''';
      Item.FILTERGROUP(-1);
      Item.SETFILTER("No.",ItemFilterContains);
      Item.SETFILTER(Description,ItemFilterContains);
      Item.SETFILTER("Base Unit of Measure",ItemFilterContains);
    END;

    IF ShowItemCard THEN
      ItemNo := PickItem(Item)
    #46..55
    IF NOT DefaultCreate THEN
      EXIT(FALSE);
    ERROR(SelectItemErr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..34
    ItemWithoutQuote := CONVERTSTR(ItemText,'''','?');
    ItemFilterContains := '''@*' + ItemWithoutQuote + '*''';
    Item.FILTERGROUP(-1);
    Item.SETFILTER("No.",ItemFilterContains);
    Item.SETFILTER(Description,ItemFilterContains);
    Item.SETFILTER("Base Unit of Measure",ItemFilterContains);
    #43..58
    */
    //end;


    //Unsupported feature: Code Modification on "PickItem(PROCEDURE 51)".

    //procedure PickItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Item.FILTERGROUP = -1 THEN
      ItemList.SetTempFilteredItemRec(Item);

    IF Item.FINDFIRST THEN;
    ItemList.SETTABLEVIEW(Item);
    ItemList.SETRECORD(Item);
    ItemList.LOOKUPMODE := TRUE;
    #8..10
      CLEAR(Item);

    EXIT(Item."No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Item.FINDSET THEN
      REPEAT
        Item.MARK(TRUE);
      UNTIL Item.NEXT = 0;
    IF Item.FINDFIRST THEN;
    Item.MARKEDONLY := TRUE;

    #5..13
    */
    //end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".

}

