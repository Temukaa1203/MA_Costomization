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
        field(90901; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Type';
            Editable = true;
            OptionCaption = 'Agent,Company,Intercompany,Person,Internal,Нэрийн Дэлгүүр';
            OptionMembers = "Agent","Company","Intercompany","Person","Internal","Нэрийн Дэлгүүр";
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