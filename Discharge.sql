-- ======================================================
-- DISCHARGE 35 RANDOMLY SELECTED ADMISSIONS
-- ======================================================

UPDATE Admission
SET status = 'Discharged',
    discharge_date = DATE_ADD(admission_date, INTERVAL FLOOR(1 + RAND()*10) DAY)
WHERE admission_id IN (
    1,2,3,4,5,6,7,
    8,9,10,12,13,14,15,16,
    18,20,22,24,
    25,26,27,28,29,
    32,33,36,
    37,38,40,
    41,42,44,
    47,49
);

-- ======================================================
-- ENSURE BEDS FREE UP FOR DISCHARGED PATIENTS
-- (Your AFTER UPDATE trigger also handles this)
-- ======================================================
UPDATE Bed
SET status='Available'
WHERE bed_id IN (
    SELECT bed_id FROM Admission
    WHERE status='Discharged'
);

-- ======================================================
-- UPDATE REMAINING 15 ACTIVE ADMISSIONS
-- MAKE THEIR DATES REALISTIC (LAST 1–14 DAYS)
-- ======================================================
UPDATE Admission
SET admission_date = DATE_SUB(CURDATE(), INTERVAL FLOOR(1 + RAND()*14) DAY)
WHERE admission_id NOT IN (
    1,2,3,4,5,6,7,
    8,9,10,12,13,14,15,16,
    18,20,22,24,
    25,26,27,28,29,
    32,33,36,
    37,38,40,
    41,42,44,
    47,49
)
AND status='Admitted';
