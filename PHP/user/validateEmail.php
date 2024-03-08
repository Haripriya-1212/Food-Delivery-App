<?php
include '../connection.php';

$email = $_POST['email'];

$sqlQuery = "SELECT * FROM userInfo WHERE email = '$email';";

// $resultOfQuery = $connectNow->query($sqlQuery);
$resultOfQuery = mysqli_query($connect,$sqlQuery);



// json_encode() is a native PHP function that allows you to convert PHP data into the JSON format.
if($resultOfQuery->num_rows > 0){
    echo json_encode(array("emailFound"=>true));
}
else{
    echo json_encode(array("emailFound"=>false));
}

mysqli_close($connect);
?>



