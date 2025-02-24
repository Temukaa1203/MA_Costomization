pageextension 90918 standardkg_SOLine extends "Sales Order Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Standard KG"; Rec."Standard KG")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}