codeunit 90914 SOtoPSI_event
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', false, false)]
    local procedure OnAfterPostSalesLine(var SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line");
    begin
        SalesInvLine."Disc. Unit Price" := SalesLine."Disc. Unit Price";
        SalesInvLine."Standard KG" := SalesLine."Standard KG";
    end;
}