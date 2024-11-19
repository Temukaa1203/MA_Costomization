report 90900 FABarcodeReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'FA Barcodes';
    RDLCLayout = 'FABarcodes.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Items';

            // Column that provides the data string for the barcode
            column(No_; "No.")
            {
            }

            column(Description; Description)
            {
            }

            column(Serial_No_; "Serial No.")
            {
            }
            // Column that stores the barcode encoded string
            column(Barcode; barcode)
            {
            }
            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                DataItemLink = "FA No." = field("No.");
                column(Starting_Date; "FA Posting Date") { }
            }

            trigger OnAfterGetRecord()
            var
                BarcodeString: code[20];
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";

            begin
                // Declare the barcode provider using the barcode provider interface and enum
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;

                // Declare the font using the barcode symbology enum
                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";

                // Set data string source
                BarcodeString := "Fixed Asset"."No.";
                // EncodedText := '*' + BarcodeString + '*'; // Code 39 encoding requires * before and after the data
                Barcode := '*' + BarcodeString + '*';
                // Barcode := '*TEST12345*';
                // // Validate the input. This method is not available for 2D provider
                BarcodeFontProvider.ValidateInput(Barcode, BarcodeSymbology);

                // // Encode the data string to the barcode font
                barcode := BarcodeFontProvider.EncodeFont(Barcode, BarcodeSymbology);
                Message('Encoded barcode: %1', Barcode);
            end;
        }
    }

    var
        // Variable for the barcode encoded string
        Barcode: Text;
}