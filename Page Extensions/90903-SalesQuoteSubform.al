pageextension 90903 SQ_Subform_ReturnCode extends "Sales Quote Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Return Code"; rec."Return Code")
            {
                ApplicationArea = all;
                Caption = 'Return Code';
                Editable = true;
                TableRelation = "Return Reason";
            }
            field("Standard KG"; Rec."Standard KG")
            {
                ApplicationArea = all;
                Editable = true;
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