# Data Warehousing and Business Intelligence

This module is taught on the BSc (Hons) Computing at Level 4 and on the Higher National Diploma in Software Engineering. Over seven teaching days you build one data warehouse, step by step, for the Thara Institute of Computing. The institute is fictional. Then you build a second warehouse in a new domain, on your own.

## Start here

1. [Getting started](getting-started.md): set up your portable tools, and learn how each day works.
2. [The scenario](scenario/organisation.md): the institute every lab builds for, and the three people who ask the questions.
3. [The glossary](glossary.md): every word the module teaches, filed under the day that first uses it.

## Learning outcomes

On completion of this module, a successful student should be able to:

- **LO1.** Explain the concepts of Data warehousing and decision support systems.
- **LO2.** Apply the de-normalized concept of data modeling in data warehousing.
- **LO3.** Use of Oracle BI / MS Power BI tools for building Data Warehouses.
- **LO4.** Explain the fundamentals of OLAP Cube creation.
- **LO5.** Use data visualization for business intelligence.

## How the module runs

Each teaching day has a theory session and a lab session. A review session after Day 7 prepares you for the written test.

| Day | Topic |
|---|---|
| [Day 1](days/day-1/README.md) | Foundations: why a warehouse exists |
| [Day 2](days/day-2/README.md) | Dimensional modelling: build the spine |
| [Day 3](days/day-3/README.md) | ETL part 1: extract, cleanse, integrate, transform |
| [Day 4](days/day-4/README.md) | ETL part 2: reduction and load; OLAP concepts |
| [Day 5](days/day-5/README.md) | OLAP operations; introduction to BI |
| [Day 6](days/day-6/README.md) | Data visualisation |
| [Day 7](days/day-7/README.md) | Integrated capstone, in an e-commerce domain |
| [Review](days/review/README.md) | Examination preparation and coursework clinic |

Each day's folder holds its notes, its lab sheet, its slides and its practice. Read the notes before the lab, and follow the lab sheet step by step. Every step says what you should see, and what to do if you do not see it.

## The tools

You use four tools, and each one has one job. PostgreSQL stores the warehouse and answers its queries. DBeaver is the SQL client, and it draws the database diagrams. Python with pandas, in Jupyter, cleans and joins the data. Metabase builds the charts and dashboards.

All four run from one folder, with no installation and no administrator rights. Metabase is free and open source. It teaches the same steps as the business intelligence tools named in the learning outcomes: connect to the warehouse, model the data, then build the visuals.

## Restoring is not cheating

Each day's `reference` folder holds the correct output of that day. If your result is wrong, use it and carry on. It costs you no marks, and one bad result never blocks the rest of your week.

## Assessment

The module has two assessments, weighted equally. The coursework asks you to build a data warehouse with business intelligence, in a domain of its own. The written test is closed book. Dates and submissions are announced for your cohort.

## Licences

The teaching content is shared under a Creative Commons licence: see [LICENSE-CONTENT.md](LICENSE-CONTENT.md). The code, the SQL and the launchers are under the MIT licence: see [LICENSE](LICENSE).
