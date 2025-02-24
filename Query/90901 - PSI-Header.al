query 90902 psi_header
{
    QueryType = API;
    APIPublisher = 'EMC';
    APIGroup = 'GroupName';
    APIVersion = 'v1.0';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName';

    elements
    {
        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            column(No_; "No.")
            {
            }
            column(Dimension_Set_ID; "Dimension Set ID") { }
            column(PickPack_Order_Code; "PickPack Order Code") { }
            column(PickPack_Sent_Date; "PickPack Sent Date") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Location_Code; "Location Code") { }
            column(Shipment_Date; "Shipment Date") { }
            column(Salesperson_Code; "Salesperson Code") { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}