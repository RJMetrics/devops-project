<?php
$conn = mysqli_connect("localhost:3001","testdb","testdb","register");
$sql = "SELECT *FROM Users";
$result = $conn->query($sql);

?>

<html>

<head>
	<title> Users Data </title>
</head>

<body>
<table width="600" border="1" cellpadding="1" cellspacing="1">
	<tr>
		<th>id</th>
		<th>FirstName</th>
		<th>LastName</th>
		<th>Age</th>
		<th>CreatedAtTimestamp</th>
	<tr>
<?php

while ($user = $result->fetch_assoc()) {
	echo "<tr>";
	echo "<td>".$user['id']."</td>";
	echo "<td>".$user['FirstName']."</td>";
	echo "<td>".$user['LastName']."</td>";
	echo "<td>".$user['Age']."</td>";
	echo "<td>".$user['CreatedAtTimestamp']."</td>";
	echo "</tr>";
} 

?>

</table>
</body>
</html>
