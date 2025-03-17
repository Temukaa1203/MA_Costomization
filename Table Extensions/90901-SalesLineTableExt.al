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
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                discprice: Decimal;
                item: Record Item;
                SalesQuoteHeader: Record "Sales Header";
            begin
                if item.Get(rec."No.") then begin
                    rec.validate(rec."Standard KG", item."Standard KG");
                    if rec."Line Discount %" = 0 then begin
                        rec.validate(rec."Disc. Unit Price", rec."Unit Price");
                    end else begin
                        discprice := REC."Unit Price" - Rec."Unit Price" * Rec."Line Discount %" / 100;
                        rec.validate(rec."Disc. Unit Price", discprice);
                    end;
                end;
                Commit();
            end;
            // local procedure getdiscunitprice(): Decimal
            // var
            //     discprice: Decimal;
            // begin
            //     if rec."Line Discount %" = 0 then begin
            //         rec."Disc. Unit Price" := rec."Unit Price";
            //         rec.Modify();
            //     end else begin
            //         discprice := Rec."Unit Price" * Rec."Line Discount %" / 100;
            //         rec."Disc. Unit Price" := discprice;
            //         rec.Modify();
            //     end;
            //     Commit();
            // end;
        }
    }


    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
    }
    // trigger OnInsert()
    // var
    //     SalesQuoteHeader: Record "Sales Header";
    //     items: record Item;
    // begin
    //     SalesQuoteHeader.get(rec."Document No.");
    //     rec."Return Reason Code" := SalesQuoteHeader."Return Code";
    //     rec.Modify(true);
    // end;

    var
        myInt: Integer;
}