pageextension 90914 salesordersub_ext extends "Sales Order Subform"
{
    layout
    {
        addafter("Quantity")
        {
            field("Disc. Unit Price"; Rec."Disc. Unit Price")
            {
                ApplicationArea = All;
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