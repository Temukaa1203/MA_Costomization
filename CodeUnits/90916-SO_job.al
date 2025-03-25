codeunit 90916 SO_job
{
    trigger OnRun()
    begin
        createso();
    end;

    local procedure createso()
    var
        mydatetime: DateTime;
        mydate: date;
        createsroCodeunit: Codeunit SalesReturnOrderProcessor;
        salesheader: Record "Sales Header";
        sro: record "Sales Header";
    begin
        mydate := CalcDate('<-1D>', Today);
        mydatetime := CreateDateTime(mydate, 0T);
        SalesHeader.Reset();
        SalesHeader.SetRange(SystemCreatedAt, mydatetime, CurrentDateTime);
        SalesHeader.SetFilter("Document Type", '=%1', SalesHeader."Document Type"::Quote);
        SalesHeader.SetFilter(Status, '=%1', SalesHeader.Status::Released);
        salesheader.SetFilter("Order Type", '=%1', SalesHeader."Order Type"::"SALES");
        salesheader.SetFilter("Responsibility Center", '=%1', 'SALESM');
        if salesheader.Find('-') then begin
            Message(Format(salesheader.Count));
            repeat
                if not CreateSalesOrder(salesheader) then begin
                    salesheader."SO Error" := GetLastErrorText();
                    salesheader.Modify();
                end;
            until salesheader.Next() = 0;
        end;
    end;

    [TryFunction]
    procedure CreateSalesOrder(SalesHeader: Record "Sales Header")
    var
        SalesQuoteLine: Record "Sales Line";
        SalesReturnOrder: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        NewReturnOrderNo: Code[20];
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        ReturnCode: Record "Return Reason";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
    begin
        if ApprovalsMgmt.PrePostApprovalCheckSales(SalesHeader) then
            SalesQuoteToOrder.run(SalesHeader);
    end;

    var
        myInt: Integer;
}