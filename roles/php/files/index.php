<?php
//Database connector params
$host = 'localhost';
$db = 'parco';
$userN = 'testdb';
$passN = 'testdb';

//Database connector variable
$link = mysqli_connect($host,$userN,$passN,$db);

//Select database
mysqli_select_db($link,$db);

//Create database table if it doesn't exists.
$check_db_table = mysqli_query($link,"
CREATE TABLE IF NOT EXISTS `Users` 
(
`id` int(255) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LastName` text COLLATE utf8_bin,
  `Age` text COLLATE utf8_bin,
  `CreatedAtTimestamp` text COLLATE utf8_bin,
   PRIMARY KEY (id)
   );");


?>
<!DOCTYPE html>

<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Magento || Zama</title>




	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<style>
    .menu {
	    width:100%;
	    height:50px;
	    margin:0;
	    background-color: lightcyan;
    }
	button {
		width:100px;
		height:40px;
		font-size: 1.5em;
		font-weight: bold;
		color:white;
		background-color: forestgreen;

	}
	.info{
		position:relative;left:50px;top:50px;
		width:70%;
		}

    .users{
	    width:70%;
    }

    table {
	    width:60%;
    }

    input{
		width:80%;
		height:40px;
		font-size:1.2em;
		}
	</style>
</head>
<body>
<header>
    <!-- Navigation Start -->
<div class="menu">
    <a href="index.php"><button>Home</button></a>
	<a href="index.php?users"><button>Users</button></a>
</div>
    <!-- Navigation End -->
</header>

<?php

if(isset($_POST['FirstName'])){

	$user_first = mysqli_real_escape_string($link,$_POST['FirstName']);
	$user_last = mysqli_real_escape_string($link,$_POST['LastName']);
	$user_age = mysqli_real_escape_string($link,$_POST['Age']);
	$timer = date('Y-m-d H:i:s');

	$check = mysqli_query($link,"SELECT FirstName,LastName,Age FROM Users WHERE FirstName = '$user_first' AND LastName = '$user_last' AND Age = '$user_age'");
	$check_nums = mysqli_num_rows($check);
	if($check_nums > 0)
	{

		echo '<div class="notax" style="background-color:lightskyblue;position:fixed;left:20px;top:100px;width:350px;height:;padding:10px;border-radius:10px;z-index:500;color:red;">
               <h2>User Exists!</h2>
          </div>';
	} else {

		$insert = mysqli_query($link,"INSERT INTO Users (FirstName,LastName,Age,CreatedAtTimestamp) VALUES ('$user_first','$user_last','$user_age','$timer')");


		if($insert){
			echo '<div class="notax" style="background-color:darkgreen;position:fixed;left:20px;top:100px;width:350px;height:;padding:10px;border-radius:10px;z-index:500;color:white;">
               <h2>User Added!</h2>
          </div>';
		} else {
			echo '<div class="notax" style="background-color:red;position:fixed;left:20px;top:100px;width:350px;height:;padding:10px;border-radius:10px;z-index:500;color:white;">
               <h2>User Not Added: Error!</h2>
          </div>';
		}



		}





}

?>

<div class="info">

	<form action="index.php" method="post" enctype="multipart/form-data">
		<label for="FirstName">First Name</label><br>
		<input name="FirstName" id="FirstName" placeholder="FirstName" required>
		<br><br>
		<label for="LastName">Last Name</label><br>
		<input name="LastName" id="LastName" placeholder="LastName" required>
		<br><br>
		<label for="Age">Age</label><br>
		<input type="number" name="Age" id="Age" placeholder="Age" required>
		<br><br><br><br>
		<button style="background-color: darkblue!important;" id="Submit" >Send</button>
	</form>
</div>
<br><br><br>

<?php

if(isset($_GET['users']))
{
	$rec_limit = 10;

	/* Get total number of records */
	$sqle = "SELECT count(id) FROM Users ";
	$retvale = mysqli_query( $link,$sqle );

	if(! $retvale ) {
		die('Could not get data: ' . mysqli_error($link));
	}
	$rowe = mysqli_fetch_array($retvale, MYSQLI_NUM );
	$rec_count = $rowe[0];

	//Setting Up pagination counter
	if( isset($_GET{'page'} ) ) {
		$page = mysqli_real_escape_string($link,$_GET{'page'} + 1);
		$offset = $rec_limit * $page ;
	}else {
		$page = 0;
		$offset = 0;
	}

	$left_rec = $rec_count - ($page * $rec_limit);

$query = mysqli_query($link, "SELECT * FROM Users ORDER BY id DESC LIMIT $offset,$rec_limit");

$row = mysqli_fetch_array($query,MYSQLI_ASSOC);
if(empty($row)){
	echo '<br><br><div><span><a href="index.php"><button style="background-color: #e83e8c;color:white;margin:20px;width:;">Back</button></a></span><span><b> -- No Users! --</b></span><span></span><span></span><span></span></div>';
} else
{
	echo '
<div class="users">

	<table>

		<th><h1>Users:</h1></th>
		<br>
		<tr><td>FirstName</td><td>LastName</td><td>Age</td><td>Created</td></tr>
		<br><br>
		';
	while ($row = mysqli_fetch_array($query, MYSQLI_ASSOC))
	{
		echo '

		<tr><td>' . $row['FirstName'] . '</td><td>' . $row['LastName'] . '</td><td>' . $row['Age'] . '</td><td>' . $row['CreatedAtTimestamp'] . '</td></tr>

	

';
	}

	echo '
</table>
</div>
';
}

    /* Pagination links */
	if ($page > 0)
	{
		$last = $page - 2;
		echo '<br /><a href = "index.php?users=users&page=' . $last . '" class="pager"><u>Last 10 Records</u> |</a> ';

		if ($left_rec < $rec_limit)
		{

		}
		else
		{
			echo '<a href="index.php?users=users&page=' . $page . '" class="pager"><u>Next 10 Records</u></a>';
		}
	}
	else if ($page == 0)
	{
		echo '<br /><a href = "index.php?users=users&page=' . $page . '" class="pager"><u>Next 10 Records</u></a>';
	}
	else
	{
	    $emp = '';
	}
}


?>


<script type="text/javascript">

    //Alerter dismiss function
    setInterval(function(){
        if(!document.querySelector('.notax')){

        } else {

            document.querySelector('.notax').style.display = 'none';
        }



    },3000);
</script>

</body>
</html>