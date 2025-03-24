pageextension 90920 postedSalesInvSub extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field("Disc. Unit Price"; Rec."Disc. Unit Price")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Standard KG"; Rec."Standard KG")
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