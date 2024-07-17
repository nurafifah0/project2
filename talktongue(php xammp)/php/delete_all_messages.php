<?php
include_once("dbconnect.php");

$sender_id = $_POST['sender_id'];
$receiver_id = $_POST['receiver_id'];

$sql = "DELETE FROM tbl_messages WHERE (sender_id='$sender_id' AND receiver_id='$receiver_id') OR (sender_id='$receiver_id' AND receiver_id='$sender_id')";

if ($conn->query($sql) === TRUE) {
    $response = array('status' => 'success');
} else {
    $response = array('status' => 'failed', 'error' => $conn->error);
}

sendJsonResponse($response);

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
