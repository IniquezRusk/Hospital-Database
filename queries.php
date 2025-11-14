<?php
// =============================
// DATABASE CONNECTION
// =============================
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "HospitalAdmissions";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("<h3>Connection failed: " . $conn->connect_error . "</h3>");
}

// =============================
// QUERIES (UPDATED FOR NEW DB)
// =============================
$sql1 = "
SELECT 
    p.name AS Patient,
    p.priority_level,
    d.name AS Doctor,
    b.branch_name AS Branch,
    a.admission_date,
    a.diagnosis,
    a.status
FROM Admission a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Branch b ON a.branch_id = b.branch_id
WHERE a.status = 'Admitted'
ORDER BY a.admission_date DESC;
";

$sql2 = "
SELECT 
    b.branch_name AS Branch,
    b.capacity AS MaxCapacity,
    COUNT(a.admission_id) AS CurrentlyAdmitted,
    (b.capacity - COUNT(a.admission_id)) AS AvailableCapacity
FROM Branch b
LEFT JOIN Admission a 
    ON b.branch_id = a.branch_id AND a.status = 'Admitted'
GROUP BY b.branch_id
ORDER BY AvailableCapacity DESC;
";

$sql3 = "
SELECT 
    p.name AS Patient,
    p.gender,
    p.age,
    p.priority_level,
    d.name AS Doctor,
    br.branch_name AS Branch
FROM Patient p
JOIN Admission a ON p.patient_id = a.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Branch br ON a.branch_id = br.branch_id
WHERE p.priority_level IN ('High','Critical')
ORDER BY p.priority_level DESC;
";

$sql4 = "
SELECT 
    d.name AS Doctor,
    br.branch_name AS Branch,
    COUNT(a.admission_id) AS CurrentPatients
FROM Doctor d
JOIN Branch br ON d.branch_id = br.branch_id
LEFT JOIN Admission a 
    ON d.doctor_id = a.doctor_id AND a.status = 'Admitted'
GROUP BY d.doctor_id
ORDER BY CurrentPatients DESC;
";

$sql5 = "
SELECT 
    p.name AS Patient,
    d.name AS Doctor,
    a.admission_date,
    a.discharge_date,
    DATEDIFF(IFNULL(a.discharge_date, CURDATE()), a.admission_date) AS Days_Stayed
FROM Admission a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
WHERE a.discharge_date IS NOT NULL
ORDER BY Days_Stayed DESC;
";

$sql6 = "
SELECT 
    br.branch_name AS Branch,
    bed.room_no,
    bed.bed_number,
    bed.bed_type,
    bed.status
FROM Bed bed
JOIN Branch br ON bed.branch_id = br.branch_id
WHERE bed.status = 'Available'
ORDER BY br.branch_name, bed.room_no;
";

$sql7 = "
SELECT 
    br.branch_name AS Branch,
    br.capacity,
    COUNT(a.admission_id) AS CurrentlyAdmitted
FROM Branch br
JOIN Admission a 
    ON br.branch_id = a.branch_id AND a.status = 'Admitted'
GROUP BY br.branch_id
HAVING COUNT(a.admission_id) > br.capacity;
";

// =============================
// FUNCTION TO DISPLAY RESULTS
// =============================
function displayResults($conn, $query, $title){
    echo "<h2>$title</h2>";
    $result = $conn->query($query);

    if($result && $result->num_rows > 0){
        echo "<table border='1' cellpadding='6' cellspacing='0'>";
        echo "<tr>";
        while($field = $result->fetch_field()){
            echo "<th>{$field->name}</th>";
        }
        echo "</tr>";

        while($row = $result->fetch_assoc()){
            echo "<tr>";
            foreach($row as $value){
                echo "<td>$value</td>";
            }
            echo "</tr>";
        }
        echo "</table><br>";
    } else {
        echo "<p style='color:red;'>No results found for this query.</p>";
    }

    echo "<p><a href='index.html' style='padding:8px 12px; background-color:#3498db; color:white; text-decoration:none; border-radius:4px;'>⬅ Back to Home</a></p><hr>";
}

// =============================
// RUN QUERY BASED ON BUTTON CLICK
// =============================
$query_num = isset($_GET['query']) ? $_GET['query'] : 1;

switch($query_num){
    case 1: displayResults($conn, $sql1, "1️⃣ All Admitted Patients"); break;
    case 2: displayResults($conn, $sql2, "2️⃣ Branch Capacity Overview"); break;
    case 3: displayResults($conn, $sql3, "3️⃣ High & Critical Priority Patients"); break;
    case 4: displayResults($conn, $sql4, "4️⃣ Doctors and Current Patient Count"); break;
    case 5: displayResults($conn, $sql5, "5️⃣ Patient Length of Stay"); break;
    case 6: displayResults($conn, $sql6, "6️⃣ Available Beds by Branch"); break;
    case 7: displayResults($conn, $sql7, "7️⃣ Branches Over Capacity"); break;
    default: displayResults($conn, $sql1, "1️⃣ All Admitted Patients");
}

$conn->close();
?>
