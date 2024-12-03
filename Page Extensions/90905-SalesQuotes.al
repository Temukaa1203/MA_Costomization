pageextension 90905 salesquoteordertypeext extends "Sales Quotes"
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field("Order Type Transfer"; Rec."Order Type Transfer")
            {
                ApplicationArea = All;
            }
            field("Order Type Sales"; Rec."Order Type Sales")
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