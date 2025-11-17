-- ===================================
-- HOSPITAL ADMISSIONS DATABASE SCRIPT
-- Fully Updated with Descriptive Keys
-- ===================================

CREATE DATABASE IF NOT EXISTS HospitalAdmissions;
USE HospitalAdmissions;

-- ===================================
-- 1️⃣ TABLE DEFINITIONS
-- ===================================

CREATE TABLE Branch (
  branch_id VARCHAR(10) PRIMARY KEY,            -- ex: BR-CARD
  branch_name VARCHAR(50) NOT NULL UNIQUE,
  floor_no INT,
  phone_ext VARCHAR(10) NOT NULL,
  capacity INT,
  head_doctor VARCHAR(50)
);

CREATE TABLE Doctor (
  doctor_id VARCHAR(10) PRIMARY KEY,            -- ex: DR-001
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
  bed_id VARCHAR(15) PRIMARY KEY,               -- ex: BD-A101-1
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
-- 2️⃣ SAMPLE DATA INSERTS
-- ===================================

-- Branches
INSERT INTO Branch VALUES
('BR-CARD','Cardiology',2,'201',25,'Dr. Adams'),
('BR-NEUR','Neurology',3,'301',20,'Dr. Banner'),
('BR-ICU','ICU',1,'101',10,'Dr. Patel'),
('BR-PEDS','Pediatrics',4,'401',20,'Dr. Chu'),
('BR-EMER','Emergency',0,'001',30,'Dr. Ross'),
('BR-ORTH','Orthopedics',5,'501',15,'Dr. Smith'),
('BR-ONCO','Oncology',6,'601',15,'Dr. Wong'),
('BR-GAST','Gastroenterology',7,'701',12,'Dr. Lee'),
('BR-PULM','Pulmonology',8,'801',10,'Dr. Kim'),
('BR-DERM','Dermatology',9,'901',8,'Dr. Singh');

-- Doctors
INSERT INTO Doctor VALUES
('DR-001','Dr. Adams','202-555-0101','BR-CARD'),
('DR-002','Dr. Banner','202-555-0102','BR-NEUR'),
('DR-003','Dr. Patel','202-555-0103','BR-ICU'),
('DR-004','Dr. Chu','202-555-0104','BR-PEDS'),
('DR-005','Dr. Ross','202-555-0105','BR-EMER'),
('DR-006','Dr. Smith','202-555-0106','BR-ORTH'),
('DR-007','Dr. Wong','202-555-0107','BR-ONCO'),
('DR-008','Dr. Lee','202-555-0108','BR-GAST'),
('DR-009','Dr. Kim','202-555-0109','BR-PULM'),
('DR-010','Dr. Singh','202-555-0110','BR-DERM');

-- Patients
INSERT INTO Patient (name,gender,age,priority_level,phone,address) VALUES
('John Smith','Male',45,'High','301-555-1001','123 Main St'),
('Mary Johnson','Female',30,'Medium','301-555-1002','456 Oak St'),
('James Brown','Male',60,'Critical','301-555-1003','789 Pine St'),
('Patricia Taylor','Female',25,'Low','301-555-1004','321 Maple St'),
('Robert Miller','Male',50,'High','301-555-1005','654 Elm St'),
('Linda Davis','Female',40,'Medium','301-555-1006','987 Cedar St'),
('Michael Wilson','Male',70,'Critical','301-555-1007','246 Birch St'),
('Barbara Moore','Female',35,'Medium','301-555-1008','135 Spruce St'),
('William Taylor','Male',55,'High','301-555-1009','864 Walnut St'),
('Elizabeth Anderson','Female',28,'Low','301-555-1010','579 Chestnut St');

-- Beds
INSERT INTO Bed VALUES
('BD-A101-1','A101',1,'Standard','Available','BR-CARD'),
('BD-A102-2','A102',2,'Standard','Available','BR-CARD'),
('BD-B101-1','B101',1,'Standard','Available','BR-NEUR'),
('BD-B102-2','B102',2,'Standard','Available','BR-NEUR'),
('BD-C101-1','C101',1,'ICU','Available','BR-ICU'),
('BD-C102-2','C102',2,'ICU','Available','BR-ICU'),
('BD-D101-1','D101',1,'Standard','Available','BR-PEDS'),
('BD-D102-2','D102',2,'Standard','Available','BR-PEDS'),
('BD-E101-1','E101',1,'Emergency','Available','BR-EMER'),
('BD-E102-2','E102',2,'Emergency','Available','BR-EMER'),
('BD-F101-1','F101',1,'Standard','Available','BR-ORTH'),
('BD-F102-2','F102',2,'Standard','Available','BR-ORTH'),
('BD-G101-1','G101',1,'Standard','Available','BR-ONCO'),
('BD-G102-2','G102',2,'Standard','Available','BR-ONCO'),
('BD-H101-1','H101',1,'Standard','Available','BR-GAST'),
('BD-H102-2','H102',2,'Standard','Available','BR-GAST'),
('BD-I101-1','I101',1,'Standard','Available','BR-PULM'),
('BD-I102-2','I102',2,'Standard','Available','BR-PULM'),
('BD-J101-1','J101',1,'Standard','Available','BR-DERM'),
('BD-J102-2','J102',2,'Standard','Available','BR-DERM');

-- Admissions
INSERT INTO Admission (patient_id,doctor_id,bed_id,branch_id,admission_date,status,diagnosis) VALUES
(1,'DR-001','BD-A101-1','BR-CARD','2025-11-01','Admitted','Hypertension'),
(2,'DR-002','BD-B101-1','BR-NEUR','2025-11-02','Admitted','Migraine'),
(3,'DR-003','BD-C101-1','BR-ICU','2025-11-01','Admitted','Heart Attack'),
(4,'DR-004','BD-D101-1','BR-PEDS','2025-11-03','Admitted','Flu'),
(5,'DR-005','BD-E101-1','BR-EMER','2025-11-01','Admitted','Broken Arm'),
(6,'DR-006','BD-F101-1','BR-ORTH','2025-11-04','Admitted','Laceration'),
(7,'DR-003','BD-C102-2','BR-ICU','2025-11-02','Admitted','Stroke'),
(8,'DR-004','BD-D102-2','BR-PEDS','2025-11-05','Admitted','Asthma Attack'),
(9,'DR-002','BD-B102-2','BR-NEUR','2025-11-03','Admitted','Seizure'),
(10,'DR-001','BD-A102-2','BR-CARD','2025-11-06','Admitted','Arrhythmia');

-- ===================================
-- 3️⃣ TRIGGERS
-- ===================================

DELIMITER $$

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

DROP TRIGGER IF EXISTS tr_bed_available$$
CREATE TRIGGER tr_bed_available
AFTER UPDATE ON Admission
FOR EACH ROW
BEGIN
    IF NEW.status='Discharged' THEN
        UPDATE Bed SET status='Available' WHERE bed_id=NEW.bed_id;
    END IF;
END$$

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

    SELECT capacity INTO max_capacity
    FROM Branch
    WHERE branch_id=NEW.branch_id;

    IF current_count >= max_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Cannot admit patient: Branch full.';
    END IF;
END$$

DROP TRIGGER IF EXISTS tr_priority_bed_assignment$$
CREATE TRIGGER tr_priority_bed_assignment
BEFORE INSERT ON Admission
FOR EACH ROW
BEGIN
    DECLARE patient_priority ENUM('Low','Medium','High','Critical');
    DECLARE bed_type_val ENUM('Standard','ICU','Emergency');

    SELECT priority_level INTO patient_priority FROM Patient WHERE patient_id=NEW.patient_id;
    SELECT bed_type INTO bed_type_val FROM Bed WHERE bed_id=NEW.bed_id;

    IF patient_priority IN ('High','Critical') THEN
        IF bed_type_val NOT IN ('ICU','Emergency') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT='High/Critical patients must be assigned ICU/Emergency bed.';
        END IF;
    END IF;
END$$

DELIMITER ;

-- ===================================
-- 4️⃣ PROCEDURES & FUNCTIONS
-- ===================================

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_check_branch_capacity$$
CREATE PROCEDURE sp_check_branch_capacity(IN p_branch_id VARCHAR(10))
BEGIN
    DECLARE total_capacity INT;
    DECLARE occupied_count INT;
    DECLARE available_beds INT;

    SELECT capacity INTO total_capacity FROM Branch WHERE branch_id=p_branch_id;
    SELECT COUNT(*) INTO occupied_count FROM Admission WHERE branch_id=p_branch_id AND status='Admitted';
    SET available_beds = total_capacity - occupied_count;

    SELECT p_branch_id AS BranchID, total_capacity AS Capacity,
           occupied_count AS Occupied, available_beds AS Available;
END$$

DROP PROCEDURE IF EXISTS sp_list_available_beds$$
CREATE PROCEDURE sp_list_available_beds(IN p_branch_id VARCHAR(10))
BEGIN
    SELECT bed_id, room_no, bed_number, bed_type, status
    FROM Bed
    WHERE branch_id=p_branch_id AND status='Available';
END$$

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

    SELECT priority_level INTO patient_priority FROM Patient WHERE patient_id=p_patient_id;

    IF patient_priority IN ('High','Critical') THEN
        SELECT bed_id INTO bed_id_val
        FROM Bed
        WHERE branch_id=p_branch_id AND status='Available'
          AND bed_type IN ('ICU','Emergency')
        LIMIT 1;
    ELSE
        SELECT bed_id INTO bed_id_val
        FROM Bed
        WHERE branch_id=p_branch_id AND status='Available'
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
-- 5️⃣ VIEWS
-- ===================================

DROP VIEW IF EXISTS vw_current_admissions;
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

DROP VIEW IF EXISTS vw_branch_occupancy;
CREATE VIEW vw_branch_occupancy AS
SELECT 
    br.branch_id,
    br.branch_name,
    br.capacity AS total_capacity,
    COUNT(a.admission_id) AS admitted_patients,
    (br.capacity - COUNT(a.admission_id)) AS available_capacity
FROM Branch br
LEFT JOIN Admission a 
    ON br.branch_id = a.branch_id 
   AND a.status = 'Admitted'
GROUP BY br.branch_id, br.branch_name, br.capacity;

DROP VIEW IF EXISTS vw_available_beds;
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

DROP VIEW IF EXISTS vw_doctor_load;
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

DROP VIEW IF EXISTS vw_high_priority_patients;
CREATE VIEW vw_high_priority_patients AS
SELECT 
    a.admission_id,
    p.name AS patient_name,
    p.priority_level,
    b.bed_id,
    b.bed_type,
    br.branch_name,
    a.admission_date
FROM Admission a
JOIN Patient p ON p.patient_id = a.patient_id
JOIN Bed b ON b.bed_id = a.bed_id
JOIN Branch br ON br.branch_id = a.branch_id
WHERE p.priority_level IN ('High','Critical')
  AND a.status = 'Admitted';

DROP VIEW IF EXISTS vw_bed_usage;
CREATE VIEW vw_bed_usage AS
SELECT 
    br.branch_id,
    br.branch_name,
    COUNT(CASE WHEN b.status = 'Available' THEN 1 END) AS available_beds,
    COUNT(CASE WHEN b.status = 'Occupied' THEN 1 END) AS occupied_beds,
    COUNT(*) AS total_beds
FROM Branch br
JOIN Bed b ON br.branch_id = b.branch_id
GROUP BY br.branch_id, br.branch_name;

DROP VIEW IF EXISTS vw_admission_history;
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

-- ===================================
-- END OF SCRIPT
-- ===================================
