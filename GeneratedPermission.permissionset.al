permissionset 90900 MAgro_Permission
{
    Assignable = true;
    Permissions = report FABarcodeReport = X,
        report itemBarcodeReport = X,
        codeunit PP_Utility = X,
        codeunit SalesReturnOrderProcessor = X,
        codeunit TransferOrderCreator = X,
        codeunit TransferOrderHelper = X,
        tabledata MyTable = RIMD,
        table MyTable = X,
        codeunit EECreateTO = X,
        codeunit ReleaseTO = X,
        codeunit "Return Reason Code Update" = X,
        codeunit to_job = X,
        query psi_header = X,
        query psi_line = X,
        query TransferOrderQry = X;
}