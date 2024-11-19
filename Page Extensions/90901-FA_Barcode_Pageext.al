pageextension 90901 barcode extends "Fixed Asset Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("C&opy Fixed Asset")
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
                    BarcodeReport: Report FABarcodeReport;
                    FACARD: Record "Fixed Asset";
                begin
                    FACARD.SetFilter("No.", '=%1', Rec."No.");
                    BarcodeReport.SetTableView(FACARD);
                    BarcodeReport.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}