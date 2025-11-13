<?php
// =============================
// DATABASE CONNECTION
// =============================
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "hospital_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("<h3>Connection failed: " . $conn->connect_error . "</h3>");
}

// =============================
// QUERIES
// =============================
$sql1 = "
SELECT 
    p.patient_name AS PatientName,
    d.doctor_name AS DoctorName,
    dept.department_name AS Department,
    a.appointment_date,
    a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id
WHERE a.status = 'Scheduled'
ORDER BY a.appointment_date;
";

$sql2 = "
SELECT 
    dept.department_name AS Department,
    COUNT(a.appointment_id) AS TotalAppointments
FROM departments dept
LEFT JOIN doctors d ON dept.department_id = d.department_id
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY dept.department_name
ORDER BY TotalAppointments DESC;
";

$sql3 = "
SELECT 
    p.patient_name AS PatientName,
    p.priority_level,
    d.doctor_name AS DoctorName,
    dept.department_name AS Department
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id
WHERE p.priority_level IN ('High', 'Critical')
ORDER BY p.priority_level DESC;
";

$sql4 = "
SELECT 
    d.doctor_name AS Doctor,
    dept.department_name AS Department,
    COUNT(a.appointment_id) AS CurrentPatients
FROM doctors d
JOIN departments dept ON d.department_id = dept.department_id
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id AND a.status = 'Scheduled'
GROUP BY d.doctor_name, dept.department_name
ORDER BY CurrentPatients DESC;
";

$sql5 = "
SELECT 
    p.patient_name AS Patient,
    d.doctor_name AS Doctor,
    DATEDIFF(a.appointment_date, a.request_date) AS WaitDays
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed'
ORDER BY WaitDays DESC;
";

$sql6 = "
SELECT 
    d.doctor_name AS Doctor,
    dept.department_name AS Department,
    d.availability_status
FROM doctors d
JOIN departments dept ON d.department_id = dept.department_id
WHERE d.availability_status = 'Available'
ORDER BY dept.department_name, d.doctor_name;
";

$sql7 = "
SELECT 
    dept.department_name AS Department,
    COUNT(a.appointment_id) AS ScheduledCount
FROM departments dept
JOIN doctors d ON dept.department_id = d.department_id
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Scheduled'
GROUP BY dept.department_name
HAVING ScheduledCount > 5
ORDER BY ScheduledCount DESC;
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

    // Back to Home button
    echo "<p><a href='index.html' style='padding:8px 12px; background-color:#3498db; color:white; text-decoration:none; border-radius:4px;'>⬅ Back to Home</a></p><hr>";
}

// =============================
// RUN QUERY BASED ON BUTTON CLICK
// =============================
$query_num = isset($_GET['query']) ? $_GET['query'] : 1;

switch($query_num){
    case 1: displayResults($conn, $sql1, "1️⃣ Scheduled Appointments (Patient + Doctor + Department)"); break;
    case 2: displayResults($conn, $sql2, "2️⃣ Total Appointments per Department"); break;
    case 3: displayResults($conn, $sql3, "3️⃣ High or Critical Priority Patients"); break;
    case 4: displayResults($conn, $sql4, "4️⃣ Doctors and Current Scheduled Patients"); break;
    case 5: displayResults($conn, $sql5, "5️⃣ Completed Appointments and Wait Time"); break;
    case 6: displayResults($conn, $sql6, "6️⃣ Available Doctors by Department"); break;
    case 7: displayResults($conn, $sql7, "7️⃣ Departments with more than 5 Scheduled Appointments"); break;
    default: displayResults($conn, $sql1, "1️⃣ Scheduled Appointments (Patient + Doctor + Department)");
}

$conn->close();
?>
