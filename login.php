<?php
header("Access-Control-Allow-Origin: *"); 
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$email = addslashes(strip_tags($_POST['email']));
$password = addslashes(strip_tags($_POST['password']));

$con = mysqli_connect("fdb1029.awardspace.net", "4564363_aya", "aya@81308515", "4564363_aya");

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";

$result = mysqli_query($con, $sql);

if (mysqli_num_rows($result) == 1) {
    echo json_encode(["status" => "success", "message" => "Login successful."]);
} else {
    echo json_encode(["status" => "error", "message" => "Invalid email or password."]);
}

mysqli_free_result($result);
mysqli_close($con);
?>
