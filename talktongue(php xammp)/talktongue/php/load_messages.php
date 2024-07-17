<?php
include_once("dbconnect.php");

$sender_id = $_GET['sender_id'];
$receiver_id = $_GET['receiver_id'];

$sql = "SELECT * FROM tbl_messages 
        WHERE ((sender_id='$sender_id' AND receiver_id='$receiver_id' AND deleted_by_sender=0) 
        OR (sender_id='$receiver_id' AND receiver_id='$sender_id' AND deleted_by_receiver=0))";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $messages = array();
    while ($row = $result->fetch_assoc()) {
        $messages[] = $row;
    }
    $response = array('status' => 'success', 'data' => array('messages' => $messages));
} else {
    $response = array('status' => 'failed', 'data' => null);
}

sendJsonResponse($response);

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
 