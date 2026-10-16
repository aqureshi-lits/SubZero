tableextension 80006 Item extends "Item"

{

    fields
    {


        field(80001; "Rent Pallet/Day"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Pallet/Day';
            trigger OnValidate()
            begin
                TestField(Type, Type::Inventory);
            end;
        }

        field(80002; "Customer Code"; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField(Type, Type::Inventory);
            end;
        }

        field(80003; "Storage Condition Code"; Code[20])
        {
            TableRelation = "Storage Condition".Code;
            Caption = 'Storage Condition Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                StorageCondition: Record "Storage Condition";
            begin
                if Type = Type::Inventory then
                    if StorageCondition.Get(Rec."Storage Condition Code") then
                        "Rent Pallet/Day" := StorageCondition."Rent Pallet/Day";
            end;
        }
        field(80004; "Last Puchase Date"; Date)
        {
            CalcFormula = max("Item Ledger Entry"."Posting Date" WHERE("Item No." = FIELD("No."),
                                                                  "Entry Type" = filter(Purchase),
                                                                  "Document Type" = filter("Purchase Receipt")));
            Caption = 'Last Puchase Receipt Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80005; "Purchase Exist"; Boolean)
        {
            CalcFormula = Exist("Item Ledger Entry" WHERE("Item No." = FIELD("No."),
                                                                  "Entry Type" = filter(Purchase | "Positive Adjmt."),
                                                                  "Document Type" = filter("Purchase Receipt" | '')));
            Caption = 'Purchase Exist';
            Editable = false;
            FieldClass = FlowField;
        }

        field(80006; "Base UOM Per Pallet"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Base UOM Per Pallet';
            trigger OnValidate()
            begin
            end;
        }

        modify("Item Category Code")
        {
            trigger OnAfterValidate()
            var
                ItemCategory: Record "Item Category";
                StorageCondition: Record "Storage Condition";
            begin
                if Type = Type::Inventory then
                    if StorageCondition.Get(Rec."Storage Condition Code") then
                        "Rent Pallet/Day" := StorageCondition."Rent Pallet/Day";
            end;
        }
    }
    keys
    {
        key(Key5000; "Rent Pallet/Day")
        {

        }
    }
    fieldgroups
    {
        addlast(DropDown; Inventory, "No. 2")
        {

        }
    }


    trigger OnAfterInsert()
    var
    begin



    end;

    trigger OnAfterModify()
    var

    begin

    end;

    var
        UserSetup: Record 91;
        DimensionValue: Record 349;
        DefaultDim: Record 352;
        InvSetup: Record 313;



}