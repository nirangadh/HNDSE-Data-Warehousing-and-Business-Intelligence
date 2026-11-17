# Day 3

## Materials

Files appear here before the teaching day.

## Theory: ETL part 1: cleanse, integrate, transform

**Ideas covered:** Data quality is measured, not felt; The grain statement is executable; A lookup can multiply rows silently.

**Demonstration:** The two failures, live.

**Activity:** Count before you clean.

**Components introduced:** 4, Conformed enrollment file.

## Lab: Cleanse and integrate

**Demonstration:** Profile first.

**You build:** component 4, Conformed enrollment file.

## After this day

**Read:**

- Kimball and Caserta, The Data Warehouse ETL Toolkit: the chapter on cleaning and conforming.

**Self-check (issued separately):** one question per idea: the quality dimensions, the grain as a business key, counting across a join; why df.duplicated() with no subset returns 0 on this file.

**Tasks:**

- Keep your before-and-after counts; Day 4 adds the warehouse column to them.
- Check that your file has 73 rows before you leave.
