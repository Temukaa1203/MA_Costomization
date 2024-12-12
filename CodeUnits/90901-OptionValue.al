// codeunit 90901 "OptionManager"
// {
//     procedure PopulateSalesOptions()
//     var
//         SalesOptionRec: Record "OptionTable";
//     begin
//         if not SalesOptionRec.Get(1) then begin
//             SalesOptionRec."OptionID" := 1;
//             SalesOptionRec."OptionName" := 'SALES';
//             SalesOptionRec.Insert();
//         end;

//         if not SalesOptionRec.Get(2) then begin
//             SalesOptionRec."OptionID" := 2;
//             SalesOptionRec."OptionName" := 'SALES RETURN';
//             SalesOptionRec.Insert();
//         end;

//         if not SalesOptionRec.Get(3) then begin
//             SalesOptionRec."OptionID" := 3;
//             SalesOptionRec."OptionName" := 'TRANSFER';
//             SalesOptionRec.Insert();
//         end;

//         if not SalesOptionRec.Get(4) then begin
//             SalesOptionRec."OptionID" := 4;
//             SalesOptionRec."OptionName" := 'TRANSFER RETURN';
//             SalesOptionRec.Insert();
//         end;
//     end;
// }
