pageextension 90907 transheadext extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field("SQ no"; Rec."SQ no")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Return Code"; Rec."Return Code")
            {
                ApplicationArea = all;
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