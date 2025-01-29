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
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Return Code"; Rec."Return Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addbefore(Shipment)
        {
            group("Totals")
            {
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        transferline: record "Transfer Line";
        total: Decimal;
    begin
        if transferline.Get(Rec."No.") then begin
            repeat
                total += transferline."Line Amount";
            until transferline.Next = 0;
            Message(Format(total));
        end;
    end;

    var
        myInt: Integer;
}