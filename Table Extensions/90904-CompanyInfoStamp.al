tableextension 90904 "Company Information Ext" extends "Company Information"
{
    fields
    {
        field(90301; "Finance Stamp"; Blob)
        {
            Caption = 'Finance Stamp';
            DataClassification = OrganizationIdentifiableInformation;
            SubType = Bitmap;
        }
    }
}
