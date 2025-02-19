codeunit 90908 to_job
{
    trigger OnRun()
    begin
        createto.Run();
        releaseTO.Run();
    end;

    var
        createto: Codeunit EECreateTO;
        releaseTO: Codeunit ReleaseTO;
}