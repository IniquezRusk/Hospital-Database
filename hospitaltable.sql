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