-- d1_registration.sql: the Thara Institute of Computing's student registration system.
-- The Thara Institute of Computing is fictional. Run it in the database `thara`:
--   psql -d thara -f d1_registration.sql
-- It rebuilds the schema `registration` and creates the schema `warehouse` if it does not exist.
-- It never touches the tables inside `warehouse`.

DROP SCHEMA IF EXISTS registration CASCADE;
CREATE SCHEMA registration;
CREATE SCHEMA IF NOT EXISTS warehouse;
SET search_path TO registration;

-- One row per student. Date of birth, gender, campus and programme are kept by the admissions office, not here.
CREATE TABLE students (
    student_id   INTEGER PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email        VARCHAR(120) NOT NULL UNIQUE,
    nationality  VARCHAR(50)  NOT NULL
);

-- One row per course. The department is a fact about the course, stored once.
CREATE TABLE courses (
    course_id    INTEGER PRIMARY KEY,
    course_name  VARCHAR(120) NOT NULL UNIQUE,
    department   VARCHAR(80)  NOT NULL,
    credits      INTEGER      NOT NULL CONSTRAINT courses_credits_check CHECK (credits IN (15, 20)),
    level        VARCHAR(20)  NOT NULL
);

-- One row per lecturer.
CREATE TABLE instructors (
    instructor_id  INTEGER PRIMARY KEY,
    title          VARCHAR(10) NOT NULL,
    initials       VARCHAR(10) NOT NULL,
    last_name      VARCHAR(50) NOT NULL
);

-- One row per enrollment: one student in one course during one academic term, taught by one lecturer.
-- A grade is empty until the lecturer enters it.
CREATE TABLE enrollments (
    enrollment_id    INTEGER PRIMARY KEY,
    student_id       INTEGER NOT NULL REFERENCES students (student_id),
    course_id        INTEGER NOT NULL REFERENCES courses (course_id),
    instructor_id    INTEGER NOT NULL REFERENCES instructors (instructor_id),
    semester         VARCHAR(20) NOT NULL CONSTRAINT enrollments_semester_check CHECK (semester IN ('Semester 1', 'Semester 2')),
    academic_year    VARCHAR(9)  NOT NULL CONSTRAINT enrollments_year_check CHECK (academic_year ~ '^[0-9]{4}/[0-9]{4}$'),
    enrollment_date  DATE        NOT NULL,
    grade            VARCHAR(2)  CONSTRAINT enrollments_grade_check CHECK (grade IN ('A', 'B', 'C', 'D', 'F')),
    CONSTRAINT enrollments_one_per_term UNIQUE (student_id, course_id, semester, academic_year)
);

INSERT INTO students (student_id, first_name, last_name, email, nationality) VALUES
    (3001, 'Amara', 'Perera', 'amara.p@thara.example', 'Sri Lankan'),
    (3002, 'Nimal', 'Silva', 'nimal.silva@thara.example', 'Sri Lankan'),
    (3003, 'Kavya', 'Fernando', 'kavya.f@thara.example', 'Sri Lankan'),
    (3004, 'Ruwan', 'Jayasuriya', 'ruwan.j@thara.example', 'Sri Lankan'),
    (3005, 'Dilani', 'Wickramasinghe', 'dilani.w@thara.example', 'Sri Lankan'),
    (3006, 'Chamara', 'Bandara', 'chamara.b@thara.example', 'Sri Lankan'),
    (3007, 'Ishara', 'Gunawardena', 'ishara.g@thara.example', 'Sri Lankan'),
    (3008, 'Tharindu', 'Rathnayake', 'tharindu.r@thara.example', 'Sri Lankan'),
    (3009, 'Sanduni', 'Mendis', 'sanduni.m@thara.example', 'Sri Lankan'),
    (3010, 'Lahiru', 'Peiris', 'lahiru.p@thara.example', 'Sri Lankan'),
    (3011, 'Achini', 'Rajapaksa', 'achini.r@thara.example', 'Sri Lankan'),
    (3012, 'Kasun', 'Dissanayake', 'kasun.d@thara.example', 'Sri Lankan'),
    (3013, 'Nadeesha', 'Ekanayake', 'nadeesha.e@thara.example', 'Sri Lankan'),
    (3014, 'Buddhika', 'Karunaratne', 'buddhika.k@thara.example', 'Sri Lankan'),
    (3015, 'Hansi', 'Weerasinghe', 'hansi.w@thara.example', 'Sri Lankan'),
    (3016, 'Priya', 'Kumar', 'priya.kumar@thara.example', 'Indian'),
    (3017, 'Ahmed', 'Rizwan', 'ahmed.r@thara.example', 'Maldivian'),
    (3018, 'Mohamed', 'Faisal', 'mohamed.f@thara.example', 'Maldivian'),
    (3019, 'Zhang', 'Wei', 'zhang.wei@thara.example', 'Chinese'),
    (3020, 'Ayesha', 'Khan', 'ayesha.khan@thara.example', 'Pakistani'),
    (3021, 'Malith', 'Senanayake', 'malith.s@thara.example', 'Sri Lankan'),
    (3022, 'Shehani', 'Gamage', 'shehani.g@thara.example', 'Sri Lankan'),
    (3023, 'Yasas', 'Liyanage', 'yasas.l@thara.example', 'Sri Lankan'),
    (3024, 'Rifka', 'Hameed', 'rifka.h@thara.example', 'Sri Lankan');

