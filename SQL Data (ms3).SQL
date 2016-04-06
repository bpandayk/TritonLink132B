-- Make sure to clear all the tables and to reset any serial IDs before running these queries

-----------------Undergraduate Student Info-----------------
INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('1', '1', 'Benjamin', '', 'B', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('1', 'MUIR', 'Computer Science', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('2', '2', 'Kristen', '', 'W', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('2', 'MUIR', 'Computer Science', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('3', '3', 'Daniel', '', 'F', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('3', 'MUIR', 'Computer Science', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('4', '4', 'Claire', '', 'J', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('4', 'MUIR', 'Computer Science', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('5', '5', 'Julie', '', 'C', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('5', 'MUIR', 'Computer Science', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('6', '6', 'Kevin', '', 'L', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('6', 'MUIR', 'Mechanical Engineering', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('7', '7', 'Michael', '', 'B', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('7', 'MUIR', 'Mechanical Engineering', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('8', '8', 'Joseph', '', 'J', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('8', 'MUIR', 'Mechanical Engineering', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('9', '9', 'Devin', '', 'P', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('9', 'MUIR', 'Mechanical Engineering', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('10', '10', 'Logan', '', 'F', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('10', 'MUIR', 'Mechanical Engineering', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('11', '11', 'Vikram', '', 'N', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('11', 'MUIR', 'Philosophy', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('12', '12', 'Rachel', '', 'Z', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('12', 'MUIR', 'Philosophy', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('13', '13', 'Zach', '', 'M', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('13', 'MUIR', 'Philosophy', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('14', '14', 'Justin', '', 'H', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('14', 'MUIR', 'Philosophy', '');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('15', '15', 'Rahul', '', 'R', 'ca_resident', 'undergraduate');
INSERT INTO Undergraduate(Undergraduate_num, college, major, minor) VALUES ('15', 'MUIR', 'Philosophy', '');

-----------------MS Student Info-----------------
INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('16', '16', 'Dave', '', 'C', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('16', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('16');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('17', '17', 'Nelson', '', 'H', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('17', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('17');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('18', '18', 'Andrew', '', 'P', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('18', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('18');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('19', '19', 'Nathan', '', 'S', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('19', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('19');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('20', '20', 'John', '', 'H', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('20', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('20');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('21', '21', 'Anwell', '', 'W', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('21', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('21');

INSERT INTO Student(student_num, ssn, first_name, middle_name, last_name, residency, student_type) VALUES ('22', '22', 'Tim', '', 'K', 'ca_resident', 'graduate');
INSERT INTO Graduate(graduate_num, graduate_type, major, department) VALUES ('22', 'ms', 'Computer Science', 'DEPARTMENT');
INSERT INTO MSStudent(msstudent_num) VALUES ('22');


-----------------Faculty Info-----------------
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Justin Bieber', 'Associate Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Flo Rida', 'Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Selena Gomez', 'Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Adele', 'Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Taylor Swift', 'Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Kelly Clarkson', 'Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Adam Levine', 'Professor', 'DEPARTMENT');
INSERT INTO Faculty(faculty_name, title, department) VALUES ('Bjork', 'Professor', 'DEPARTMENT');

-----------------Course Info-----------------
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '8A', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '105', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '123', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '250A', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '250B', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '255', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '232A', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('CSE', '221', 2, 4, 'BOTH', FALSE, FALSE);

INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('MAE', '3', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('MAE', '107', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('MAE', '108', 2, 4, 'BOTH', FALSE, FALSE);

INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('PHIL', '10', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('PHIL', '12', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('PHIL', '165', 2, 4, 'BOTH', FALSE, FALSE);
INSERT INTO Course(department, course_num, min_units, max_units, grade_option, requires_lab, requires_consent) VALUES('PHIL', '167', 2, 4, 'BOTH', FALSE, FALSE);

-----------------Class Info-----------------
INSERT INTO Class(class_title, quarter, class_year) VALUES('Introduction to Computer Science: Java', 'FALL', '2014');
INSERT INTO ClassInstance(course_id, class_id) VALUES (1, 1);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Introduction to Computer Science: Java', 'SPRING', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (1, 2);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Introduction to Computer Science: Java', 'FALL', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (1, 3);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Introduction to Computer Science: Java', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (1, 4);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Introduction to Computer Science: Java', 'SPRING', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (1, 5);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Intro to Theory', 'WINTER', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (2, 6);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Intro to Theory', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (2, 7);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Intro to Theory', 'FALL', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (2, 8);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Probabilistic Reasoning', 'FALL', '2014');
INSERT INTO ClassInstance(course_id, class_id) VALUES (4, 9);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Probabilistic Reasoning', 'FALL', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (4, 10);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Probabilistic Reasoning', 'SPRING', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (4, 11);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Machine Learning', 'WINTER', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (5, 12);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Machine Learning', 'FALL', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (5, 13);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Data Mining and Predictive Analytics', 'FALL', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (6, 14);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Data Mining and Predictive Analytics', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (6, 15);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Data Mining and Predictive Analytics', 'WINTER', '2017');
INSERT INTO ClassInstance(course_id, class_id) VALUES (6, 16);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Databases', 'FALL', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (7, 17);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Databases', 'SPRING', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (7, 18);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Operating Systems', 'SPRING', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (8, 19);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Operating Systems', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (8, 20);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Operating Systems', 'FALL', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (8, 21);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Computational Methods', 'SPRING', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (10, 22);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Computational Methods', 'SPRING', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (10, 23);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Probability and Statistics', 'FALL', '2014');
INSERT INTO ClassInstance(course_id, class_id) VALUES (11, 24);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Probability and Statistics', 'WINTER', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (11, 25);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Probability and Statistics', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (11, 26);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Probability and Statistics', 'FALL', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (11, 27);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Intro to Logic', 'FALL', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (12, 28);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Intro to Logic', 'WINTER', '2017');
INSERT INTO ClassInstance(course_id, class_id) VALUES (12, 29);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Scientific Reasoning', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (13, 30);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Scientific Reasoning', 'SPRING', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (13, 31);

INSERT INTO Class(class_title, quarter, class_year) VALUES('Freedom, Equality, and the Law', 'SPRING', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (14, 32);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Freedom, Equality, and the Law', 'FALL', '2015');
INSERT INTO ClassInstance(course_id, class_id) VALUES (14, 33);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Freedom, Equality, and the Law', 'WINTER', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (14, 34);
INSERT INTO Class(class_title, quarter, class_year) VALUES('Freedom, Equality, and the Law', 'FALL', '2016');
INSERT INTO ClassInstance(course_id, class_id) VALUES (14, 35);

-----------------Current Quarter Section Info-----------------
INSERT INTO Section(section_num, class_id, section_limit) VALUES('1', 26, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('2', 20, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('3', 15, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('4', 30, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('5', 20, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('6', 7, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('7', 34, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('8', 26, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('9', 20, 100);
INSERT INTO Section(section_num, class_id, section_limit) VALUES('10', 4, 100);

-----------------Current Quarter Enrollment Info-----------------
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('16', 2, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('17', 9, 4, 'S/U');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('18', 5, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('19', 2, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('20', 9, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('21', 5, 4, 'S/U');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('22', 3, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('16', 3, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('17', 3, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('1', 10, 4, 'S/U');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('5', 10, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('3', 10, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('7', 1, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('8', 1, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('9', 8, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('4', 6, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('12', 4, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('13', 7, 4, 'S/U');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('14', 4, 4, 'LETTER');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES('15', 7, 4, 'LETTER');

-----------------Past Classes Info-----------------
INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE8A_FA14_SECTION_1', 1, 100); -- section.id = 11
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('1', 11, 4, 'LETTER');  -- sectionenrollment.id = 21
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('1', 21, 'A-');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('3', 11, 4, 'LETTER');  -- sectionenrollment.id = 22
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('3', 22, 'B+');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE8A_SP15_SECTION_1', 2, 100); -- section.id = 12
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('2', 12, 4, 'LETTER');  -- sectionenrollment.id = 23
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('2', 23, 'C-');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE8A_FA15_SECTION_1', 3, 100); -- section.id = 13
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('4', 13, 4, 'LETTER');  -- sectionenrollment.id = 24
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('4', 24, 'A-');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('5', 13, 4, 'LETTER');  -- sectionenrollment.id = 25
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('5', 25, 'B');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE105_WI15_SECTION_1', 6, 100); -- section.id = 14
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('1', 14, 4, 'LETTER');  -- sectionenrollment.id = 26
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('1', 26, 'A-');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('5', 14, 4, 'LETTER');  -- sectionenrollment.id = 27
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('5', 27, 'B+');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('4', 14, 4, 'LETTER');  -- sectionenrollment.id = 28
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('4', 28, 'C');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE250A_FA14_SECTION_1', 9, 100); -- section.id = 15
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('16', 15, 4, 'LETTER');  -- sectionenrollment.id = 29
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('16', 29, 'C');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE250A_FA15_SECTION_1', 10, 100); -- section.id = 16
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('22', 16, 4, 'LETTER');  -- sectionenrollment.id = 30
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('2', 30, 'B+');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('18', 16, 4, 'LETTER');  -- sectionenrollment.id = 31
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('18', 31, 'D');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('19', 16, 4, 'LETTER');  -- sectionenrollment.id = 32
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('19', 32, 'F');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE250B_WI15_SECTION_1', 12, 100); -- section.id = 17
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('17', 17, 4, 'LETTER');  -- sectionenrollment.id = 33
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('17', 33, 'A');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('19', 17, 4, 'LETTER');  -- sectionenrollment.id = 34
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('19', 34, 'A');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE255_FA15_SECTION_1', 14, 100); -- section.id = 18
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('20', 18, 4, 'LETTER');  -- sectionenrollment.id = 35
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('20', 35, 'B-');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('18', 18, 4, 'LETTER');  -- sectionenrollment.id = 36
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('18', 36, 'B');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('21', 18, 4, 'LETTER');  -- sectionenrollment.id = 37
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('21', 37, 'F');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE232A_FA15_SECTION_1', 17, 100); -- section.id = 19
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('17', 19, 4, 'LETTER');  -- sectionenrollment.id = 38
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('17', 38, 'A-');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('CSE221_SP15_SECTION_1', 19, 100); -- section.id = 20
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('22', 20, 4, 'LETTER');  -- sectionenrollment.id = 39
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('22', 39, 'A');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('20', 20, 4, 'LETTER');  -- sectionenrollment.id = 40
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('20', 40, 'A');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('MAE107_SP15_SECTION_1', 22, 100); -- section.id = 21
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('10', 21, 4, 'LETTER');  -- sectionenrollment.id = 41
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('10', 41, 'B+');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('MAE108_FA14_SECTION_1', 24, 100); -- section.id = 22
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('8', 22, 2, 'LETTER');  -- sectionenrollment.id = 42
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('8', 42, 'B-');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('7', 22, 2, 'LETTER');  -- sectionenrollment.id = 43
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('7', 43, 'A-');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('MAE108_WI15_SECTION_1', 25, 100); -- section.id = 23
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('6', 23, 2, 'LETTER');  -- sectionenrollment.id = 44
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('6', 44, 'B');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('10', 23, 2, 'LETTER');  -- sectionenrollment.id = 45
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('10', 45, 'B+');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('PHIL10_FA15_SECTION_1', 28, 100); -- section.id = 24
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('11', 24, 4, 'LETTER');  -- sectionenrollment.id = 46
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('11', 46, 'A');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('12', 24, 4, 'LETTER');  -- sectionenrollment.id = 47
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('12', 47, 'A');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('13', 24, 4, 'LETTER');  -- sectionenrollment.id = 48
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('13', 48, 'C-');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('14', 24, 4, 'LETTER');  -- sectionenrollment.id = 49
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('14', 49, 'C+');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('PHIL165_SP15_SECTION_1', 32, 100); -- section.id = 25
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('15', 25, 2, 'LETTER');  -- sectionenrollment.id = 50
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('15', 50, 'F');
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('12', 25, 2, 'LETTER');  -- sectionenrollment.id = 51
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('12', 51, 'D');

INSERT INTO Section(section_num, class_id, section_limit) VALUES('PHIL165_FA15_SECTION_1', 33, 100); -- section.id = 26
INSERT INTO SectionEnrollment(student_num, section_id, units_taking, grade_option) VALUES ('11', 26, 2, 'LETTER');  -- sectionenrollment.id = 52
INSERT INTO ClassesTaken(student_num, sectionenrollment_id, grade_received) VALUES ('11', 52, 'A-');

-----------------Teaching Info-----------------
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Justin Bieber', 1);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Flo Rida', 32);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Selena Gomez', 3);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Adele', 24);
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(6, 'Taylor Swift');
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Kelly Clarkson', 2);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Bjork', 9);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Bjork', 28);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Justin Bieber', 12);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Flo Rida', 14);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Selena Gomez', 25);
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(10, 'Adele');
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Taylor Swift', 6);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Kelly Clarkson', 17);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Adam Levine', 33);
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Bjork', 22);
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(3, 'Justin Bieber');
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(1, 'Selena Gomez');
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(8, 'Selena Gomez');
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(4, 'Adam Levine');
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Bjork', 10);
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(7, 'Taylor Swift');
INSERT INTO TeachingHistory(faculty_name, class_id) VALUES('Kelly Clarkson', 19);
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(2, 'Kelly Clarkson');
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(5, 'Kelly Clarkson');
INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES(9, 'Kelly Clarkson');

-----------------Degree Info-----------------
INSERT INTO Degree(degree_name, degree_type, required_units) VALUES('Computer Science', 'BS', 40);
INSERT INTO Degree(degree_name, degree_type, required_units) VALUES('Philosophy', 'BA', 35);
INSERT INTO Degree(degree_name, degree_type, required_units) VALUES('Mechanical Engineering', 'BS', 50);
INSERT INTO Degree(degree_name, degree_type, required_units) VALUES('Computer Science', 'MS', 45);

INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(1, 1, 'Lower Division', 10, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(2, 1, 'Upper Division', 15, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(3, 1, 'Upper Division', 15, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(2, 1, 'Technical Elective', 15, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(4, 1, 'Technical Elective', 15, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(8, 1, 'Technical Elective', 15, 0.0);

INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(4, 4, 'Graduate Division', 45, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(5, 4, 'Graduate Division', 45, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(6, 4, 'Graduate Division', 45, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(7, 4, 'Graduate Division', 45, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(8, 4, 'Graduate Division', 45, 0.0);


INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(9, 3, 'Lower Division', 20, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(10, 3, 'Upper Division', 20, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(11, 3, 'Upper Division', 20, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(9, 3, 'Technical Elective', 10, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(10, 3, 'Technical Elective', 10, 0.0);

INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(12, 2, 'Lower Division', 15, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(13, 2, 'Lower Division', 15, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(14, 2, 'Upper Division', 20, 0.0);
INSERT INTO CourseCategory(course_id, degree_id, category_name, required_units, min_gpa) VALUES(15, 2, 'Upper Division', 20, 0.0);

INSERT INTO CourseConcentration(course_id, degree_id, concentration_name, required_units, min_gpa) VALUES(7, 4,'Databases', 4, 3.0);
INSERT INTO CourseConcentration(course_id, degree_id, concentration_name, required_units, min_gpa) VALUES(6, 4,'AI', 8, 3.1);
INSERT INTO CourseConcentration(course_id, degree_id, concentration_name, required_units, min_gpa) VALUES(4, 4,'AI', 8, 3.1);
INSERT INTO CourseConcentration(course_id, degree_id, concentration_name, required_units, min_gpa) VALUES(8, 4,'Systems', 4, 3.3);

-----------------Weekly Meeting Info-----------------
DO
$$
BEGIN
    FOR i IN 0..9 LOOP
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(1, 'LECTURE', '2016-01-04 10:00:00'::timestamp + (i * INTERVAL '7 DAYS') , '2016-01-04 11:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(1, 'LECTURE', '2016-01-06 10:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-06 11:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(1, 'LECTURE', '2016-01-08 10:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-08 11:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(2, 'LECTURE', '2016-01-04 10:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-04 11:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(2, 'LECTURE', '2016-01-06 10:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-06 11:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(2, 'LECTURE', '2016-01-08 10:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-08 11:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(3, 'LECTURE', '2016-01-04 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-04 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(3, 'LECTURE', '2016-01-06 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-06 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(3, 'LECTURE', '2016-01-08 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-08 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(4, 'LECTURE', '2016-01-04 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-04 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(4, 'LECTURE', '2016-01-06 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-06 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(4, 'LECTURE', '2016-01-08 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-08 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(5, 'LECTURE', '2016-01-04 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-04 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(5, 'LECTURE', '2016-01-06 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-06 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(5, 'LECTURE', '2016-01-08 12:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-08 13:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(6, 'LECTURE', '2016-01-05 14:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-05 15:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(6, 'LECTURE', '2016-01-07 14:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-07 15:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(6, 'DISCUSSION', '2016-01-08 18:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-08 19:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(7, 'LECTURE', '2016-01-05 15:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-05 16:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(7, 'LECTURE', '2016-01-07 15:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-07 16:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(8, 'LECTURE', '2016-01-05 15:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-05 16:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(8, 'LECTURE', '2016-01-07 15:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-07 16:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(9, 'LECTURE', '2016-01-05 17:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-05 18:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(9, 'LECTURE', '2016-01-07 17:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-07 18:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);

        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(10, 'LECTURE', '2016-01-05 17:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-05 18:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(10, 'LECTURE', '2016-01-07 17:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-07 18:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
        INSERT INTO WeeklyMeeting(section_id, meeting_type, start_datetime, end_datetime, location, required)
                VALUES(10, 'DISCUSSION', '2016-01-06 19:00:00'::timestamp + (i * INTERVAL '7 DAYS'), '2016-01-06 20:00:00'::timestamp + (i * INTERVAL '7 DAYS'), 'LOCATION', FALSE);
    END LOOP;
END
$$