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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}