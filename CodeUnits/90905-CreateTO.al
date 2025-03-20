codeunit 90905 EECreateTO
{
    trigger OnRun()
    begin
        CreateTO();
    end;


    [TryFunction]
    local procedure CreateTO()
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        maketransferorder: Codeunit TransferOrderCreator;
        mydatetime: DateTime;
        mydate: date;
    begin
        mydate := CalcDate('<-1D>', Today);
        mydatetime := CreateDateTime(mydate, 0T);
        SalesHeader.Reset();
        SalesHeader.SetRange(SystemCreatedAt, mydatetime, CurrentDateTime);
        SalesHeader.SetFilter("Document Type", '=%1', SalesHeader."Document Type"::Quote);
        SalesHeader.SetFilter(Status, '=%1', SalesHeader.Status::Released);
        if SalesHeader.Find('-') then begin
            repeat
                if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") and (SalesHeader."Order Type" = SalesHeader."Order Type"::TRANSFER) then begin
                    if not CreateTransferOrder(SalesHeader) then begin
                        SalesHeader."SQ2TO Error" := GetLastErrorText();
                        SalesHeader.Modify();
                    end;
                end;
                if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") and (SalesHeader."Order Type" = SalesHeader."Order Type"::"TRANSFER RETURN") then begin
                    if not CreateTransferOrder(SalesHeader) then begin
                        SalesHeader."SQ2TO Error" := GetLastErrorText();
                        SalesHeader.Modify();
                    end;
                end;
            until SalesHeader.Next() = 0;
        end;
    end;

    [TryFunction]
    procedure CreateTransferOrder(var SalesQuoteHeader: Record "Sales Header")
    var
        TransferOrder: Record "Transfer Header";
        SalesQuoteLine: Record "Sales Line";
        TransferOrderLine: Record "Transfer Line";
        Location: Record Location;
        NewTransferOrderNo: Code[20];
        cust: Record Customer;
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        total: Decimal;
    begin
        TransferOrder.Init();
        TransferOrder.Validate("Transfer-to Code", SalesQuoteHeader."Transfer-to Code");
        TransferOrder.Validate("Transfer-from Code", SalesQuoteHeader."Transfer-from Code");
        TransferOrder.Validate("Return Code", SalesQuoteHeader."Return Code");
        TransferOrder.Validate("SQ no", SalesQuoteHeader."No.");
        TransferOrder.Validate("MA Salesperson Code", SalesQuoteHeader."Salesperson Code");
        TransferOrder.Validate("In-Transit Code", 'IN-TRANSIT');
        TransferOrder.Validate("PickPack State Code", SalesQuoteHeader."PickPack State Code");
        TransferOrder.Validate("PickPack District Code", SalesQuoteHeader."PickPack District Code");
        TransferOrder.Validate("PickPack quarter Code", SalesQuoteHeader."PickPack Quarter Code");
        TransferOrder.Validate("PickPack Delivery Type Code", SalesQuoteHeader."PickPack Delivery Type Code");
        TransferOrder.Validate("PickPack Delivery Name", SalesQuoteHeader."PickPack Delivery Name");
        TransferOrder.Validate("PickPack Delivery Email", SalesQuoteHeader."PickPack Delivery email");
        TransferOrder.Validate("PickPack Delivery Type Code", SalesQuoteHeader."PickPack Delivery Type Code");
        TransferOrder.Validate("PickPack Delivery Phone No.", SalesQuoteHeader."PickPack Delivery Phone No.");
        TransferOrder.Validate("PickPack Item Prepared Date", SalesQuoteHeader."PickPack Item Prepared Date");
        TransferOrder.Validate("PickPack Message", SalesQuoteHeader."PickPack Message");
        TransferOrder.Validate("PickPack Order Code", SalesQuoteHeader."PickPack Order Code");
        TransferOrder.Validate("PickPack Received Date", SalesQuoteHeader."PickPack Received Date");
        TransferOrder.Validate(TransferOrder."PickPack Not Send", SalesQuoteHeader."PickPack Not Send");
        Location.SetRange(Code, 'PP200');
        if Location.FindSet() then begin
            TransferOrder.Validate("Transfer-from Name", Location.Name);
            TransferOrder.Validate("Transfer-from Name 2", Location."Name 2");
            TransferOrder.Validate("Transfer-from Address", Location.Address);
            TransferOrder.Validate("Transfer-from Address 2", Location."Address 2");
            TransferOrder.Validate("Transfer-from Post Code", Location."Post Code");
            TransferOrder.Validate("Transfer-from City", Location.City);
            TransferOrder.Validate("Transfer-from County", Location.County);
            TransferOrder.Validate("Trsf.-from Country/Region Code", Location."Country/Region Code");
            TransferOrder.Validate("Transfer-from Contact", Location.Contact);
        end;
        cust.Reset();
        cust.SetRange("No.", SalesQuoteHeader."Sell-to Customer No.");
        if cust.FindSet() then begin
            TransferOrder.Validate("Transfer-to Name", cust.Name);
            TransferOrder.Validate("Transfer-to Contact", cust.Contact);
            TransferOrder.Validate("Transfer-to Name 2", cust."Name 2");
            TransferOrder.Validate("Transfer-to Address", cust.Address);
            TransferOrder.Validate("Transfer-to Address 2", cust."Address 2");
            TransferOrder.Validate("Transfer-to Post Code", cust."Post Code");
            TransferOrder.Validate("Transfer-to City", cust.City);
            TransferOrder.Validate("Transfer-to County", cust.County);
            TransferOrder.Validate("Trsf.-to Country/Region Code", cust."Country/Region Code");
        end;
        TransferOrder.Insert(true);
        SalesQuoteLine.SetRange("Document No.", SalesQuoteHeader."No.");
        if SalesQuoteLine.FindSet() then begin
            repeat
                TransferOrderLine.Init(); // Initialize new line record
                TransferOrderLine.Validate("Document No.", TransferOrder."No.");
                TransferOrderLine.Validate("Item No.", SalesQuoteLine."No.");
                TransferOrderLine.Validate("Quantity", SalesQuoteLine.Quantity);
                TransferOrderLine.Validate("Description", SalesQuoteLine.Description);
                TransferOrderLine.Validate("Line No.", SalesQuoteLine."Line No.");
                TransferOrderLine.Validate("Qty. to Ship", SalesQuoteLine."Qty. to Ship");
                TransferOrderLine.Validate("Quantity Shipped", SalesQuoteLine."Quantity Shipped");
                TransferOrderLine.Validate("Unit of Measure Code", SalesQuoteLine."Unit of Measure Code");
                TransferOrderLine.Validate("Unit of Measure", SalesQuoteLine."Unit of Measure");
                TransferOrderLine.Validate("Inventory Posting Group", SalesQuoteLine."Posting Group");
                TransferOrderLine.Validate("Quantity (Base)", SalesQuoteLine."Quantity (Base)");
                TransferOrderLine.Validate("Outstanding Qty. (Base)", SalesQuoteLine."Outstanding Qty. (Base)");
                TransferOrderLine.Validate("Qty. Shipped (Base)", SalesQuoteLine."Qty. Shipped (Base)");
                TransferOrderLine.Validate("Outstanding Quantity", SalesQuoteLine."Outstanding Quantity");
                TransferOrderLine.Validate("Gross Weight", SalesQuoteLine."Gross Weight");
                TransferOrderLine.Validate("Net Weight", SalesQuoteLine."Net Weight");
                TransferOrderLine.Validate("Unit Volume", SalesQuoteLine."Unit Volume");
                TransferOrderLine.Validate("Qty. Rounding Precision", SalesQuoteLine."Qty. Rounding Precision");
                TransferOrderLine.Validate("Qty. Rounding Precision (Base)", SalesQuoteLine."Qty. Rounding Precision (Base)");
                TransferOrderLine.Validate("Variant Code", SalesQuoteLine."Variant Code");
                TransferOrderLine.Validate("Units per Parcel", SalesQuoteLine."Units per Parcel");
                TransferOrderLine.Validate("Description 2", SalesQuoteLine."Description 2");
                TransferOrderLine.Validate("Appl.-to Item Entry", SalesQuoteLine."Appl.-to Item Entry");
                TransferOrderLine.Validate("Dimension Set ID", SalesQuoteLine."Dimension Set ID");
                TransferOrderLine.Validate("In-Transit Code", 'IN-TRANSIT');
                TransferOrderLine.Validate("Return Code", SalesQuoteLine."Return Code");
                TransferOrderLine.Validate("Gen. Prod. Posting Group", SalesQuoteLine."Gen. Prod. Posting Group");
                TransferOrderLine.Validate("Transfer-from Code", TransferOrder."Transfer-from Code");
                TransferOrderLine.Validate("Transfer-to Code", TransferOrder."Transfer-to Code");
                TransferOrderLine.Validate("Shipment Date", TransferOrder."Shipment Date");
                TransferOrderLine.Validate("Receipt Date", TransferOrder."Receipt Date");
                TransferOrderLine.Validate("Product Price", SalesQuoteLine."Unit Price");
                TransferOrderLine.Validate("line amount", SalesQuoteLine."Line Amount");
                TransferOrderLine.Validate("Standard KG", SalesQuoteLine."Standard KG");
                TransferOrderLine.Validate("disc. Unit Price", SalesQuoteLine."disc. Unit Price");
                // Validate and insert the new line into the Transfer Order
                TransferOrderLine.Validate(Quantity, SalesQuoteLine.Quantity);
                total += SalesQuoteLine."Line Amount";
                TransferOrderLine.Insert(true);
            until SalesQuoteLine.Next() = 0;
            TransferOrder.validate("Total Amount", total);
        end;
        // SalesQuoteHeader.Delete(true);
        Commit();
    end;

    var
        myInt: Integer;
}