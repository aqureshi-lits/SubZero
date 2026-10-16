pageextension 80080 PurchOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field(BaseUOMPerPallet; BaseUOMPerPallet)
            {
                ApplicationArea = All;
                Caption = 'Base UOM/Pallet';
                DecimalPlaces = 0 : 5;
                Editable = false;
            }

            field(PalletConsumed; PalletConsumed)
            {
                ApplicationArea = All;
                Caption = 'Pallets Consumed';
                DecimalPlaces = 0 : 0;
                Editable = false;
                ToolTip = 'Specifies the number of pallets required based on the quantity in base unit of measure.';
            }
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                CalculatePalletValues();
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CalculatePalletValues();
            end;
        }

        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                CalculatePalletValues();
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalculatePalletValues();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(BaseUOMPerPallet);
        Clear(PalletConsumed);
    end;

    var
        BaseUOMPerPallet: Decimal;
        PalletConsumed: Decimal;

    local procedure CalculatePalletValues()
    var
        Item: Record Item;
    begin
        Clear(BaseUOMPerPallet);
        Clear(PalletConsumed);

        if Rec.Type <> Rec.Type::Item then
            exit;

        if Rec."No." = '' then
            exit;

        if not Item.Get(Rec."No.") then
            exit;

        BaseUOMPerPallet := Item."Base UOM Per Pallet";

        if BaseUOMPerPallet = 0 then
            exit;

        PalletConsumed :=
            Round(
                Rec."Quantity (Base)" / BaseUOMPerPallet,
                1,
                '>');
    end;
}