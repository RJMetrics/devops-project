<?php

$conn = mysqli_connect('localhost','testdb','testdb','testdb');


if(isset($_POST['submit']))
{

 if(!empty($_POST['firstname']) && ($_POST['lastname']) && ($_POST['age']))
  {
    $firstname= $_POST['firstname'];
    $lastname=  $_POST['lastname'];
    $age= $_POST['age'];
    $date = date('Y-m-d H:i:s');
    
    if(mysqli_query($conn, "insert into Users(Firstname,Lastname,Age,CreatedAtTimestamp) values ('$firstname','$lastname','$age','$date')"));
    {
     echo "Data has saved";
    }
    }
    else{
    echo "Please try again later";
    }
 
}
 
header("refresh:2; url=index.html");


?>
