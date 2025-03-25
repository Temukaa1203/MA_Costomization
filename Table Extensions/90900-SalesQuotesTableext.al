tableextension 90900 SalesQuoteHeaderExt extends "Sales Header"
{
    fields
    {
        field(90900; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(90901; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(90902; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Type';
            Editable = true;
            OptionCaption = 'Борлуулалт,Борлуулалтын буцаалт,Агент (борлуулалт),Агент (борлуулалтын буцаалт)';
            OptionMembers = "SALES","SALES RETURN","TRANSFER","TRANSFER RETURN";
        }
        field(90903; "Return Code"; Code[10])
        {
            Caption = 'Return Code';
            TableRelation = "Return Reason";
            NotBlank = true;
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     salesline: Record "Sales Line";
            //     salesheader: Record "Sales Header";
            // begin
            //     salesline.get(rec."No.");
            //     repeat
            //         salesline."Return Code"
            // end;
        }
        field(90910; "SQ2TO Error"; Text[2048])
        {
            Caption = 'SQ2TO Error';
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(90911; "SRO error"; text[2000])
        {
            Caption = 'SRO error';
            DataClassification = ToBeClassified;
        }
        field(90912; "SQ no."; Code[20])
        {
            Caption = 'SQ no.';
            DataClassification = ToBeClassified;
        }
        field(90913; "SO Error"; Text[2000])
        {
            Caption = 'SO Error';
            DataClassification = ToBeClassified;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                if rec."Document Type" = Rec."Document Type"::"Return Order"
                    then begin
                    rec.validate("Gen. Bus. Posting Group", 'SRO');
                    rec.Validate("VAT Bus. Posting Group", 'VAT10');
                end;
            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}