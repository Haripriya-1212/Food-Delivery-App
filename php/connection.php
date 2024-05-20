<?php

$severhost = "localhost";
$user = "root";
$password = "root";
$database = "flutterTry";

$connect = mysqli_connect($severhost, $user, $password, $database);

if (!$connect) {
    // If connection failed, display an error message
    die("Connection failed: " . mysqli_connect_error());
}


?>