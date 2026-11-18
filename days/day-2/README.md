# Day 2

## Materials

Files appear here before the teaching day.

## Theory: Build the spine

**Ideas covered:** Grain is declared before any column is chosen; Measures live in the fact, context lives in the dimensions; Denormalisation is a deliberate choice.

**Demonstration:** The star in DBeaver.

**Activity:** Fact or dimension?

**Components introduced:** 3, Star schema.

## Lab: Build the star in SQL

**Demonstration:** One table, live.

**Activity:** Test the star against your questions.

**You build:** component 3, Star schema.

## After this day

**Read:**

- Kimball and Caserta, The Data Warehouse ETL Toolkit, Chapter 5 (Delivering Dimension Tables) and Chapter 6 (Delivering Fact Tables).

**Self-check:** The notes' Self-Check asks one question per idea: the grain sentence, measures and context, star and snowflake. From the lab, explain why fact_enrollment is created after the three dimensions.

**Tasks:**

- Learn the grain sentence word for word.
- Optional extension: add dim_instructor and a key for it on the fact.
