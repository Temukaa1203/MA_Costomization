codeunit 90915 SRO_job
{
    trigger OnRun()
    begin
        createsro();
    end;

    local procedure createsro()
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
        salesheader.SetFilter("Order Type", '=%1', SalesHeader."Order Type"::"SALES RETURN");
        salesheader.SetFilter("Responsibility Center", '=%1', 'SALESM');
        if salesheader.Find('-') then begin
            Message(Format(salesheader.Count));
            repeat
                if not CreateSalesReturnOrder(salesheader) then begin
                    salesheader."SRO Error" := GetLastErrorText();
                    salesheader.Modify();
                    sro.Reset();
                    sro.SetRange("SQ no.", salesheader."No.");
                    if sro.FindSet() then begin
                        sro.delete(true);
                    end;
                end;
            until salesheader.Next() = 0;
        end;
    end;

    [TryFunction]
    procedure CreateSalesReturnOrder(PSI: Record "Sales Header")
    var
        SalesQuoteLine: Record "Sales Line";
        SalesReturnOrder: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        NewReturnOrderNo: Code[20];
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        ReturnCode: Record "Return Reason";
    begin
        // if not ReturnCode.Get(SalesQuote."Return Code") then
        //     Error('Return reason not found');
        SalesReturnOrder.Init();
        SalesReturnOrder."Document Type" := SalesReturnOrder."Document Type"::"Return Order";
        SalesReturnOrder.Validate("Sell-to Customer No.", PSI."Sell-to Customer No.");
        SalesReturnOrder.validate("PickPack Ret. Del. Type Code", 'DELIVERY-ITEM');
        SalesReturnOrder.Validate("PickPack Return Reason Code", 'CUSTOMERWISH');
        SalesReturnOrder.Validate("Your Reference", PSI."Your Reference");
        SalesReturnOrder.Validate("Salesperson Code", PSI."Salesperson Code");
        SalesReturnOrder.Validate("Customer Posting Group", PSI."Customer Posting Group");
        SalesReturnOrder.Validate("Customer Disc. Group", PSI."Customer Disc. Group");
        SalesReturnOrder.Validate("Customer Price Group", PSI."Customer Price Group");
        SalesReturnOrder.Validate("PickPack Return Code", PSI."PickPack return Code");
        SalesReturnOrder.Validate("External Document No.", PSI."External Document No.");
        SalesReturnOrder.Validate("PickPack Delivery Email", PSI."PickPack Delivery Email");
        SalesReturnOrder.Validate("PickPack Return Name", PSI."PickPack Delivery Name");
        SalesReturnOrder.Validate("PickPack Return Phone No.", PSI."PickPack Delivery Phone No.");
        SalesReturnOrder.Validate("PickPack Delivery Type Code", PSI."PickPack Delivery Type Code");
        SalesReturnOrder.Validate("PickPack State Code", PSI."PickPack State Code");
        SalesReturnOrder.Validate("PickPack District Code", PSI."PickPack District Code");
        SalesReturnOrder.Validate("PickPack Quarter Code", PSI."PickPack Quarter Code");
        SalesReturnOrder.Validate("Bill-to Customer No.", PSI."Bill-to Customer No.");
        SalesReturnOrder.Validate("Gen. Bus. Posting Group", 'SRO');
        SalesReturnOrder.Validate("VAT Bus. Posting Group", 'VAT10');
        SalesReturnOrder.Validate("Work Description", PSI."Work Description");
        SalesReturnOrder.validate("Return Code", PSI."Return Code");
        SalesReturnOrder.validate("SQ no.", PSI."No.");
        SalesReturnOrder.Insert(true);
        SalesQuoteLine.SetRange("Document No.", PSI."No.");

        if SalesQuoteLine.FindSet() then begin
            repeat
                SalesOrderLine.Init();
                SalesOrderLine."Document No." := SalesReturnOrder."No.";
                SalesOrderLine.validate(Type, SalesQuoteLine.Type);
                SalesOrderLine.Validate("Document Type", SalesReturnOrder."Document Type"::"Return Order");
                SalesOrderLine.validate("Sell-to Customer No.", SalesReturnOrder."Sell-to Customer No.");

                SalesOrderLine.validate("No.", SalesQuoteLine."No.");
                SalesOrderLine.validate("Line No.", SalesQuoteLine."Line No.");
                SalesOrderLine.Validate("Item Reference No.", SalesQuoteLine."Item Reference No.");

                SalesOrderLine.Validate("Bill-to Customer No.", SalesReturnOrder."Bill-to Customer No.");
                SalesOrderLine.validate("Shortcut Dimension 1 Code", SalesQuoteLine."Shortcut Dimension 1 Code");
                SalesOrderLine.validate("Shortcut Dimension 2 Code", SalesQuoteLine."Shortcut Dimension 2 Code");
                SalesOrderLine.validate("Work Type Code", SalesQuoteLine."Work Type Code");
                SalesOrderLine.Validate("Transaction Type", SalesQuoteLine."Transaction Type");
                SalesOrderLine.validate("Transport Method", SalesQuoteLine."Transport Method");
                SalesOrderLine.Validate("Posting Group", SalesQuoteLine."Posting Group");
                SalesOrderLine.Validate("Customer Price Group", SalesQuoteLine."Customer Price Group");
                SalesOrderLine.Validate("Gen. Bus. Posting Group", SalesReturnOrder."Gen. Bus. Posting Group");
                SalesOrderLine.Validate("Gen. Prod. Posting Group", SalesQuoteLine."Gen. Prod. Posting Group");
                SalesOrderLine.Validate("Tax Group Code", SalesQuoteLine."Tax Group Code");
                SalesOrderLine.Validate("Description", SalesQuoteLine."Description");
                SalesOrderLine.Validate("VAT Prod. Posting Group", SalesQuoteLine."VAT Prod. Posting Group");
                SalesOrderLine.Validate("Quantity", SalesQuoteLine.Quantity);

                SalesOrderLine.Validate("Amount", SalesQuoteLine.Amount);
                SalesOrderLine.Validate("Unit of Measure", SalesQuoteLine."Unit of Measure");
                SalesOrderLine.Validate("Unit of Measure code", SalesQuoteLine."Unit of Measure code");
                SalesOrderLine.Validate("Line Amount", SalesQuoteLine."Line Amount");
                SalesOrderLine.Validate("Line Discount %", SalesQuoteLine."Line Discount %");
                SalesOrderLine.Validate("Location Code", SalesQuoteLine."Location Code");
                SalesOrderLine.Validate("Disc. Unit Price", SalesQuoteLine."Disc. Unit Price");
                SalesOrderLine.validate("Return Reason Code", SalesQuoteLine."Return Code");
                SalesOrderLine.Validate("Unit Price", SalesQuoteLine."Unit Price");
                SalesOrderLine.Insert();
            until SalesQuoteLine.Next() = 0;
            SalesReturnOrder.Modify();
            Commit();
            ReleaseSalesDoc.PerformManualRelease(SalesReturnOrder);
            psi.delete(true);
            // page.Run(page::"Sales Return Order", SalesReturnOrder);

        end;

    end;

    var
        myInt: Integer;
}