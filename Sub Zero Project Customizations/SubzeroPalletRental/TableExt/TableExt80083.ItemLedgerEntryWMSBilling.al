tableextension 80083 "Item Ledg. Entry WMS Billing" extends "Item Ledger Entry"
{
    fields
    {

        field(80001; "WMS Over time"; Decimal) { Caption = 'WMS Over time'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
        field(80002; "WMS Plug In"; Decimal) { Caption = 'WMS Plug In'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
        field(80003; "WMS DM Inspection"; Decimal) { Caption = 'WMS DM Inspection'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }

        field(80004; "WMS Management Fee"; Decimal) { Caption = 'WMS Management Fee'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
        field(80005; "WMS Purchase Order No."; Code[20]) { Caption = 'WMS Purchase Order No.'; DataClassification = CustomerContent; }
        field(80006; "WMS Purchase Receipt No."; Code[20]) { Caption = 'WMS Purchase Receipt No.'; DataClassification = CustomerContent; }
        field(80007; "Container Type"; Enum containerType)
        {
            Caption = 'Container Type';
            DataClassification = CustomerContent;
        }
    }
}
