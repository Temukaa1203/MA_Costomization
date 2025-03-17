codeunit 90909 "SalesReturnOrderProcessor"
{
    procedure CreateSalesReturnOrder(PSI: Record "Sales Invoice Header")
    var
        SalesQuoteLine: Record "Sales Invoice Line";
        SalesReturnOrder: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        NewReturnOrderNo: Code[20];
        ReturnCode: Record "Return Reason";
    begin
        // if not ReturnCode.Get(SalesQuote."Return Code") then
        //     Error('Return reason not found');
        SalesReturnOrder.Init();
        SalesReturnOrder."Document Type" := SalesReturnOrder."Document Type"::"Return Order";
        SalesReturnOrder.Validate("Sell-to Customer No.", PSI."Sell-to Customer No.");
        SalesReturnOrder.validate("PickPack Ret. Del. Type Code", 'DELIVERY-ITEM');
        SalesReturnOrder.Validate("PickPack Return Reason Code", 'CUSTOMERWISH');
        // SalesReturnOrder.Validate("Sell-to Customer Name", PSI."Sell-to Customer Name");
        // SalesReturnOrder.Validate("Sell-to Customer Name 2", PSI."Sell-to Customer Name 2");
        // SalesReturnOrder.Validate("Sell-to Address", PSI."Sell-to Address");
        // SalesReturnOrder.Validate("Sell-to Address 2", PSI."Sell-to Address 2");
        SalesReturnOrder.Validate("Your Reference", PSI."Your Reference");
        // SalesReturnOrder.Validate("Sell-to City", PSI."Sell-to City");
        // SalesReturnOrder.Validate("Sell-to Contact", PSI."Sell-to Contact");
        // SalesReturnOrder.Validate("Sell-to Post Code", PSI."Sell-to Post Code");
        // SalesReturnOrder.Validate("Sell-to County", PSI."Sell-to County");
        // SalesReturnOrder.Validate("Sell-to Phone No.", PSI."Sell-to Phone No.");
        // SalesReturnOrder.Validate("Sell-to E-Mail", PSI."Sell-to E-Mail");
        // SalesReturnOrder.Validate("Sell-to Contact No.", PSI."Sell-to Contact No.");
        // SalesReturnOrder.Validate("Sell-to Country/Region Code", PSI."Sell-to Country/Region Code");
        SalesReturnOrder.Validate("Customer Posting Group", PSI."Customer Posting Group");
        SalesReturnOrder.Validate("Customer Disc. Group", PSI."Customer Disc. Group");
        SalesReturnOrder.Validate("Customer Price Group", PSI."Customer Price Group");
        SalesReturnOrder.Validate("PickPack Return Code", PSI."PickPack order Code");
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
        SalesReturnOrder.Insert(true);
        // SalesReturnOrder.validate("Applies-to ID", PSI."No.");
        // CODEUNIT.Run(CODEUNIT::"Sales Header Apply", SalesReturnOrder);
        SalesQuoteLine.SetRange("Document No.", PSI."No.");

        if SalesQuoteLine.FindSet() then begin
            repeat
                SalesOrderLine.Init();
                SalesOrderLine."Document Type" := SalesReturnOrder."Document Type";
                SalesOrderLine."Document No." := SalesReturnOrder."No."; // Set the document number
                // SalesOrderLine.validate("No.", SalesQuoteLine."No."); // Reference the Item No.
                SalesOrderLine."No." := SalesQuoteLine."No."; // Reference the Item No.
                SalesOrderLine."Type" := SalesQuoteLine."Type";
                SalesOrderLine."Posting Group" := SalesQuoteLine."Posting Group";
                SalesOrderLine."Customer Price Group" := SalesQuoteLine."Customer Price Group";
                SalesOrderLine."Gen. Bus. Posting Group" := SalesReturnOrder."Gen. Bus. Posting Group";
                SalesOrderLine."Gen. Prod. Posting Group" := SalesQuoteLine."Gen. Prod. Posting Group";
                SalesOrderLine."Tax Group Code" := SalesQuoteLine."Tax Group Code";
                SalesOrderLine."Description" := SalesQuoteLine."Description";
                // SalesOrderLine."VAT Prod. Posting Group" := SalesQuoteLine."VAT Prod. Posting Group";
                SalesOrderLine."Quantity" := SalesQuoteLine.Quantity;
                SalesOrderLine."Unit Price" := SalesQuoteLine."Unit Price";
                SalesOrderLine."Amount" := SalesQuoteLine.Amount;
                SalesOrderLine."Unit of Measure" := SalesQuoteLine."Unit of Measure";
                SalesOrderLine."Unit of Measure code" := SalesQuoteLine."Unit of Measure code";
                SalesOrderLine."Line no." := SalesQuoteLine."Line No.";
                SalesOrderLine."Line Amount" := SalesQuoteLine."Line Amount";
                SalesOrderLine."Line Discount %" := SalesQuoteLine."Line Discount %";
                SalesOrderLine.Validate(Quantity, SalesQuoteLine.Quantity); // 
                SalesOrderLine."Location Code" := SalesQuoteLine."Location Code";
                SalesOrderLine.Insert();
            until SalesQuoteLine.Next() = 0;

            // SalesReturnOrder.Status := SalesReturnOrder.Status::Released;
            SalesReturnOrder.Modify();
            Commit();
            // NewReturnOrderNo := SalesReturnOrder."No.";
            // // Return the created SalesReturnOrder document for further processing if needed
            // MESSAGE('Sales Return Order created with No: %1', NewReturnOrderNo);
            page.Run(page::"Sales Return Order", SalesReturnOrder);
        end;

    end;
}
