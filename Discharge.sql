USE HospitalAdmissions;

-- Discharge 25 of the 50 admissions.
-- Admissions NOT touched here remain 'Admitted' (25 current in-patients).

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-01-11'
WHERE admission_id = 1;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-02-17'
WHERE admission_id = 2;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-04-23'
WHERE admission_id = 3;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-06-14'
WHERE admission_id = 4;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-02-25'
WHERE admission_id = 8;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-03-15'
WHERE admission_id = 9;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-01-27'
WHERE admission_id = 13;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-02-23'
WHERE admission_id = 14;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-03-19'
WHERE admission_id = 15;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-04-15'
WHERE admission_id = 16;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-02-08'
WHERE admission_id = 20;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-03-17'
WHERE admission_id = 21;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-06-16'
WHERE admission_id = 23;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-10-05'
WHERE admission_id = 25;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-02-17'
WHERE admission_id = 27;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-04-14'
WHERE admission_id = 28;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-06-28'
WHERE admission_id = 29;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-01-29'
WHERE admission_id = 32;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-03-16'
WHERE admission_id = 33;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-03-08'
WHERE admission_id = 36;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-05-14'
WHERE admission_id = 37;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-03-21'
WHERE admission_id = 40;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-02-15'
WHERE admission_id = 46;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-04-24'
WHERE admission_id = 47;

UPDATE Admission
SET status = 'Discharged', discharge_date = '2025-11-19'
WHERE admission_id = 50;
