pageextension 90904 customerlocationext extends "Customer Card"
{
    layout
    {
        addlast("Address & Contact")
        {
            field("Agent Location"; Rec."Agent Location")
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field("Customer Type"; Rec."Customer Type")
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