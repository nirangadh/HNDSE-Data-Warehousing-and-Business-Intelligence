# Day 1 reference: three questions the warehouse must answer

This is a worked example of today's deliverable. Compare it with your own page. Your questions may differ and still be right, if each one compares terms or groups many rows.

## The scenario

The Thara Institute of Computing records every enrollment in a registration system built for the registration desk. The Dean needs answers across many terms and campuses, so the institute wants a data warehouse beside that system.

## Question 1: enrollments per course, per term

| | |
|---|---|
| The question | How many students enrolled in each course, in each semester of both academic years? |
| Who asks | The Dean |
| Data it needs | Every enrollment, with its course and its term |
| Shape of the answer | A table: one row for each course and term, with a count |
| Why not the registration system | It reads every enrollment and joins it to its course, on the same tables the desk writes. During enrollment week the desk waits behind it. |

## Question 2: enrollments by campus

| | |
|---|---|
| The question | How many students enrolled in each course at each campus, term by term? |
| Who asks | The Dean, and the Registrar for the gaps |
| Data it needs | Every enrollment with its term, and each student's campus |
| Shape of the answer | A table: one row for each campus, course and term, with a count |
| Why not the registration system | It holds no campus. The admissions office keeps campus in its own registry, so the two sources must be integrated first. |

## Question 3: is demand for a course growing?

| | |
|---|---|
| The question | Does enrollment in Database Systems grow from one academic year to the next, so that another intake should open? |
| Who asks | The Dean |
| Data it needs | Enrollments per course for the same semester in each academic year |
| Shape of the answer | A comparison: the same course and semester, one year beside the next |
| Why not the registration system | It records events, not trends. Every comparison rereads and regroups the whole history on the live system. |

For example, Database Systems had 3 enrollments in Semester 1 of 2023/2024 and 9 in Semester 1 of 2024/2025. That pair is information. Reading it as growth, and acting on it, is knowledge.

## Why none of these is a desk question

A desk question looks up one record, such as whether student 3003 is enrolled in Web Development this term. All three questions here group many rows or compare terms. That is the work a warehouse is built for.
