pageextension 90902 item_barcode extends "item card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(ApplyTemplate)
        {
            action("Generate Bar Code")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Generate Barcode';
                Image = Report;
                trigger OnAction()
                var
                    BarcodeReport: Report itemBarcodeReport;
                    itemcard: Record Item;
                begin
                    itemcard.SetFilter("No.", '=%1', Rec."No.");
                    BarcodeReport.SetTableView(itemcard);
                    BarcodeReport.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}