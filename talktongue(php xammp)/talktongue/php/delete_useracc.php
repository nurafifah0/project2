<?php
//error_reporting(0);

if (!isset($_POST['userid']) && !isset($_POST['bookid'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$bookid = $_POST['bookid'];


$sqldelete = "DELETE FROM `tbl_books` WHERE `book_id` = '$bookid' AND `user_id` = '$userid'";

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