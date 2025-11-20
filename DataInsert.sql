-- ==============================================
-- DEMO DATA FOR HOSPITALADMISSIONS
--  - Branch capacity ≥ 5 (except Pulmonology = 2)
--  - Beds per branch = capacity
--  - 50 Patients
--  - 50 Admissions (all Admitted; later you’ll discharge 35)
-- ==============================================

-- If you already have data, clear it in FK-safe order:
-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE Admission;
-- TRUNCATE Bed;
-- TRUNCATE Doctor;
-- TRUNCATE Patient;
-- TRUNCATE Branch;
-- SET FOREIGN_KEY_CHECKS = 1;

-- 1️⃣ BRANCHES (10 rows)
-- Capacities chosen to support 50 concurrent admissions total.
-- Pulmonology explicitly set to capacity = 2.

INSERT INTO Branch (branch_id,branch_name,floor_no,phone_ext,capacity,head_doctor) VALUES
('BR-CARD','Cardiology',2,'201',7,'Dr. Adams'),
('BR-NEUR','Neurology',3,'301',6,'Dr. Banner'),
('BR-ICU','ICU',1,'101',8,'Dr. Patel'),
('BR-PEDS','Pediatrics',4,'401',5,'Dr. Chu'),
('BR-EMER','Emergency',0,'001',8,'Dr. Ross'),
('BR-ORTH','Orthopedics',5,'501',5,'Dr. Smith'),
('BR-ONCO','Oncology',6,'601',5,'Dr. Wong'),
('BR-GAST','Gastroenterology',7,'701',5,'Dr. Lee'),
('BR-PULM','Pulmonology',8,'801',2,'Dr. Kim'),   -- capacity = 2 (special)
('BR-DERM','Dermatology',9,'901',5,'Dr. Singh');

-- 2️⃣ DOCTORS (10 rows, 1 per branch)

INSERT INTO Doctor (doctor_id,name,phone,branch_id) VALUES
('DR-CARD','Dr. Adams','202-555-0101','BR-CARD'),
('DR-NEUR','Dr. Banner','202-555-0102','BR-NEUR'),
('DR-ICU','Dr. Patel','202-555-0103','BR-ICU'),
('DR-PEDS','Dr. Chu','202-555-0104','BR-PEDS'),
('DR-EMER','Dr. Ross','202-555-0105','BR-EMER'),
('DR-ORTH','Dr. Smith','202-555-0106','BR-ORTH'),
('DR-ONCO','Dr. Wong','202-555-0107','BR-ONCO'),
('DR-GAST','Dr. Lee','202-555-0108','BR-GAST'),
('DR-PULM','Dr. Kim','202-555-0109','BR-PULM'),
('DR-DERM','Dr. Singh','202-555-0110','BR-DERM');

-- 3️⃣ BEDS (match capacity per branch)
-- ICU branch uses bed_type='ICU'
-- Emergency branch uses bed_type='Emergency'
-- All others use 'Standard'

INSERT INTO Bed (bed_id,room_no,bed_number,bed_type,status,branch_id) VALUES
-- Cardiology (7 Standard)
('BD-CARD-1','C101',1,'Standard','Available','BR-CARD'),
('BD-CARD-2','C102',2,'Standard','Available','BR-CARD'),
('BD-CARD-3','C103',3,'Standard','Available','BR-CARD'),
('BD-CARD-4','C104',4,'Standard','Available','BR-CARD'),
('BD-CARD-5','C105',5,'Standard','Available','BR-CARD'),
('BD-CARD-6','C106',6,'Standard','Available','BR-CARD'),
('BD-CARD-7','C107',7,'Standard','Available','BR-CARD'),

-- Neurology (6 Standard)
('BD-NEUR-1','N101',1,'Standard','Available','BR-NEUR'),
('BD-NEUR-2','N102',2,'Standard','Available','BR-NEUR'),
('BD-NEUR-3','N103',3,'Standard','Available','BR-NEUR'),
('BD-NEUR-4','N104',4,'Standard','Available','BR-NEUR'),
('BD-NEUR-5','N105',5,'Standard','Available','BR-NEUR'),
('BD-NEUR-6','N106',6,'Standard','Available','BR-NEUR'),

