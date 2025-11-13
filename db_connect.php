<?php
$servername = "localhost";
$username = "root"; // your MySQL username
$password = "";     // your MySQL password (leave blank for XAMPP default)
$dbname = "hospital_db"; // your database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

