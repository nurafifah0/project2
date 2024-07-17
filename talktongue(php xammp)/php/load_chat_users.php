<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include_once("dbconnect.php");

$userid = $_GET['userid'];

if (!$conn) {
    sendJsonResponse(array('status' => 'failed', 'message' => 'Database connection error'));
    exit();
}

// Correct column names for the tbl_users table
$sql = "SELECT u.user_id, u.user_name, m.latest_message
        FROM tbl_users u
        LEFT JOIN (
            SELECT LEAST(sender_id, receiver_id) AS user1,
                   GREATEST(sender_id, receiver_id) AS user2,
                   MAX(timestamp) AS latest_timestamp,
                   content AS latest_message
            FROM tbl_messages
            WHERE sender_id = '$userid' OR receiver_id = '$userid'
            GROUP BY LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id)
        ) m ON (u.user_id = m.user1 OR u.user_id = m.user2) AND (m.user1 = '$userid' OR m.user2 = '$userid')
        WHERE u.user_id != '$userid'";

$result = $conn->query($sql);

if ($result) {
    if ($result->num_rows > 0) {
        $users = array();
        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }
        $response = array('status' => 'success', 'data' => array('users' => $users));
    } else {
        $response = array('status' => 'failed', 'data' => null);
    }
} else {
    $response = array('status' => 'failed', 'message' => 'Query error: ' . $conn->error);
}

sendJsonResponse($response);

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