-- ICU (8 ICU beds)
('BD-ICU-1','I101',1,'ICU','Available','BR-ICU'),
('BD-ICU-2','I102',2,'ICU','Available','BR-ICU'),
('BD-ICU-3','I103',3,'ICU','Available','BR-ICU'),
('BD-ICU-4','I104',4,'ICU','Available','BR-ICU'),
('BD-ICU-5','I105',5,'ICU','Available','BR-ICU'),
('BD-ICU-6','I106',6,'ICU','Available','BR-ICU'),
('BD-ICU-7','I107',7,'ICU','Available','BR-ICU'),
('BD-ICU-8','I108',8,'ICU','Available','BR-ICU'),

-- Pediatrics (5 Standard)
('BD-PEDS-1','P101',1,'Standard','Available','BR-PEDS'),
('BD-PEDS-2','P102',2,'Standard','Available','BR-PEDS'),
('BD-PEDS-3','P103',3,'Standard','Available','BR-PEDS'),
('BD-PEDS-4','P104',4,'Standard','Available','BR-PEDS'),
('BD-PEDS-5','P105',5,'Standard','Available','BR-PEDS'),

-- Emergency (8 Emergency)
('BD-EMER-1','E101',1,'Emergency','Available','BR-EMER'),
('BD-EMER-2','E102',2,'Emergency','Available','BR-EMER'),
('BD-EMER-3','E103',3,'Emergency','Available','BR-EMER'),
('BD-EMER-4','E104',4,'Emergency','Available','BR-EMER'),
('BD-EMER-5','E105',5,'Emergency','Available','BR-EMER'),
('BD-EMER-6','E106',6,'Emergency','Available','BR-EMER'),
('BD-EMER-7','E107',7,'Emergency','Available','BR-EMER'),
('BD-EMER-8','E108',8,'Emergency','Available','BR-EMER'),

-- Orthopedics (5 Standard)
('BD-ORTH-1','O101',1,'Standard','Available','BR-ORTH'),
('BD-ORTH-2','O102',2,'Standard','Available','BR-ORTH'),
('BD-ORTH-3','O103',3,'Standard','Available','BR-ORTH'),
('BD-ORTH-4','O104',4,'Standard','Available','BR-ORTH'),
('BD-ORTH-5','O105',5,'Standard','Available','BR-ORTH'),

-- Oncology (5 Standard)
('BD-ONCO-1','ON101',1,'Standard','Available','BR-ONCO'),
('BD-ONCO-2','ON102',2,'Standard','Available','BR-ONCO'),
('BD-ONCO-3','ON103',3,'Standard','Available','BR-ONCO'),
('BD-ONCO-4','ON104',4,'Standard','Available','BR-ONCO'),
('BD-ONCO-5','ON105',5,'Standard','Available','BR-ONCO'),

-- Gastroenterology (5 Standard)
('BD-GAST-1','G101',1,'Standard','Available','BR-GAST'),
('BD-GAST-2','G102',2,'Standard','Available','BR-GAST'),
('BD-GAST-3','G103',3,'Standard','Available','BR-GAST'),
('BD-GAST-4','G104',4,'Standard','Available','BR-GAST'),
('BD-GAST-5','G105',5,'Standard','Available','BR-GAST'),

-- Pulmonology (2 Standard, capacity 2)
('BD-PULM-1','PU101',1,'Standard','Available','BR-PULM'),
('BD-PULM-2','PU102',2,'Standard','Available','BR-PULM'),

-- Dermatology (5 Standard)
('BD-DERM-1','D101',1,'Standard','Available','BR-DERM'),
('BD-DERM-2','D102',2,'Standard','Available','BR-DERM'),
('BD-DERM-3','D103',3,'Standard','Available','BR-DERM'),
('BD-DERM-4','D104',4,'Standard','Available','BR-DERM'),
('BD-DERM-5','D105',5,'Standard','Available','BR-DERM');

-- 4️⃣ PATIENTS (50 rows)
-- First 14 are High/Critical and will be used for ICU/Emergency.
-- All others Low/Medium for Standard beds.

