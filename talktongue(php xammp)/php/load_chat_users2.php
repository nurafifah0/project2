<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', 'php_errors.log'); // Set a path to a writable log file

include_once("dbconnect.php");

$userid = $_GET['userid'];

if (!$conn) {
    sendJsonResponse(array('status' => 'failed', 'message' => 'Database connection error'));
    exit();
}

// Main query to get users and their latest messages
$sql_main = "SELECT u.user_id, u.user_name, m.latestmessage
             FROM tbl_users u
             LEFT JOIN (
                 SELECT LEAST(sender_id, receiver_id) AS user1,
                        GREATEST(sender_id, receiver_id) AS user2,
                        MAX(timestamp) AS latest_timestamp,
                        content AS latestmessage
                 FROM tbl_messages
                 WHERE sender_id = '$userid' OR receiver_id = '$userid'
                 GROUP BY LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id)
             ) m ON (u.user_id = m.user1 OR u.user_id = m.user2) AND (m.user1 = '$userid' OR m.user2 = '$userid')
             WHERE u.user_id != '$userid'";

$result_main = $conn->query($sql_main);

$response_main = array();
if ($result_main) {
    if ($result_main->num_rows > 0) {
        $userslist["users"] = array();
        while ($row = $result_main->fetch_assoc()) {
            $user = array();
            $user['userid'] = $row['user_id'];
            $user['username'] = $row['user_name'];
            $user['latestmessage'] = $row['latestmessage']; // Including the latest message in the response
            array_push($userslist["users"], $user);
        }
        $response_main = array('status' => 'success', 'data' => $userslist);
    } else {
        $response_main = array('status' => 'failed', 'data' => null);
    }
} else {
    $response_main = array('status' => 'failed', 'message' => 'Query error: ' . $conn->error);
}

// Secondary query to get distinct users
$sql_secondary = "SELECT DISTINCT user_id, user_name 
                  FROM tbl_users 
                  WHERE user_id IN (
                      SELECT DISTINCT receiver_id 
                      FROM tbl_messages 
                      WHERE sender_id = '$userid'
                      UNION
                      SELECT DISTINCT sender_id 
                      FROM tbl_messages 
                      WHERE receiver_id = '$userid'
                  )";

$result_secondary = $conn->query($sql_secondary);

$response_secondary = array();
if ($result_secondary) {
    if ($result_secondary->num_rows > 0) {
        $userslist["users"] = array();
        while ($row = $result_secondary->fetch_assoc()) {
            $user = array();
            $user['userid'] = $row['user_id'];
            $user['username'] = $row['user_name'];
            array_push($userslist["users"], $user);
        }
        $response_secondary = array('status' => 'success', 'data' => $userslist);
    } else {
        $response_secondary = array('status' => 'failed', 'data' => null);
    }
} else {
    $response_secondary = array('status' => 'failed', 'message' => 'Query error: ' . $conn->error);
}

// Combine both responses
$response = array(
    'main_response' => $response_main,
    'secondary_response' => $response_secondary
);

sendJsonResponse($response);

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
