// table 90901 "SalesTransaction"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "TransactionID"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(2; "Amount"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(3; "OptionID"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; "SalesOptionLookup"; Code[20])
//         {
//             Caption = 'Sales Option Lookup';
//             TableRelation = "OptionTable".OptionID;
//         }
//     }

//     keys
//     {
//         key(PK; "TransactionID")
//         {
//             Clustered = true;
//         }
//     }
// }
