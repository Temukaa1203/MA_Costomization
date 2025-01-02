permissionset 90900 MAgro_Permission
{
    Assignable = true;
    Permissions = report FABarcodeReport = X,
        report itemBarcodeReport = X,
        codeunit PP_Utility = X,
        codeunit SalesReturnOrderProcessor = X,
        codeunit TransferOrderCreator = X,
        codeunit TransferOrderHelper = X;
}