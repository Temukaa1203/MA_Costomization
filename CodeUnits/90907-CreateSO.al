// codeunit 90907 "Create SO"
// {
//     trigger OnRun()
//     var
//         SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
//         SalesHeader: Record "Sales Header";
//         Customer: Record Customer;
//         maketransferorder: Codeunit TransferOrderCreator;
//         makeSalesReturnOrder: codeunit SalesReturnOrderProcessor;
//         SalesPerson: Record "Salesperson/Purchaser";
//         sqno: code[20];
//         salesheaderaddress: text[100];
//         InStream: InStream;
//         OutStream: OutStream;
//         ReleaseSalesDoc: Codeunit "Release Sales Document";
//     begin
//         SalesHeader.Reset();
//         SalesHeader.SetFilter("Document Type", '=%1', SalesHeader."Document Type"::Quote);
//         SalesHeader.SetFilter(Status, '=%1', SalesHeader.Status::Released);
//         SalesHeader.SetFilter("Order Type", '=%1', SalesHeader."Order Type"::SALES);
//         // SalesHeader.SetFilter("Check Document Type", '=%1', SalesHeader."Check Document Type"::" ");
//         // SalesHeader.SetFilter("Promotion Check Status", '<>%1', SalesHeader."Promotion Check Status"::" ");

//         if SalesHeader.Find('-') then begin
//             repeat
//                 if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") then begin
//                     // if SalesPerson.Get(SalesHeader."Salesperson Code") and SalesPerson."Sales-Quote to Order" then begin
//                     if trycreateSO(SalesHeader) then begin
//                         Commit();
//                     end;
//                 end;
//             until SalesHeader.Next() = 0;
//         end;
//     end;

//     [TryFunction]
//     local procedure trycreateSO(var SalesHeader: Record "Sales Header")
//     var
//         ReleaseSalesDoc: Codeunit "Release Sales Document";
//         SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
//     begin
//         SalesQuoteToOrder.Run(SalesHeader);
//         // ReleaseSalesDoc.PerformManualRelease(SalesHeader);
//     end;
// }