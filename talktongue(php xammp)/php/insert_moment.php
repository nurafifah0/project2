<?php
//error_reporting(0);

if (!isset($_POST['userid']) && !isset($_POST['deets'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$name = $_POST['name'];
$deets = addslashes($_POST['deets']);




$sqlinsert = "INSERT INTO `tbl_moments`(`user_id`, `user_name`, `post_deets`) 
VALUES ('$userid','$name','$deets')";

if ($conn->query($sqlinsert) === TRUE) {
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