<?php
/*
Author: Kiran
*/

$con = mysqli_connect("localhost:3001","testdb","testdb","register");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
?>
