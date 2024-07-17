
<?php
/*
include_once("dbconnect.php");

$message_id = $_POST['message_id'];
$user_id = $_POST['user_id'];

// Determine if the user is the sender or receiver of the message
$sql = "SELECT sender_id, receiver_id FROM tbl_messages WHERE message_id='$message_id'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if ($row['sender_id'] == $user_id) {
        // User is the sender, mark as deleted by sender
        $sql_update = "UPDATE tbl_messages SET deleted_by_sender=1 WHERE message_id='$message_id'";
    } elseif ($row['receiver_id'] == $user_id) {
        // User is the receiver, mark as deleted by receiver
        $sql_update = "UPDATE tbl_messages SET deleted_by_receiver=1 WHERE message_id='$message_id'";
    }

    if ($conn->query($sql_update) === TRUE) {
        $response = array('status' => 'success');
    } else {
        $response = array('status' => 'failed', 'error' => $conn->error);
    }
} else {
    $response = array('status' => 'failed', 'error' => 'Message not found');
}

sendJsonResponse($response);

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
*/
?>
<?php
include_once("dbconnect.php");

$message_id = $_POST['message_id'];
$user_id = $_POST['user_id'];

// Determine if the user is the sender or receiver of the message
$sql = "SELECT sender_id, receiver_id, deleted_by_sender, deleted_by_receiver FROM tbl_messages WHERE message_id='$message_id'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $isSender = $row['sender_id'] == $user_id;
    $isReceiver = $row['receiver_id'] == $user_id;

    if ($isSender) {
        // User is the sender, mark as deleted by sender
        $sql_update = "UPDATE tbl_messages SET deleted_by_sender=1 WHERE message_id='$message_id'";
    } elseif ($isReceiver) {
        // User is the receiver, mark as deleted by receiver
        $sql_update = "UPDATE tbl_messages SET deleted_by_receiver=1 WHERE message_id='$message_id'";
    }

    if ($isSender || $isReceiver) {
        if ($conn->query($sql_update) === TRUE) {
            // Check if both sender and receiver have marked the message as deleted
            $sql_check = "SELECT deleted_by_sender, deleted_by_receiver FROM tbl_messages WHERE message_id='$message_id'";
            $result_check = $conn->query($sql_check);
            if ($result_check->num_rows > 0) {
                $row_check = $result_check->fetch_assoc();
                if ($row_check['deleted_by_sender'] == 1 && $row_check['deleted_by_receiver'] == 1) {
                    // Both sender and receiver have marked the message as deleted, delete the message
                    $sql_delete = "DELETE FROM tbl_messages WHERE message_id='$message_id'";
                    if ($conn->query($sql_delete) === TRUE) {
                        $response = array('status' => 'success');
                    } else {
                        $response = array('status' => 'failed', 'error' => $conn->error);
                    }
                } else {
                    $response = array('status' => 'success');
                }
            } else {
                $response = array('status' => 'failed', 'error' => 'Message not found during check');
            }
        } else {
            $response = array('status' => 'failed', 'error' => $conn->error);
        }
    } else {
        $response = array('status' => 'failed', 'error' => 'User is neither sender nor receiver');
    }
} else {
    $response = array('status' => 'failed', 'error' => 'Message not found');
}

sendJsonResponse($response);

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
