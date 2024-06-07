<?php
//error_reporting(0);

if (!isset($_POST['postid']) && !isset($_POST['userid'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$postid = $_POST['postid'];


$sqldelete = "DELETE FROM `tbl_moments` WHERE `post_id` = '$postid' AND `user_id` = '$userid'";

if ($conn->query($sqldelete) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>