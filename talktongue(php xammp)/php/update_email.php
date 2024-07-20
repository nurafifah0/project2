<?php
//error_reporting(0);
if (!isset($_POST['userid']) || !isset($_POST['newemail'])) {
    $response = array('status' => 'failed', 'data' => 'Missing parameters');
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$newemail = $_POST['newemail'];

$sqlupdate = "UPDATE tbl_users SET user_email = ? WHERE user_id = ?";
$stmt = $conn->prepare($sqlupdate);
$stmt->bind_param("si", $newemail, $userid);

if ($stmt->execute()) {
    $response = array('status' => 'success', 'data' => 'Email updated successfully');
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
