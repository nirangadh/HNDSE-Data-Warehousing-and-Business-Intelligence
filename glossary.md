# Glossary

Every word the module teaches, filed under the day that first uses it.

## Day 1

### OLTP
Online transaction processing. A system that records events one row at a time, with insert, update, delete and look-up. Each event it records is called a transaction.
*Thara example:* The registration desk adds one enrollment for a student at the counter. That is OLTP work.

### OLAP
Online analytical processing. Work that reads many rows at once and groups them to count, sum and compare.
*Thara example:* Counting the enrollments in each course for one term is OLAP work.

### workload
The kind of work a database does most of the time: many small writes, or large reads over history.
*Thara example:* The registration system's workload is the desk's small writes, all day, during enrollment week.

### data warehouse
A separate system that holds history for analysis. It is subject-oriented, integrated, time-variant and non-volatile.
*Thara example:* The institute's warehouse will answer the Dean's questions without slowing the registration desk.

### subject-oriented
Organised around the subject people ask about, not around the screens of the system that records it.
*Thara example:* The warehouse is organised around enrollment, the subject the Dean asks about.

### integrated
Every source uses one spelling for each value and one key for each thing it describes.
*Thara example:* A student keeps one key in the warehouse, whether the row came from the registration system or the admissions registry.

### time-variant
Every row carries the time it belongs to, so one period can be compared with another.
*Thara example:* Each enrollment carries its semester and academic year, so Semester 1 of 2024/2025 can be compared with Semester 1 of 2023/2024.

### non-volatile
Rows are loaded and read, not edited, so a report gives the same answer next month.
*Thara example:* An enrollment loaded into the warehouse is never changed in place by the desk.

### data
A recorded fact about one event, with no context around it.
*Thara example:* Student 3003 enrolled in Web Development in Semester 1 of 2024/2025.

### information
Data with context, so it can be read and compared.
*Thara example:* Database Systems had 9 enrollments in Semester 1 of 2024/2025, more than any other course.

### knowledge
A pattern you can act on, found by reading information over time and in context.
*Thara example:* Whether demand for Database Systems grows from one year to the next.

### decision support system
A system that helps people move from stored data to a decision, with questions they ask themselves.
*Thara example:* The warehouse and its dashboards help the Dean decide whether to open another intake.
