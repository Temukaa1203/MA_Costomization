namespace PP;

permissionset 90901 "PP-SRO"
{
    Assignable = true;
    Permissions = tabledata MyTable=RIMD,
        table MyTable=X,
        report FABarcodeReport=X,
        report itemBarcodeReport=X,
        codeunit EECreateTO=X,
        codeunit PP_Utility=X,
        codeunit ReleaseTO=X,
        codeunit "Return Reason Code Update"=X,
        codeunit SalesReturnOrderProcessor=X,
        codeunit to_job=X,
        codeunit TransferOrderCreator=X,
        codeunit TransferOrderHelper=X,
        query psi_header=X,
        query psi_line=X,
        query TransferOrderQry=X;
}