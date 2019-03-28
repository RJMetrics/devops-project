<?php
/*
Author: Kiran
*/
?>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Registration</title>
<link rel="stylesheet" href="css/style.css" />
</head>
<body>
<?php
	require('db.php');
    // If form submitted, insert values into the database.
    if (isset($_REQUEST['firstName'])){
		$firstName = stripslashes($_REQUEST['firstName']); // removes backslashes
		$firstName = mysqli_real_escape_string($con,$firstName); //escapes special characters in a string
		$lastName = stripslashes($_REQUEST['lastName']);
		$lastName = mysqli_real_escape_string($con,$lastName);
		$age = stripslashes($_REQUEST['age']);
		$age = mysqli_real_escape_string($con,$age);

		$created_at_timestamp = date("Y-m-d H:i:s");
        $query = "INSERT into `Users` (FirstName, Age, LastName, CreatedAtTimestamp) VALUES ('$firstName', '$age', '$lastName', '$created_at_timestamp')";
        $result = mysqli_query($con,$query);
        if($result){ 
            echo "<div class='form'><h3>You are registered successfully! </h3><br/>Click here to <a href='displayusers.php'>See users table</a></div>";
        }
    }else{
?>
<div class="form">
<h1>Registration Form</h1>
<form name="registration" action="" method="post">
<input type="text" name="firstName" placeholder="FirstName" required />
<input type="text" name="lastName" placeholder="LastName" required />
<input type="number" name="age" placeholder="Age" required />
<input type="submit" name="submit" value="Register" />
</form>
</div>
<?php } ?>
</body>
</html>
