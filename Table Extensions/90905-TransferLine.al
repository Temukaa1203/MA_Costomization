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