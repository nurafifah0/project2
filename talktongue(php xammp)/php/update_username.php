<?php
if (!isset($_POST['userid']) || !isset($_POST['newusername'])) {
    $response = array('status' => 'failed', 'data' => 'Missing parameters');
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$newusername = $_POST['newusername'];

$sqlupdate = "UPDATE tbl_users SET user_name = ? WHERE user_id = ?";
$stmt = $conn->prepare($sqlupdate);
$stmt->bind_param("si", $newusername, $userid);

if ($stmt->execute()) {
    $response = array('status' => 'success', 'data' => 'Username updated successfully');
} else {
    $response = array('status' => 'failed', 'data' => 'Update failed');
}

sendJsonResponse($response);
$stmt->close();
$conn->close();

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
