<?php
include_once("dbconnect.php");

$sender_id = $_POST['sender_id'];
$receiver_id = $_POST['receiver_id'];
$message = $_POST['message'];

if (empty($sender_id) || empty($receiver_id) || empty($message)) {
    $response = array('status' => 'failed', 'error' => 'Empty fields');
    sendJsonResponse($response);
    exit();
}

$sql = "INSERT INTO tbl_messages (sender_id, receiver_id, content) VALUES ('$sender_id', '$receiver_id', '$message')";

if ($conn->query($sql) === TRUE) {
    $response = array('status' => 'success');
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'error' => $conn->error);
    error_log("Error: " . $conn->error); // Log the error for debugging
    sendJsonResponse($response);
}

$conn->close();

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
