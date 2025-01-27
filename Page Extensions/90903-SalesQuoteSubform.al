pageextension 90903 SQ_Subform_ReturnCode extends "Sales Quote Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Return Code"; rec."Return Code")
            {
                ApplicationArea = all;
                Caption = 'Return Code';
                Editable = true;
                TableRelation = "Return Reason";
            }
            field("Standard KG"; Rec."Standard KG")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Disc. Unit Price"; Rec."Disc. Unit Price")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
            begin
                GetStandKG();
                getdiscunitprice();
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
        if ItemR.Get(Rec."No.") then begin
            Rec."Standard KG" := ItemR."Standard KG";
            Rec.Modify();
        end;
    end;

    local procedure getdiscunitprice(): Decimal
    var
        discprice: Decimal;
    begin
        discprice := Rec."Unit Price" * Rec."Line Discount %" / 100;
        rec."Disc. Unit Price" := discprice;
        rec.Modify();
        Commit();
    end;

    var
        myInt: Integer;
}