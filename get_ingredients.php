<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$con = mysqli_connect("fdb1029.awardspace.net", "4564363_aya", "aya@81308515", "4564363_aya");
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$sql = "SELECT id, name FROM ingredients";
$result = $con->query($sql);

if ($result->num_rows > 0) {
    $ingredients = [];
    while ($row = $result->fetch_assoc()) {
        $ingredients[] = $row;
    }
    echo json_encode($ingredients);
} else {
    echo json_encode(['status' => 'error', 'message' => 'No ingredients found.']);
}

$con->close();
?>
