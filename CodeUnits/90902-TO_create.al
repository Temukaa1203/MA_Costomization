codeunit 90902 "TransferOrderCreator"
{
    procedure CreateTransferOrder(SalesQuoteHeader: Record "Sales Header")
    var
        TransferOrder: Record "Transfer Header";
        SalesQuoteLine: Record "Sales Line";
        TransferOrderLine: Record "Transfer Line";
        Location: Record Location;
        NewTransferOrderNo: Code[20];
    begin
        // Get the location based on the "Transfer-from Code"
        if not Location.Get(SalesQuoteHeader."Transfer-from Code") then
            Error('Location not found for Transfer-from Code %1', SalesQuoteHeader."Transfer-from Code");

        // Initialize the Transfer Order header
        TransferOrder.Init();
        TransferOrder."Transfer-to Code" := SalesQuoteHeader."Transfer-to Code";
        TransferOrder."Transfer-from Code" := SalesQuoteHeader."Transfer-from Code";
        TransferOrder."SQ no" := SalesQuoteHeader."No.";
        TransferOrder."In-Transit Code" := 'IN-TRANSIT';
        TransferOrder."Transfer-from Name" := Location.Name;
        TransferOrder."Transfer-from Name 2" := Location."Name 2";
        TransferOrder."Transfer-from Address" := Location.Address;
        TransferOrder."Transfer-from Address 2" := Location."Address 2";
        TransferOrder."Transfer-from Post Code" := Location."Post Code";
        TransferOrder."Transfer-from City" := Location.City;
        TransferOrder."Transfer-from County" := Location.County;
        TransferOrder."Trsf.-from Country/Region Code" := Location."Country/Region Code";
        TransferOrder."Transfer-from Contact" := Location.Contact;
        TransferOrder."Transfer-to Name" := Location.Name;
        TransferOrder."Transfer-to Name 2" := Location."Name 2";
        TransferOrder."Transfer-to Address" := Location.Address;
        TransferOrder."Transfer-to Address 2" := Location."Address 2";
        TransferOrder."Transfer-to Post Code" := Location."Post Code";
        TransferOrder."Transfer-to City" := Location.City;
        TransferOrder."Transfer-to County" := Location.County;
        TransferOrder."Trsf.-to Country/Region Code" := Location."Country/Region Code";
        TransferOrder."Return Code" := SalesQuoteHeader."Return Code";
        // Insert the Transfer Order header
        TransferOrder.Insert(true);

        // Loop through the Sales Quote lines and add them to the Transfer Order
        SalesQuoteLine.SetRange("Document No.", SalesQuoteHeader."No.");
        if SalesQuoteLine.FindSet() then begin
            repeat
                TransferOrderLine.Init(); // Initialize new line record
                TransferOrderLine."Document No." := TransferOrder."No."; // Link to Transfer Order
                TransferOrderLine."Item No." := SalesQuoteLine."No."; // Correctly reference Item No.
                TransferOrderLine."Quantity" := SalesQuoteLine.Quantity;
                TransferOrderLine."Description" := SalesQuoteLine."Description";
                TransferOrderLine."Line No." := SalesQuoteLine."Line No.";
                TransferOrderLine."Qty. to Ship" := SalesQuoteLine."Qty. to Ship";
                TransferOrderLine."Quantity Shipped" := SalesQuoteLine."Quantity Shipped";
                TransferOrderLine."Unit of Measure Code" := SalesQuoteLine."Unit of Measure Code";
                TransferOrderLine."Unit of Measure" := SalesQuoteLine."Unit of Measure";
                TransferOrderLine."Inventory Posting Group" := SalesQuoteLine."Posting Group";
                TransferOrderLine."Quantity (Base)" := SalesQuoteLine."Quantity (Base)";
                TransferOrderLine."Outstanding Qty. (Base)" := SalesQuoteLine."Outstanding Qty. (Base)";
                TransferOrderLine."Qty. Shipped (Base)" := SalesQuoteLine."Qty. Shipped (Base)";
                TransferOrderLine."Outstanding Quantity" := SalesQuoteLine."Outstanding Quantity";
                TransferOrderLine."Gross Weight" := SalesQuoteLine."Gross Weight";
                TransferOrderLine."Net Weight" := SalesQuoteLine."Net Weight";
                TransferOrderLine."Unit Volume" := SalesQuoteLine."Unit Volume";
                TransferOrderLine."Qty. Rounding Precision" := SalesQuoteLine."Qty. Rounding Precision";
                TransferOrderLine."Qty. Rounding Precision (Base)" := SalesQuoteLine."Qty. Rounding Precision (Base)";
                TransferOrderLine."Variant Code" := SalesQuoteLine."Variant Code";
                TransferOrderLine."Units per Parcel" := SalesQuoteLine."Units per Parcel";
                TransferOrderLine."Description 2" := SalesQuoteLine."Description 2";
                TransferOrderLine."Appl.-to Item Entry" := SalesQuoteLine."Appl.-to Item Entry";
                TransferOrderLine."Dimension Set ID" := SalesQuoteLine."Dimension Set ID";
                TransferOrderLine."In-Transit Code" := 'IN-TRANSIT';
                TransferOrderLine."Return Code" := SalesQuoteLine."Return Code";
                TransferOrderLine."Gen. Prod. Posting Group" := SalesQuoteLine."Gen. Prod. Posting Group";
                TransferOrderLine."Transfer-from Code" := TransferOrder."Transfer-from Code";
                TransferOrderLine."Transfer-to Code" := TransferOrder."Transfer-to Code";
                TransferOrderLine."Shipment Date" := TransferOrder."Shipment Date";
                TransferOrderLine."Receipt Date" := TransferOrder."Receipt Date";

                // Validate and insert the new line into the Transfer Order
                TransferOrderLine.Validate(Quantity, SalesQuoteLine.Quantity);
                TransferOrderLine.Insert();
            until SalesQuoteLine.Next() = 0;
        end;
        TransferOrder.Status := TransferOrder.Status::Released;
        TransferOrder.Modify();
        // Return the Transfer Order number
        // NewTransferOrderNo := TransferOrder."No."; // Capture the new order number
        // // Optionally, you could return the Transfer Order record, or implement additional logic here
        // Message('Transfer Order %1 has been created.', NewTransferOrderNo);
        // PAGE.RUN(PAGE::"Transfer Order", TransferOrder);
    end;
}