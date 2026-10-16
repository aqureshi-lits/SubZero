page 80008 "Storage Condition"
{

    ApplicationArea = All;
    Caption = 'Storage Condition';
    PageType = List;
    SourceTable = "Storage Condition";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Use for Warehouse Rents"; Rec."Use for Warehouse Rents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Use for Warehouse Rents field.';
                }
                field("Rent Pallet/Day"; Rec."Rent Pallet/Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rent Pallet/Day field.';
                }

            }
        }

    }

}
