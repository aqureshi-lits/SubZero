page 80029 "Storage Condition_Customer"
{

    ApplicationArea = All;
    Caption = 'Storage Condition Customer';
    PageType = List;
    SourceTable = "Storage Condition_Customer";
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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
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
