pageextension 90909 translineext extends "Transfer Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Return Code"; Rec."Return Code")
            {
                ApplicationArea = all;
            }
            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = all;
            }
            field("Product Price"; Rec."Product Price")
            {
                ApplicationArea = all;
            }
            field("Standard KG"; Rec."Standard KG")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("disc. Unit Price"; Rec."disc. Unit Price")
            {
                Caption = 'Disc. Unit Price';
                ApplicationArea = all;
                Editable = false;
            }
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
            begin
                GetStandKG();
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    local procedure GetStandKG(): Decimal
    var
        ItemR: Record Item;
    begin
        if ItemR.Get(Rec."Item No.") then begin
            Rec."Standard KG" := ItemR."Standard KG";
            Rec.Modify();
        end;
    end;

    var
        myInt: Integer;
}