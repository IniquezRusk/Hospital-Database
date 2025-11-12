-- =========================================
-- RESET DATABASE SAFELY
-- =========================================
DROP DATABASE IF EXISTS HospitalAdmissions;
CREATE DATABASE HospitalAdmissions;
USE HospitalAdmissions;

-- =========================================
-- CREATE TABLES
-- =========================================

CREATE TABLE Branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15),
    department VARCHAR(100),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('Male','Female','Other'),
    phone_number VARCHAR(15)
);

CREATE TABLE Bed (
    bed_id INT AUTO_INCREMENT PRIMARY KEY,
    room_no VARCHAR(10),
    bed_number VARCHAR(10),
    bed_type ENUM('Standard','ICU','Emergency'),
    status ENUM('Available','Occupied') DEFAULT 'Available',
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Admission (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    branch_id INT,
    bed_id INT,
    admission_date DATE,
    discharge_date DATE,
    status ENUM('Admitted','Discharged') DEFAULT 'Admitted',
    priority_level ENUM('Low','Medium','High'),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (bed_id) REFERENCES Bed(bed_id)
);

-- =========================================
-- INSERT DATA INTO BRANCH
-- =========================================

INSERT INTO Branch (branch_name, location, capacity) VALUES
('Central Ward', 'Main Building', 5),
('North Wing', 'North Complex', 5),
('East Wing', 'East Complex', 5),
('West Wing', 'West Complex', 5),
('South Wing', 'South Complex', 5),
('Emergency Unit', 'Ground Floor', 5),
('Cardiology Ward', 'Building B', 5),
('Neurology Ward', 'Building C', 5),
('ICU Department', 'Building D', 5),
('Pediatrics Wing', 'Building E', 5);

-- =========================================
-- INSERT DATA INTO DOCTOR
-- =========================================

INSERT INTO Doctor (first_name, last_name, phone_number, department, branch_id) VALUES
('Alice', 'Reed', '214-555-1201', 'Emergency', 6),
('Brian', 'Cole', '214-555-1202', 'Cardiology', 7),
('Catherine', 'Nguyen', '214-555-1203', 'Neurology', 8),
('David', 'Kim', '214-555-1204', 'ICU', 9),
('Ella', 'Hughes', '214-555-1205', 'Pediatrics', 10),
('Frank', 'Turner', '214-555-1206', 'General Medicine', 1),
('Grace', 'Lopez', '214-555-1207', 'Surgery', 2),
('Henry', 'Wright', '214-555-1208', 'Orthopedics', 3),
('Isabella', 'Shaw', '214-555-1209', 'Geriatrics', 4),
('James', 'Miller', '214-555-1210', 'General Medicine', 5);

-- =========================================
-- INSERT DATA INTO PATIENT
-- =========================================

INSERT INTO Patient (first_name, last_name, dob, gender, phone_number) VALUES
('John', 'Smith', '1985-03-15', 'Male', '214-555-1301'),
('Sarah', 'Johnson', '1990-06-10', 'Female', '214-555-1302'),
('Michael', 'Brown', '1978-02-22', 'Male', '214-555-1303'),
('Emily', 'Davis', '2001-11-03', 'Female', '214-555-1304'),
('Daniel', 'Wilson', '1995-08-14', 'Male', '214-555-1305'),
('Olivia', 'Martinez', '1989-09-09', 'Female', '214-555-1306'),
('Matthew', 'Taylor', '1993-05-27', 'Male', '214-555-1307'),
('Sophia', 'Anderson', '2000-12-01', 'Female', '214-555-1308'),
('William', 'Thomas', '1980-01-17', 'Male', '214-555-1309'),
('Ava', 'Jackson', '1998-07-24', 'Female', '214-555-1310');

-- =========================================
-- INSERT DATA INTO BED
-- =========================================

INSERT INTO Bed (room_no, bed_number, bed_type, status, branch_id) VALUES
('A101', '1', 'Standard', 'Available', 1),
('A101', '2', 'Standard', 'Available', 1),
('B201', '1', 'ICU', 'Available', 2),
('B201', '2', 'ICU', 'Occupied', 2),
('C301', '1', 'Emergency', 'Available', 3),
('C301', '2', 'Emergency', 'Available', 3),
('D401', '1', 'Standard', 'Available', 4),
('D401', '2', 'Standard', 'Available', 4),
('E501', '1', 'ICU', 'Available', 5),
('E501', '2', 'ICU', 'Available', 5),
('F601', '1', 'Emergency', 'Available', 6),
('F601', '2', 'Emergency', 'Available', 6),
('G701', '1', 'Standard', 'Available', 7),
('H801', '1', 'Standard', 'Available', 8),
('I901', '1', 'ICU', 'Available', 9),
('J1001', '1', 'Standard', 'Available', 10),
('J1001', '2', 'Standard', 'Available', 10),
('G701', '2', 'Standard', 'Available', 7),
('H801', '2', 'Standard', 'Available', 8),
('I901', '2', 'ICU', 'Available', 9);

-- =========================================
-- INSERT DATA INTO ADMISSION
-- =========================================

INSERT INTO Admission (patient_id, doctor_id, branch_id, bed_id, admission_date, discharge_date, status, priority_level) VALUES
(1, 1, 6, 11, '2025-11-01', NULL, 'Admitted', 'High'),
(2, 2, 7, 13, '2025-11-02', NULL, 'Admitted', 'Medium'),
(3, 3, 8, 14, '2025-11-03', NULL, 'Admitted', 'High'),
(4, 4, 9, 15, '2025-11-04', NULL, 'Admitted', 'Low'),
(5, 5, 10, 16, '2025-11-05', NULL, 'Admitted', 'Medium'),
(6, 6, 1, 1, '2025-11-06', NULL, 'Admitted', 'Low'),
(7, 7, 2, 3, '2025-11-07', NULL, 'Admitted', 'Medium'),
(8, 8, 3, 5, '2025-11-08', NULL, 'Admitted', 'High'),
(9, 9, 4, 7, '2025-11-09', NULL, 'Admitted', 'Low'),
(10, 10, 5, 9, '2025-11-10', NULL, 'Admitted', 'Medium');

-- =========================================
-- TRIGGERS
-- =========================================

DELIMITER $$

-- Trigger 1: When a new admission is made, mark bed as occupied
CREATE TRIGGER trg_after_admission_insert
AFTER INSERT ON Admission
FOR EACH ROW
BEGIN
    UPDATE Bed
    SET status = 'Occupied'
    WHERE bed_id = NEW.bed_id;
END$$

-- Trigger 2: When an admission is discharged, mark bed as available
CREATE TRIGGER trg_after_admission_update
AFTER UPDATE ON Admission
FOR EACH ROW
BEGIN
    IF NEW.status = 'Discharged' THEN
        UPDATE Bed
        SET status = 'Available'
        WHERE bed_id = NEW.bed_id;
    END IF;
END$$

DELIMITER ;

-- =========================================
-- STORED PROCEDURES / FUNCTIONS
-- =========================================

DELIMITER $$

CREATE PROCEDURE sp_check_branch_capacity(IN p_branch_id INT)
BEGIN
    DECLARE total_capacity INT;
    DECLARE occupied_count INT;
    DECLARE available_beds INT;

    SELECT capacity INTO total_capacity FROM Branch WHERE branch_id = p_branch_id;
    SELECT COUNT(*) INTO occupied_count FROM Admission WHERE branch_id = p_branch_id AND status = 'Admitted';
    SET available_beds = total_capacity - occupied_count;

    SELECT p_branch_id AS BranchID, total_capacity AS Capacity, occupied_count AS Occupied, available_beds AS Available;
END$$

CREATE PROCEDURE sp_list_available_beds(IN p_branch_id INT)
BEGIN
    SELECT bed_id, room_no, bed_number, bed_type, status
    FROM Bed
    WHERE branch_id = p_branch_id AND status = 'Available';
END$$

CREATE FUNCTION fn_count_admitted_patients(p_branch_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE patient_count INT;
    SELECT COUNT(*) INTO patient_count FROM Admission WHERE branch_id = p_branch_id AND status = 'Admitted';
    RETURN patient_count;
END$$

DELIMITER ;


