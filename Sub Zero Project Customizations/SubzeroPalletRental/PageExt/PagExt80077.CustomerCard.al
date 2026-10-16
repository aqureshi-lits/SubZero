pageextension 80077 "Pallet Customer Card" extends "Customer Card"
{
    // MERGED, self-contained Customer Card extension (formerly v1 pageextension 80077).
    // The method here is a DEFAULT for prefilling Purchase Orders; the authoritative
    // scenario is stamped per pallet at receiving.
    layout
    {
        addbefore(Blocked)
        {
            field("Customer CBM"; Rec."Customer CBM")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Legacy CBM value (retained for reference). Not used by the physical-pallet model.';
            }
        }
        addlast(General)
        {
            group("Pallet Rental")
            {
                Caption = 'Pallet Rental';

                field("WMS Billing Type"; Rec."WMS Billing Type")
                {
                    ApplicationArea = all;
                }

                field("WMS Allocated Pallets"; Rec."WMS Allocated Pallets")
                {
                    ApplicationArea = all;
                    Enabled = Rec."WMS Billing Type" = Rec."WMS Billing Type"::"Fixed Location";
                }

                field("WMS Fixed Monthly Charge"; Rec."WMS Fixed Monthly Charge")
                {
                    ApplicationArea = all;
                    Enabled = Rec."WMS Billing Type" = Rec."WMS Billing Type"::"Fixed Location";
                }
                field("WMS Minimum Storage Days"; Rec."WMS Minimum Storage Days")
                {
                    ApplicationArea = all;
                    Enabled = Rec."WMS Billing Type" = Rec."WMS Billing Type"::"Fixed Days";
                }

                field("WMS Management Fee"; Rec."WMS Management Fee")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        addlast(Navigation)
        {
            action("Storage Rates")
            {
                ApplicationArea = All;
                Caption = 'Storage Rates';
                Image = PriceAdjustment;
                runObject = page "Storage Condition_Customer";
                RunPageLink = "Customer No." = field("No.");
            }

            action("Charges")
            {
                ApplicationArea = All;
                Caption = 'Customer Charges';
                Image = PriceAdjustment;
                RunObject = page "Charges";
                RunPageLink = "Customer No." = field("No.");
            }

        }

        addafter("Report Statement_Promoted")
        {
            Group("Pallet Rental1")
            {
                Caption = 'Pallet Rental';
                actionref("StorageRates"; "Storage Rates") { }
                actionref("Charges1"; "Charges") { }
            }
        }
    }
}
