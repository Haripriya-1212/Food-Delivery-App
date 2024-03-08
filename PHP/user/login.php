<?php
include '../connection.php';

$user_email = $_POST['email'];
$user_password = $_POST['password'];

$query = "SELECT * FROM userInfo WHERE email = '$user_email' AND password = '$user_password'";

$resOfQuery = mysqli_query($connect,$query);
$userRecord = array();

if($resOfQuery->num_rows > 0){
    
    while($rowFound = $resOfQuery->fetch_assoc()){
        $userRecord[] = $rowFound;
    }

    echo json_encode(array(
        "success"=>true,
        "userData"=>$userRecord[0]
    ));
}
else{
    echo json_encode(array("success"=>false));
}

mysqli_close($connect);

?>