<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$user_id = addslashes(strip_tags($_GET['user_id']));

$con = mysqli_connect("fdb1029.awardspace.net", "4564363_aya", "aya@81308515", "4564363_aya");

if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$sql = "SELECT r.name AS recipe_name, r.flavor, r.vegan
FROM recipes r
INNER JOIN recipe_ingredients ri ON r.id = ri.recipe_id
INNER JOIN user_ingredients ui ON ri.ingredient_id = ui.ingredient_id
WHERE ui.user_id = '$user_id';";

$result = mysqli_query($con, $sql);

if (mysqli_num_rows($result) > 0) {
    $recipes = array();
    while($row = mysqli_fetch_assoc($result)) {
        $recipes[] = $row;
    }
    echo json_encode(["status" => "success", "recipes" => $recipes]);
} else {
    echo json_encode(["status" => "error", "message" => "No recipes found."]);
}

mysqli_free_result($result);
mysqli_close($con);
?>
