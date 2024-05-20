<?php
include '../connection.php';

// POST = send/save data to db
// GET = retreive/read data from db

$userid = $_POST['userid'];

$sqlQuery = "SELECT *  FROM Orders WHERE userid = $userid";

// $resultOfQuery = $connectNow->query($sqlQuery);
$resultOfQuery = mysqli_query($connect,$sqlQuery);


// json_encode() is a native PHP function that allows you to convert PHP data into the JSON format.
if($resultOfQuery){
    // if($resultOfQuery->num_rows > 0){
    if(mysqli_num_rows($resultOfQuery) > 0){
        $orderData = array();
        while($rowFound = $resultOfQuery->fetch_assoc()){
            $orderData[] = $rowFound;
        }
        echo json_encode(array("success"=>true,"userOrderData"=>$orderData));
    }
    else{
        echo json_encode(array("success"=>true,"no record"=>true));
    }
}
    else{
    echo json_encode(array("success"=>false,"error"=>mysqli_error($connect)));
}

mysqli_close($connect);

?>