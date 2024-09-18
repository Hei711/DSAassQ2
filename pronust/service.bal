import ballerina/http;

public type Programme record {|

    readonly string ProgrammeCode;
    string NQFlevel;
    string Faculty;
    string Department;
    string Title;
    string RegistrationDate;
    Course[] courses;
|};

public type Course record {|
    readonly string CourseCode;
    string CourseName;
    string NQFlevel;
|};

table<Programme> key(ProgrammeCode) programmes = table [
    {
        ProgrammeCode: "P001",
        NQFlevel: "Level 6",
        Faculty: "Science",
        Department: "Computer Science",
        Title: "BSc Computer Science",
        RegistrationDate: "2022-01-01",
        courses: [
            {CourseCode: "CS101", CourseName: "Peanut", NQFlevel: "Level 6"},
            {CourseCode: "CS102", CourseName: "Butter", NQFlevel: "Level 6"}
        ]
    },
    {
        ProgrammeCode: "P002",
        NQFlevel: "Level 7",
        Faculty: "Engineering",
        Department: "Mechanical Engineering",
        Title: "BEng Mechanical Engineering",
        RegistrationDate: "2022-01-01",
        courses: [
            {CourseCode: "ME101", CourseName: "Tom", NQFlevel: "Level 7"},
            {CourseCode: "ME102", CourseName: "Jerry", NQFlevel: "Level 7"}
        ]
    }
];

# A service representing a network-accessible API
# bound to port `8080`.
service /Programmes on new http:Listener(8080) {
    resource function get programmes() returns Programme[] {
        return programmes.toArray();
    }

    resource function post programmes(@http:Payload Programme[] ProgrammeList)
                                    returns Programme[] {

        ProgrammeList.forEach(programme => programmes.add(programme));
        return ProgrammeList;
    }
}
