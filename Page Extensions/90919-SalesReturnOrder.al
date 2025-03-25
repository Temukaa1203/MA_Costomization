pageextension 90919 SalesRetOrd extends "Sales Return Order"
{
    layout
    {
        addlast(General)
        {
            field("Return Code"; Rec."Return Code")
            {
                ApplicationArea = All;
                Caption = 'Return Reason Code';
                Editable = true;
                TableRelation = "Return Reason";
                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            field("SQ no."; Rec."SQ no.")
            {
                ApplicationArea = All;
                Caption = 'SQ no.';
                Editable = false;
            }
        }
        modify("PickPack return Code")
        {
            Editable = false;
        }
        modify("PickPack District Code")
        {
            Editable = false;
        }
        modify("PickPack Quarter Code")
        {
            Editable = false;
        }
        modify("PickPack State Code")
        {
            Editable = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}