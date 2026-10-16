tableextension 80002 Customer extends "Customer"

{
    fields
    {
        field(80001; "Customer CBM"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer CBM';
        }

        field(80080; "WMS Billing Type"; Enum "WMS Billing Type")
        {
            Caption = 'Billing Type';
            DataClassification = CustomerContent;
        }
        field(80081; "WMS Allocated Pallets"; Decimal)
        {
            Caption = 'Allocated Pallets';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(80082; "WMS Minimum Storage Days"; Integer)
        {
            Caption = 'Minimum Storage Days';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        // field(80083; "WMS Storage Rate"; Decimal)
        // {
        //     Caption = 'Storage Rate';
        //     DataClassification = CustomerContent;
        //     DecimalPlaces = 0 : 5;
        //     MinValue = 0;
        // }
        field(80084; "WMS Fixed Monthly Charge"; Decimal)
        {
            Caption = 'Fixed Monthly Charge';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(80085; "WMS Management Fee"; Decimal)
        {
            Caption = 'Management Fee';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
    }


    trigger OnAfterInsert()
    var
        CustName: Text[50];
        myInt: Integer;
    begin


    end;

    trigger OnAfterModify()
    var
        CustName: Text[50];
        myInt: Integer;
    begin

    end;

    var
        UserSetup: Record 91;
        DimensionValue: Record 349;
        DefaultDim: Record 352;
        SalesSetup: Record 311;

}