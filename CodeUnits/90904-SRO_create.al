codeunit 90904 "SalesReturnOrderProcessor"
{
    procedure CreateSalesReturnOrder(SalesQuote: Record "Sales Header")
    var
        SalesQuoteLine: Record "Sales Line";
        SalesReturnOrder: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        NewReturnOrderNo: Code[20];
        ReturnCode: Record "Return Reason";
    begin
        if not ReturnCode.Get(SalesQuote."Return Code") then
            Error('Return reason not found');

        SalesReturnOrder.Init();
        SalesReturnOrder."Document Type" := SalesReturnOrder."Document Type"::"Return Order";
        SalesReturnOrder."Sell-to Customer no." := SalesQuote."Sell-to Customer no.";
        SalesReturnOrder."Sell-to Customer name" := SalesQuote."Sell-to Customer name";
        SalesReturnOrder."Sell-to Customer name 2" := SalesQuote."Sell-to Customer name 2";
        SalesReturnOrder."Sell-to address" := SalesQuote."Sell-to address";
        SalesReturnOrder."Sell-to address 2" := SalesQuote."Sell-to address 2";
        SalesReturnOrder."assigned user id" := SalesQuote."assigned user id";
        SalesReturnOrder."Your Reference" := SalesQuote."Your Reference";
        SalesReturnOrder."Sell-to city" := SalesQuote."Sell-to city";
        SalesReturnOrder."Sell-to contact" := SalesQuote."Sell-to contact";
        SalesReturnOrder."Sell-to post code" := SalesQuote."Sell-to post code";
        SalesReturnOrder."Sell-to county" := SalesQuote."Sell-to County";
        SalesReturnOrder."Sell-to IC Partner Code" := SalesQuote."Sell-to IC Partner Code";
        SalesReturnOrder."Sell-to phone no." := SalesQuote."Sell-to phone no.";
        SalesReturnOrder."Sell-to e-mail" := SalesQuote."Sell-to e-mail";
        SalesReturnOrder."Sell-to contact no." := SalesQuote."Sell-to contact no.";
        SalesReturnOrder."Sell-to Country/Region Code" := SalesQuote."Sell-to Country/Region Code";
        SalesReturnOrder."Customer Posting Group" := SalesQuote."Customer Posting Group";
        SalesReturnOrder."Customer Disc. Group" := SalesQuote."Customer Disc. Group";
        SalesReturnOrder."Customer Price Group" := SalesQuote."Customer Price Group";
        SalesReturnOrder."VAT Bus. Posting Group" := SalesQuote."VAT Bus. Posting Group";
        SalesReturnOrder."Gen. Bus. Posting Group" := SalesQuote."Gen. Bus. Posting Group";
        SalesReturnOrder."Return Code" := SalesQuote."Return Code";
        SalesReturnOrder."External Document No." := SalesQuote."External Document No.";
        SalesReturnOrder."Sell-to Customer Templ. Code" := SalesQuote."Sell-to Customer Templ. Code";
        SalesReturnOrder."bill-to name" := SalesQuote."bill-to name";
        SalesReturnOrder."bill-to name 2" := SalesQuote."bill-to name 2";
        SalesReturnOrder."bill-to city" := SalesQuote."bill-to city";
        SalesReturnOrder."bill-to address 2" := SalesQuote."bill-to address 2";
        SalesReturnOrder."bill-to contact" := SalesQuote."bill-to contact";
        SalesReturnOrder."Bill-to Country/Region Code" := SalesQuote."Bill-to Country/Region Code";
        SalesReturnOrder."Bill-to IC Partner Code" := SalesQuote."Bill-to IC Partner Code";
        SalesReturnOrder."Bill-to Contact No." := SalesQuote."Bill-to Contact No.";
        SalesReturnOrder."Bill-to Customer Templ. Code" := SalesQuote."Bill-to Customer Templ. Code";
        SalesReturnOrder."bill-to post code" := SalesQuote."bill-to post code";
        SalesReturnOrder."bill-to address" := SalesQuote."bill-to address";
        SalesReturnOrder."bill-to Customer no." := SalesQuote."bill-to Customer no.";
        SalesReturnOrder.Insert(true);

        SalesQuoteLine.SetRange("Document No.", SalesQuote."No.");
        if SalesQuoteLine.FindSet() then begin
            repeat
                SalesOrderLine.Init();
                SalesOrderLine."Document Type" := SalesOrderLine."Document Type"::"Return Order";
                SalesOrderLine."Document No." := SalesReturnOrder."No."; // Set the document number
                SalesOrderLine."No." := SalesQuoteLine."No."; // Reference the Item No.
                SalesOrderLine."Type" := SalesQuoteLine."Type";
                SalesOrderLine."Posting Group" := SalesQuoteLine."Posting Group";
                SalesOrderLine."Customer Price Group" := SalesQuoteLine."Customer Price Group";
                SalesOrderLine."Gen. Bus. Posting Group" := SalesQuoteLine."Gen. Bus. Posting Group";
                SalesOrderLine."Gen. Prod. Posting Group" := SalesQuoteLine."Gen. Prod. Posting Group";
                SalesOrderLine."Tax Group Code" := SalesQuoteLine."Tax Group Code";
                SalesOrderLine."Description" := SalesQuoteLine."Description";
                SalesOrderLine."VAT Prod. Posting Group" := SalesQuoteLine."VAT Prod. Posting Group";
                SalesOrderLine."Quantity" := SalesQuoteLine.Quantity;
                SalesOrderLine."Unit Price" := SalesQuoteLine."Unit Price";
                SalesOrderLine."Amount" := SalesQuoteLine.Amount;
                SalesOrderLine."Return Reason Code" := SalesQuoteLine."Return Code";
                SalesOrderLine."Unit of Measure" := SalesQuoteLine."Unit of Measure";
                SalesOrderLine."Unit of Measure code" := SalesQuoteLine."Unit of Measure code";
                SalesOrderLine."Line no." := SalesQuoteLine."Line No.";
                SalesOrderLine."Line Amount" := SalesQuoteLine."Line Amount";
                SalesOrderLine."Line Discount %" := SalesQuoteLine."Line Discount %";
                SalesOrderLine.Validate(Quantity, SalesQuoteLine.Quantity); // 
                SalesOrderLine."Location Code" := SalesQuoteLine."Location Code";
                SalesOrderLine."Standard KG" := SalesQuoteLine."Standard KG";
                SalesOrderLine.Insert();
            until SalesQuoteLine.Next() = 0;
            // SalesReturnOrder.Status := SalesReturnOrder.Status::Released;
            SalesReturnOrder.Modify();
            // NewReturnOrderNo := SalesReturnOrder."No.";
            // // Return the created SalesReturnOrder document for further processing if needed
            // MESSAGE('Sales Return Order created with No: %1', NewReturnOrderNo);
        end;
    end;
}
