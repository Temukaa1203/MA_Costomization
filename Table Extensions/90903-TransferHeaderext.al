tableextension 90903 transheadext extends "Transfer Header"
{
    fields
    {
        field(90900; "SQ no"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90901; "Return Code"; code[10])
        {
            Caption = 'Return Code';
            TableRelation = "Return Reason";
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(90902; "Salesperson Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Salesperson Code';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(90903; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
            Editable = false;
        }
        // field(90904; "Total VAT"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Total VAT';
        //     Editable = false;
        // }
        // field(90905; "Total Incl. VAT"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Total Incl. VAT';
        //     Editable = false;
        // }
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