<?php
//error_reporting(0);
include_once("dbconnect.php");
$deets = $_GET['deets'];
$username = $_GET['username'];


//step 1
$results_per_page = 10;
//step 2
if (isset($_GET['pageno'])){
	$pageno = (int)$_GET['pageno'];
}else{
	$pageno = 1;
}
//step 3
$page_first_result = ($pageno - 1) * $results_per_page;

//step 4
$sqlloadmoments = "SELECT * FROM `tbl_moments` WHERE  `post_deets` LIKE '%$deets%' OR  `user_name` LIKE '%$username%' ";
$result = $conn->query($sqlloadmoments);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);

//step 5
$sqlloadmoments = $sqlloadmoments . " LIMIT $page_first_result , $results_per_page";

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
        array_push( $momentlist["posts"],$post);
    }
    $response = array('status' => 'success', 'data' => $momentlist, 'numofpage'=>$number_of_page,'numberofresult'=>$number_of_result);
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