INSERT INTO courses (course_id, course_name, department, credits, level) VALUES
    (2001, 'Database Systems', 'Computing', 15, 'Level 4'),
    (2002, 'Web Development', 'Computing', 15, 'Level 4'),
    (2003, 'Object Oriented Programming', 'Computing', 20, 'Level 4'),
    (2004, 'Data Warehousing and Business Intelligence', 'Computing', 15, 'Level 4'),
    (2005, 'Financial Accounting', 'Business', 15, 'Level 4'),
    (2006, 'Marketing Principles', 'Business', 15, 'Level 4'),
    (2007, 'Networking Fundamentals', 'Computing', 20, 'Level 4');

INSERT INTO instructors (instructor_id, title, initials, last_name) VALUES
    (4001, 'Dr.', 'S.', 'Fonseka'),
    (4002, 'Mr.', 'R.', 'Abeywardena'),
    (4003, 'Ms.', 'T.', 'Herath'),
    (4004, 'Dr.', 'N.', 'Wijesuriya');

INSERT INTO enrollments (enrollment_id, student_id, course_id, instructor_id, semester, academic_year, enrollment_date, grade) VALUES
    (5001, 3001, 2001, 4001, 'Semester 1', '2024/2025', '2024-09-01', NULL),
    (5002, 3001, 2002, 4002, 'Semester 1', '2024/2025', '2024-09-01', NULL),
    (5003, 3001, 2003, 4002, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5004, 3001, 2004, 4002, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5005, 3002, 2001, 4001, 'Semester 1', '2024/2025', '2024-09-01', NULL),
    (5006, 3002, 2003, 4004, 'Semester 1', '2024/2025', '2024-09-01', NULL),
    (5007, 3002, 2005, 4001, 'Semester 2', '2023/2024', '2024-02-01', 'A'),
    (5008, 3003, 2002, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'A'),
    (5009, 3003, 2004, 4002, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5010, 3004, 2001, 4001, 'Semester 1', '2023/2024', '2023-09-01', 'F'),
    (5011, 3004, 2006, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5012, 3004, 2007, 4004, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5013, 3005, 2003, 4004, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5014, 3005, 2004, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5015, 3006, 2001, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'A'),
    (5016, 3006, 2005, 4003, 'Semester 1', '2024/2025', '2024-09-01', 'D'),
    (5017, 3006, 2006, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5018, 3007, 2002, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5019, 3007, 2007, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5020, 3008, 2004, 4001, 'Semester 1', '2024/2025', '2024-09-01', 'A'),
    (5021, 3008, 2001, 4001, 'Semester 2', '2023/2024', '2024-02-01', 'D'),
    (5022, 3009, 2003, 4003, 'Semester 1', '2024/2025', '2024-09-01', 'C'),
    (5023, 3009, 2006, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5024, 3010, 2001, 4004, 'Semester 1', '2024/2025', '2024-09-01', 'A'),
    (5025, 3010, 2002, 4001, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5026, 3011, 2004, 4001, 'Semester 1', '2024/2025', '2024-09-01', 'D'),
    (5027, 3011, 2005, 4003, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5028, 3011, 2007, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5029, 3012, 2001, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5030, 3012, 2003, 4001, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5031, 3013, 2002, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'A'),
    (5032, 3013, 2004, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5033, 3014, 2001, 4002, 'Semester 1', '2023/2024', '2023-09-01', 'A'),
    (5034, 3014, 2006, 4004, 'Semester 1', '2024/2025', '2024-09-01', 'A'),
    (5035, 3015, 2003, 4004, 'Semester 1', '2024/2025', '2024-09-01', 'C'),
    (5036, 3015, 2007, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5037, 3016, 2004, 4003, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5038, 3016, 2001, 4003, 'Semester 2', '2024/2025', '2025-02-01', NULL),
    (5039, 3017, 2002, 4003, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5040, 3017, 2005, 4001, 'Semester 2', '2024/2025', '2025-02-01', 'C'),
    (5041, 3018, 2001, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5042, 3018, 2003, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5043, 3018, 2004, 4002, 'Semester 2', '2024/2025', '2025-02-01', 'F'),
    (5044, 3018, 2006, 4004, 'Semester 2', '2024/2025', '2025-02-01', 'F'),
    (5045, 3019, 2001, 4003, 'Semester 1', '2024/2025', '2024-09-01', 'D'),
    (5046, 3019, 2002, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5047, 3019, 2007, 4003, 'Semester 2', '2024/2025', '2025-02-01', 'D'),
    (5048, 3019, 2005, 4001, 'Semester 2', '2024/2025', '2025-02-01', 'B'),
    (5049, 3020, 2004, 4001, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5050, 3020, 2003, 4003, 'Semester 2', '2024/2025', '2025-02-01', 'F'),
    (5051, 3020, 2001, 4004, 'Semester 2', '2024/2025', '2025-02-01', 'B'),
    (5052, 3002, 2002, 4002, 'Semester 2', '2023/2024', '2024-02-01', 'C'),
    (5053, 3003, 2006, 4004, 'Semester 1', '2023/2024', '2023-09-01', 'D'),
    (5054, 3004, 2002, 4002, 'Semester 1', '2023/2024', '2023-09-01', 'B'),
    (5055, 3005, 2006, 4003, 'Semester 2', '2023/2024', '2024-02-01', 'F'),
    (5056, 3006, 2006, 4004, 'Semester 2', '2023/2024', '2024-02-01', 'D'),
    (5057, 3007, 2003, 4004, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5058, 3008, 2001, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'B'),
    (5059, 3009, 2006, 4001, 'Semester 1', '2024/2025', '2024-09-01', 'D'),
    (5060, 3010, 2004, 4004, 'Semester 1', '2023/2024', '2023-09-01', 'F'),
    (5061, 3011, 2005, 4001, 'Semester 2', '2023/2024', '2024-02-01', 'F'),
    (5062, 3012, 2001, 4003, 'Semester 2', '2023/2024', '2024-02-01', 'A'),
    (5063, 3013, 2007, 4001, 'Semester 2', '2023/2024', '2024-02-01', 'C'),
    (5064, 3014, 2003, 4004, 'Semester 1', '2023/2024', '2023-09-01', 'B'),
    (5065, 3015, 2001, 4002, 'Semester 2', '2023/2024', '2024-02-01', 'C'),
    (5066, 3016, 2005, 4002, 'Semester 1', '2024/2025', '2024-09-01', 'C'),
    (5067, 3017, 2002, 4001, 'Semester 1', '2023/2024', '2023-09-01', 'B'),
    (5068, 3002, 2005, 4001, 'Semester 1', '2023/2024', '2023-09-01', 'D'),
    (5069, 3003, 2001, 4002, 'Semester 1', '2023/2024', '2023-09-01', 'C'),
    (5070, 3004, 2001, 4001, 'Semester 1', '2024/2025', '2024-09-01', 'F'),
    (5071, 3005, 2001, 4001, 'Semester 2', '2023/2024', '2024-02-01', 'D'),
    (5072, 3006, 2007, 4002, 'Semester 2', '2023/2024', '2024-02-01', 'B'),
    (5073, 3007, 2006, 4002, 'Semester 1', '2023/2024', '2023-09-01', 'F');

RESET search_path;
