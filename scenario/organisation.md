# Thara Institute of Computing

The institute every lab in Days 1 to 6 builds for. The Thara Institute of Computing is fictional, and any likeness to a real institute is accidental.

## 1. Profile

Thara Institute of Computing is a private higher-education institute in Sri Lanka. It teaches at two campuses, Colombo and Kandy, and runs an online programme. Two programmes share most of their courses: the BSc (Hons) Computing and the HND in Software Engineering. A smaller School of Business teaches accounting and marketing courses that computing students may take as electives.

Every student, course and enrollment is recorded in one student registration system. That system was built for the registration desk: it adds, changes and looks up one record at a time, quickly and correctly. A separate admissions office keeps its own student registry as a spreadsheet export, with each student's date of birth, gender, entry year, campus and programme.

## 2. What went wrong

Last year, the Dean asked a simple question. How many students enrolled in each course, each semester, at each campus, over two years? The answer took a week. The first attempt ran a large query on the live registration system during enrollment week, and the registration desk slowed to a crawl. The second attempt combined spreadsheet exports from three offices, and the three gave three different totals. Nobody could say which total was right, or why the others were wrong.

The institute now wants a data warehouse. It is one place, separate from the live system. There, these questions are answered quickly, and the same way every time.

## 3. The three voices

These are roles, not named people. You meet them at the start of each day and in the practice activities.

- **The Dean of Academic Affairs** asks the questions a decision needs. Should the institute open another intake? Which courses are growing? Where do students fail? The Dean wants one number to trust, not a spreadsheet.
- **The Registrar** owns the student data and answers for its quality. The Registrar knows where the registration system and the admissions registry disagree, and does not want the warehouse to hide it.
- **The Head of Computing** runs the courses, the timetable and the lecturers. The Head wants to see enrollment and results by course, by lecturer and by term, and to plan next semester from them.

## 4. The questions the warehouse must answer

These come from the voices on Day 1, and later days test the warehouse against them.

1. How many students enrolled in each course, in each semester and academic year? (Dean)
2. How do enrollment and results differ by campus, programme, gender and entry year? (Dean, Registrar)
3. Which courses grow or shrink from one year to the next, and where should another intake open? (Dean)
4. Which lecturers teach the courses with the highest enrollment? (Head of Computing; answered by an optional extension, a fourth dimension for lecturers)
5. How many grades are still missing for terms that have ended? (Registrar)

## 5. The source systems

| Source | What it holds | Where it is used |
|---|---|---|
| Student registration system (OLTP) | Tables `students`, `courses`, `instructors`, `enrollments`, normalised | Day 1, compared with the warehouse; Day 2, the source the star is designed from |
| Enrollment extract | `enrollments_raw.csv`: one wide row per enrollment, exported from the registration system with its real defects | Day 3 |
| Admissions registry | `student_registry.csv`: one row per student, from the admissions office's spreadsheet | Day 3, the second source integrated |

## 6. The warehouse being built

A star schema in PostgreSQL. The grain is fixed, word for word:

**One row in fact_enrollment represents one student enrolled in one course during one academic term.**

The fact table `fact_enrollment` carries `grade` and the additive measure `enrollment_count`. Three dimensions carry the context: `dim_student`, `dim_course` (with the department denormalised onto it) and `dim_date` (one row per academic term). You design it on Day 2 and fill it on Days 3 and 4. You query it on Days 4 and 5, and build a dashboard on it on Day 6.

Day 7 leaves the institute. The capstone runs the same method on a public e-commerce dataset (Olist), so students see that the method transfers and the domain does not.

## 7. The warehouse you will build

Each lab lights up numbered components on the [warehouse diagram](architecture.svg).

| No. | Component | What it is | Day |
|---|---|---|---|
| 1 | Registration system | the normalised OLTP database (students, courses, instructors, enrollments), compared with the warehouse | 1 |
| 2 | Requirements | the voices' questions, turned into what the warehouse must answer | 1 |
| 3 | Star schema | fact_enrollment and dim_student, dim_course, dim_date in PostgreSQL, from DDL, with the seed rows | 2 |
| 4 | Conformed enrollment file | enrollments_conformed.csv, 73 rows, from the enrollment extract and the admissions registry in a pandas notebook | 3 |
| 5 | Loaded warehouse | reduced, keyed and loaded by psql backslash-copy, dimensions before the fact; dw_complete.sql | 4 |
| 6 | OLAP query shapes | slice, dice, drill down, roll up and pivot with ROLLUP, CUBE and GROUPING SETS | 4, 5 |
| 7 | Dashboard | Metabase connected to the warehouse; five visuals and filters for one role | 5, 6 |
| 8 | Capstone warehouse | the whole pipeline again on the e-commerce domain, from design to dashboard | 7 |

## 8. Names used in labs

Every name a lab uses is in this table.

| Kind | Names |
|---|---|
| OLTP tables | `students`, `courses`, `instructors`, `enrollments` |
| Warehouse tables | `fact_enrollment`, `dim_student`, `dim_course`, `dim_date`; optional extension `dim_instructor` |
| Keys | surrogate `student_key`, `course_key`, `date_key`, `enrollment_key`; natural `student_id`, `course_id`, `enrollment_id` |
| Day 3 files | `enrollments_raw.csv` (78 rows), `student_registry.csv` (22 rows), output `enrollments_conformed.csv` (73 rows), manifest `d3_data_manifest.md` |
| Day 3 notebooks | `d3_etl_skeleton.ipynb`, `d3_etl_solution.ipynb` |
| Day 4 files | `dw_complete.sql` (the populated warehouse), load report `d4_load_report.md` |
| Courses | 2001 Database Systems, 2002 Web Development, 2003 Object Oriented Programming, 2004 Data Warehousing and Business Intelligence, 2005 Financial Accounting, 2006 Marketing Principles, 2007 Networking Fundamentals |
| Departments | Computing, Business |
| Campuses | Colombo, Kandy, Online |
| Programmes | BSc (Hons) Computing, HND Software Engineering |
| Terms | Semester 1 and Semester 2 of 2023/2024 and 2024/2025 |
| Lecturers | Dr. S. Fonseka, Mr. R. Abeywardena, Ms. T. Herath, Dr. N. Wijesuriya |
| Student ids | 3001 to 3024; 3001 is the student whose duplicate in the registry causes the Day 3 fan-out |
| Email domain | `thara.example` |
