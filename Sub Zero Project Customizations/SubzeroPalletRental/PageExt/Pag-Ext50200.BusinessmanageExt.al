pageextension 50200 BusinessmanageExt extends "Business Manager Role Center"
{
    actions

    {
        addfirst(sections)
        {
            group("Pallet Rental Management")
            {
                Caption = 'Pallet Rental Management';
                action("Item List")
                {
                    ApplicationArea = All;
                    Caption = 'Item List';
                    Image = Setup;
                    RunObject = page "Item List";
                }
                action("Storage Condition")
                {
                    ApplicationArea = All;
                    Caption = 'Storage Condition';
                    Image = List;
                    RunObject = page "Storage Condition";
                }
                action(Charges)
                {
                    ApplicationArea = All;
                    Caption = 'Charges';
                    Image = List;
                    RunObject = page "Charges";
                }
                action("Daily Rental Stock Detail List")
                {
                    ApplicationArea = All;
                    Caption = 'Daily Rental Stock Detail List';
                    Image = List;
                    RunObject = page "Daily Rental Stock Detail List";
                }

                action("Customer list")
                {
                    ApplicationArea = All;
                    Caption = 'Customer list';
                    Image = List;
                    RunObject = page "Customer list";
                }




                action("Sales Order1")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    Image = List;
                    RunObject = page "Sales Orders";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    Image = List;
                    RunObject = page "Posted Purchase Invoices";
                }



                action("Storage Condition_Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Storage Condition_Customer';
                    Image = Setup;
                    RunObject = page "Storage Condition_Customer";
                }

            }
        }
    }
}
