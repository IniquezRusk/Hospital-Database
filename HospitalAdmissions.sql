-- ===================================
-- HOSPITAL ADMISSIONS DATABASE SCRIPT (PRIORITY INTEGRATED)
-- ===================================

CREATE DATABASE IF NOT EXISTS HospitalAdmissions;
USE HospitalAdmissions;

-- ===================================
-- 1️⃣ Tables
-- ===================================

CREATE TABLE Branch (
  branch_id INT AUTO_INCREMENT PRIMARY KEY,
  branch_name VARCHAR(50) NOT NULL UNIQUE,
  floor_no INT,
  phone_ext VARCHAR(10) NOT NULL,
  capacity INT,
  head_doctor VARCHAR(50)
);

CREATE TABLE Doctor (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  phone VARCHAR(15) UNIQUE,
  branch_id INT NOT NULL,
  FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE Patient (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  gender ENUM('Male', 'Female', 'Other') NOT NULL,
  age INT CHECK (age BETWEEN 0 AND 120),
  priority_level ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,
  phone VARCHAR(15) UNIQUE,
  address VARCHAR(100)
);

CREATE TABLE Bed (
  bed_id INT AUTO_INCREMENT PRIMARY KEY,
  room_no VARCHAR(10) NOT NULL,
  bed_number INT CHECK (bed_number > 0),
  bed_type ENUM('Standard', 'ICU', 'Emergency') NOT NULL,
  status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
  branch_id INT NOT NULL,
  FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE Admission (
  admission_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  bed_id INT NOT NULL,
  branch_id INT NOT NULL,
  admission_date DATE NOT NULL,
  discharge_date DATE DEFAULT NULL,
  diagnosis VARCHAR(100),
  status ENUM('Admitted', 'Discharged') DEFAULT 'Admitted',
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
  FOREIGN KEY (bed_id) REFERENCES Bed(bed_id),
  FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
  CHECK (discharge_date IS NULL OR discharge_date >= admission_date)
);

-- ===================================
-- 2️⃣ Sample Data
-- ===================================

-- Branches
INSERT INTO Branch (branch_name, floor_no, phone_ext, capacity, head_doctor) VALUES
('Cardiology', 2, '201', 25, 'Dr. Adams'),
('Neurology', 3, '301', 20, 'Dr. Banner'),
('ICU', 1, '101', 10, 'Dr. Patel'),
('Pediatrics', 4, '401', 20, 'Dr. Chu'),
('Emergency', 0, '001', 30, 'Dr. Ross'),
('Orthopedics', 5, '501', 15, 'Dr. Smith'),
('Oncology', 6, '601', 15, 'Dr. Wong'),
('Gastroenterology', 7, '701', 12, 'Dr. Lee'),
('Pulmonology', 8, '801', 10, 'Dr. Kim'),
('Dermatology', 9, '901', 8, 'Dr. Singh');

-- Doctors
INSERT INTO Doctor (name, phone, branch_id) VALUES
('Dr. Adams', '202-555-0101', 1),
('Dr. Banner', '202-555-0102', 2),
('Dr. Patel', '202-555-0103', 3),
('Dr. Chu', '202-555-0104', 4),
('Dr. Ross', '202-555-0105', 5),
('Dr. Smith', '202-555-0106', 6),
('Dr. Wong', '202-555-0107', 7),
('Dr. Lee', '202-555-0108', 8),
('Dr. Kim', '202-555-0109', 9),
('Dr. Singh', '202-555-0110', 10);

-- Patients
INSERT INTO Patient (name, gender, age, priority_level, phone, address) VALUES
('John Smith', 'Male', 45, 'High', '301-555-1001', '123 Main St'),
('Mary Johnson', 'Female', 30, 'Medium', '301-555-1002', '456 Oak St'),
('James Brown', 'Male', 60, 'Critical', '301-555-1003', '789 Pine St'),
('Patricia Taylor', 'Female', 25, 'Low', '301-555-1004', '321 Maple St'),
('Robert Miller', 'Male', 50, 'High', '301-555-1005', '654 Elm St'),
('Linda Davis', 'Female', 40, 'Medium', '301-555-1006', '987 Cedar St'),
('Michael Wilson', 'Male', 70, 'Critical', '301-555-1007', '246 Birch St'),
('Barbara Moore', 'Female', 35, 'Medium', '301-555-1008', '135 Spruce St'),
('William Taylor', 'Male', 55, 'High', '301-555-1009', '864 Walnut St'),
('Elizabeth Anderson', 'Female', 28, 'Low', '301-555-1010', '579 Chestnut St');

-- Beds (2 per branch)
INSERT INTO Bed (room_no, bed_number, bed_type, status, branch_id) VALUES
('A101', 1, 'Standard', 'Available', 1),('A102', 2, 'Standard', 'Available', 1),
('B101', 1, 'Standard', 'Available', 2),('B102', 2, 'Standard', 'Available', 2),
('C101', 1, 'ICU', 'Available', 3),('C102', 2, 'ICU', 'Available', 3),
('D101', 1, 'Standard', 'Available', 4),('D102', 2, 'Standard', 'Available', 4),
('E101', 1, 'Emergency', 'Available', 5),('E102', 2, 'Emergency', 'Available', 5),
('F101', 1, 'Standard', 'Available', 6),('F102', 2, 'Standard', 'Available', 6),
('G101', 1, 'Standard', 'Available', 7),('G102', 2, 'Standard', 'Available', 7),
('H101', 1, 'Standard', 'Available', 8),('H102', 2, 'Standard', 'Available', 8),
('I101', 1, 'Standard', 'Available', 9),('I102', 2, 'Standard', 'Available', 9),
('J101', 1, 'Standard', 'Available', 10),('J102', 2, 'Standard', 'Available', 10);

-- Admission sample rows
INSERT INTO Admission (patient_id, doctor_id, bed_id, branch_id, admission_date, status, diagnosis) VALUES
(1, 1, 1, 1, '2025-11-01', 'Admitted', 'Hypertension'),
(2, 2, 3, 2, '2025-11-02', 'Admitted', 'Migraine'),
(3, 3, 5, 3, '2025-11-01', 'Admitted', 'Heart Attack'),
(4, 4, 7, 4, '2025-11-03', 'Admitted', 'Flu'),
(5, 5, 9, 5, '2025-11-01', 'Admitted', 'Broken Arm'),
(6, 6, 11, 6, '2025-11-04', 'Admitted', 'Laceration'),
(7, 3, 6, 3, '2025-11-02', 'Admitted', 'Stroke'),
(8, 4, 8, 4, '2025-11-05', 'Admitted', 'Asthma Attack'),
(9, 2, 4, 2, '2025-11-03', 'Admitted', 'Seizure'),
(10, 1, 2, 1, '2025-11-06', 'Admitted', 'Arrhythmia');

-- ===================================
-- 3️⃣ Triggers
-- ===================================

DELIMITER $$

-- Trigger 1: Mark bed as Occupied
DROP TRIGGER IF EXISTS tr_bed_occupied$$
CREATE TRIGGER tr_bed_occupied
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE bed_status VARCHAR(20);
    SELECT status INTO bed_status FROM Bed WHERE bed_id = NEW.bed_id;

    IF bed_status <> 'Available' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bed is not available!';
    END IF;

    UPDATE Bed SET status='Occupied' WHERE bed_id=NEW.bed_id;
END$$

-- Trigger 2: Free bed on discharge
DROP TRIGGER IF EXISTS tr_bed_available$$
CREATE TRIGGER tr_bed_available
AFTER UPDATE ON Admission
FOR EACH ROW
BEGIN
    IF NEW.status='Discharged' THEN
        UPDATE Bed SET status='Available' WHERE bed_id=NEW.bed_id;
    END IF;
END$$

-- Trigger 3: Prevent overcapacity
DROP TRIGGER IF EXISTS tr_branch_capacity$$
CREATE TRIGGER tr_branch_capacity
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE current_count INT;
    DECLARE max_capacity INT;
    SELECT COUNT(*) INTO current_count
    FROM Admission
    WHERE branch_id=NEW.branch_id AND status='Admitted';

    SELECT capacity INTO max_capacity FROM Branch WHERE branch_id=NEW.branch_id;

    IF current_count >= max_capacity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cannot admit patient: Branch full.';
    END IF;
END$$

-- Trigger 4: Enforce priority bed type
DROP TRIGGER IF EXISTS tr_priority_bed_assignment$$
CREATE TRIGGER tr_priority_bed_assignment
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE patient_priority ENUM('Low','Medium','High','Critical');
    SELECT priority_level INTO patient_priority FROM Patient WHERE patient_id=NEW.patient_id;

    IF patient_priority IN ('High','Critical') THEN
        IF (SELECT bed_type FROM Bed WHERE bed_id=NEW.bed_id) NOT IN ('ICU','Emergency') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT='High/Critical patients must be assigned ICU/Emergency bed.';
        END IF;
    END IF;
END$$

DELIMITER ;

-- ===================================
-- 4️⃣ Procedures and Functions
-- ===================================

DELIMITER $$

-- Check branch capacity
DROP PROCEDURE IF EXISTS sp_check_branch_capacity$$
CREATE PROCEDURE sp_check_branch_capacity(IN p_branch_id INT)
BEGIN
    DECLARE total_capacity INT;
    DECLARE occupied_count INT;
    DECLARE available_beds INT;

    SELECT capacity INTO total_capacity FROM Branch WHERE branch_id=p_branch_id;
    SELECT COUNT(*) INTO occupied_count FROM Admission WHERE branch_id=p_branch_id AND status='Admitted';
    SET available_beds = total_capacity - occupied_count;

    SELECT p_branch_id AS BranchID, total_capacity AS Capacity, occupied_count AS Occupied, available_beds AS Available;
END$$

-- List available beds
DROP PROCEDURE IF EXISTS sp_list_available_beds$$
CREATE PROCEDURE sp_list_available_beds(IN p_branch_id INT)
BEGIN
    SELECT bed_id, room_no, bed_number, bed_type, status
    FROM Bed
    WHERE branch_id=p_branch_id AND status='Available';
END$$

-- Count admitted patients
DROP FUNCTION IF EXISTS fn_count_admitted_patients$$
CREATE FUNCTION fn_count_admitted_patients(p_branch_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE patient_count INT;
    SELECT COUNT(*) INTO patient_count FROM Admission WHERE branch_id=p_branch_id AND status='Admitted';
    RETURN patient_count;
END$$

-- Admit patient with priority-based bed assignment
DROP PROCEDURE IF EXISTS sp_admit_patient$$
CREATE PROCEDURE sp_admit_patient(IN p_patient_id INT, IN p_doctor_id INT, IN p_branch_id INT, IN p_diagnosis VARCHAR(100))
BEGIN
    DECLARE bed_id INT;
    DECLARE patient_priority ENUM('Low','Medium','High','Critical');
    SELECT priority_level INTO patient_priority FROM Patient WHERE patient_id=p_patient_id;

    IF patient_priority IN ('High','Critical') THEN
        SELECT bed_id INTO bed_id FROM Bed
        WHERE branch_id=p_branch_id AND status='Available' AND bed_type IN ('ICU','Emergency')
        LIMIT 1;
    ELSE
        SELECT bed_id INTO bed_id FROM Bed
        WHERE branch_id=p_branch_id AND status='Available'
        LIMIT 1;
    END IF;

    IF bed_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No available bed for patient priority.';
    END IF;

    INSERT INTO Admission(patient_id, doctor_id, bed_id, branch_id, admission_date, status, diagnosis)
    VALUES(p_patient_id, p_doctor_id, bed_id, p_branch_id, CURDATE(), 'Admitted', p_diagnosis);
END$$

DELIMITER ;
