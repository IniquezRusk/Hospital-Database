<?php
// login.php
require 'config.php';

$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    $stmt = $pdo->prepare("SELECT staff_id, name, role, password FROM AdmissionStaff WHERE username = :username");
$stmt->execute(['username' => $username]);
$row = $stmt->fetch();

// plain text password comparison
if ($row && $password === $row['password']) {
    $_SESSION['staff_id'] = $row['staff_id'];
    $_SESSION['staff_name'] = $row['name'];
    $_SESSION['role'] = $row['role'];
    header('Location: dashboard.php');
    exit;
} else {
    $err = "Invalid username or password";
}

}
?>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Hospital Staff Login</title>
<link rel="stylesheet" href="assets/styles.css">
<style>
body {
    font-family: Arial, sans-serif;
    background: #e9f2fb;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}
.login-container {
    background: white;
    padding: 2em;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    width: 300px;
}
.login-container h2 {
    text-align: center;
    color: #0d6efd;
}
.login-container form {
    display: flex;
    flex-direction: column;
}
.login-container input, .login-container select, .login-container button {
    margin: 0.5em 0;
    padding: 0.5em;
    border-radius: 5px;
    border: 1px solid #ccc;
}
.login-container button {
    background: #0d6efd;
    color: white;
    border: none;
    cursor: pointer;
}
.login-container button:hover {
    background: #0b5ed7;
}
.error {
    color: red;
    text-align: center;
    margin-bottom: 0.5em;
}
</style>
</head>
<body>
  <div class="login-container">
    <h2>Staff Login</h2>
    <?php if($err): ?>
      <div class="error"><?= htmlspecialchars($err) ?></div>
    <?php endif; ?>
    <form method="post">
      <input type="text" name="username" placeholder="Username" required>
      <input type="password" name="password" placeholder="Password" required>
      <button type="submit">Login</button>
    </form>
  </div>
</body>
</html>