INSERT INTO Patient (name,gender,age,priority_level,phone,address) VALUES
-- 1–10: Low/Medium (standard-ward branches)
('Alice Johnson','Female',34,'Low','555-0001','123 Main St'),
('Brian Smith','Male',62,'Medium','555-0002','456 Oak Rd'),
('Carla Green','Female',27,'Low','555-0003','789 Pine Dr'),
('David Young','Male',45,'Medium','555-0004','101 Maple Ln'),
('Emily Clark','Female',38,'Low','555-0005','202 River Rd'),
('Frank Harris','Male',70,'Medium','555-0006','303 Hill St'),
('George King','Male',52,'Low','555-0007','404 Birch Ave'),
('Hannah Lewis','Female',29,'Medium','555-0008','505 Cedar St'),
('Ian Moore','Male',48,'Low','555-0009','606 Cherry Blvd'),
('Julia Nelson','Female',41,'Medium','555-0010','707 Elm Way'),

-- 11–24: High/Critical (for ICU/EMER)
('Kevin Adams','Male',55,'High','555-0011','808 Oak Circle'),
('Laura Brown','Female',60,'Critical','555-0012','909 Pine Place'),
('Michael Carter','Male',50,'High','555-0013','111 Cedar Ct'),
('Natalie Davis','Female',47,'Critical','555-0014','222 Maple Ave'),
('Oscar Edwards','Male',63,'High','555-0015','333 Walnut St'),
('Patricia Foster','Female',58,'Critical','555-0016','444 Cherry Ln'),
('Quentin Garcia','Male',49,'High','555-0017','555 Birch Blvd'),
('Rebecca Hall','Female',53,'Critical','555-0018','666 Spruce Dr'),
('Samuel Irving','Male',45,'High','555-0019','777 Aspen Rd'),
('Teresa Johnson','Female',61,'Critical','555-0020','888 Poplar St'),
('Ulysses Kelly','Male',57,'High','555-0021','999 Oak St'),
('Victoria Lopez','Female',44,'Critical','555-0022','1010 Pine St'),
('William Martin','Male',59,'High','555-0023','1111 Cedar Ave'),
('Ximena Nguyen','Female',46,'Critical','555-0024','1212 Maple Blvd'),

-- 25–50: More Low/Medium (standard beds)
('Yolanda Ortiz','Female',35,'Medium','555-0025','1313 Birch St'),
('Zachary Perez','Male',33,'Low','555-0026','1414 Spruce Dr'),
('Amber Quinn','Female',26,'Medium','555-0027','1515 Ash Ave'),
('Brandon Rivera','Male',29,'Low','555-0028','1616 Oak Cir'),
('Chloe Scott','Female',31,'Medium','555-0029','1717 Pine Way'),
('Daniel Taylor','Male',40,'Low','555-0030','1818 Cedar Ct'),
('Erica Underwood','Female',28,'Medium','555-0031','1919 Maple Ln'),
('Felix Vega','Male',37,'Low','555-0032','2020 Cherry Pl'),
('Grace White','Female',42,'Medium','555-0033','2121 Walnut St'),
('Henry Xu','Male',39,'Low','555-0034','2222 Poplar Rd'),
('Isabel Young','Female',30,'Medium','555-0035','2323 Aspen Trl'),
('Jack Zimmerman','Male',36,'Low','555-0036','2424 Oak Park'),
('Kylie Anderson','Female',27,'Medium','555-0037','2525 Pine Ct'),
('Liam Baker','Male',32,'Low','555-0038','2626 Cedar Ln'),
('Mia Cooper','Female',34,'Medium','555-0039','2727 Maple St'),
('Noah Diaz','Male',29,'Low','555-0040','2828 Birch Ave'),
('Olive Ellis','Female',33,'Medium','555-0041','2929 Spruce Dr'),
('Peter Flynn','Male',41,'Low','555-0042','3030 Ash St'),
('Queenie Gordon','Female',38,'Medium','555-0043','3131 Oak Ave'),
('Robert Hayes','Male',45,'Low','555-0044','3232 Pine Cir'),
('Sophia Ingram','Female',29,'Medium','555-0045','3333 Cedar Dr'),
('Thomas James','Male',50,'Low','555-0046','3434 Maple Ct'),
('Uma Knight','Female',36,'Medium','555-0047','3535 Cherry St'),
('Victor Lane','Male',44,'Low','555-0048','3636 Walnut Ave'),
('Wendy Miles','Female',31,'Medium','555-0049','3737 Poplar Cir'),
('Xavier Nash','Male',27,'Low','555-0050','3838 Aspen Rd');

