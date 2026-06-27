



-- STEP 1: DATABASE CREATION

CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;


-- STEP 2: TABLE CREATION

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    experience_years INT,
    consultation_fee DECIMAL(10,2)
);

-- Departments Table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Doctor_Department Table (Mapping)
CREATE TABLE Doctor_Department (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Medical_Records Table
CREATE TABLE Medical_Records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    prescription TEXT,
    treatment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Billing Table
CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(50),
    invoice_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);


-- STEP 3: SAMPLE DATA INSERTION

INSERT INTO Patients (name, dob, gender, phone_number, email)
VALUES 
('Rahul Sharma', '1985-07-12', 'Male', '9876543210', 'rahul@gmail.com'),
('Priya Verma', '1992-03-25', 'Female', '9898989898', 'priya@gmail.com'),
('Amit Singh', '1978-11-08', 'Male', '9999000011', 'amit@gmail.com');

INSERT INTO Doctors (name, specialization, phone_number, email, experience_years, consultation_fee)
VALUES
('Dr. Meena Rao', 'Cardiology', '9812345678', 'meena@hospital.com', 18, 1200.00),
('Dr. Ajay Gupta', 'Neurology', '9823456789', 'ajay@hospital.com', 10, 950.00),
('Dr. Kavita Das', 'Dermatology', '9834567890', 'kavita@hospital.com', 6, 800.00);

INSERT INTO Departments (department_name)
VALUES ('Cardiology'), ('Neurology'), ('Dermatology');

INSERT INTO Doctor_Department (doctor_id, department_id)
VALUES (1,1), (2,2), (3,3);

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status)
VALUES
(1,1,'2024-06-10','Completed'),
(2,2,'2024-07-12','Scheduled'),
(3,3,'2024-06-25','Completed');

INSERT INTO Medical_Records (patient_id, doctor_id, diagnosis, prescription, treatment_date)
VALUES
(1,1,'Heart Checkup','Beta Blockers','2024-06-10'),
(2,2,'Migraine','Painkillers','2024-07-12'),
(3,3,'Skin Allergy','Ointment','2024-06-25');

INSERT INTO Billing (patient_id, appointment_id, total_amount, payment_status, invoice_date)
VALUES
(1,1,1200.00,'Paid','2024-06-11'),
(2,2,950.00,'Pending','2024-07-12'),
(3,3,800.00,'Paid','2024-06-26');


-- STEP 4: PRIMARY & FOREIGN KEY RELATIONSHIPS

-- Ensures medical records are linked correctly with patients and doctors.


-- STEP 5: IMPLEMENT JOINS

-- INNER JOIN: List doctors and their departments
SELECT d.name AS Doctor_Name, dep.department_name
FROM Doctors d
INNER JOIN Doctor_Department dd ON d.doctor_id = dd.doctor_id
INNER JOIN Departments dep ON dep.department_id = dd.department_id;

-- LEFT JOIN: Patients with completed appointments
SELECT p.name, a.status
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.status = 'Completed';

-- RIGHT JOIN: Appointments with no payments
SELECT a.appointment_id, a.status
FROM Appointments a
RIGHT JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.bill_id IS NULL;

-- FULL OUTER JOIN equivalent (using UNION)
SELECT p.name AS Patient, a.appointment_id
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
UNION
SELECT p.name, a.appointment_id
FROM Patients p
RIGHT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE p.patient_id IS NULL;


-- STEP 6: SUBQUERIES

-- Doctors handling more than 50 patients
SELECT doctor_id, name
FROM Doctors
WHERE doctor_id IN (
    SELECT doctor_id FROM Appointments
    GROUP BY doctor_id
    HAVING COUNT(*) > 50
);

-- Patient who spent the most
SELECT patient_id, SUM(total_amount) AS Total_Spent
FROM Billing
GROUP BY patient_id
ORDER BY Total_Spent DESC
LIMIT 1;

-- Appointments where doctor specializes in Dermatology
SELECT * FROM Appointments
WHERE doctor_id IN (
    SELECT doctor_id FROM Doctors
    WHERE specialization = 'Dermatology'
);


-- STEP 7: DATE & TIME FUNCTIONS

-- Extract month
SELECT MONTH(appointment_date) AS Month, COUNT(*) AS Total_Visits
FROM Appointments
GROUP BY Month;

-- Calculate total hospital stay (example table addition)
-- Assuming admission_date and discharge_date exist
-- SELECT DATEDIFF(discharge_date, admission_date) AS Stay_Days FROM Admissions;

-- Format date
SELECT DATE_FORMAT(treatment_date, '%d-%m-%Y') AS Formatted_Treatment_Date
FROM Medical_Records;

-- STEP 8: STRING MANIPULATION FUNCTIONS

-- Convert names to uppercase
SELECT UPPER(name) AS Patient_Name FROM Patients;

-- Trim whitespace from doctor names
SELECT TRIM(name) AS Doctor_Name FROM Doctors;

-- Replace missing phone numbers
SELECT COALESCE(phone_number, 'Not Available') AS Phone FROM Patients;


-- STEP 9: WINDOW FUNCTIONS

-- Rank doctors by number of patients
SELECT doctor_id, COUNT(patient_id) AS Total_Patients,
RANK() OVER (ORDER BY COUNT(patient_id) DESC) AS Doctor_Rank
FROM Appointments
GROUP BY doctor_id;

-- Cumulative revenue per month
SELECT MONTH(invoice_date) AS Month,
SUM(total_amount) AS Revenue,
SUM(SUM(total_amount)) OVER (ORDER BY MONTH(invoice_date)) AS Cumulative_Revenue
FROM Billing
GROUP BY Month;

-- Running total of appointments
SELECT appointment_date, COUNT(*) AS Daily_Appointments,
SUM(COUNT(*)) OVER (ORDER BY appointment_date) AS Running_Total
FROM Appointments
GROUP BY appointment_date;


-- STEP 10: CASE EXPRESSIONS

-- Assigning patient risk level
SELECT patient_id,
CASE 
    WHEN COUNT(record_id) > 5 THEN 'High'
    WHEN COUNT(record_id) BETWEEN 3 AND 5 THEN 'Medium'
    ELSE 'Low'
END AS Patient_Risk_Level
FROM Medical_Records
GROUP BY patient_id;

-- Categorize doctors by experience
SELECT name,
CASE
    WHEN experience_years > 15 THEN 'Senior'
    WHEN experience_years BETWEEN 5 AND 15 THEN 'Mid-Level'
    ELSE 'Junior'
END AS Doctor_Level
FROM Doctors;




