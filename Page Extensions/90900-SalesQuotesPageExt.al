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
            field("SRO error"; Rec."SRO error")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("SO Error"; Rec."SO Error")
            {
                ApplicationArea = All;
                Editable = false;
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
            field("PickPack Delivery Type Code"; Rec."PickPack Delivery Type Code")
            {
                Editable = true;
                ApplicationArea = All;
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

                end;

            }
            // action(releasedSQ)
            // {
            //     ApplicationArea = All;
            //     Caption = 'releasedSQ';
            //     trigger OnAction()
            //     var
            //         utility: Codeunit PP_Utility;
            //     begin
            //         utility.Run()
            //     end;

            // }
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