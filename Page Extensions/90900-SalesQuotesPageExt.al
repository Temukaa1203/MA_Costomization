pageextension 90900 SalesQuoteExt extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field("Order Type"; rec."Order Type")
            {
                ShowMandatory = true;
                Editable = true;
                ApplicationArea = All;
                ToolTip = 'Order Type';
                trigger OnValidate()
                begin
                    InitializeVariables();
                    SetTransferFromtoCode(); // Call to set Transfer-from Code when page is opened.
                end;
            }
            // field(SystemCreatedBy; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
            // {
            //     ApplicationArea = all;
            // }
            // field("Transfer-from Code"; Rec."Transfer-from Code")
            // {

            //     ApplicationArea = All;
            //     Visible = isvisible;
            // }
            // field("Transfer-to Code"; rec."Transfer-to Code")
            // {
            //     ApplicationArea = All;
            //     Visible = isvisible;
            // }


            group(Showgroup)
            {
                ShowCaption = false;
                Visible = isvisible;
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }

                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                // field("Return Code"; rec."Return Code")
                // {
                //     ApplicationArea = All;
                // }
            }
            group(Showgroup1)
            {
                ShowCaption = false;
                Visible = isvisible1;
                field("Return Code"; rec."Return Code")
                {
                    ApplicationArea = All;
                }
            }

        }

    }

    actions
    {
        addlast(Processing)
        {
            action(NewTransferOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Transfer Order';
                Image = TransferOrder;
                trigger OnAction()
                var
                    TransferOrder: Record "Transfer Header";
                    SalesQuoteLine: Record "Sales Line";
                    SalesQuote: Record "Sales header";
                    NewTransferOrderNo: Code[20];
                    TransferOrderLine: Record "Transfer Line";
                    Location: record Location;
                    TransferOrderCreator: Codeunit "TransferOrderCreator";
                begin
                    TransferOrderCreator.CreateTransferOrder(Rec);
                    // if not Location.Get(rec."Transfer-from Code") then
                    //     error('Location not found for Transfer-from Code %1', rec."Transfer-from Code");
                    // TransferOrder.Init(); // Set appropriate fields
                    // TransferOrder."Transfer-to Code" := rec."Transfer-to Code"; // Specify the target location
                    // TransferOrder."Transfer-from Code" := rec."Transfer-from Code";
                    // TransferOrder."SQ no" := rec."No.";
                    // TransferOrder."In-Transit Code" := 'IN-TRANSIT';
                    // TransferOrder."Transfer-from Name" := Location.Name;
                    // TransferOrder."Transfer-from Name 2" := Location."Name 2";
                    // TransferOrder."Transfer-from Address" := Location.Address;
                    // TransferOrder."Transfer-from Address 2" := Location."Address 2";
                    // TransferOrder."Transfer-from Post Code" := Location."Post Code";
                    // TransferOrder."Transfer-from City" := Location.City;
                    // TransferOrder."Transfer-from County" := Location.County;
                    // TransferOrder."Trsf.-from Country/Region Code" := Location."Country/Region Code";
                    // TransferOrder."Transfer-from Contact" := Location.Contact;
                    // TransferOrder."Transfer-to Name" := Location.Name;
                    // TransferOrder."Transfer-to Name 2" := Location."Name 2";
                    // TransferOrder."Transfer-to Address" := Location.Address;
                    // TransferOrder."Transfer-to Address 2" := Location."Address 2";
                    // TransferOrder."Transfer-to Post Code" := Location."Post Code";
                    // TransferOrder."Transfer-to City" := Location.City;
                    // TransferOrder."Transfer-to County" := Location.County;
                    // TransferOrder."Trsf.-to Country/Region Code" := Location."Country/Region Code";
                    // // TransferOrder."Transfer-to Contact" := Location.Contact;
                    // // TransferOrder."In-Transit Code" := 'IN-TRANSIT';
                    // // Insert the Transfer Order
                    // TransferOrder.Insert(true);

                    // // Loop through the Sales Quote lines and add them to the Transfer Order
                    // SalesQuoteLine.SetRange("Document No.", rec."No.");
                    // if SalesQuoteLine.FindSet() then begin
                    //     repeat
                    //         TransferOrderLine.Init(); // Initialize new line record
                    //         TransferOrderLine."Document No." := TransferOrder."No."; // Link to Transfer Order
                    //         TransferOrderLine."Item No." := SalesQuoteLine."No."; // Correctly reference Item No.
                    //         TransferOrderLine."Quantity" := SalesQuoteLine.Quantity;// Validate Quantity
                    //         TransferOrderLine."Description" := SalesQuoteLine."Description";
                    //         TransferOrderLine."Line No." := SalesQuoteLine."Line No.";
                    //         TransferOrderLine."Qty. to Ship" := SalesQuoteLine."Qty. to Ship";
                    //         TransferOrderLine."Quantity Shipped" := SalesQuoteLine."Quantity Shipped";
                    //         TransferOrderLine."Unit of Measure Code" := SalesQuoteLine."Unit of Measure Code";
                    //         TransferOrderLine."Unit of Measure" := SalesQuoteLine."Unit of Measure";
                    //         TransferOrderLine."Inventory Posting Group" := SalesQuoteLine."Posting Group";
                    //         TransferOrderLine."Quantity (Base)" := SalesQuoteLine."Quantity (Base)";
                    //         TransferOrderLine."Outstanding Qty. (Base)" := SalesQuoteLine."Outstanding Qty. (Base)";
                    //         TransferOrderLine."Qty. Shipped (Base)" := SalesQuoteLine."Qty. Shipped (Base)";
                    //         TransferOrderLine."Outstanding Quantity" := SalesQuoteLine."Outstanding Quantity";
                    //         TransferOrderLine."Gross Weight" := SalesQuoteLine."Gross Weight";
                    //         TransferOrderLine."Net Weight" := SalesQuoteLine."Net Weight";
                    //         TransferOrderLine."Unit Volume" := SalesQuoteLine."Unit Volume";
                    //         TransferOrderLine."Qty. Rounding Precision" := SalesQuoteLine."Qty. Rounding Precision";
                    //         TransferOrderLine."Qty. Rounding Precision (Base)" := SalesQuoteLine."Qty. Rounding Precision (Base)";
                    //         TransferOrderLine."Variant Code" := SalesQuoteLine."Variant Code";
                    //         TransferOrderLine."Units per Parcel" := SalesQuoteLine."Units per Parcel";
                    //         TransferOrderLine."Description 2" := SalesQuoteLine."Description 2";
                    //         TransferOrderLine."Appl.-to Item Entry" := SalesQuoteLine."Appl.-to Item Entry";
                    //         TransferOrderLine."Dimension Set ID" := SalesQuoteLine."Dimension Set ID";
                    //         TransferOrderLine."In-Transit Code" := 'IN-TRANSIT';
                    //         // TransferOrderLine. := SalesQuoteLine.;
                    //         // TransferOrderLine. := SalesQuoteLine.;
                    //         // TransferOrderLine. := SalesQuoteLine.;

                    //         TransferOrderLine."Gen. Prod. Posting Group" := SalesQuoteLine."Gen. Prod. Posting Group";

                    //         TransferOrderLine."Transfer-from Code" := TransferOrder."Transfer-from Code";
                    //         TransferOrderLine."Transfer-to Code" := TransferOrder."Transfer-to Code";
                    //         TransferOrderLine."Shipment Date" := TransferOrder."Shipment Date";
                    //         TransferOrderLine."Receipt Date" := TransferOrder."Receipt Date";
                    //         TransferOrderLine.Validate(Quantity, SalesQuoteLine.Quantity);
                    //         TransferOrderLine.Insert(); // Insert the new line

                    //     until SalesQuoteLine.Next() = 0;
                    // end;

                    // // Open the new Transfer Order page
                    // NewTransferOrderNo := TransferOrder."No."; // Capture the new order number
                    // PAGE.RUN(PAGE::"Transfer Order", TransferOrder);
                end;

            }
            action(releasedSQ)
            {
                ApplicationArea = All;
                Caption = 'releasedSQ';
                trigger OnAction()
                var
                    utility: Codeunit PP_Utility;
                begin
                    utility.Run()
                end;

            }
        }
        addafter(NewTransferOrder)
        {
            action(SalesReturnOrder)
            {
                ApplicationArea = All;
                Caption = 'Make Sales Return Order';
                Image = Sales;
                trigger OnAction()
                var
                    SalesQuoteLine: Record "Sales Line";
                    SalesOrderLine: Record "Sales Line";
                    SalesQuote: Record "Sales header";
                    salesreturnorder: Record "Sales header";
                    NewReturnOrderNo: Code[20];
                    returncode: Record "Return Reason";
                    srocreator: Codeunit "SalesReturnOrderProcessor";
                begin
                    srocreator.CreateSalesReturnOrder(Rec);

                    // if not returncode.Get(rec."Return Code") then
                    //     Error('Return reason not found');
                    // SalesReturnOrder.Init();
                    // SalesReturnOrder."Document Type" := SalesReturnOrder."Document Type"::"Return Order";
                    // SalesReturnOrder."Sell-to Customer no." := rec."Sell-to Customer no.";
                    // SalesReturnOrder."Sell-to Customer name 2" := rec."Sell-to Customer name 2";
                    // SalesReturnOrder."Sell-to Customer name" := rec."Sell-to Customer name";
                    // SalesReturnOrder."Sell-to address" := rec."Sell-to address";
                    // SalesReturnOrder."Sell-to address 2" := rec."Sell-to address 2";
                    // SalesReturnOrder."assigned user id" := rec."assigned user id";
                    // SalesReturnOrder."Your Reference" := rec."Your Reference";
                    // SalesReturnOrder."Sell-to city" := rec."Sell-to city";
                    // SalesReturnOrder."Sell-to city" := rec."Sell-to city";
                    // SalesReturnOrder."Sell-to city" := rec."Sell-to city";
                    // SalesReturnOrder."Sell-to contact" := rec."Sell-to contact";
                    // SalesReturnOrder."Sell-to post code" := rec."Sell-to post code";
                    // SalesReturnOrder."Sell-to county" := rec."Sell-to County";
                    // SalesReturnOrder."Sell-to IC Partner Code" := rec."Sell-to IC Partner Code";
                    // SalesReturnOrder."Sell-to phone no." := rec."Sell-to phone no.";
                    // SalesReturnOrder."Sell-to e-mail" := rec."Sell-to e-mail";
                    // SalesReturnOrder."Sell-to contact no." := rec."Sell-to contact no.";
                    // SalesReturnOrder."Sell-to Country/Region Code" := rec."Sell-to Country/Region Code";
                    // SalesReturnOrder."Customer Posting Group" := rec."Customer Posting Group";
                    // SalesReturnOrder."Customer Disc. Group" := rec."Customer Disc. Group";
                    // SalesReturnOrder."Customer Price Group" := rec."Customer Price Group";
                    // SalesReturnOrder."VAT Bus. Posting Group" := rec."VAT Bus. Posting Group";
                    // SalesReturnOrder."Gen. Bus. Posting Group" := rec."Gen. Bus. Posting Group";
                    // SalesReturnOrder."Return Code" := rec."Return Code";
                    // SalesReturnOrder."External Document No." := rec."External Document No.";
                    // SalesReturnOrder."Return Code" := rec."Return Code";
                    // SalesReturnOrder."Sell-to Customer Templ. Code" := rec."Sell-to Customer Templ. Code";
                    // SalesReturnOrder."bill-to name" := rec."bill-to name";
                    // SalesReturnOrder."bill-to name 2" := rec."bill-to name 2";
                    // SalesReturnOrder."bill-to city" := rec."bill-to city";
                    // SalesReturnOrder."bill-to address 2" := rec."bill-to address 2";
                    // SalesReturnOrder."bill-to contact" := rec."bill-to contact";
                    // SalesReturnOrder."Bill-to Country/Region Code" := rec."Bill-to Country/Region Code";
                    // SalesReturnOrder."Bill-to IC Partner Code" := rec."Bill-to IC Partner Code";
                    // SalesReturnOrder."Bill-to Contact No." := rec."Bill-to Contact No.";
                    // SalesReturnOrder."Bill-to Customer Templ. Code" := rec."Bill-to Customer Templ. Code";
                    // SalesReturnOrder."bill-to post code" := rec."bill-to post code";
                    // SalesReturnOrder."bill-to address" := rec."bill-to address";
                    // SalesReturnOrder."bill-to Customer no." := rec."bill-to Customer no.";
                    // SalesReturnOrder.Insert(true);
                    // SalesQuoteLine.SetRange("Document No.", rec."No.");
                    // if SalesQuoteLine.FindSet() then begin
                    //     repeat
                    //         SalesOrderLine.Init();
                    //         SalesOrderLine."Document Type" := SalesOrderLine."Document Type"::"Return Order";
                    //         SalesOrderLine."Document No." := SalesReturnOrder."No."; // Set the document number
                    //         SalesOrderLine."No." := SalesQuoteLine."No."; // Reference the Item No.
                    //         SalesOrderLine."type" := SalesQuoteLine."Type";
                    //         SalesOrderLine."Posting Group" := SalesQuoteLine."Posting Group";
                    //         SalesOrderLine."Customer Price Group" := SalesQuoteLine."Customer Price Group";
                    //         SalesOrderLine."Gen. Bus. Posting Group" := SalesQuoteLine."Gen. Bus. Posting Group";
                    //         SalesOrderLine."Gen. Prod. Posting Group" := SalesQuoteLine."Gen. Prod. Posting Group";
                    //         SalesOrderLine."Tax Group Code" := SalesQuoteLine."Tax Group Code";
                    //         SalesOrderLine."Description" := SalesQuoteLine."Description";
                    //         SalesOrderLine."VAT Prod. Posting Group" := SalesQuoteLine."VAT Prod. Posting Group";
                    //         SalesOrderLine."Quantity" := SalesQuoteLine.Quantity; // Negative quantity for return
                    //         SalesOrderLine."Unit Price" := SalesQuoteLine."Unit Price"; // Copy unit price from the quote
                    //         SalesOrderLine."Amount" := SalesQuoteLine.Amount; // Copy amount from the quote
                    //         SalesOrderLine."Return Reason Code" := SalesQuoteLine."Return Code";
                    //         SalesOrderLine."Unit of Measure" := SalesQuoteLine."Unit of Measure";// Copy other fields as needed
                    //         SalesOrderLine."Unit of Measure code" := SalesQuoteLine."Unit of Measure code";
                    //         SalesOrderLine."Line no." := SalesQuoteLine."Line No.";
                    //         SalesOrderLine."Line Amount" := SalesQuoteLine."Line Amount";
                    //         SalesOrderLine."Line Discount %" := SalesQuoteLine."Line Discount %";
                    //         SalesOrderLine.Validate(Quantity, SalesQuoteLine.Quantity);
                    //         SalesOrderLine."Location Code" := SalesQuoteLine."Location Code";
                    //         SalesOrderLine.Insert();
                    //     until SalesQuoteLine.Next() = 0;
                    //     NewReturnOrderNo := SalesReturnOrder."No.";
                    //     PAGE.RUN(PAGE::"Sales Return Order", SalesReturnOrder);
                    // end;
                end;
            }
        }
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            var
            begin
                if (rec."Order Type" = rec."Order Type"::"TRANSFER") or (rec."Order Type" = rec."Order Type"::"TRANSFER RETURN") or (rec."Order Type" = rec."Order Type"::"SALES RETURN") then begin
                    error('Transfer Order үүсгэнэ үү.')
                end;
            end;
        }

        // modify(Release)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         cust: record Customer;
        //     begin
        //         cust.get(rec."Sell-to Customer No.");
        //         if cust.FindSet() then begin
        //             if (cust."Customer Type" <> cust."Customer Type"::Agent) and ((rec."Order Type" = rec."Order Type"::TRANSFER) or (rec."Order Type" = rec."Order Type"::"TRANSFER RETURN")) then begin
        //                 error('Агентийн хөдөлгөөн хийх боломжгүй харилцагч байна.');
        //                 // Message((Format(cust."Customer Type")));
        //                 // Message((Format(rec."Order Type")));
        //             end;
        //         end;
        //     end;
        // }
    }


    trigger OnOpenPage()

    begin
        InitializeVariables();

    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        [InDataSet]
        isVisible: Boolean;
        isVisible1: Boolean;

    local procedure InitializeVariables()
    begin
        case rec."Order Type" of
            rec."Order Type"::"SALES":
                SetFieldsVisible3(true);
            rec."Order Type"::"SALES RETURN":
                SetFieldsVisible1(true);
            rec."Order Type"::"TRANSFER RETURN":
                SetFieldsVisible(true);
            rec."Order Type"::"TRANSFER":
                SetFieldsVisible2(true);
        end;

    end;

    // procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    // var
    //     User: Record User;
    // begin
    //     User.Get(UserSecurityID);
    //     exit(User."User Name");
    // end;


    local procedure SetFieldsVisible(newisvisible: Boolean)
    begin
        isVisible := newisvisible;
        isVisible1 := newisvisible;
    end;

    local procedure SetFieldsVisible1(newisvisible: Boolean)
    begin
        isVisible1 := newisvisible;
        isVisible := false;
    end;

    local procedure SetFieldsVisible2(newisvisible: Boolean)
    begin
        isVisible := newisvisible;
        isVisible1 := false;
    end;

    local procedure SetFieldsVisible3(newisvisible: Boolean)
    begin
        isVisible := false;
        isVisible1 := false;
    end;



    local procedure SetTransferFromtoCode()
    var
        Customer: Record "Customer";
    begin
        if rec."Order Type" = rec."Order Type"::"TRANSFER RETURN" then begin
            if rec."Sell-to Customer no." <> '' then begin
                // Get the customer record based on the customer number
                if Customer.Get(rec."Sell-to Customer no.") then begin
                    // Automatically set the Transfer-from Code to the Location Code of the customer
                    rec."Transfer-from Code" := Customer."Agent Location";
                end;
            end;
            rec."Transfer-to Code" := 'PP200'
        end;
        if rec."Order Type" = rec."Order Type"::"TRANSFER" then begin
            if rec."Sell-to Customer no." <> '' then begin
                // Get the customer record based on the customer number
                if Customer.Get(rec."Sell-to Customer no.") then begin
                    // Automatically set the Transfer-from Code to the Location Code of the customer
                    rec."Transfer-to Code" := Customer."Agent Location";
                end;
            end;
            rec."Transfer-from Code" := 'PP200'
        end;

    end;


    // Add a procedure to handle the Return Code being set on new Sales Line
    // local procedure SetReturnCodeOnSalesLine(var SalesLine: Record "Sales Line")
    // begin
    //     // Ensure the Return Code on Sales Line is set to the header's Return Code
    //     if SalesLine."Return Code" = '' then
    //         SalesLine."Return Code" := rec."Return Code"; // Default to the header's Return Code
    // end;

    // trigger OnAfterInsert()
    // var
    //     SalesLine: Record "Sales Line";
    // begin
    //     // After inserting a new Sales Line, ensure the Return Code is set to the header's Return Code
    //     SalesLine.SetRange("Document No.", rec."No."); // Set the document number filter
    //     if SalesLine.FindLast() then
    //         SetReturnCodeOnSalesLine(SalesLine); // Set the Return Code for this new line
    // end;
    // trigger OnAfterGetRecord()
    // var
    //     TransferFromVisible: Boolean;
    //     TransferToVisible: Boolean;
    // begin
    //     // Control visibility of Transfer-from and Transfer-to fields based on Order Type
    //     TransferFromVisible := Rec."Order Type" = Rec."Order Type"::"TRANSFER";
    //     TransferToVisible := Rec."Order Type" = Rec."Order Type"::"TRANSFER";

    //     // Update visibility directly through the page controls
    //     "Transfer-from Code".Visible := TransferFromVisible;
    //     "Transfer-to Code".Visible := TransferToVisible;
    // end;
    // local procedure IsTransferOrder(): Boolean
    // begin
    //     exit(rec."Order Type"= "Order Type"::Transfer); // Adjust this condition based on your business logic
    // end;
}