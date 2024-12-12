pageextension 90908 "Finance Stamp" extends "Company Information"
{
    layout
    {
        addafter(General)
        {
            field("Finance Stamp"; Rec."Finance Stamp")
            {
                ApplicationArea = All;
            }
        }
    }
}