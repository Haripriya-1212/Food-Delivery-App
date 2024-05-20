<?php
include '../connection.php';

if(isset($_POST['userid']) && isset($_POST['amount'])){
    
    $userid = $_POST['userid'];
    $amount = $_POST['amount'];
    $status = $_POST['status'];
    
    $query = "INSERT INTO Orders (userid, dateTime, amount, status) VALUES ('$userid',CURRENT_TIMESTAMP,'$amount','$status')";
    
    $resultOfQuery = mysqli_query($connect,$query); 
    
    if($resultOfQuery){
        echo json_encode(array("success"=>true));
    }
    else{
        echo json_encode(array("success"=>false, "error" => mysqli_error($connect),"userid"=>$userid,"amount"=>$amount,"status"=>$status));
    }
}
else {
    // Return error response if userid or amount is not set
    echo json_encode(array("success" => false, "error" => "userid or amount not provided"));
}

mysqli_close($connect);
?>