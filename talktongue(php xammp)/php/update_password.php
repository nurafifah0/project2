<?php
//error_reporting(0);
if (!isset($_POST['userid']) || !isset($_POST['oldpass']) || !isset($_POST['newpass'])) {
    $response = array('status' => 'failed', 'data' => 'Missing parameters');
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$oldpass = sha1($_POST['oldpass']);
$newpass = sha1($_POST['newpass']);

// Check if the old password is correct
$sqllogin = "SELECT * FROM tbl_users WHERE user_id = ? AND user_password = ?";
$stmt = $conn->prepare($sqllogin);
$stmt->bind_param("is", $userid, $oldpass);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Update the password
    $sqlupdate = "UPDATE tbl_users SET user_password = ? WHERE user_id = ?";
    $stmt = $conn->prepare($sqlupdate);
    $stmt->bind_param("si", $newpass, $userid);

    if ($stmt->execute()) {
        $response = array('status' => 'success', 'data' => 'Password updated successfully');
    } else {
        $response = array('status' => 'failed', 'data' => 'Update failed');
    }
} else {
    $response = array('status' => 'failed', 'data' => 'Incorrect old password');
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
