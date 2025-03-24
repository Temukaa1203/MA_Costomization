tableextension 90906 saleslineext extends "Sales Invoice Line"
{
    fields
    {
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

    var
        myInt: Integer;
}