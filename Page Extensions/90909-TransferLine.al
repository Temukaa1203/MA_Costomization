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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}