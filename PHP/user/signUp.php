<?php
include '../connection.php';

// POST = send/save data to db
// GET = retreive/read data from db

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];
$phoneNum = $_POST['phoneNum'];
$flatNum = $_POST['flatNum'];
$street = $_POST['street'];
$area = $_POST['area'];
$city = $_POST['city'];
$pincode = $_POST['pincode'];


$sqlQuery = "INSERT INTO userInfo (username,email,password,phoneNum,flatNum,street,area,city,pincode) VALUES ('$username','$email','$password','$phoneNum','$flatNum','$street','$area','$city','$pincode')";
// $sqlQuery = "INSERT INTO userInfo SET username = '$username', email = '$email', password = '$password'";

// $resultOfQuery = $connectNow->query($sqlQuery);
$resultOfQuery = mysqli_query($connect,$sqlQuery);


// json_encode() is a native PHP function that allows you to convert PHP data into the JSON format.
if($resultOfQuery){
    echo json_encode(array("success"=>true,"userId"=>$userId));
}
else{
    echo json_encode(array("success"=>false));
}

mysqli_close($connect);
?>



