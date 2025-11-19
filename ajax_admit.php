<?php
// ajax_admit.php
require 'config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success'=>false, 'error'=>'Invalid method']); exit;
}
if (!hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) {
    echo json_encode(['success'=>false, 'error'=>'Invalid CSRF token']); exit;
}

$patient_id = intval($_POST['patient_id'] ?? 0);
$doctor_id = $_POST['doctor_id'] ?? '';
$branch_id = $_POST['branch_id'] ?? '';
$diagnosis = $_POST['diagnosis'] ?? '';

try {
    // Call stored procedure
    $stmt = $pdo->prepare("CALL sp_admit_patient(:p_patient_id, :p_doctor_id, :p_branch_id, :p_diagnosis)");
    $stmt->bindValue(':p_patient_id', $patient_id, PDO::PARAM_INT);
    $stmt->bindValue(':p_doctor_id', $doctor_id);
    $stmt->bindValue(':p_branch_id', $branch_id);
    $stmt->bindValue(':p_diagnosis', $diagnosis);
    $stmt->execute();

    // If sp_admit_patient inserted, we can return success message
    echo json_encode(['success'=>true, 'message'=>'Patient admitted successfully.']);
} catch (PDOException $e) {
    // handle SQLSTATE from SIGNALs
    echo json_encode(['success'=>false, 'error'=> $e->getMessage()]);
}
