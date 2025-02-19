codeunit 90903 PP_Utility
{
    trigger OnRun()
    var
        SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
        maketransferorder: Codeunit TransferOrderCreator;
        // makeSalesReturnOrder: codeunit SalesReturnOrderProcessor;
        SalesPerson: Record "Salesperson/Purchaser";
        sqno: code[20];
        salesheaderaddress: text[100];
        InStream: InStream;
        OutStream: OutStream;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        SalesHeader.Reset();
        SalesHeader.SetFilter("Document Type", '=%1', SalesHeader."Document Type"::Quote);
        SalesHeader.SetFilter(Status, '=%1', SalesHeader.Status::Released);
        // SalesHeader.SetFilter("Check Document Type", '=%1', SalesHeader."Check Document Type"::" ");
        // SalesHeader.SetFilter("Promotion Check Status", '<>%1', SalesHeader."Promotion Check Status"::" ");

        if SalesHeader.Find('-') then begin
            repeat
                if SalesHeader."Order Type" = SalesHeader."Order Type"::"SALES" then begin
                    if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") then begin
                        // if SalesPerson.Get(SalesHeader."Salesperson Code") and SalesPerson."Sales-Quote to Order" then begin
                        if trycreateSO(SalesHeader) then begin
                            sqno := SalesHeader."No.";
                            SalesHeaderAddress := SalesHeader."Sell-to Address";
                            SalesHeader.Reset();
                            SalesHeader.SetRange("Quote No.", sqno);
                            if SalesHeader.FindSet() then begin
                                ReleaseSalesDoc.Reopen(SalesHeader);
                                // SalesHeader.Status := SalesHeader.Status::Released;
                                SalesHeader."Work Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                                OutStream.WriteText(salesheaderaddress);
                                // InStream.ReadText(salesheaderaddress);
                                SalesHeader.Modify();
                            end;
                            Commit();
                            //ReleaseSalesDoc.PerformManualRelease(SalesHeader);
                        end;
                    end;
                end;
            until SalesHeader.Next() = 0;
        end;


        SalesHeader.Reset();
        SalesHeader.SetFilter("Document Type", '=%1', SalesHeader."Document Type"::Quote);
        SalesHeader.SetFilter(Status, '=%1', SalesHeader.Status::Released);
        if SalesHeader.Find('-') then begin
            repeat
                if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") and (SalesHeader."Order Type" = SalesHeader."Order Type"::TRANSFER) then begin
                    // if SalesPerson.Get(SalesHeader."Salesperson Code") and SalesPerson."Sales-Quote to Order" then begin
                    // maketransferorder.CreateTransferOrder(SalesHeader);
                    // Message(Format());
                    trycreateTO(SalesHeader)
                    // trycreateTO(SalesHeader);
                end;
                // if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") and (SalesHeader."Order Type" = SalesHeader."Order Type"::"SALES RETURN") then begin
                //     // if SalesPerson.Get(SalesHeader."Salesperson Code") and SalesPerson."Sales-Quote to Order" then begin
                //     makeSalesReturnOrder.CreateSalesReturnOrder(SalesHeader);
                //     Commit();
                // end;
                if Customer.Get(SalesHeader."Sell-to Customer No.") and (Customer.Blocked = Customer.Blocked::" ") and (SalesHeader."Order Type" = SalesHeader."Order Type"::"TRANSFER RETURN") then begin
                    // if SalesPerson.Get(SalesHeader."Salesperson Code") and SalesPerson."Sales-Quote to Order" then begin
                    trycreateTO(SalesHeader)
                end;
            // SalesHeader.Delete();
            until SalesHeader.Next() = 0;
        end;

    end;


    [TryFunction]
    local procedure trycreateTO(var SalesHeader: Record "Sales Header")
    var
        maketransferorder: Codeunit TransferOrderCreator;
        transferorder: Record "Transfer Header";
    begin
        if maketransferorder.CreateTransferOrder(SalesHeader) then begin

            SalesHeader.Delete();
            Commit();
        end
        else begin
            transferorder.Reset();
            transferorder.SetRange("SQ no", SalesHeader."No.");
            if transferorder.FindSet() then begin
                repeat
                    // Message('sqnumber: %1, tonumber : %2', transferorder."SQ no", transferorder."No.");
                    transferorder.Delete();
                until transferorder.Next() = 0;
            end;
        end;
    end;

    [TryFunction]
    local procedure trycreateSO(var SalesHeader: Record "Sales Header")
    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
    begin
        SalesQuoteToOrder.Run(SalesHeader);
        ReleaseSalesDoc.PerformManualRelease(SalesHeader);
    end;
    // [TryFunction]
    // local procedure TrymakeSO(var SalesHeader: Record "Sales Header")
    // var
    //     SalesQuoteToOrder: Codeunit "Sales-Quote to Order";
    // begin
    //     SalesQuoteToOrder.Run(SalesHeader);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterOnRun', '', false, false)]
    local procedure OnAfterOnRun(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        ReleaseSalesDoc.PerformManualRelease(SalesOrderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeModifySalesOrderHeader', '', false, false)]
    local procedure OnBeforeModifySalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderHeader."Posting Date" := SalesQuoteHeader."Shipment Date";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforePerformManualReleaseProcedure', '', false, false)]
    local procedure OnBeforePerformManualReleaseProcedure(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
        "Sales Info-Pane Management": Codeunit "Sales Info-Pane Management";
        CheckQty: Decimal;
        Item: Record Item;
        cust: Record customer;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) then begin
            SalesLine.Reset();
            SalesLine.SetFilter("Document Type", '=%1', SalesHeader."Document Type");
            SalesLine.SetFilter("Document No.", '=%1', SalesHeader."No.");
            SalesLine.SetFilter(Type, '=%1', SalesLine.Type::Item);


            // if SalesLine.find('-') then
            //     repeat
            //         Item.Get(SalesLine."No.");
            //         if not Item."Assembly BOM" then begin
            //             CheckQty := "Sales Info-Pane Management".CalcAvailability(SalesLine);
            //             if SalesLine.Quantity > CheckQty then
            //                 Error('Item No.:' + SalesLine."No." + ' Таны оруулсан тоо ширхэг боломжит хэмжээнээс их байна. Боломжит тоо ширхэг (' + Format(CheckQty) + ')');
            //         end;
            //     until SalesLine.Next() = 0;
            if (SalesHeader."Order Type" = SalesHeader."Order Type"::TRANSFER) or (SalesHeader."Order Type" = SalesHeader."Order Type"::"TRANSFER RETURN") then begin
                cust.get(SalesHeader."Sell-to Customer No.");
                if (cust."Customer Type" <> cust."Customer Type"::Agent) and (cust."Customer Type" <> cust."Customer Type"::"Нэрийн Дэлгүүр") then begin
                    Error('Агентын хөдөлгөөн хийх боломжгүй харилцагч байна. Customer Type эсвэл Order Type шалгана уу.');
                end;
            end else begin
                if (SalesHeader."Order Type" = SalesHeader."Order Type"::SALES) or (SalesHeader."Order Type" = SalesHeader."Order Type"::"SALES RETURN") then begin
                    cust.get(SalesHeader."Sell-to Customer No.");
                    if (cust."Customer Type" = cust."Customer Type"::Agent) or (cust."Customer Type" = cust."Customer Type"::"Нэрийн Дэлгүүр") then begin
                        Error('Борлуулалтын хөдөлгөөн хийх боломжгүй харилцагч байна. Customer Type эсвэл Order Type шалгана уу.');
                    end;
                end
            end;
        end;
    end;



    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    // local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean)
    // begin
    //     if SalesCrMemoHdrNo <> '' then begin
    //         GenerateReturnJournal(SalesCrMemoHdrNo);
    //     end;
    // end;


    // procedure GenerateReturnJournal(SalesCrMemoHdrNo: Code[20])
    // var
    //     SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    //     SalesCrMemoLine: Record "Sales Cr.Memo Line";
    //     GenLedgSetup: Record "General Ledger Setup";
    //     GenJnlLine: Record "Gen. Journal Line";
    // begin
    //     if SalesCrMemoHdrNo <> '' then begin
    //         GenLedgSetup.Get();

    //         GenJnlLine.Reset();
    //         GenJnlLine.SetFilter("Journal Template Name", '=%1', 'GENERAL');
    //         GenJnlLine.SetFilter("Journal Batch Name", '=%1', GenLedgSetup."Return Order Journal Batch");
    //         GenJnlLine.DeleteAll();

    //         SalesCrMemoLine.Reset();
    //         SalesCrMemoLine.SetFilter("Document No.", '=%1', SalesCrMemoHdrNo);
    //         SalesCrMemoLine.SetFilter(Type, '<>%1', SalesCrMemoLine.Type::" ");
    //         if SalesCrMemoLine.find('-') then
    //             repeat
    //                 CreateReturnJournal(SalesCrMemoLine);
    //             until SalesCrMemoLine.Next() = 0;
    //         Message('Successfully generated general journal.');
    //     end;
    // end;

    // local procedure CreateReturnJournal(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    // var
    //     GenJnlLine: Record "Gen. Journal Line";
    //     GenLedgSetup: Record "General Ledger Setup";
    //     GenPostingSetup: Record "General Posting Setup";
    // begin
    //     GenPostingSetup.Get(SalesCrMemoLine."Gen. Bus. Posting Group", SalesCrMemoLine."Gen. Prod. Posting Group");
    //     GenLedgSetup.Get();
    //     if SalesCrMemoLine."Amount Including VAT" <> 0 then begin
    //         Clear(GenJnlLine);
    //         GenJnlLine.Init();
    //         GenJnlLine.Validate("Journal Template Name", 'GENERAL');
    //         GenJnlLine.Validate("Journal Batch Name", GenLedgSetup."Return Order Journal Batch");
    //         GenJnlLine.Validate("Line No.", GetLineNo(GenLedgSetup."Return Order Journal Batch"));
    //         GenJnlLine.Validate("Posting Date", SalesCrMemoLine."Posting Date");
    //         GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
    //         GenJnlLine.Validate("Account No.", GenLedgSetup."Борлуулалтын буцаалтын данс");
    //         GenJnlLine.Validate(Amount, -1 * SalesCrMemoLine."Amount Including VAT");
    //         GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
    //         GenJnlLine.Validate("Bal. Account No.", GenPostingSetup."Sales Credit Memo Account");
    //         GenJnlLine.Validate("Description", 'RSC-' + SalesCrMemoLine."Document No." + '-' + Format(SalesCrMemoLine."Line No."));
    //         GenJnlLine.Validate("Document No.", 'RSC-' + SalesCrMemoLine."Document No." + '-' + Format(SalesCrMemoLine."Line No."));
    //         GenJnlLine.Insert();
    //     end;


    //     if SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount" <> 0 then begin
    //         Clear(GenJnlLine);
    //         GenJnlLine.Init();
    //         GenJnlLine.Validate("Journal Template Name", 'GENERAL');
    //         GenJnlLine.Validate("Journal Batch Name", GenLedgSetup."Return Order Journal Batch");
    //         GenJnlLine.Validate("Line No.", GetLineNo(GenLedgSetup."Return Order Journal Batch"));
    //         GenJnlLine.Validate("Posting Date", SalesCrMemoLine."Posting Date");
    //         GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
    //         GenJnlLine.Validate("Account No.", GenLedgSetup."Борлуулалтын хөнгөлөлтийн данс");
    //         GenJnlLine.Validate(Amount, -1 * (SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount"));
    //         GenJnlLine.Validate("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
    //         GenJnlLine.Validate("Bal. Account No.", GenPostingSetup."Sales Credit Memo Account");
    //         GenJnlLine.Validate("Description", 'RSC-' + SalesCrMemoLine."Document No." + '-' + Format(SalesCrMemoLine."Line No."));
    //         GenJnlLine.Validate("Document No.", 'RSC-' + SalesCrMemoLine."Document No." + '-' + Format(SalesCrMemoLine."Line No."));
    //         GenJnlLine.Insert();
    // //     end;

    // end;


    local procedure GetLineNo(BatchName: Code[20]): Integer
    var
        JournalLine: Record "Gen. Journal Line";
    begin
        JournalLine.Reset();
        JournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        JournalLine.SetRange("Journal Template Name", 'GENERAL');
        JournalLine.SetRange("Journal Batch Name", BatchName);
        JournalLine.Ascending(FALSE);
        if JournalLine.FindFirst() then
            exit(10000 + JournalLine."Line No.")
        else
            exit(10000)
    end;
}