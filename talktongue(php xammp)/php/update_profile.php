<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

if (isset($_POST['image'])) {
    $encoded_string = $_POST['image'];
    $userid = $_POST['userid'];
    $decoded_string = base64_decode($encoded_string);
    $path = '../assets/profile/' . $userid . '.png';
    $is_written = file_put_contents($path, $decoded_string);
    if ($is_written){
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
    die();
}

if (isset($_POST['image'])) {
    $encoded_string = $_POST['image'];
    $userid = $_POST['userid'];
    $decoded_string = base64_decode($encoded_string);
    $path = '../assets/moment/' . $userid . '.png';
    $is_written = file_put_contents($path, $decoded_string);
    if ($is_written){
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
    die();
}

if (isset($_POST['newphone'])) {
    $phone = $_POST['newphone'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_phone ='$phone' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

if (isset($_POST['oldpass'])) {
    $oldpass = sha1($_POST['oldpass']);
    $newpass = sha1($_POST['newpass']);
    $userid = $_POST['userid'];
    include_once("dbconnect.php");
    $sqllogin = "SELECT * FROM tbl_users WHERE user_id = '$userid' AND user_password = '$oldpass'";
    $result = $conn->query($sqllogin);
    if ($result->num_rows > 0) {
    	$sqlupdate = "UPDATE tbl_users SET user_password ='$newpass' WHERE user_id = '$userid'";
            if ($conn->query($sqlupdate) === TRUE) {
                $response = array('status' => 'success', 'data' => null);
                sendJsonResponse($response);
            } else {
                $response = array('status' => 'failed', 'data' => null);
                sendJsonResponse($response);
            }
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

if (isset($_POST['newname'])) {
    $name = $_POST['newname'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_name ='$name' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

if (isset($_POST['newaddr'])) {
    $address = $_POST['newaddr'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_address ='$address' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

/* if (!isset($_POST['userid']) && !isset($_POST['newage']) && !isset($_POST['status1']) && !isset($_POST['status2']) && !isset($_POST['status3'])) {
    $age = $_POST['newage'];
    $nativelang = $_POST['status1'];
    $learninglang = $_POST['status2'];
    $fluencylang = $_POST['status3'];
    $userid = $_POST['userid'];
    include_once("dbconnect.php");
    $sqlinsert = "INSERT INTO `tbl_accsetting` (`user_id`, `user_age`,`user_nativelang`, `user_learninglang`,`user_fluency` ) VALUES ('$userid','$age','$nativelang', '$learninglang','$fluencylang')";
    if ($conn->query($sqlinsert) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
} */

if (!isset($_POST['userid']) && !isset($_POST['newage']) ) {
    include_once("dbconnect.php");

    $age = $_POST['newage'];
    $userid = $_POST['userid'];
    
    $sqlupdate = "UPDATE tbl_accsetting SET user_age='$age' WHERE user_id='$userid'";
    if ($conn->query($sqlupdate) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }

}

/* if (isset($_POST['newage'])) {
    $age = $_POST['newage'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_accsetting SET user_age ='$age' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
} */

if (isset($_POST['status1'])) {
    $nativelang = $_POST['status1'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_accsetting SET user_nativelang ='$nativelang' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

if (isset($_POST['status2'])) {
    $learninglang = $_POST['status2'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_accsetting SET user_learninglang ='$learninglang' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

if (isset($_POST['status3'])) {
    $fluencylang = $_POST['status3'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_accsetting SET user_fluency ='$fluencylang' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

/* if (isset($_POST['newaddr'])) {
    $userid = $_POST['userid'];
    $age = $_POST['age'];
    $status1 = $_POST['status1'];
    $status2 = $_POST['status2'];
    $status3 = $_POST['status3'];
    $sqlinsert = "INSERT INTO `tbl_books`(`user_id`, `user_age`, `user_nativelang`, `user_learninglang`, `user_fluency`) 
VALUES ('$userid','age','$status1','$status2','$status3')";
if ($conn->query($sqlinsert) === TRUE) {
    
	$response = array('status' => 'success', 'data' => $sqlinsert);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => $sqlinsert);
	sendJsonResponse($response);
}
    
} */

function databaseUpdate($sql){
    include_once("dbconnect.php");
    if ($conn->query($sql) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>