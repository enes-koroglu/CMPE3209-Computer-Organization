# CMPE3209-Computer-Organization
RISC-V RV32IM Computer Organization Project
# CMPE3209 - Computer Organization Project

## Project Overview
This project is developed for the CMPE3209 Computer Organization course using C99 and RISC-V RV32IM.

The selected task is **G2 - Exam Grade Distribution**.

## Project Description
The program generates 43 exam grades using a deterministic Linear Congruential Generator (LCG) based on the student ID.

It performs the following operations:
- Classifies grades into five intervals.
- Calculates the integer mean.
- Counts passing grades.
- Marks grades below the mean using bitwise OR (`0x100`).
- Stores results in global variables for verification.

## Technologies
- C99
- RISC-V RV32IM
- GCC 15.2.0
- QEMU and GDB

## Project Milestones
- M1: C implementation and parameter calculations
- M2: Assembly analysis and machine code encoding
- Final: CPU, interrupt, cache and performance analysis
