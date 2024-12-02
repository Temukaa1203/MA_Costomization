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
    begin
        // If the "Return Code" is not already set, use the value from the "Sales Header"
        if "Return Code" = '' then begin
            if SalesQuoteHeader.Get("Document Type", "Document No.") then begin
                "Return Code" := SalesQuoteHeader."Return Code"; // Set the Return Code from the header
            end;
        end;
    end;

    var
        myInt: Integer;
}