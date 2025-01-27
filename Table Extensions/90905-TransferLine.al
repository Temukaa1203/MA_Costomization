tableextension 90905 transLineext extends "Transfer Line"
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
        field(90901; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(90902; "Standard KG"; Decimal)
        {
            Caption = 'Standard KG';
            DataClassification = ToBeClassified;
        }
        field(90903; "disc. Unit Price"; Decimal)
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