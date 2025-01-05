<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");


$name = addslashes(strip_tags($_POST['name']));
$email = addslashes(strip_tags($_POST['email']));
$password = addslashes(strip_tags($_POST['password']));


$con = mysqli_connect("fdb1029.awardspace.net", "4564363_aya", "aya@81308515", "4564363_aya");


if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }


$sql = "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password')";

if (mysqli_query($con, $sql)) {
    echo json_encode(["status" => "success", "message" => "User registered successfully."]);
} else {
    echo json_encode(["status" => "error", "message" => "Error: " . mysqli_error($con)]);
}


mysqli_close($con);
?>
