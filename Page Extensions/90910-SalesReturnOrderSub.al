pageextension 90910 SRO_Ext extends "Sales Return Order Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Standard KG"; Rec."Standard KG")
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