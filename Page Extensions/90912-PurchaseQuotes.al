pageextension 90912 PQs_SystemcreatedbyExt extends "Purchase Quotes"
{
    layout
    {
        addafter(Status)
        {
            // field(SystemCreatedBy; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
            // {
            //     ApplicationArea = all;
            // }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    // procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    // var
    //     User: Record User;
    // begin
    //     User.Get(UserSecurityID);
    //     exit(User."User Name");
    // end;

    var
        myInt: Integer;
}