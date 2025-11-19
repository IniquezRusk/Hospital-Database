<?php
// config.php
session_start();

$DB_HOST = '127.0.0.1';
$DB_NAME = 'HospitalAdmissions';
$DB_USER = 'root';
$DB_PASS = ''; // change as needed

try {
    $pdo = new PDO("mysql:host=$DB_HOST;dbname=$DB_NAME;charset=utf8mb4", $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch (PDOException $e) {
    die("DB Connection failed: " . $e->getMessage());
}

// simple auth helper
function require_login() {
    if (empty($_SESSION['staff_id'])) {
        header('Location: login.php');
        exit;
    }
}

function csrf_token() {
    if (empty($_SESSION['csrf'])) {
        $_SESSION['csrf'] = bin2hex(random_bytes(16));
    }
    return $_SESSION['csrf'];
}
?>
