CREATE TABLE Student(
    id SERIAL UNIQUE,
    student_num TEXT,
    ssn TEXT NOT NULL UNIQUE,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    residency TEXT NOT NULL,
    student_type TEXT NOT NULL,
    PRIMARY KEY (student_num)
);

CREATE TABLE Faculty(
    id SERIAL UNIQUE,
    faculty_name TEXT,
    title TEXT NOT NULL,
    department TEXT NOT NULL,
    PRIMARY KEY (faculty_name)
);

CREATE TABLE Class(
    id SERIAL UNIQUE,
    class_title TEXT,
    quarter TEXT,
    class_year CHAR(4),
    PRIMARY KEY (class_title, quarter, class_year)
);

CREATE TABLE Section(
    id SERIAL UNIQUE,
    section_num TEXT,
    class_id INTEGER,
    section_limit INTEGER,
    PRIMARY KEY (section_num, class_id),
    FOREIGN KEY (class_id) REFERENCES Class (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Degree(
    id SERIAL UNIQUE,
    degree_type TEXT,
    degree_name TEXT,
    required_units INTEGER,
    PRIMARY KEY (degree_type, degree_name)
);

CREATE TABLE AttendancePeriod(
    id SERIAL UNIQUE,
    student_num TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY (student_num),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ProbationPeriod(
    id SERIAL UNIQUE,
    student_num TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason TEXT NOT NULL,
    PRIMARY KEY (student_num),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PreviousDegree(
    id SERIAL UNIQUE,
    student_num TEXT,
    type TEXT,
    major TEXT,
    school_name TEXT,
    PRIMARY KEY (student_num, type, major, school_name),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE StudentAccount(
    id SERIAL UNIQUE,
    account_num TEXT,
    balance MONEY NOT NULL,
    PRIMARY KEY (account_num),
    FOREIGN KEY (account_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AccountStatement(
    id SERIAL UNIQUE,
    account_num TEXT,
    statement_number INTEGER UNIQUE NOT NULL,
    bill_amount MONEY NOT NULL,
    due_date DATE NOT NULL,
    PRIMARY KEY (account_num, statement_number),
    FOREIGN KEY (account_num) REFERENCES StudentAccount (account_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Undergraduate(
    id SERIAL UNIQUE,
    undergraduate_num TEXT,
    college TEXT NOT NULL,
    major TEXT NOT NULL,
    minor TEXT,
    PRIMARY KEY (undergraduate_num),
    FOREIGN KEY (undergraduate_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MSUndergraduate(
    id SERIAL UNIQUE,
    msundergraduate_num TEXT,
    department TEXT NOT NULL,
    PRIMARY KEY (msundergraduate_num),
    FOREIGN KEY (msundergraduate_num) REFERENCES Undergraduate (undergraduate_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Graduate(
    id SERIAL UNIQUE,
    graduate_num TEXT,
    graduate_type TEXT NOT NULL,
    major TEXT NOT NULL,
    department TEXT NOT NULL,
    PRIMARY KEY (graduate_num),
    FOREIGN KEY (graduate_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MSStudent(
    id SERIAL UNIQUE,
    msstudent_num TEXT,
    advisor TEXT,
    PRIMARY KEY (msstudent_num),
    FOREIGN KEY (msstudent_num) REFERENCES Graduate (graduate_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (advisor) REFERENCES Faculty (faculty_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PhDStudent(
    id SERIAL UNIQUE,
    phdstudent_num TEXT,
    candidate_type TEXT NOT NULL,
    PRIMARY KEY (phdstudent_num),
    FOREIGN KEY (phdstudent_num) REFERENCES Graduate (graduate_num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Precandidate(
    id SERIAL UNIQUE,
    precandidate_num TEXT,
    advisor TEXT,
    PRIMARY KEY (precandidate_num),
    FOREIGN KEY (precandidate_num) REFERENCES PhDStudent (phdstudent_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (advisor) REFERENCES Faculty (faculty_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Candidate(
    id SERIAL UNIQUE,
    candidate_num TEXT,
    advisor TEXT NOT NULL,
    PRIMARY KEY (candidate_num),
    FOREIGN KEY (candidate_num) REFERENCES PhDStudent (phdstudent_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (advisor) REFERENCES Faculty (faculty_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ThesisCommittee(
    id SERIAL UNIQUE,
    graduate_num TEXT,
    faculty_name TEXT,
    PRIMARY KEY (graduate_num, faculty_name),
    FOREIGN KEY (graduate_num) REFERENCES Graduate (graduate_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (faculty_name) REFERENCES Faculty (faculty_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SectionEnrollment(
    id SERIAL UNIQUE,
    student_num TEXT,
    section_id INTEGER,
    units_taking INTEGER NOT NULL,
    grade_option TEXT NOT NULL,
    PRIMARY KEY (student_num, section_id),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ClassesTaken(
    id SERIAL UNIQUE,
    student_num TEXT,
    sectionenrollment_id INTEGER,
    grade_received TEXT NOT NULL,
    PRIMARY KEY (student_num, sectionenrollment_id),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (sectionenrollment_id) REFERENCES SectionEnrollment (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TeachingHistory(
    id SERIAL UNIQUE,
    faculty_name TEXT,
    class_id INTEGER,
    PRIMARY KEY (faculty_name, class_id),
    FOREIGN KEY (faculty_name) REFERENCES Faculty (faculty_name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Class (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CurrentlyTeaching(
    id SERIAL UNIQUE,
    section_id INTEGER,
    faculty_name TEXT,
    PRIMARY KEY (section_id),
    FOREIGN KEY (faculty_name) REFERENCES Faculty (faculty_name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Course(
    id SERIAL UNIQUE,
    department TEXT,
    course_num TEXT,
    min_units INTEGER NOT NULL CHECK (min_units > 0),
    max_units INTEGER NOT NULL CHECK (max_units >= min_units),
    grade_option TEXT NOT NULL,
    requires_lab BOOLEAN,
    requires_consent BOOLEAN,
    PRIMARY KEY (department, course_num)
);

CREATE TABLE Prerequisite(
    id SERIAL UNIQUE,
    target_id INTEGER,
    prerequisite_id INTEGER,
    PRIMARY KEY (target_id, prerequisite_id),
    FOREIGN KEY (target_id) REFERENCES Course (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prerequisite_id) REFERENCES Course (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CourseConcentration(
    id SERIAL UNIQUE,
    course_id INTEGER,
    degree_id INTEGER,
    concentration_name TEXT,
    required_units INTEGER NOT NULL,
    min_gpa NUMERIC(3, 2),
    PRIMARY KEY (course_id, degree_id, concentration_name),
    FOREIGN KEY (course_id) REFERENCES Course (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (degree_id) REFERENCES Degree (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CourseCategory(
    id SERIAL UNIQUE,
    course_id INTEGER,
    degree_id INTEGER,
    category_name TEXT,
    required_units INTEGER NOT NULL,
    min_gpa NUMERIC(3, 2),
    PRIMARY KEY (course_id, degree_id, category_name),
    FOREIGN KEY (course_id) REFERENCES Course (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (degree_id) REFERENCES Degree (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ClassInstance(
    id SERIAL UNIQUE,
    course_id INTEGER,
    class_id INTEGER,
    PRIMARY KEY (course_id, class_id),
    FOREIGN KEY (course_id) REFERENCES Course (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Class (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SectionWaitlist(
    id SERIAL UNIQUE,
    student_num TEXT,
    section_id INTEGER,
    position INTEGER,
    PRIMARY KEY (student_num, section_id),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE NonweeklyMeeting(
    id SERIAL UNIQUE,
    section_id INTEGER,
	meeting_type TEXT,
    start_datetime TIMESTAMP,
    end_datetime TIMESTAMP,
    location TEXT NOT NULL,
    required BOOLEAN NOT NULL,
    PRIMARY KEY (section_id, meeting_type, start_datetime, end_datetime),
    FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE WeeklyMeeting(
    id SERIAL UNIQUE,
    section_id INTEGER,
    meeting_type TEXT,
    start_datetime TIMESTAMP,
    end_datetime TIMESTAMP,
    location TEXT NOT NULL,
    required BOOLEAN NOT NULL,
    PRIMARY KEY (section_id, meeting_type, start_datetime, end_datetime),
    FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DegreesEarned(
    id SERIAL UNIQUE,
    student_num TEXT,
    degree_id INTEGER,
    PRIMARY KEY (student_num, degree_id),
    FOREIGN KEY (student_num) REFERENCES Student (student_num) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (degree_id) REFERENCES Degree (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Quarter(
    id SERIAL PRIMARY KEY,
    quarter TEXT NOT NULL,
    year CHAR(4) NOT NULL
);

CREATE TABLE GRADE_CONVERSION(
    LETTER_GRADE CHAR(2) NOT NULL,
    NUMBER_GRADE DECIMAL(2,1)
);
insert into grade_conversion values('A+', 4.0);
insert into grade_conversion values('A', 4.0);
insert into grade_conversion values('A-', 3.7);
insert into grade_conversion values('B+', 3.3);
insert into grade_conversion values('B', 3.0);
insert into grade_conversion values('B-', 2.7);
insert into grade_conversion values('C+', 2.3);
insert into grade_conversion values('C', 2.0);
insert into grade_conversion values('C-', 1.7);
insert into grade_conversion values('D', 1.0);
insert into grade_conversion values('F', 0.0);

DO
$$
BEGIN
    FOR i IN 1960..2030 LOOP
        INSERT INTO Quarter(quarter, year) VALUES ('WINTER', i);
        INSERT INTO Quarter(quarter, year) VALUES ('SPRING', i);
        INSERT INTO Quarter(quarter, year) VALUES ('SUMMER', i);
        INSERT INTO Quarter(quarter, year) VALUES ('FALL', i);
    END LOOP;
END
$$