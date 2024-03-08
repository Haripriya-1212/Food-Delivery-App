<?php

include '../connection.php';

$q = "SELECT * FROM MenuData";
$result = mysqli_query($connect,$q);

if($result){
    $data = array();
    while ($row = mysqli_fetch_assoc($res)) {
        $data[] = $row;
    }
    echo json_encode(array("success"=>true,"menuData"=>$data));
}
else{
    echo json_encode(array("success"=>false,"error"=>mysqli_error($connect)));
}

mysqli_close($connect);

?>

