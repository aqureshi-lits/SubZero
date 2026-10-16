pageextension 80008 ItemCard extends "Item Card"
{
    layout
    {
        addafter("VAT Bus. Posting Gr. (Price)")
        {
            field("Rent Pallet/Day"; Rec."Rent Pallet/Day")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the rent per day to be charged for each pallet of this item stored in the warehouse. Only applicable for inventory items.';
            }
            field("Customer Code"; Rec."Customer Code")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the customer to whom this item belongs. It is used to calculate the warehouse rents for specified customer. Only applicable for inventory items.';
            }
        }

        addafter("Item Category Code")
        {
            field("Storage Condition Code"; Rec."Storage Condition Code")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Storage Condition Code that the item belongs to. Storage Condition Code also contain any assigned item attributes.';
            }

            field("Base UOM Per Pallet"; Rec."Base UOM Per Pallet")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }


}