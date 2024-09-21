import ballerina/http;
import ballerina/io;

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

public function main() returns error? {
    http:Client programmeClient = check new ("http://localhost:8080");

    // Call the API to retrieve all programmes
    ProgrammeRecord[] allProgrammes = check programmeClient->get("/Programmes/programmes");
    io:println("All Programmes: ", allProgrammes);
    io:println("************************************");
    io:println("\n");


    // Retrieve a specific programme by its ProgrammeCode
    string programmeCode = "P001";
    ProgrammeRecord programme = check programmeClient->get("/Programmes/programmes/" + programmeCode);
    io:println("Programme with ProgrammeCode ", programmeCode, ": ", programme);
    io:println("************************************");
    io:println("\n");

    // Add a new programme
    ProgrammeRecord newProgramme = {
        ProgrammeCode: "P003",
        NQFlevel: "Level 8",
        Faculty: "Science",
        Department: "Mathematics",
        Title: "BSc Mathematics",
        RegistrationDate: "2021-06-15",
        courses: [
            {CourseCode: "MA101", CourseName: "Algebra", NQFlevel: "Level 8"},
            {CourseCode: "MA102", CourseName: "Calculus", NQFlevel: "Level 8"}
        ]
    };
    ProgrammeRecord[] addedProgrammes = check programmeClient->post("/Programmes/programmes", [newProgramme]);
    io:println("Added Programme: ", addedProgrammes);
    io:println("************************************");
    io:println("\n");

    // Update an existing programme
    ProgrammeRecord updatedProgramme = {
        ProgrammeCode: "P003",
        NQFlevel: "Level 9",
        Faculty: "Science",
        Department: "Mathematics",
        Title: "BSc Mathematics Advanced",
        RegistrationDate: "2021-06-15",
        courses: [
            {CourseCode: "MA101", CourseName: "Algebra", NQFlevel: "Level 9"},
            {CourseCode: "MA102", CourseName: "Calculus", NQFlevel: "Level 9"}
        ]
    };
    string updateResponse = check programmeClient->put("/Programmes/programmes/" + updatedProgramme.ProgrammeCode, updatedProgramme);
    io:println("Update Response: ", updateResponse);
    io:println("************************************");
    io:println("\n");

    // Delete a programme
    string deleteResponse = check programmeClient->delete("/Programmes/programmes/P003");
    io:println("Delete Response: ", deleteResponse);
    io:println("************************************");
    io:println("\n");


    // Retrieve all programmes due for review
    ProgrammeRecord[] dueForReview = check programmeClient->get("/Programmes/programmes/review");
    io:println("Programmes due for review: ", dueForReview);
    io:println("************************************");
    io:println("\n");

    // Retrieve all programmes by faculty
    string faculty = "Science";
    ProgrammeRecord[] facultyProgrammes = check programmeClient->get("/Programmes/programmes/faculty/" + faculty);
    io:println("Programmes in Faculty ", faculty, ": ", facultyProgrammes);
    io:println("************************************");
    io:println("\n");
}

