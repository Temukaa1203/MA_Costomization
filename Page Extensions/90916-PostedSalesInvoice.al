pageextension 90916 MakeSRO_fromPSI extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Update Document")
        {
            // action(SalesReturnOrder)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Make Sales Return Order';
            //     Image = Sales;
            //     trigger OnAction()
            //     var
            //         SalesQuoteLine: Record "Sales Line";
            //         SalesOrderLine: Record "Sales Line";
            //         SalesQuote: Record "Sales header";
            //         salesreturnorder: Record "Sales header";
            //         NewReturnOrderNo: Code[20];
            //         returncode: Record "Return Reason";
            //         srocreator: Codeunit "SalesReturnOrderProcessor";
            //     begin
            //         srocreator.CreateSalesReturnOrder(Rec);
            //     end;
            // }
        }
    }

    var
        myInt: Integer;
}