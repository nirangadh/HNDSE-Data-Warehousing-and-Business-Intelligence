# Day 4

## Materials

Files appear here before the teaching day.

## Theory: ETL part 2: reduce and load, then OLAP

**Ideas covered:** Reduction never lowers the grain; The warehouse invents its own keys; A cube is a set of query shapes.

**Demonstration:** The load in psql.

**Activity:** Name the shape.

**Components introduced:** 5, Loaded warehouse; 6, OLAP query shapes.

## Lab: Load the warehouse

**Demonstration:** Read the COPY counts.

**Activity:** Before and after.

**You build:** component 5, Loaded warehouse; component 6, OLAP query shapes.

## After this day

**Read:**

- Han, Kamber and Pei: the sections on OLAP operations and on MOLAP, ROLAP and HOLAP.

**Self-check (issued separately):** one question per idea: reduction, surrogate keys, the cube; why backslash-copy leaves a SERIAL sequence where it was.

**Tasks:**

- Read the coursework brief, released today.
- Start the coursework: declare the grain of the clinic warehouse.
