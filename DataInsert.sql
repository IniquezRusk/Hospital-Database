-- ======================================
-- DATA INSERT SCRIPT (NEW DEMO DATA)
-- Run AFTER HospitalAdmissions schema file
-- ======================================

USE HospitalAdmissions;

-- 1️⃣ BRANCHES (10 branches, capacity = #beds, Pulmonology full at 2)
INSERT INTO Branch (branch_id, branch_name, floor_no, phone_ext, capacity, head_doctor) VALUES
('BR-CARD','Cardiology',2,'201',7,'Dr. Adams'),
('BR-NEUR','Neurology',3,'301',5,'Dr. Banner'),
('BR-ICU','ICU',1,'101',7,'Dr. Patel'),
('BR-PEDS','Pediatrics',4,'401',5,'Dr. Chu'),
('BR-EMER','Emergency',0,'001',7,'Dr. Ross'),
('BR-ORTH','Orthopedics',5,'501',4,'Dr. Smith'),
('BR-ONCO','Oncology',6,'601',4,'Dr. Wong'),
('BR-GAST','Gastroenterology',7,'701',4,'Dr. Lee'),
('BR-PULM','Pulmonology',8,'801',2,'Dr. Kim'),
('BR-DERM','Dermatology',9,'901',5,'Dr. Singh');

-- 2️⃣ DOCTORS (1 per branch)
INSERT INTO Doctor (doctor_id, name, phone, branch_id) VALUES
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

-- 3️⃣ BEDS (capacity-matched to each branch)
INSERT INTO Bed (bed_id, room_no, bed_number, bed_type, status, branch_id) VALUES
-- Cardiology (7 Standard)
('BD-CARD-1','C101',1,'Standard','Available','BR-CARD'),
('BD-CARD-2','C102',2,'Standard','Available','BR-CARD'),
('BD-CARD-3','C103',3,'Standard','Available','BR-CARD'),
('BD-CARD-4','C104',4,'Standard','Available','BR-CARD'),
('BD-CARD-5','C105',5,'Standard','Available','BR-CARD'),
('BD-CARD-6','C106',6,'Standard','Available','BR-CARD'),
('BD-CARD-7','C107',7,'Standard','Available','BR-CARD'),

-- Neurology (5 Standard)
('BD-NEUR-1','N101',1,'Standard','Available','BR-NEUR'),
('BD-NEUR-2','N102',2,'Standard','Available','BR-NEUR'),
('BD-NEUR-3','N103',3,'Standard','Available','BR-NEUR'),
('BD-NEUR-4','N104',4,'Standard','Available','BR-NEUR'),
('BD-NEUR-5','N105',5,'Standard','Available','BR-NEUR'),

-- ICU (7 ICU)
('BD-ICU-1','I101',1,'ICU','Available','BR-ICU'),
('BD-ICU-2','I102',2,'ICU','Available','BR-ICU'),
('BD-ICU-3','I103',3,'ICU','Available','BR-ICU'),
('BD-ICU-4','I104',4,'ICU','Available','BR-ICU'),
('BD-ICU-5','I105',5,'ICU','Available','BR-ICU'),
('BD-ICU-6','I106',6,'ICU','Available','BR-ICU'),
('BD-ICU-7','I107',7,'ICU','Available','BR-ICU'),

-- Pediatrics (5 Standard)
('BD-PEDS-1','P101',1,'Standard','Available','BR-PEDS'),
('BD-PEDS-2','P102',2,'Standard','Available','BR-PEDS'),
('BD-PEDS-3','P103',3,'Standard','Available','BR-PEDS'),
('BD-PEDS-4','P104',4,'Standard','Available','BR-PEDS'),
('BD-PEDS-5','P105',5,'Standard','Available','BR-PEDS'),

-- Emergency (7 Emergency)
('BD-EMER-1','E101',1,'Emergency','Available','BR-EMER'),
('BD-EMER-2','E102',2,'Emergency','Available','BR-EMER'),
('BD-EMER-3','E103',3,'Emergency','Available','BR-EMER'),
('BD-EMER-4','E104',4,'Emergency','Available','BR-EMER'),
('BD-EMER-5','E105',5,'Emergency','Available','BR-EMER'),
('BD-EMER-6','E106',6,'Emergency','Available','BR-EMER'),
('BD-EMER-7','E107',7,'Emergency','Available','BR-EMER'),

-- Orthopedics (4 Standard)
('BD-ORTH-1','O101',1,'Standard','Available','BR-ORTH'),
('BD-ORTH-2','O102',2,'Standard','Available','BR-ORTH'),
('BD-ORTH-3','O103',3,'Standard','Available','BR-ORTH'),
('BD-ORTH-4','O104',4,'Standard','Available','BR-ORTH'),

-- Oncology (4 Standard)
('BD-ONCO-1','ON101',1,'Standard','Available','BR-ONCO'),
('BD-ONCO-2','ON102',2,'Standard','Available','BR-ONCO'),
('BD-ONCO-3','ON103',3,'Standard','Available','BR-ONCO'),
('BD-ONCO-4','ON104',4,'Standard','Available','BR-ONCO'),

-- Gastroenterology (4 Standard)
('BD-GAST-1','G101',1,'Standard','Available','BR-GAST'),
('BD-GAST-2','G102',2,'Standard','Available','BR-GAST'),
('BD-GAST-3','G103',3,'Standard','Available','BR-GAST'),
('BD-GAST-4','G104',4,'Standard','Available','BR-GAST'),

-- Pulmonology (2 Standard, capacity 2 → will be kept full)
('BD-PULM-1','PU101',1,'Standard','Available','BR-PULM'),
('BD-PULM-2','PU102',2,'Standard','Available','BR-PULM'),

-- Dermatology (5 Standard)
('BD-DERM-1','D101',1,'Standard','Available','BR-DERM'),
('BD-DERM-2','D102',2,'Standard','Available','BR-DERM'),
('BD-DERM-3','D103',3,'Standard','Available','BR-DERM'),
('BD-DERM-4','D104',4,'Standard','Available','BR-DERM'),
('BD-DERM-5','D105',5,'Standard','Available','BR-DERM');

-- 4️⃣ PATIENTS (50 demo patients)
-- High/Critical (IDs 13-26) are reserved for ICU/Emergency so triggers are always satisfied
INSERT INTO Patient (name, gender, age, priority_level, phone, address) VALUES
-- 1-12: Low / Medium (Cardiology + Neurology)
('Alice Johnson','Female',45,'Medium','555-0001','123 Main St'),
('Brian Smith','Male',62,'Low','555-0002','456 Oak Rd'),
('Carla Green','Female',37,'Medium','555-0003','789 Pine Dr'),
('David Young','Male',53,'Low','555-0004','101 Maple Ln'),
('Elena Ruiz','Female',50,'Medium','555-0005','202 River Rd'),
('Frank Harris','Male',59,'Low','555-0006','303 Hill St'),
('Georgia Miles','Female',41,'Medium','555-0007','404 Birch Ave'),
('Henry Ortiz','Male',39,'Low','555-0008','505 Cedar St'),
('Isabella Reed','Female',29,'Medium','555-0009','606 Cherry Blvd'),
('James Carter','Male',33,'Low','555-0010','707 Elm Way'),
('Karen Lopez','Female',47,'Medium','555-0011','808 Oak Circle'),
('Liam Baker','Male',36,'Low','555-0012','909 Willow Ct'),

-- 13-19: High / Critical for ICU
('Mia Turner','Female',58,'High','555-0013','11 ICU Lane'),
('Noah Price','Male',64,'High','555-0014','22 ICU Lane'),
('Olivia King','Female',71,'Critical','555-0015','33 ICU Lane'),
('Paul Allen','Male',69,'High','555-0016','44 ICU Lane'),
('Quinn Rivera','Female',60,'Critical','555-0017','55 ICU Lane'),
('Ryan Scott','Male',67,'High','555-0018','66 ICU Lane'),
('Sophia Diaz','Female',63,'Critical','555-0019','77 ICU Lane'),

-- 20-26: High / Critical for Emergency
('Thomas Gray','Male',52,'High','555-0020','11 ER Road'),
('Uma Patel','Female',48,'High','555-0021','22 ER Road'),
('Victor Chen','Male',55,'Critical','555-0022','33 ER Road'),
('Wendy Brooks','Female',43,'High','555-0023','44 ER Road'),
('Xavier Long','Male',39,'Critical','555-0024','55 ER Road'),
('Yara Flores','Female',46,'High','555-0025','66 ER Road'),
('Zach Morris','Male',51,'Critical','555-0026','77 ER Road'),

-- 27-31: Pediatrics (Low / Medium)
('Amelia Foster','Female',8,'Medium','555-0027','10 Kids Ave'),
('Brandon Hill','Male',12,'Low','555-0028','20 Kids Ave'),
('Chloe Ward','Female',6,'Medium','555-0029','30 Kids Ave'),
('Dylan Ross','Male',10,'Low','555-0030','40 Kids Ave'),
('Eva Collins','Female',9,'Medium','555-0031','50 Kids Ave'),

-- 32-39: Orthopedics + Oncology (Low / Medium)
('Finn Howard','Male',65,'Medium','555-0032','10 Ortho St'),
('Grace Kelly','Female',58,'Low','555-0033','20 Ortho St'),
('Harper Allen','Female',72,'Medium','555-0034','30 Ortho St'),
('Ian Wright','Male',69,'Low','555-0035','40 Ortho St'),
('Jade Parker','Female',57,'Medium','555-0036','10 Onco Blvd'),
('Kyle Murphy','Male',61,'Low','555-0037','20 Onco Blvd'),
('Luna Chavez','Female',54,'Medium','555-0038','30 Onco Blvd'),
('Mason Reed','Male',59,'Low','555-0039','40 Onco Blvd'),

-- 40-45: Gastro + Pulmonology (Low / Medium)
('Nora Simmons','Female',49,'Medium','555-0040','10 GI Way'),
('Owen Brooks','Male',52,'Low','555-0041','20 GI Way'),
('Piper James','Female',44,'Medium','555-0042','30 GI Way'),
('Reid Porter','Male',51,'Low','555-0043','40 GI Way'),
('Sara Blake','Female',65,'Medium','555-0044','10 Pulm Dr'),
('Tyler Fox','Male',68,'Low','555-0045','20 Pulm Dr'),

-- 46-50: Dermatology (Low / Medium)
('Uma Novak','Female',34,'Medium','555-0046','10 Derm Ct'),
('Violet Stone','Female',29,'Low','555-0047','20 Derm Ct'),
('Wyatt Green','Male',42,'Medium','555-0048','30 Derm Ct'),
('Ximena Rose','Female',37,'Low','555-0049','40 Derm Ct'),
('Yusuf Ali','Male',55,'Medium','555-0050','50 Derm Ct');

-- 5️⃣ ADMISSIONS (50 rows)
-- 25 will remain Admitted, 25 will be discharged by Discharge.sql
-- Dates spread from Jan–Nov 2025 with no large gaps so trends look good.

INSERT INTO Admission (patient_id, doctor_id, bed_id, branch_id, admission_date, status, diagnosis) VALUES
(1, 'DR-CARD', 'BD-CARD-1', 'BR-CARD', '2025-01-05', 'Admitted', 'Chest pain evaluation'),
(2, 'DR-CARD', 'BD-CARD-2', 'BR-CARD', '2025-02-10', 'Admitted', 'Hypertension workup'),
(3, 'DR-CARD', 'BD-CARD-3', 'BR-CARD', '2025-04-15', 'Admitted', 'Arrhythmia monitoring'),
(4, 'DR-CARD', 'BD-CARD-4', 'BR-CARD', '2025-06-05', 'Admitted', 'Post-stent follow-up'),
(5, 'DR-CARD', 'BD-CARD-5', 'BR-CARD', '2025-08-10', 'Admitted', 'Heart failure management'),
(6, 'DR-CARD', 'BD-CARD-6', 'BR-CARD', '2025-09-22', 'Admitted', 'Palpitations'),
(7, 'DR-CARD', 'BD-CARD-7', 'BR-CARD', '2025-11-05', 'Admitted', 'Cardiac rehab'),

(8, 'DR-NEUR', 'BD-NEUR-1', 'BR-NEUR', '2025-02-12', 'Admitted', 'Migraine assessment'),
(9, 'DR-NEUR', 'BD-NEUR-2', 'BR-NEUR', '2025-03-01', 'Admitted', 'Seizure evaluation'),
(10, 'DR-NEUR', 'BD-NEUR-3', 'BR-NEUR', '2025-06-18', 'Admitted', 'Neuropathy workup'),
(11, 'DR-NEUR', 'BD-NEUR-4', 'BR-NEUR', '2025-08-03', 'Admitted', 'Dizziness and falls'),
(12, 'DR-NEUR', 'BD-NEUR-5', 'BR-NEUR', '2025-10-14', 'Admitted', 'Stroke rehab'),

(13, 'DR-ICU', 'BD-ICU-1', 'BR-ICU', '2025-01-20', 'Admitted', 'Post-operative monitoring'),
(14, 'DR-ICU', 'BD-ICU-2', 'BR-ICU', '2025-02-15', 'Admitted', 'Septic shock'),
(15, 'DR-ICU', 'BD-ICU-3', 'BR-ICU', '2025-03-10', 'Admitted', 'Respiratory failure'),
(16, 'DR-ICU', 'BD-ICU-4', 'BR-ICU', '2025-04-05', 'Admitted', 'Multi-organ failure'),
(17, 'DR-ICU', 'BD-ICU-5', 'BR-ICU', '2025-07-02', 'Admitted', 'Cardiogenic shock'),
(18, 'DR-ICU', 'BD-ICU-6', 'BR-ICU', '2025-09-01', 'Admitted', 'Status asthmaticus'),
(19, 'DR-ICU', 'BD-ICU-7', 'BR-ICU', '2025-11-10', 'Admitted', 'Intracranial bleed'),

(20, 'DR-EMER', 'BD-EMER-1', 'BR-EMER', '2025-01-25', 'Admitted', 'Motor vehicle accident'),
(21, 'DR-EMER', 'BD-EMER-2', 'BR-EMER', '2025-03-02', 'Admitted', 'Acute abdomen'),
(22, 'DR-EMER', 'BD-EMER-3', 'BR-EMER', '2025-05-19', 'Admitted', 'Polytrauma'),
(23, 'DR-EMER', 'BD-EMER-4', 'BR-EMER', '2025-06-10', 'Admitted', 'Acute stroke'),
(24, 'DR-EMER', 'BD-EMER-5', 'BR-EMER', '2025-08-18', 'Admitted', 'Severe sepsis'),
(25, 'DR-EMER', 'BD-EMER-6', 'BR-EMER', '2025-09-27', 'Admitted', 'Chest trauma'),
(26, 'DR-EMER', 'BD-EMER-7', 'BR-EMER', '2025-11-15', 'Admitted', 'GI bleed'),

(27, 'DR-PEDS', 'BD-PEDS-1', 'BR-PEDS', '2025-02-07', 'Admitted', 'Asthma exacerbation'),
(28, 'DR-PEDS', 'BD-PEDS-2', 'BR-PEDS', '2025-04-03', 'Admitted', 'Pneumonia'),
(29, 'DR-PEDS', 'BD-PEDS-3', 'BR-PEDS', '2025-06-16', 'Admitted', 'Appendicitis post-op'),
(30, 'DR-PEDS', 'BD-PEDS-4', 'BR-PEDS', '2025-09-05', 'Admitted', 'Failure to thrive'),
(31, 'DR-PEDS', 'BD-PEDS-5', 'BR-PEDS', '2025-10-22', 'Admitted', 'Type 1 diabetes onset'),

(32, 'DR-ORTH', 'BD-ORTH-1', 'BR-ORTH', '2025-01-14', 'Admitted', 'Hip fracture repair'),
(33, 'DR-ORTH', 'BD-ORTH-2', 'BR-ORTH', '2025-03-11', 'Admitted', 'Knee replacement'),
(34, 'DR-ORTH', 'BD-ORTH-3', 'BR-ORTH', '2025-05-07', 'Admitted', 'Shoulder surgery'),
(35, 'DR-ORTH', 'BD-ORTH-4', 'BR-ORTH', '2025-08-25', 'Admitted', 'Spine fusion'),

(36, 'DR-ONCO', 'BD-ONCO-1', 'BR-ONCO', '2025-02-28', 'Admitted', 'Chemotherapy cycle'),
(37, 'DR-ONCO', 'BD-ONCO-2', 'BR-ONCO', '2025-05-05', 'Admitted', 'Radiation therapy'),
(38, 'DR-ONCO', 'BD-ONCO-3', 'BR-ONCO', '2025-08-12', 'Admitted', 'Stem cell transplant'),
(39, 'DR-ONCO', 'BD-ONCO-4', 'BR-ONCO', '2025-11-02', 'Admitted', 'Immunotherapy'),

(40, 'DR-GAST', 'BD-GAST-1', 'BR-GAST', '2025-03-09', 'Admitted', 'GI bleed eval'),
(41, 'DR-GAST', 'BD-GAST-2', 'BR-GAST', '2025-07-14', 'Admitted', 'Liver failure'),
(42, 'DR-GAST', 'BD-GAST-3', 'BR-GAST', '2025-09-19', 'Admitted', 'Pancreatitis'),
(43, 'DR-GAST', 'BD-GAST-4', 'BR-GAST', '2025-11-08', 'Admitted', 'IBD flare'),

(44, 'DR-PULM', 'BD-PULM-1', 'BR-PULM', '2025-11-18', 'Admitted', 'COPD exacerbation'),
(45, 'DR-PULM', 'BD-PULM-2', 'BR-PULM', '2025-11-19', 'Admitted', 'COVID pneumonia'),

(46, 'DR-DERM', 'BD-DERM-1', 'BR-DERM', '2025-02-08', 'Admitted', 'Severe psoriasis'),
(47, 'DR-DERM', 'BD-DERM-2', 'BR-DERM', '2025-04-16', 'Admitted', 'Drug rash'),
(48, 'DR-DERM', 'BD-DERM-3', 'BR-DERM', '2025-08-29', 'Admitted', 'Burn management'),
(49, 'DR-DERM', 'BD-DERM-4', 'BR-DERM', '2025-10-30', 'Admitted', 'Cellulitis'),
(50, 'DR-DERM', 'BD-DERM-5', 'BR-DERM', '2025-11-12', 'Admitted', 'Chronic ulcers');
