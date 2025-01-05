<?php
header("Access-Control-Allow-Origin: *"); 
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$con = mysqli_connect("fdb1029.awardspace.net", "4564363_aya", "aya@81308515", "4564363_aya");

if (mysqli_connect_errno()) {
    echo json_encode(["status" => "error", "message" => "Failed to connect to MySQL: " . mysqli_connect_error()]);
    exit();
}

$sql = "
    SELECT 
        uh.user_id,
        u.name AS user_name,
        uh.recipe_id,
        r.name AS recipe_name,
        r.flavor,
        r.vegan,
        uh.searched_at
    FROM user_history uh
    INNER JOIN users u ON uh.user_id = u.id
    INNER JOIN recipes r ON uh.recipe_id = r.id
    ORDER BY uh.searched_at DESC
";

$result = mysqli_query($con, $sql);

if ($result) {
    $history = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $history[] = $row;
    }
    if (count($history) > 0) {
        echo json_encode(["status" => "success", "history" => $history]);
    } else {
        echo json_encode(["status" => "error", "message" => "No history found."]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Error executing query: " . mysqli_error($con)]);
}


mysqli_free_result($result);
mysqli_close($con);
?>
