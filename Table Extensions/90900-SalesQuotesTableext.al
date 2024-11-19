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
            OptionCaption = 'SALES,TRANSFER';
            OptionMembers = "SALES","TRANSFER";
        }
        field(90903; "Return Code"; Code[10])
        {
            Caption = 'Return Code';
            TableRelation = "Return Reason";
            NotBlank = true;
            DataClassification = ToBeClassified;
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