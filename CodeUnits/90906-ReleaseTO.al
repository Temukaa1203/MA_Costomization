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
        releasetodoc: Codeunit "Release Transfer Document";
        salesheader: Record "Sales Header";
    begin
        mydate := CalcDate('<-3D>', Today);
        TranHeader.Reset();
        //Filter
        mydatetime := CreateDateTime(mydate, 0T);
        TranHeader.SetRange(SystemCreatedAt, mydatetime, CurrentDateTime);
        TranHeader.SetRange(status, TranHeader.Status::Open);
        TranHeader.SetFilter("SQ no", '<>%1', '');
        Message(Format(TranHeader.Count));
        if TranHeader.Find('-') then
            repeat
                if not ReleaseTO(TranHeader) then begin
                    if TranHeader.Get(TranHeader."No.") then begin
                        releasetodoc.Reopen(TranHeader);
                        TranHeader.delete(true);
                        message('deleted, ' + Format(TranHeader."No."));
                    end;
                end else begin
                    salesheader.Reset();
                    salesheader.SetRange("No.", TranHeader."SQ no");
                    if salesheader.find('-') then begin
                        salesheader.Delete();
                        message('deleted, ' + Format(salesheader."No."));
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