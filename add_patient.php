<?php
require 'config.php';
require_login();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $gender = $_POST['gender'];
    $age = $_POST['age'];
    $priority_level = $_POST['priority_level'];
    $phone = $_POST['phone'] ?? null;
    $address = $_POST['address'] ?? null;

    $stmt = $pdo->prepare("
        INSERT INTO Patient (name, gender, age, priority_level, phone, address)
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    $stmt->execute([$name, $gender, $age, $priority_level, $phone, $address]);

    header('Location: dashboard.php?msg=patient_added');
    exit;
}
?>
