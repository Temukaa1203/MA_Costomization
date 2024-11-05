codeunit 90900 TransferOrderHelper
{
    local procedure InitFromTransferFromLocation(var TransferHeader: Record "Transfer Header"; Location: Record Location)
    begin
        Message('sss:', "TransferHeader"."Transfer-from Code");
        TransferHeader."Transfer-from Name" := Location.Name;
        TransferHeader."Transfer-from Name 2" := Location."Name 2";
        TransferHeader."Transfer-from Address" := Location.Address;
        TransferHeader."Transfer-from Address 2" := Location."Address 2";
        TransferHeader."Transfer-from Post Code" := Location."Post Code";
        TransferHeader."Transfer-from City" := Location.City;
        TransferHeader."Transfer-from County" := Location.County;
        TransferHeader."Trsf.-from Country/Region Code" := Location."Country/Region Code";
        TransferHeader."Transfer-from Contact" := Location.Contact;

    end;

    // Define the event to be triggered after the initialization
}
