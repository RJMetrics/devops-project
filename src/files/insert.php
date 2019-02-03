<html>
<body>

<?php
$con = mysqli_connect("localhost","testdb","testdb","testdb","3001");
if (!$con)
  {
  die('Could not connect: ' . mysqli_connect_error());
  }
#mysqli_select_db($con,"testdb");
$sql="INSERT INTO MyGuests (FirstName, LastName, Age)
VALUES
('$_POST[FirstName]','$_POST[LastName]','$_POST[Age]')";
if (!mysqli_query($con,$sql))
  {
  die('Error: ' . mysqli_error());
  }
echo "1 record added";
$conn = mysqli_connect("localhost", "testdb", "testdb","testdb","3001");
$result = mysqli_query($conn,"SELECT * FROM MyGuests");

echo "<table border='1'>
<tr>
<th>Firstname</th>
<th>Lastname</th>
<th>Age</th>
</tr>";

while($row = mysqli_fetch_array($result))
{
echo "<tr>";
echo "<td>" . $row['FirstName'] . "</td>";
echo "<td>" . $row['LastName'] . "</td>";
echo "<td>" . $row['Age'] . "</td>";
echo "</tr>";
}
echo "</table>";
mysqli_close($con)
?>

</body>
</html>
