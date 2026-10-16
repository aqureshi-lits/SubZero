// table 80007 "Daily Rental Stock Detail"
// {
//     Caption = 'Daily Rental Stock Detail - Customer';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Posting Date"; Date)
//         {
//             Caption = 'Posting Date';
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Customer Code"; Code[20])
//         {
//             Caption = 'Customer Code';
//             DataClassification = ToBeClassified;
//             TableRelation = Customer;
//             Editable = false;
//         }
//         field(3; "Storage Condition"; Code[20])
//         {
//             Caption = 'Storage Condition';
//             DataClassification = ToBeClassified;
//             Editable = false;
//             TableRelation = "Storage Condition";
//         }
//         field(4; "Per Day Rate"; Decimal)
//         {
//             Caption = 'Per Day Rate';
//             DataClassification = ToBeClassified;
//         }
//         field(5; "Item Code"; Code[20])
//         {
//             Caption = 'Item Code';
//             DataClassification = ToBeClassified;
//             Editable = false;
//             TableRelation = Item;

//         }
//         field(6; "Goods In (UOM)"; Decimal)
//         {
//             Caption = 'Goods In (UOM)';
//             DataClassification = ToBeClassified;
//         }
//         field(7; "Goods Out (UOM)"; Decimal)
//         {
//             Caption = 'Goods Out (UOM)';
//             DataClassification = ToBeClassified;
//         }
//         field(8; "Same Day In-Out (UOM)"; Decimal)
//         {
//             Caption = 'Same Day In-Out (UOM)';
//             DataClassification = ToBeClassified;
//         }
//         field(9; "Goods In (Actual-Pallet)"; Decimal)
//         {
//             Caption = 'Goods In (Actual-Pallet)';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }
//         field(10; "Goods In (Round-Pallet)"; Decimal)
//         {
//             Caption = 'Goods In (Round-Pallet)';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }
//         field(11; "Goods Out (Actual-Pallet)"; Decimal)
//         {
//             Caption = 'Goods Out (Actual-Pallet)';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }
//         field(12; "Goods Out (Round-Pallet)"; Decimal)
//         {
//             Caption = 'Goods Out (Round-Pallet)';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }
//         field(13; "Same Day In-Out (Act.-Pallet)"; Decimal)
//         {
//             Caption = 'Same Day In-Out (Actual-Pallet)';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }
//         field(14; "Same Day In-Out (Round-Pallet)"; Decimal)
//         {
//             Caption = 'Same Day In-Out (Round-Pallet)';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }
//         field(15; "Item Name"; Text[100])
//         {
//             Caption = 'Item Name';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(16; "Customer Name"; Text[100])
//         {
//             Caption = 'Customer Name';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }


//         field(17; "WMS Total Occupancy Pallets"; Decimal)
//         {
//             Caption = 'WMS Total Occupancy Pallets';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }

//         field(18; "WMS Balance Pallets"; Decimal)
//         {
//             Caption = 'WMS Balance Pallets';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }

//         field(19; "WMS Chargeable Pallets"; Decimal)
//         {
//             Caption = 'WMS Chargeable Pallets';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 1 : 4;
//         }


//         field(80080; "WMS Billing Type"; Enum "WMS Billing Type") { Caption = 'Billing Type'; DataClassification = CustomerContent; }
//         field(80081; "WMS Allocated Pallets"; Decimal) { Caption = 'Allocated Pallets'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
//         field(80082; "WMS Minimum Storage Days"; Integer) { Caption = 'Minimum Storage Days'; DataClassification = CustomerContent; }
//         // field(80083; "WMS Storage Rate"; Decimal) { Caption = 'Storage Rate'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
//         field(80084; "WMS Fixed Monthly Charge"; Decimal) { Caption = 'Fixed Monthly Charge'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
//         field(80085; "WMS Management Fee"; Decimal) { Caption = 'Management Fee'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
//         field(80086; "WMS Additional Charge"; Decimal) { Caption = 'Additional Storage Charge'; DataClassification = CustomerContent; DecimalPlaces = 0 : 5; }
//         field(80087; "WMS Purchase Order No."; Code[20]) { Caption = 'Purchase Order No.'; DataClassification = CustomerContent; }

//         field(80088; "Total Charges"; Decimal) { Caption = 'Total Charges'; DataClassification = CustomerContent; }

//         Field(80089; "Over Time"; Decimal)
//         {
//             Caption = 'Over Time';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 0 : 2;
//         }

//         Field(80090; "Plug In"; Decimal)
//         {
//             Caption = 'Plug In';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 0 : 2;
//         }

//         Field(80091; "DM Inspection"; Decimal)
//         {
//             Caption = 'DM Inspection';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 0 : 2;
//         }

//         Field(80092; "Handling Charges"; Decimal)
//         {
//             Caption = 'Handling Charges';
//             DataClassification = ToBeClassified;
//             DecimalPlaces = 0 : 2;
//         }

//     }
//     keys
//     {
//         key(PK; "Posting Date", "Customer Code", "Storage Condition", "Per Day Rate", "Item Code")
//         {
//             Clustered = true;
//         }
//     }
// }
