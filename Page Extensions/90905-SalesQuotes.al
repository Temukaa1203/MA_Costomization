pageextension 90905 salesquoteordertypeext extends "Sales Quotes"
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
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