tableextension 90902 customerlocationext extends Customer
{
    fields
    {
        field(90900; "Agent Location"; code[10])
        {
            Caption = 'Agent Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
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