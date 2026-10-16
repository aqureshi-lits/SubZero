page 80012 "Daily Rental Stock Detail List"
{
    ApplicationArea = All;
    Caption = 'Daily Rental Stock Detail - Customer';
    PageType = List;
    SourceTable = "Daily Rental Stock Detail";
    UsageCategory = Lists;
    SourceTableView = sorting("Storage Condition", "Item Code") order(ascending);
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Code field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }

                field("Storage Condition"; Rec."Storage Condition")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Storage Condition field.';
                }

                field("WMS Billing Type"; Rec."WMS Billing Type")
                {
                    ApplicationArea = all;
                }


                field("Per Day Rate"; Rec."Per Day Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Per Day Rate field.';
                }

                // field("Item Code"; Rec."Item Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Item Code field.';
                // }
                // field("Item Name"; Rec."Item Name")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Item Name field.';
                // }

                field("Goods In (UOM)"; Rec."Goods In (UOM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Goods In (UOM) field.';
                }
                field("Goods Out (UOM)"; Rec."Goods Out (UOM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Goods Out (UOM) field.';
                }
                field("Same Day In-Out (UOM)"; Rec."Same Day In-Out (UOM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Day In-Out (UOM) field.';
                }
                field("Goods In (Actual-Pallet)"; Rec."Goods In (Actual-Pallet)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Goods In (Pallet) field.';
                }
                field("Goods In (Round-Pallet)"; Rec."Goods In (Round-Pallet)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Goods In (Round-Pallet) field.';
                }
                field("Goods Out (Actual-Pallet)"; Rec."Goods Out (Actual-Pallet)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Goods Out (Actual-Pallet) field.';
                }
                field("Goods Out (Round-Pallet)"; Rec."Goods Out (Round-Pallet)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Goods Out (Round-Pallet) field.';
                }
                field("Same Day In-Out (Act.-Pallet)"; Rec."Same Day In-Out (Act.-Pallet)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Day In-Out (Actual-Pallet) field.';
                }
                field("Same Day In-Out (Round-Pallet)"; Rec."Same Day In-Out (Round-Pallet)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Same Day In-Out (Round-Pallet) field.';
                }

                field("WMS Additional Charge"; Rec."WMS Additional Charge")
                {
                    ApplicationArea = all;
                }

                field("WMS Allocated Pallets"; Rec."WMS Allocated Pallets")
                {
                    ApplicationArea = all;
                }

                field("WMS Total Occupancy Pallets"; Rec."WMS Total Occupancy Pallets")
                {
                    ApplicationArea = all;
                }


                field("WMS Balance Pallets"; Rec."WMS Balance Pallets")
                {
                    ApplicationArea = all;
                }

                field("WMS Chargeable Pallets"; Rec."WMS Chargeable Pallets")
                {
                    ApplicationArea = all;
                }

                field("WMS Fixed Monthly Charge"; Rec."WMS Fixed Monthly Charge")
                {
                    ApplicationArea = all;
                }

                field("Over Time"; Rec."Over Time")
                {
                    ApplicationArea = all;
                }

                field("Plug In"; Rec."Plug In")
                {
                    ApplicationArea = all;
                }

                field("DM Inspection"; Rec."DM Inspection")
                {
                    ApplicationArea = all;
                }

                field("Handling Charges"; Rec."Handling Charges")
                {
                    ApplicationArea = all;
                }

                field("WMS Management Fee"; Rec."WMS Management Fee")
                {
                    ApplicationArea = all;
                }

                field("WMS Minimum Storage Days"; Rec."WMS Minimum Storage Days")
                {
                    ApplicationArea = all;
                }

                // field("WMS Purchase Order No."; Rec."WMS Purchase Order No.")
                // {
                //     ApplicationArea = all;
                // }

                field("GRN No.'s"; Rec."GRN No.'s")
                {
                    applicationArea = all;
                }

                field("GDN No.'s"; Rec."GDN No.'s")
                {
                    applicationArea = all;
                }

                field("Total Charges"; Rec."Total Charges")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Stock Pallet Count Detail")
            {
                ApplicationArea = all;
                Caption = 'Stock Pallet Count Detail';
                Image = Inventory;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Report "Stock Pallet Count Detail";
                ToolTip = 'Print the detail daily stock count in pallets.';
            }

            action("WMS Rental Accounting Detail")
            {
                ApplicationArea = all;
                Caption = 'WMS Rental Accounting Detail';
                Image = Inventory;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Report "WMS Rental Accounting Detail";
                ToolTip = 'Print the WMS rental accounting detail report.';
            }
            action("WMS Rental Accounting Summary")
            {
                ApplicationArea = all;
                Caption = 'WMS Rental Accounting Summary';
                Image = Inventory;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Report "WMS Rental Accounting Summary";
                ToolTip = 'Print the WMS rental accounting Summary report.';
            }

            action("Calculate Rental Stock Counts Detail")
            {
                ApplicationArea = all;
                Caption = 'Calculate Rental Stock Counts Detail';
                Image = Inventory;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Report "Calc.RentalStockCountsDetail";
                ToolTip = 'Print the Calculate Rental Stock Counts Detail.';
            }
        }
    }
}
