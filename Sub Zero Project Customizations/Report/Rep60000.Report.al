// report 60100 "Delete Change Log Entries"
// {
//     Caption = 'Delete Change Log Entries';
//     ProcessingOnly = true;

//     UsageCategory = Tasks;
//     ApplicationArea = All;

//     dataset
//     {
//         dataitem(ChangeLog; "Change Log Entry")
//         {
//             RequestFilterFields = "Entry No.", "Date and Time", "User ID", "Table No.", "Primary Key Field 1 Value";

//             trigger OnAfterGetRecord()
//             begin
//                 ChangeLog.Delete();
//             end;
//         }
//     }

//     trigger OnPostReport()
//     begin
//         Message('Selected Change Log entries have been deleted.');
//     end;
// }
