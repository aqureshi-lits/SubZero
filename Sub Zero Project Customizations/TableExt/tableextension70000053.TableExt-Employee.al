tableextension 60052 EmplExt extends Employee
{
    fields
    {
        modify("E-Mail")
        {
            Caption = 'Alt. Email';
            Description = 'Caption changed';
        }
        modify(Pager)
        {
            Caption = 'Alt. Mob. No.';
            Description = 'Caption changed';
        }

        //Unsupported feature: Property Modification (Data type) on ""Salespers./Purch. Code"(Field 52)".


        //Unsupported feature: Deletion on "City(Field 10).OnLookup".


        //Unsupported feature: Deletion on ""Post Code"(Field 11).OnLookup".


        //Unsupported feature: Deletion on ""Country/Region Code"(Field 25).OnValidate".


        //Unsupported feature: Deletion (FieldCollection) on ""Privacy Blocked"(Field 150)".

        field(50001; "Visa Issued at"; Text[100])
        {
            Description = 'ATOS';
        }
        field(50011; "Working at"; Text[100])
        {
            Description = 'ATOS';
        }
        field(50051; "Reporting To Email"; Text[100])
        {
            Description = 'ATOS';
        }
        field(50055; "PRO Email"; Text[100])
        {
            Description = 'ATOS';
        }
        field(50059; Company; Text[100])
        {
            Description = 'ATOS';
            // TableRelation = "Employee Company"."Company Name";

            // trigger OnValidate()
            // var
            //     EmpComp: Record "Employee Company";
            // begin
            //     //ATOS
            //     IF EmpComp.GET(Company) THEN
            //         IF "PRO Email" = '' THEN
            //             "PRO Email" := EmpComp."PRO E-Mail";
            //     //ATOS
            // end;
        }
        field(50101; Type; Option)
        {
            Description = 'ATOS';
            OptionCaption = 'Employee,Trade Licence,Car Registration';
            OptionMembers = Employee,"Trade Licence","Car Registration";
        }
    }
}

