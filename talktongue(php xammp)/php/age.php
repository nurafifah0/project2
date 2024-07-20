<?php
// Enable error reporting for debugging purposes (disable in production)
// error_reporting(E_ALL);
// ini_set('display_errors', 1);

if (!isset($_POST['userid']) || !isset($_POST['newage'])) {
    $response = array('status' => 'failed', 'data' => 'Missing parameters');
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$age = $_POST['newage'];
$userid = $_POST['userid'];

$sqlupdate = "UPDATE tbl_accsetting SET user_age = ? WHERE user_id = ?";
$stmt = $conn->prepare($sqlupdate);
$stmt->bind_param("si", $age, $userid);

if ($stmt->execute()) {
    $response = array('status' => 'success', 'data' => 'Age updated successfully');
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
