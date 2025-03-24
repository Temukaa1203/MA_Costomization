codeunit 90910 "Return Reason Code Update"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Return Code', true, true)]
    local procedure OnAfterValidateReturnReasonCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";

    begin
        if Rec."Return Code" <> xRec."Return Code" then begin
            SalesLine.SetRange("Document Type", Rec."Document Type");
            SalesLine.SetRange("Document No.", Rec."No.");
            if SalesLine.FindSet() then begin
                repeat
                    SalesLine.Validate("Return Code", Rec."Return Code");
                    SalesLine.Modify();
                until SalesLine.Next() = 0;
            end;
        end;
    end;
}