# SQL-project
A MySQL-based Hospital Management System Database implementing relational database design, patient management, doctor management, appointments, billing, medical records, SQL joins, subqueries, aggregate functions, and window functions

# Hospital Management System Database

## Overview

The Hospital Management System Database is a MySQL-based relational database project designed to manage and organize hospital operations efficiently. The database stores information related to patients, doctors, departments, appointments, medical records, and billing while maintaining proper relationships between tables using primary and foreign keys.

This project demonstrates fundamental as well as advanced SQL concepts, making it suitable for learning database management and SQL query writing.

---

## Objectives

- Design a normalized relational database.
- Maintain data integrity using primary and foreign keys.
- Store and manage hospital-related information.
- Perform data retrieval using SQL queries.
- Demonstrate advanced SQL concepts through practical examples.

---

## Technologies Used

- MySQL
- SQL
- MySQL Workbench

---

## Database Structure

The project consists of the following tables:

### Patients

Stores patient information.

Fields include:

- Patient ID
- Patient Name
- Date of Birth
- Gender
- Phone Number
- Email Address

---

### Doctors

Stores doctor information.

Fields include:

- Doctor ID
- Doctor Name
- Specialization
- Phone Number
- Email Address
- Experience
- Consultation Fee

---

### Departments

Stores hospital department details.

Fields include:

- Department ID
- Department Name

---

### Doctor_Department

Maintains the relationship between doctors and departments.

Fields include:

- Doctor ID
- Department ID

---

### Appointments

Stores appointment records between patients and doctors.

Fields include:

- Appointment ID
- Patient ID
- Doctor ID
- Appointment Date
- Appointment Status

---

### Medical_Records

Stores diagnosis and prescription details.

Fields include:

- Record ID
- Patient ID
- Doctor ID
- Diagnosis
- Prescription
- Treatment Date

---

### Billing

Stores billing information.

Fields include:

- Bill ID
- Patient ID
- Appointment ID
- Total Amount
- Payment Status
- Invoice Date

---

## Database Relationships

- One patient can have multiple appointments.
- One doctor can attend multiple appointments.
- One patient can have multiple medical records.
- One doctor can create multiple medical records.
- Doctors can belong to multiple departments.
- Departments can have multiple doctors.
- Each appointment can generate a billing record.

---

## SQL Concepts Implemented

### Database Creation

- CREATE DATABASE
- USE DATABASE

### Table Creation

- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- AUTO_INCREMENT
- NOT NULL
- UNIQUE

### Data Manipulation

- INSERT
- UPDATE
- DELETE
- SELECT

### SQL Joins

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN (using UNION)

### Aggregate Functions

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

### Grouping

- GROUP BY
- HAVING

### Sorting

- ORDER BY

### Filtering

- WHERE
- BETWEEN
- IN
- LIKE

### Subqueries

Examples include:

- Highest spending patient
- Doctors treating multiple patients
- Department-based doctor filtering

### Window Functions

- RANK()
- Running Total
- Cumulative Revenue

### Date Functions

- MONTH()
- YEAR()
- DATE_FORMAT()
- DATEDIFF()

### String Functions

- UPPER()
- LOWER()
- TRIM()
- CONCAT()
- COALESCE()

### Conditional Statements

- CASE

---

## Features

- Patient Management
- Doctor Management
- Department Management
- Appointment Scheduling
- Medical Record Management
- Billing Management
- Relational Database Design
- Data Integrity using Foreign Keys
- Advanced SQL Queries
- Reporting using SQL Functions

---

## Sample Queries Included

The SQL file contains examples such as:

- Display doctors with their departments.
- Display completed appointments.
- Find patients with pending payments.
- Calculate monthly appointments.
- Rank doctors by patient count.
- Calculate cumulative hospital revenue.
- Find highest spending patient.
- Categorize doctors based on experience.
- Categorize patients using CASE statements.
- Format treatment dates.

---

## Learning Outcomes

After completing this project, you will understand:

- Relational Database Design
- Database Normalization
- Primary and Foreign Keys
- SQL CRUD Operations
- SQL Joins
- Aggregate Functions
- Window Functions
- Subqueries
- Date Functions
- String Functions
- CASE Statements
- Query Optimization Basics

---

## How to Run the Project

1. Install MySQL Server.
2. Open MySQL Workbench.
3. Import or open the `hospitalmanagement.sql` file.
4. Execute the script.
5. The database, tables, sample data, and SQL queries will be created successfully.

---

## Future Enhancements

- User Authentication
- Nurse Management
- Pharmacy Management
- Laboratory Management
- Room Allocation
- Patient Admission and Discharge
- Inventory Management
- Online Appointment Booking
- Stored Procedures
- Triggers
- Views
- Dashboard Integration using Power BI
- Frontend Integration using Python or Java

---

## Author

**Nandani Rajput**

B.Tech Computer Science Engineering

GLS University