-- 5️⃣ ADMISSIONS (50 rows, all initially Admitted)
-- Distribution:
--   Cardiology: 7
--   Neurology: 5
--   ICU:       7 (High/Critical only, ICU beds)
--   Emergency: 7 (High/Critical only, Emergency beds)
--   Pediatrics:5
--   Orthopedics:5
--   Oncology:  4
--   Gastro:    4
--   Pulmonology:2 (capacity 2, both Admitted → branch at capacity)
--   Dermatology:4
-- Later you’ll write a discharge script to mark 35 of these as Discharged.

INSERT INTO Admission
(patient_id, doctor_id, bed_id, branch_id, admission_date, status, diagnosis)
VALUES
-- Cardiology (7) - Low/Medium to Standard beds
(1, 'DR-CARD', 'BD-CARD-1', 'BR-CARD', '2025-01-05', 'Admitted', 'Hypertension'),
(2, 'DR-CARD', 'BD-CARD-2', 'BR-CARD', '2025-02-10', 'Admitted', 'Chest Pain'),
(3, 'DR-CARD', 'BD-CARD-3', 'BR-CARD', '2025-03-15', 'Admitted', 'Palpitations'),
(4, 'DR-CARD', 'BD-CARD-4', 'BR-CARD', '2025-04-20', 'Admitted', 'Arrhythmia'),
(5, 'DR-CARD', 'BD-CARD-5', 'BR-CARD', '2025-05-25', 'Admitted', 'Heart Failure'),
(6, 'DR-CARD', 'BD-CARD-6', 'BR-CARD', '2025-06-10', 'Admitted', 'Follow-up'),
(7, 'DR-CARD', 'BD-CARD-7', 'BR-CARD', '2025-07-05', 'Admitted', 'Post-op Care'),

-- Neurology (5) - Low/Medium to Standard beds
(8,  'DR-NEUR', 'BD-NEUR-1', 'BR-NEUR', '2025-01-12', 'Admitted', 'Migraine'),
(9,  'DR-NEUR', 'BD-NEUR-2', 'BR-NEUR', '2025-03-01', 'Admitted', 'Seizure Evaluation'),
(10, 'DR-NEUR', 'BD-NEUR-3', 'BR-NEUR', '2025-04-18', 'Admitted', 'Dizziness'),
(25, 'DR-NEUR', 'BD-NEUR-4', 'BR-NEUR', '2025-05-22', 'Admitted', 'Neuropathy'),
(26, 'DR-NEUR', 'BD-NEUR-5', 'BR-NEUR', '2025-06-30', 'Admitted', 'Headache'),

-- ICU (7) - High/Critical to ICU beds
(11, 'DR-ICU', 'BD-ICU-1', 'BR-ICU', '2025-01-20', 'Admitted', 'Severe Pneumonia'),
(12, 'DR-ICU', 'BD-ICU-2', 'BR-ICU', '2025-02-15', 'Admitted', 'Septic Shock'),
(13, 'DR-ICU', 'BD-ICU-3', 'BR-ICU', '2025-03-10', 'Admitted', 'Cardiogenic Shock'),
(14, 'DR-ICU', 'BD-ICU-4', 'BR-ICU', '2025-04-05', 'Admitted', 'Respiratory Failure'),
(15, 'DR-ICU', 'BD-ICU-5', 'BR-ICU', '2025-05-01', 'Admitted', 'Multi-organ Failure'),
(16, 'DR-ICU', 'BD-ICU-6', 'BR-ICU', '2025-06-01', 'Admitted', 'Stroke ICU'),
(17, 'DR-ICU', 'BD-ICU-7', 'BR-ICU', '2025-07-01', 'Admitted', 'Post-op ICU'),

-- Emergency (7) - High/Critical to Emergency beds
(18, 'DR-EMER', 'BD-EMER-1', 'BR-EMER', '2025-01-25', 'Admitted', 'Major Trauma'),
(19, 'DR-EMER', 'BD-EMER-2', 'BR-EMER', '2025-02-18', 'Admitted', 'Acute Coronary Syndrome'),
(20, 'DR-EMER', 'BD-EMER-3', 'BR-EMER', '2025-03-22', 'Admitted', 'Stroke'),
(21, 'DR-EMER', 'BD-EMER-4', 'BR-EMER', '2025-04-16', 'Admitted', 'Polytrauma'),
(22, 'DR-EMER', 'BD-EMER-5', 'BR-EMER', '2025-05-19', 'Admitted', 'Severe Asthma Attack'),
(23, 'DR-EMER', 'BD-EMER-6', 'BR-EMER', '2025-06-23', 'Admitted', 'Internal Bleeding'),
(24, 'DR-EMER', 'BD-EMER-7', 'BR-EMER', '2025-07-10', 'Admitted', 'Head Injury'),

