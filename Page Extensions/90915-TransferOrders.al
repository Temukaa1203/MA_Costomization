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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}