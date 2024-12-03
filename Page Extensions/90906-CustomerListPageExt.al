pageextension 90906 customersPageExt extends "Customer List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Customer Type"; Rec."Customer Type")
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