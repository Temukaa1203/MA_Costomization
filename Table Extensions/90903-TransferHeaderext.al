tableextension 90903 transheadext extends "Transfer Header"
{
    fields
    {
        field(90900; "SQ no"; code[20])
        {
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