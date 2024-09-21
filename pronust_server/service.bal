import ballerina/http;
import ballerina/time;

public type ProgrammeRecord record {|
    readonly string ProgrammeCode;
    string NQFlevel;
    string Faculty;
    string Department;
    string Title;
    string RegistrationDate;
    CourseRecord[] courses;
|};

public type CourseRecord record {|
    readonly string CourseCode;
    string CourseName;
    string NQFlevel;
|};

table<ProgrammeRecord> key(ProgrammeCode) programmesTable = table [
    {
        ProgrammeCode: "P001",
        NQFlevel: "Level 6",
        Faculty: "Science",
        Department: "Computer Science",
        Title: "BSc Computer Science",
        RegistrationDate: "2017-01-01",
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
        RegistrationDate: "2018-01-01",
        courses: [
            {CourseCode: "ME101", CourseName: "Tom", NQFlevel: "Level 7"},
            {CourseCode: "ME102", CourseName: "Jerry", NQFlevel: "Level 7"}
        ]
    }
];

// Helper function to check if a programme is due for review after 5 years compared to the current date
function isDueForReview(ProgrammeRecord programme) returns boolean|error {
    string regDate = programme.RegistrationDate;
    // "2017-01-01"
    int year = check int:fromString(regDate.substring(0, 4)); // This command gets the year as the first 4 digits
    time:Utc currentTime = time:utcNow(); // Get the current date
    int currentYear = currentTime[0];
    return (currentYear - year) >= 5;
}

service /Programmes on new http:Listener(8080) {

    // Retrieve all programmes
    resource function get programmes() returns ProgrammeRecord[] {
        return programmesTable.toArray();
    }

    // Add new programme(s)
    resource function post programmes(@http:Payload ProgrammeRecord[] programmeList) returns ProgrammeRecord[] {
        programmeList.forEach(programme => programmesTable.add(programme));
        return programmeList;
    }

    // Update an existing programme by ProgrammeCode
    resource function put programmes/[string ProgrammeCode](@http:Payload ProgrammeRecord updatedProgramme) returns string|error {
        if (programmesTable.hasKey(ProgrammeCode)) {
            programmesTable.put(updatedProgramme);
            return "Programme updated successfully";
        }
        return error("Programme not found");
    }

    // Retrieve a specific programme by ProgrammeCode
    resource function get programmes/[string ProgrammeCode]() returns ProgrammeRecord|error {
        foreach var programme in programmesTable {
            if programme.ProgrammeCode == ProgrammeCode {
                return programme;
            }
        }
        return error("Programme not found");
    }

    // Delete a programme by ProgrammeCode
    resource function delete programmes/[string ProgrammeCode]() returns string|error {
        if (programmesTable.hasKey(ProgrammeCode)) {
            _ = programmesTable.remove(ProgrammeCode);
            return "Programme deleted successfully";
        }
        return error("Programme not found");
    }

    // Retrieve all programmes due for review after 5 years
    resource function get programmes/review() returns ProgrammeRecord[]|error {
        ProgrammeRecord[] dueForReviewAfter5Years = [];
        foreach ProgrammeRecord programme in programmesTable {
            boolean|error isDue = isDueForReview(programme);
            if isDue is error {
                return error("Error checking review status: " + isDue.message());
            }
            if isDue {
                // After the helper function returns true, then it should be added to the list
                dueForReviewAfter5Years.push(programme);
            }
        }
        return dueForReviewAfter5Years;
    }

    // Retrieve all programmes belonging to the same faculty
    resource function get programmes/faculty/[string faculty]() returns ProgrammeRecord[] {
        ProgrammeRecord[] facultyProgrammes = [];
        foreach var programme in programmesTable {
            if programme.Faculty == faculty {
                facultyProgrammes.push(programme);
            }
        }
        return facultyProgrammes;
    }
}
