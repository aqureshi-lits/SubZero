pageextension 80078 ItemList extends "Item List"
{
    layout
    {
        addafter("Base Unit of Measure")
        {

            field("Customer Code"; Rec."Customer Code")
            {
                ApplicationArea = all;
            }

            field("Storage Condition Code"; Rec."Storage Condition Code")
            {
                ApplicationArea = all;
            }

            field("Base UOM Per Pallet"; Rec."Base UOM Per Pallet")
            {
                ApplicationArea = all;
            }
        }
    }
}
