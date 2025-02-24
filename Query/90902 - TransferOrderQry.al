query 90903 TransferOrderQry
{
    QueryType = API;
    APIPublisher = 'EMC';
    APIGroup = 'GroupName';
    APIVersion = 'v1.0';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName';

    elements
    {
        dataitem(Transfer_Header; "Transfer Header")
        {
            column(No_; "No.") { }
            column(Dimension_Set_ID; "Dimension Set ID") { }
            column(PickPack_Order_Code; "PickPack Order Code") { }
            column(PickPack_Sent_Date; "PickPack Sent Date") { }
            column(Transfer_to_Name; "Transfer-to Name") { }
            column(Transfer_from_Code; "Transfer-from Code") { }
            column(Transfer_to_Code; "Transfer-to Code") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(Total_Amount; "Total Amount") { }
            column(Posting_Date; "Posting Date") { }
            column(Status; "Status") { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}