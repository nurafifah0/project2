<?php
if (!isset($_POST['userid'])) {
    $response = array('status' => 'failed', 'data' => 'Missing user ID');
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];

$sqldelete = "DELETE FROM tbl_users WHERE user_id = ?";
$stmt = $conn->prepare($sqldelete);
$stmt->bind_param("i", $userid);

if ($stmt->execute()) {
    $response = array('status' => 'success', 'data' => 'Account deleted successfully');
} else {
    $response = array('status' => 'failed', 'data' => 'Deletion failed');
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
