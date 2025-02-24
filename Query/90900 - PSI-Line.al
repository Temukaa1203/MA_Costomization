query 90901 psi_line
{
    QueryType = API;
    APIPublisher = 'EMC';
    APIGroup = 'GroupName';
    APIVersion = 'v1.0';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName';

    elements
    {
        dataitem(SalesInvLine; "Sales Invoice Line")
        {
            column(No_; "No.")
            {

            }
            column(Document_No_; "Document No.") { }
            column(Line_No_; "Line No.") { }
            column("Itemno"; "No.") { }
            column("Quantity"; "Quantity") { }
            column("UnitPrice"; "Unit Price") { }
            column("Amount"; "Amount") { }
            column(Dimension_Set_ID; "Dimension Set ID") { }
            // dataitem(Dimension_Set_Entry;"Dimension Set Entry")
            // {

            //     DataItemLink = "Dimension Set ID" = SalesInvLine."Dimension Set ID";
            //     column(Dimension_Code;"Dimension Code"){}
            //     column(Dimension_Value_Code;"Dimension Value Code"){}
            // }
        }

    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}