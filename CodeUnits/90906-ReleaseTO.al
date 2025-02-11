codeunit 90906 ReleaseTO
{
    trigger OnRun()
    var
        TranHeader: Record "Transfer Header";
    begin
        relto();
    end;


    local procedure relto()
    var
        TranHeader: Record "Transfer Header";
        mydatetime: DateTime;
        mydate: date;
    begin
        mydate := CalcDate('<-7D>', Today);
        TranHeader.Reset();
        //Filter
        mydatetime := CreateDateTime(mydate, 0T);
        TranHeader.SetRange(SystemCreatedAt, mydatetime, CurrentDateTime);
        TranHeader.SetRange(status, TranHeader.Status::Open);
        Message(Format(TranHeader.Count));
        if TranHeader.Find('-') then
            repeat
                if not ReleaseTO(TranHeader) then begin
                    if TranHeader.Get(TranHeader."No.") then begin
                        TranHeader."Release Error" := GetLastErrorText();
                        TranHeader.Modify();
                    end;
                end;

            until TranHeader.Next() = 0;
        Message(Format(mydatetime));
    end;

    [TryFunction]
    local procedure ReleaseTO(var TransferOrder: Record "Transfer Header")
    begin
        CODEUNIT.Run(CODEUNIT::"Release Transfer Document", TransferOrder);
        // Commit();
    end;



    var
        myInt: Integer;
}