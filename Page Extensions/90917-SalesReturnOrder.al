pageextension 90917 salesreturnorder_ext extends "Sales Return Order"
{
    layout
    {
        addlast(General)
        {
            field("PickPack Last Status"; Rec."PickPack Last Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PickPack Last Status Date"; Rec."PickPack Last Status Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PickPack Sent"; Rec."PickPack Sent")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PickPack Sent Date"; Rec."PickPack Sent Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PickPack Message"; Rec."PickPack Message")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PickPack Order Code"; Rec."PickPack Order Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PP Json Data"; Rec."PP Json Data")
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