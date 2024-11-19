pageextension 90900 SalesQuoteExt extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field("Order Type"; rec."Order Type")
            {
                NotBlank = true;
                Editable = true;
                ApplicationArea = All;
                ToolTip = 'Order Type';
                trigger OnValidate()
                begin
                    initializevariables();
                    // Message('Current Order Type: %1', Rec."Order Type");
                    // if Rec."Order Type" = Rec."Order Type"::TRANSFER then begin
                    //     isvisible := true;
                    // end
                    // else begin
                    //     isvisible := false;
                    // end;
                    // Message('isvisible: %1', isvisible);
                end;

            }
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
                begin

                    if not Location.Get(rec."Transfer-from Code") then
                        error('Location not found for Transfer-from Code %1', rec."Transfer-from Code");
                    TransferOrder.Init(); // Set appropriate fields
                    TransferOrder."Transfer-to Code" := rec."Transfer-to Code"; // Specify the target location
                    TransferOrder."Transfer-from Code" := rec."Transfer-from Code";
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
                    TransferOrder."Transfer-to Contact" := Location.Contact;
                    // Insert the Transfer Order
                    TransferOrder.Insert(true);

                    // Loop through the Sales Quote lines and add them to the Transfer Order
                    SalesQuoteLine.SetRange("Document No.", rec."No.");
                    if SalesQuoteLine.FindSet() then begin
                        repeat

                            TransferOrderLine.Init(); // Initialize new line record
                            TransferOrderLine."Document No." := TransferOrder."No."; // Link to Transfer Order
                            TransferOrderLine."Item No." := SalesQuoteLine."No."; // Correctly reference Item No.
                            TransferOrderLine."Quantity" := SalesQuoteLine.Quantity;// Validate Quantity
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
                            // TransferOrderLine. := SalesQuoteLine.;
                            // TransferOrderLine. := SalesQuoteLine.;
                            // TransferOrderLine. := SalesQuoteLine.;

                            TransferOrderLine."Gen. Prod. Posting Group" := SalesQuoteLine."Gen. Prod. Posting Group";

                            TransferOrderLine."Transfer-from Code" := TransferOrder."Transfer-from Code";
                            TransferOrderLine."Transfer-to Code" := TransferOrder."Transfer-to Code";
                            TransferOrderLine."Shipment Date" := TransferOrder."Shipment Date";
                            TransferOrderLine."Receipt Date" := TransferOrder."Receipt Date";
                            TransferOrderLine.Validate(Quantity, SalesQuoteLine.Quantity);
                            TransferOrderLine.Insert(); // Insert the new line

                        until SalesQuoteLine.Next() = 0;
                    end;

                    // Open the new Transfer Order page
                    NewTransferOrderNo := TransferOrder."No."; // Capture the new order number
                    PAGE.RUN(PAGE::"Transfer Order", TransferOrder);
                end;

            }
        }
    }



    trigger OnOpenPage()

    begin
        initializeVariables();
    end;

    var
        [InDataSet]
        isVisible: Boolean;

    local procedure InitializeVariables()
    begin
        case rec."Order Type" of
            rec."Order Type"::"TRANSFER":
                SetFieldsVisible(true);
            rec."Order Type"::"SALES":
                SetFieldsVisible(false);
        end;

    end;

    local procedure SetFieldsVisible(newisvisible: Boolean)
    begin
        isVisible := newisvisible;
    end;
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