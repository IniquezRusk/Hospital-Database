<?php
// ajax_available_beds.php
require 'config.php';
header('Content-Type: application/json');

$branch = $_GET['branch'] ?? '';
if (!$branch) {
    echo json_encode([]);
    exit;
}

$stmt = $pdo->prepare("SELECT bed_id, room_no, bed_number, bed_type FROM Bed WHERE branch_id=:branch AND status='Available'");
$stmt->execute(['branch' => $branch]);
$res = $stmt->fetchAll();
echo json_encode($res);