-- Pediatrics (5) - Low/Medium to Standard beds
(27, 'DR-PEDS', 'BD-PEDS-1', 'BR-PEDS', '2025-02-02', 'Admitted', 'Flu'),
(28, 'DR-PEDS', 'BD-PEDS-2', 'BR-PEDS', '2025-03-14', 'Admitted', 'Asthma Exacerbation'),
(29, 'DR-PEDS', 'BD-PEDS-3', 'BR-PEDS', '2025-04-09', 'Admitted', 'Dehydration'),
(30, 'DR-PEDS', 'BD-PEDS-4', 'BR-PEDS', '2025-05-03', 'Admitted', 'Gastroenteritis'),
(31, 'DR-PEDS', 'BD-PEDS-5', 'BR-PEDS', '2025-06-07', 'Admitted', 'Pneumonia'),

-- Orthopedics (5) - Low/Medium to Standard beds
(32, 'DR-ORTH', 'BD-ORTH-1', 'BR-ORTH', '2025-02-20', 'Admitted', 'Fractured Arm'),
(33, 'DR-ORTH', 'BD-ORTH-2', 'BR-ORTH', '2025-03-25', 'Admitted', 'Knee Replacement'),
(34, 'DR-ORTH', 'BD-ORTH-3', 'BR-ORTH', '2025-04-28', 'Admitted', 'Hip Fracture'),
(35, 'DR-ORTH', 'BD-ORTH-4', 'BR-ORTH', '2025-05-30', 'Admitted', 'Spinal Injury'),
(36, 'DR-ORTH', 'BD-ORTH-5', 'BR-ORTH', '2025-06-25', 'Admitted', 'Shoulder Surgery'),

-- Oncology (4) - Low/Medium to Standard beds
(37, 'DR-ONCO', 'BD-ONCO-1', 'BR-ONCO', '2025-01-30', 'Admitted', 'Chemotherapy Cycle 1'),
(38, 'DR-ONCO', 'BD-ONCO-2', 'BR-ONCO', '2025-03-05', 'Admitted', 'Radiation Therapy'),
(39, 'DR-ONCO', 'BD-ONCO-3', 'BR-ONCO', '2025-04-12', 'Admitted', 'Tumor Evaluation'),
(40, 'DR-ONCO', 'BD-ONCO-4', 'BR-ONCO', '2025-05-18', 'Admitted', 'Complication Management'),

-- Gastroenterology (4) - Low/Medium to Standard beds
(41, 'DR-GAST', 'BD-GAST-1', 'BR-GAST', '2025-02-11', 'Admitted', 'GI Bleed'),
(42, 'DR-GAST', 'BD-GAST-2', 'BR-GAST', '2025-03-19', 'Admitted', 'Pancreatitis'),
(43, 'DR-GAST', 'BD-GAST-3', 'BR-GAST', '2025-04-21', 'Admitted', 'Liver Failure'),
(44, 'DR-GAST', 'BD-GAST-4', 'BR-GAST', '2025-05-27', 'Admitted', 'IBD Flare'),

-- Pulmonology (2) - Low/Medium to Standard beds
-- Capacity = 2, both are Admitted → branch is at capacity TODAY-ish.
(45, 'DR-PULM', 'BD-PULM-1', 'BR-PULM', '2025-11-18', 'Admitted', 'COPD Exacerbation'),
(46, 'DR-PULM', 'BD-PULM-2', 'BR-PULM', '2025-11-19', 'Admitted', 'Severe Bronchitis'),

-- Dermatology (4) - Low/Medium to Standard beds
(47, 'DR-DERM', 'BD-DERM-1', 'BR-DERM', '2025-02-08', 'Admitted', 'Severe Psoriasis'),
(48, 'DR-DERM', 'BD-DERM-2', 'BR-DERM', '2025-03-16', 'Admitted', 'Cellulitis'),
(49, 'DR-DERM', 'BD-DERM-3', 'BR-DERM', '2025-04-23', 'Admitted', 'Drug Rash'),
(50, 'DR-DERM', 'BD-DERM-4', 'BR-DERM', '2025-05-29', 'Admitted', 'Chronic Eczema');
