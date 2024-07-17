<?php
include_once("dbconnect.php");

$message_ids = json_decode($_POST['message_ids']);

$sql = "DELETE FROM tbl_messages WHERE message_id IN (" . implode(',', $message_ids) . ")";

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
