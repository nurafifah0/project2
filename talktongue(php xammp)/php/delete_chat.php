<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', 'php_errors.log'); // Set a path to a writable log file

include_once("dbconnect.php");

$userid = $_POST['userid'];
$chatid = $_POST['chatid'];

if (!$conn) {
    sendJsonResponse(array('status' => 'failed', 'message' => 'Database connection error'));
    exit();
}

$sql_delete = "DELETE FROM tbl_messages WHERE (sender_id = '$userid' AND receiver_id = '$chatid') OR (sender_id = '$chatid' AND receiver_id = '$userid')";

if ($conn->query($sql_delete) === TRUE) {
    sendJsonResponse(array('status' => 'success', 'message' => 'Chat deleted successfully'));
} else {
    sendJsonResponse(array('status' => 'failed', 'message' => 'Error deleting chat: ' . $conn->error));
}

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
