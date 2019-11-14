<?php

$servername = "localhost";
$username = "id11571226_admin";
$password = "admin";
$dbname = "id11571226_my_store";

$connect = new mysqli($servername, $username, $password, $dbname);

if($connect) {
    echo "Connection Success";
} else {
    echo "Connection Failed";
    exit();
}

?>