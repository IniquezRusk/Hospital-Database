DROP TABLE IF EXISTS Patients;
CREATE TABLE Patients (
patient_id   INT NOT NULL AUTO_INCREMENT, 
first_name     VARCHAR(50) NOT NULL, 
last_name       VARCHAR(50) NOT NULL,
date_of_birth  DATE  NOT NULL,
gender    VARCHAR(10) CHECK (gender IN ('Male','Female','Other')) 
phone        VARCHAR(20) NULL
email        VARCHAR(100) NULL
CONSTRAINT patient_PK
       PRIMARY KEY (patient_id)
);

DROP TABLE IF EXISTS Doctors;
CREATE TABLE Doctors (
    doctor_id   INT NOT NULL AUTO_INCREMENT,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    specialty   VARCHAR(100) NOT NULL,
    phone       VARCHAR(20) NULL,
    email       VARCHAR(100) NULL,
    CONSTRAINT doctor_PK
        PRIMARY KEY (doctor_id)
);

DROP TABLE IF EXISTS Admission;
CREATE TABLE Admission (
  admission_id INT NOT NULL AUTO_INCREMENT,
  patient_id INT NOT NULL,
  doctor_id  INT NOT NULL,
  room_no VARCHAR(10),
  admission_date DATE NOT NULL,
  discharge_date DATE,
  diagnosis VARCHAR(255),
  PRIMARY KEY (admission_id),
  CONSTRAINT fk_adm_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  CONSTRAINT fk_adm_doctor  FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
);

INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email)
VALUES('Alice', 'Johnson', '1985-04-12', 'Female', '(555) 123-4567', 'alice.j@example.com'),
('Roberto', 'Chen', '1972-11-20', 'Male', '(555) 987-6543', 'roberto.c@example.com'),
('Maria', 'Lopez', '1998-07-01', 'Female', '(555) 555-1212', 'marialopez@mail.com'),
('Davido', 'Smith', '1955-01-25', 'Male', NULL, 'david0.smith@oldmail.net'),
('Emily', 'Williams', '2003-09-15', 'Female', '(555) 234-5678', 'emilyw@workmail.org'),
('Ethan', 'Brown', '1991-03-08', 'Male', '(555) 345-6789', NULL),
('Sofia', 'Garcia', '1968-06-30', 'Other', '(555) 456-7890', 's.garcia@personal.net'),
('Liam', 'Miller', '2010-12-19', 'Male', '(555) 678-9012', NULL),
('Chloe', 'Davis', '1980-02-14', 'Female', '(555) 789-0123', 'chloe.davis@web.info'),
('Noah', 'Rodriguez', '1945-10-05', 'Male', '(555) 890-1234', 'noah.r@webmail.com'); 

INSERT INTO Doctors (first_name, last_name, specialty, phone, email) 
VALUES ('Elizabeth', 'Hayes', 'Cardiology', '(713) 700-1122', 'e.hayes@vitalink.org'),
('Samuel', 'Patel', 'Emergency', '(713) 700-3344', 'samuel.p@vitalink.org'),
('Jennifer', 'Wang', 'ICU', '(713) 700-5566', 'jwang@vitalink.org'),
('Daniel', 'O\'Connell', 'General Surgery', '(713) 700-7788', 'daniel.oc@vitalink.org'),
('Anya', 'Sharma', 'Cardiology', '(713) 700-9900', 'asharma@vitalink.org'),
('Ben', 'Carter', 'Emergency', '(713) 701-0120', 'b.carter@vitalink.org'),
('Vivian', 'Liu', 'ICU', '(713) 701-2030', 'vliu@vitalink.org'),
('Marcus', 'Stone', 'General Surgery', '(713) 701-4050', 'marcus.s@vitalink.org'),
('Isabella', 'Cruz', 'Cardiology', '(713) 701-6070', NULL),
('Kevin', 'Foster', 'ICU', '(713) 701-8090', 'k.foster@vitalink.org');

INSERT INTO Admission (patient_id, doctor_id, room_no, admission_date, discharge_date, diagnosis) VALUES
(3, 7, 'ICU-05', '2025-11-08', NULL, 'Severe Dehydration'),
(1, 8, 'A203',   '2025-11-07', '2025-11-09', 'Post-surgery observation'),
(4,10, 'B112',   '2025-11-03', NULL, 'Pneumonia'),
(2, 1, 'C110',   '2025-11-03', NULL, 'Heart arrhythmia'),
(5, 8, 'A110',   '2025-11-01', '2025-11-05', 'Fractured rib'),
(4, 4, 'A101',   '2025-11-03', '2025-11-03', 'Routine physical exam, elevated blood pressure'),
(2, 6, 'ER-02',  '2025-11-08', '2025-11-10', 'Fractured wrist'),
(1, 1, 'C204',   '2025-10-28', '2025-11-04', 'Atrial fibrillation'),
(7, 2, 'P113',   '2025-11-01', '2025-11-03', 'Severe flu and dehydration'),
(4, 8, 'B312',   '2025-10-25', '2025-11-05', 'Appendectomy recovery'),
(9,10, 'N107',   '2025-11-05', NULL, 'Migraine evaluation');
