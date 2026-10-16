page 80009 "Charges"
{

    ApplicationArea = All;
    Caption = 'Charges';
    PageType = List;
    SourceTable = "Charges";
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
                field("Customer no."; Rec."Customer no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer no. field.';
                }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }

            }
        }

    }

}
