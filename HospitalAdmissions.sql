-- ===================================
-- HOSPITAL ADMISSIONS DATABASE SCRIPT
-- Clean Schema + Triggers + Procedures + Views (NO SAMPLE DATA)
-- ===================================

DROP DATABASE IF EXISTS HospitalAdmissions;
CREATE DATABASE HospitalAdmissions;
USE HospitalAdmissions;

-- ===================================
-- 1️⃣ TABLE DEFINITIONS
-- ===================================

CREATE TABLE Branch (
  branch_id VARCHAR(10) PRIMARY KEY,
  branch_name VARCHAR(50) NOT NULL UNIQUE,
  floor_no INT,
  phone_ext VARCHAR(10) NOT NULL,
  capacity INT,
  head_doctor VARCHAR(50)
);

CREATE TABLE Doctor (
  doctor_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  phone VARCHAR(15) UNIQUE,
  branch_id VARCHAR(10) NOT NULL,
  FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE Patient (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  gender ENUM('Male','Female','Other') NOT NULL,
  age INT CHECK (age BETWEEN 0 AND 120),
  priority_level ENUM('Low','Medium','High','Critical') NOT NULL,
  phone VARCHAR(15) UNIQUE,
  address VARCHAR(100)
);

CREATE TABLE Bed (
  bed_id VARCHAR(15) PRIMARY KEY,
  room_no VARCHAR(10) NOT NULL,
  bed_number INT CHECK (bed_number > 0),
  bed_type ENUM('Standard','ICU','Emergency') NOT NULL,
  status ENUM('Available','Occupied','Maintenance') DEFAULT 'Available',
  branch_id VARCHAR(10) NOT NULL,
  FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE Admission (
  admission_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id VARCHAR(10) NOT NULL,
  bed_id VARCHAR(15) NOT NULL,
  branch_id VARCHAR(10) NOT NULL,
  admission_date DATE NOT NULL,
  discharge_date DATE DEFAULT NULL,
  diagnosis VARCHAR(100),
  status ENUM('Admitted','Discharged') DEFAULT 'Admitted',
  FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
  FOREIGN KEY (bed_id) REFERENCES Bed(bed_id),
  FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
  CHECK (discharge_date IS NULL OR discharge_date >= admission_date)
);

-- ===================================
-- 2️⃣ TRIGGERS
-- ===================================

DELIMITER $$

-- 1. One active admission per patient
DROP TRIGGER IF EXISTS tr_one_active_admission_per_patient$$
CREATE TRIGGER tr_one_active_admission_per_patient
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE active_count INT;

    SELECT COUNT(*) INTO active_count
    FROM Admission
    WHERE patient_id = NEW.patient_id
      AND status = 'Admitted';

    IF active_count >= 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Patient already has an active admission.';
    END IF;
END$$

-- 2. Branch capacity enforcement
DROP TRIGGER IF EXISTS tr_branch_capacity$$
CREATE TRIGGER tr_branch_capacity
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE current_count INT;
    DECLARE max_capacity INT;

    SELECT COUNT(*) INTO current_count
    FROM Admission
    WHERE branch_id = NEW.branch_id AND status='Admitted';

    SELECT capacity INTO max_capacity
    FROM Branch
    WHERE branch_id = NEW.branch_id;

    IF current_count >= max_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot admit patient: Branch full.';
    END IF;
END$$

-- 3. Priority-level bed assignment
DROP TRIGGER IF EXISTS tr_priority_bed_assignment$$
CREATE TRIGGER tr_priority_bed_assignment
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE patient_priority VARCHAR(20);
    DECLARE bed_type_val VARCHAR(20);

    SELECT priority_level INTO patient_priority
    FROM Patient WHERE patient_id = NEW.patient_id;

    SELECT bed_type INTO bed_type_val
    FROM Bed WHERE bed_id = NEW.bed_id;

    IF patient_priority IN ('High','Critical') THEN
        IF bed_type_val NOT IN ('ICU','Emergency') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT='High/Critical patients must be assigned ICU/Emergency bed.';
        END IF;
    END IF;
END$$

-- 4. Bed must be available BEFORE assignment + auto-set to Occupied
DROP TRIGGER IF EXISTS tr_bed_occupied$$
CREATE TRIGGER tr_bed_occupied
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE bed_status_val VARCHAR(20);

    SELECT status INTO bed_status_val FROM Bed WHERE bed_id = NEW.bed_id;

    IF bed_status_val = 'Occupied' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bed is already occupied!';
    END IF;

    IF bed_status_val = 'Maintenance' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Bed is under maintenance!';
    END IF;

    UPDATE Bed SET status='Occupied'
    WHERE bed_id = NEW.bed_id;
END$$

-- 5. Restore bed to Available after discharge
DROP TRIGGER IF EXISTS tr_bed_available$$
CREATE TRIGGER tr_bed_available
AFTER UPDATE ON Admission
FOR EACH ROW
BEGIN
    IF NEW.status = 'Discharged' THEN
        UPDATE Bed 
        SET status='Available' 
        WHERE bed_id = NEW.bed_id;
    END IF;
END$$

DELIMITER ;

-- ===================================
-- 3️⃣ FUNCTIONS & PROCEDURES
-- ===================================

DELIMITER $$

DROP FUNCTION IF EXISTS fn_count_admitted_patients$$
CREATE FUNCTION fn_count_admitted_patients(p_branch_id VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE patient_count INT;
    SELECT COUNT(*) INTO patient_count
    FROM Admission
    WHERE branch_id = p_branch_id AND status = 'Admitted';
    RETURN patient_count;
END$$

DROP PROCEDURE IF EXISTS sp_admit_patient$$
CREATE PROCEDURE sp_admit_patient(
    IN p_patient_id INT,
    IN p_doctor_id VARCHAR(10),
    IN p_branch_id VARCHAR(10),
    IN p_diagnosis VARCHAR(100)
)
BEGIN
    DECLARE bed_id_val VARCHAR(15);
    DECLARE patient_priority ENUM('Low','Medium','High','Critical');

    SELECT priority_level INTO patient_priority 
    FROM Patient WHERE patient_id=p_patient_id;

    -- Priority-based bed selection
    IF patient_priority IN ('High','Critical') THEN
        SELECT bed_id INTO bed_id_val
        FROM Bed
        WHERE branch_id=p_branch_id
          AND status='Available'
          AND bed_type IN ('ICU','Emergency')
        LIMIT 1;
    ELSE
        SELECT bed_id INTO bed_id_val
        FROM Bed
        WHERE branch_id=p_branch_id
          AND status='Available'
        LIMIT 1;
    END IF;

    IF bed_id_val IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='No available bed for patient priority.';
    END IF;

    INSERT INTO Admission (
        patient_id, doctor_id, bed_id, branch_id,
        admission_date, status, diagnosis
    ) VALUES (
        p_patient_id, p_doctor_id, bed_id_val, p_branch_id,
        CURDATE(), 'Admitted', p_diagnosis
    );
END$$

DELIMITER ;

-- ===================================
-- 4️⃣ VIEWS
-- ===================================

-- Current admissions
CREATE VIEW vw_current_admissions AS
SELECT 
    a.admission_id,
    p.name AS patient_name,
    p.priority_level,
    d.name AS doctor_name,
    b.room_no,
    b.bed_id,
    b.bed_type,
    br.branch_name,
    a.admission_date,
    a.status,
    a.diagnosis
FROM Admission a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Bed b ON a.bed_id = b.bed_id
JOIN Branch br ON a.branch_id = br.branch_id
WHERE a.status = 'Admitted';

-- Branch occupancy
CREATE VIEW vw_branch_occupancy AS
SELECT 
    br.branch_id,
    br.branch_name,
    br.capacity AS total_capacity,
    COUNT(DISTINCT CASE WHEN a.status = 'Admitted' THEN a.admission_id END) AS admitted_patients,
    COUNT(CASE WHEN b.status = 'Available' THEN 1 END) AS available_beds,
    COUNT(CASE WHEN b.status = 'Occupied' THEN 1 END) AS occupied_beds,
    COUNT(CASE WHEN b.status = 'Maintenance' THEN 1 END) AS maintenance_beds,
    COUNT(*) AS total_beds
FROM Branch br
LEFT JOIN Bed b ON br.branch_id = b.branch_id
LEFT JOIN Admission a ON br.branch_id = a.branch_id
GROUP BY br.branch_id, br.branch_name, br.capacity;

-- Available beds
CREATE VIEW vw_available_beds AS
SELECT 
    b.bed_id,
    b.room_no,
    b.bed_number,
    b.bed_type,
    b.status,
    br.branch_name,
    br.branch_id
FROM Bed b
JOIN Branch br ON br.branch_id = b.branch_id
WHERE b.status = 'Available';

-- Doctor load
CREATE VIEW vw_doctor_load AS
SELECT 
    d.doctor_id,
    d.name AS doctor_name,
    br.branch_name,
    COUNT(a.admission_id) AS active_patients
FROM Doctor d
LEFT JOIN Admission a 
       ON a.doctor_id = d.doctor_id 
      AND a.status = 'Admitted'
JOIN Branch br ON br.branch_id = d.branch_id
GROUP BY d.doctor_id, d.name, br.branch_name;

-- High/Critical patients
CREATE VIEW vw_high_priority_patients AS
SELECT 
    a.admission_id,
    p.name AS patient_name,
    p.priority_level,
    b.bed_id,
    b.bed_type,
    br.branch_name,
    a.admission_date,
    a.diagnosis
FROM Admission a
JOIN Patient p ON p.patient_id = a.patient_id
JOIN Bed b ON b.bed_id = a.bed_id
JOIN Branch br ON br.branch_id = a.branch_id
WHERE p.priority_level IN ('High','Critical')
  AND a.status = 'Admitted';

-- Bed usage summary
CREATE VIEW vw_bed_usage AS
SELECT 
    br.branch_id,
    br.branch_name,
    COUNT(CASE WHEN b.status = 'Available' THEN 1 END) AS available_beds,
    COUNT(CASE WHEN b.status = 'Occupied' THEN 1 END) AS occupied_beds,
    COUNT(CASE WHEN b.status = 'Maintenance' THEN 1 END) AS maintenance_beds,
    COUNT(*) AS total_beds
FROM Branch br
JOIN Bed b ON br.branch_id = b.branch_id
GROUP BY br.branch_id, br.branch_name;

-- Full admission history
CREATE VIEW vw_admission_history AS
SELECT
    a.admission_id,
    p.name AS patient_name,
    d.name AS doctor_name,
    b.bed_id,
    br.branch_name,
    a.admission_date,
    a.discharge_date,
    a.status,
    a.diagnosis
FROM Admission a
JOIN Patient p ON p.patient_id = a.patient_id
JOIN Doctor d ON d.doctor_id = a.doctor_id
JOIN Bed b ON b.bed_id = a.bed_id
JOIN Branch br ON br.branch_id = a.branch_id;

-- Priority distribution
CREATE VIEW vw_priority_distribution AS
SELECT 
    p.priority_level,
    COUNT(*) AS total_patients
FROM Admission a
JOIN Patient p ON p.patient_id = a.patient_id
WHERE a.status = 'Admitted'
GROUP BY p.priority_level;

-- Priority per branch
CREATE VIEW vw_priority_by_branch AS
SELECT 
    br.branch_name,
    p.priority_level,
    COUNT(*) AS total_patients
FROM Admission a
JOIN Patient p ON p.patient_id = a.patient_id
JOIN Branch br ON br.branch_id = a.branch_id
WHERE a.status = 'Admitted'
GROUP BY br.branch_name, p.priority_level;

-- Admissions per day
CREATE VIEW vw_admissions_per_day AS
SELECT 
    admission_date,
    COUNT(*) AS total_admissions
FROM Admission
GROUP BY admission_date
ORDER BY admission_date;

-- Admissions per branch
CREATE VIEW vw_admissions_by_branch AS
SELECT 
    br.branch_name,
    COUNT(*) AS total_admissions
FROM Admission a
JOIN Branch br ON br.branch_id = a.branch_id
GROUP BY br.branch_name
ORDER BY total_admissions DESC;

-- ===================================
-- END OF CLEAN SCRIPT
-- ===================================
