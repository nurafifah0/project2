<?php
include_once("dbconnect.php");
//load_user.php
$sql = "SELECT user_id, user_name FROM tbl_users";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $userslist["users"] = array();
    while ($row = $result->fetch_assoc()) {
        $user = array();
        $user['userid'] = $row['user_id'];
        $user['username'] = $row['user_name'];
        array_push($userslist["users"], $user);
    }
    $response = array('status' => 'success', 'data' => $userslist);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
