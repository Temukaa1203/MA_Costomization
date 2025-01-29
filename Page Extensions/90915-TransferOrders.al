pageextension 90915 transferorders_ext extends "Transfer Orders"
{
    layout
    {
        addafter(Status)
        {
            field("SQ no"; Rec."SQ no")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
            field("Total Amount"; Rec."Total Amount")
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