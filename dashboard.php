<?php
// dashboard.php
require 'config.php';
require_login();

// fetch current admissions
$admissions = $pdo->query("
    SELECT * FROM vw_current_admissions ORDER BY admission_date DESC
")->fetchAll();

// fetch doctor load
$doctors = $pdo->query("SELECT * FROM vw_doctor_load ORDER BY active_patients DESC")->fetchAll();

// fetch available beds (view)
$availableBeds = $pdo->query("SELECT * FROM vw_available_beds")->fetchAll();

// fetch patients who are not currently admitted (candidates)
$patients = $pdo->query("
    SELECT p.patient_id, p.name, p.priority_level
    FROM Patient p
    LEFT JOIN Admission a ON p.patient_id = a.patient_id AND a.status='Admitted'
    WHERE a.admission_id IS NULL
    ORDER BY p.name
")->fetchAll();

// branches
$branches = $pdo->query("SELECT branch_id, branch_name FROM Branch")->fetchAll();
?>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Admission Dashboard</title>
<link rel="stylesheet" href="assets/styles.css">
<script>
function admitPatient() {
    const form = document.getElementById('admitForm');
    const data = new FormData(form);
    fetch('ajax_admit.php', { method: 'POST', body: data })
      .then(r => r.json())
      .then(j => {
         if (j.success) {
            alert('Admitted: ' + j.message);
            window.location.reload();
         } else {
            alert('Error: ' + j.error);
         }
      });
    return false;
}

function loadAvailableBeds(branchId) {
    fetch('ajax_available_beds.php?branch='+encodeURIComponent(branchId))
      .then(r => r.json())
      .then(j => {
         const out = document.getElementById('availableBeds');
         out.innerHTML = j.map(b => `<div>${b.bed_id} (${b.bed_type}) — ${b.room_no}</div>`).join('');
      });
}
</script>
</head>
<body>
  <header>
    <h1>Admission Dashboard</h1>
    <div>Welcome, <?=htmlspecialchars($_SESSION['staff_name'])?> | <a href="logout.php">Logout</a></div>
  </header>

  <section>
    <h2>Currently Admitted Patients</h2>
    <table border="1" cellpadding="4">
      <thead><tr><th>ID</th><th>Patient</th><th>Priority</th><th>Doctor</th><th>Bed</th><th>Branch</th><th>Admission Date</th></tr></thead>
      <tbody>
        <?php foreach($admissions as $a): ?>
        <tr>
          <td><?= $a['admission_id'] ?></td>
          <td><?= htmlspecialchars($a['patient_name']) ?></td>
          <td><?= $a['priority_level'] ?></td>
          <td><?= htmlspecialchars($a['doctor_name']) ?></td>
          <td><?= htmlspecialchars($a['bed_id']) ?> (<?= $a['bed_type'] ?>)</td>
          <td><?= htmlspecialchars($a['branch_name']) ?></td>
          <td><?= htmlspecialchars($a['admission_date']) ?></td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </section>

  <section>
    <h2>Doctor workload</h2>
    <ul>
      <?php foreach($doctors as $d): ?>
        <li><?=htmlspecialchars($d['doctor_name'])?> — <?= $d['active_patients'] ?> patients (<?= htmlspecialchars($d['branch_name']) ?>)</li>
      <?php endforeach; ?>
    </ul>
  </section>

  <section>
    <h2>Available Beds</h2>
    <div id="availableBeds">
      <?php foreach($availableBeds as $b): ?>
         <div><?=htmlspecialchars($b['bed_id'])?> — <?=htmlspecialchars($b['bed_type'])?> — <?=htmlspecialchars($b['branch_name'])?></div>
      <?php endforeach; ?>
    </div>
  </section>

  <!-- Add New Patient Section -->
  <section>
    <h2>Add New Patient</h2>
    <form method="post" action="add_patient.php">
      <label>Name: <input name="name" required></label><br>
      <label>Gender:
        <select name="gender" required>
          <option value="">--Select--</option>
          <option value="Male">Male</option>
          <option value="Female">Female</option>
          <option value="Other">Other</option>
        </select>
      </label><br>
      <label>Age: <input type="number" name="age" min="0" max="120" required></label><br>
      <label>Priority Level:
        <select name="priority_level" required>
          <option value="">--Select--</option>
          <option value="Low">Low</option>
          <option value="Medium">Medium</option>
          <option value="High">High</option>
          <option value="Critical">Critical</option>
        </select>
      </label><br>
      <label>Phone: <input name="phone"></label><br>
      <label>Address: <input name="address"></label><br>
      <button type="submit">Add Patient</button>
    </form>
  </section>

  <!-- Admit Patient Section -->
  <section>
    <h2>Admit Patient</h2>
    <form id="admitForm" onsubmit="return admitPatient();">
      <input type="hidden" name="csrf" value="<?=csrf_token()?>"/>
      <label>Patient:
        <select name="patient_id" required>
          <?php foreach($patients as $p): ?>
            <option value="<?= $p['patient_id'] ?>"><?= htmlspecialchars($p['name']) ?> (<?= $p['priority_level'] ?>)</option>
          <?php endforeach; ?>
        </select>
      </label><br>

      <label>Doctor:
        <select name="doctor_id" required>
          <?php
            $stm = $pdo->query("SELECT doctor_id, name, branch_id FROM Doctor");
            foreach($stm->fetchAll() as $doc){
              echo "<option value=\"{$doc['doctor_id']}\">".htmlspecialchars($doc['name'])." ({$doc['branch_id']})</option>";
            }
          ?>
        </select>
      </label><br>

      <label>Branch:
        <select name="branch_id" onchange="loadAvailableBeds(this.value)" required>
          <option value="">--select--</option>
          <?php foreach($branches as $br): ?>
            <option value="<?= $br['branch_id'] ?>"><?= htmlspecialchars($br['branch_name']) ?></option>
          <?php endforeach; ?>
        </select>
      </label><br>

      <label>Diagnosis: <input name="diagnosis" required></label><br>
      <button type="submit">Admit patient</button>
    </form>
  </section>

</body>
</html>
