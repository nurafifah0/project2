<?php
//error_reporting(0);
include_once("dbconnect.php");

$username = $_GET['username'];


//step 1
//$results_per_page = 10;
//step 2
/* if (isset($_GET['pageno'])){
	$pageno = (int)$_GET['pageno'];
}else{
	$pageno = 1;
} */
//step 3
//$page_first_result = ($pageno - 1) * $results_per_page;

//step 4
$sqlloadaccs = "SELECT * FROM `tbl_users` WHERE  `user_name` LIKE '%$username%' ";
/* $result = $conn->query($sqlloadaccs);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page); */

//step 5
//$sqlloadaccs = $sqlloadaccs . " LIMIT $page_first_result , $results_per_page";

$result = $conn->query($sqlloadaccs);
if ($result->num_rows > 0) {
    $acclist["users"] = array();
    while ($row = $result->fetch_assoc()) {
        $user = array();
        
        $user['userid'] = $row['user_id'];
        $user['useremail'] = $row['user_email'];
        $user['username'] = $row['user_name'];
        $user['userpassword'] = $row['user_password'];
        $user['userdatereg'] = $row['user_datereg'];
      
        array_push( $acclist["users"],$user);
    }
    $response = array('status' => 'success', 'data' => $acclist);
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