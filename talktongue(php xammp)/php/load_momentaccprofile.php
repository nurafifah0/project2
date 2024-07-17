<?php
include_once("dbconnect.php");

$userid = $_GET['userid'];

$sqlloadmoments = "SELECT * FROM tbl_moments WHERE user_id = '$userid'";

$result = $conn->query($sqlloadmoments);
if ($result->num_rows > 0) {
    $momentlist["posts"] = array();
    while ($row = $result->fetch_assoc()) {
        $post = array();
        $post['post_id'] = $row['post_id'];
        $post['user_id'] = $row['user_id'];
        $post['user_name'] = $row['user_name'];
        $post['post_deets'] = $row['post_deets'];
        $post['post_date'] = $row['post_date'];
        array_push($momentlist["posts"], $post);
    }
    $response = array('status' => 'success', 'data' => $momentlist);
} else {
    $response = array('status' => 'failed', 'data' => null);
}

sendJsonResponse($response);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
