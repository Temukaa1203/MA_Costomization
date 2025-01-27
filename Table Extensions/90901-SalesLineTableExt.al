tableextension 90901 SalesLine_ReturnCode extends "Sales Line"
{
    fields
    {
        field(90900; "Return Code"; code[10])
        {
            Caption = 'Return Code';
            TableRelation = "Return Reason";
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(90901; "Standard KG"; Decimal)
        {
            Caption = 'Standard KG';
            DataClassification = ToBeClassified;
        }
        field(90902; "Disc. Unit Price"; Decimal)
        {
            Caption = 'Disc. Unit Price';
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
    trigger OnInsert()
    var
        SalesQuoteHeader: Record "Sales Header";
        items: record Item;
    begin
        // If the "Return Code" is not already set, use the value from the "Sales Header"
        if "Return Code" = '' then begin
            if SalesQuoteHeader.Get("Document Type", "Document No.") then begin
                "Return Code" := SalesQuoteHeader."Return Code"; // Set the Return Code from the header
            end;
        end;
        // if "Standard KG" = 0 then begin
        //     if items.get("No.") then begin
        //         "Standard KG" := items."Standard KG";
        //     end;
        // end;
    end;

    var
        myInt: Integer;
}