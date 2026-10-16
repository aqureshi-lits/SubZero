tableextension 60059 SalLinDisExt extends "Sales Line Discount"
{
    fields
    {

        //Unsupported feature: Property Insertion (DecimalPlaces) on ""Line Discount %"(Field 5)".

        field(50001; "Line Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'ITOS';
        }
    }
}

