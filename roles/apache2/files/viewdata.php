<?php
$db_host = 'localhost'; 
$db_user = 'testdb'; 
$db_pass = 'testdb'; 
$db_name = 'testdb'; 
$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);

if (!$conn) {
	die ('Failed to connect to MySQL: ' . mysqli_connect_error());	
}

if (isset($_GET['pages'])) {
            $pages = $_GET['pages'];
        } else {
            $pages = 1;
        }
        $records_page = 10;
        $offset = ($pages-1) * $records_page;
        
        $count_sqldata = "SELECT COUNT(*) FROM Users";
        $result = mysqli_query($conn,$count_sqldata);
        $total_rows = mysqli_fetch_array($result)[0];
        $total_pages = ceil($total_rows / $records_page);


         
$sql="SELECT * FROM Users  LIMIT $offset, $records_page";
$result = mysqli_query($conn,$sql);

?>
<span class="view_data"><a href="index.html"> Home</a></span>
<?php 
echo "<table align='center' border='1'>
<tr>
<th>Firstname</th>
<th>Lastname</th>
<th>Age</th>
<th>Created Date</th>
</tr>";

while($row = mysqli_fetch_array($result))
{
	echo "<tr>";
	echo "<td align='center'>" . $row['Firstname'] . "</td>";
	echo "<td>" . $row['Lastname'] . "</td>";
	echo "<td>" . $row['Age'] . "</td>";
	echo "<td>" . $row['CreatedAtTimestamp'] . "</td>";
	echo "</tr>";
}
echo "</table>";

?>

<ul class="pagination">
        <li><a href="?pages=1">First</a></li>
        <li class="<?php if($pages <= 1){ echo 'disabled'; } ?>">
            <a href="<?php if($pages <= 1){ echo '#'; } else { echo "?pages=".($pages - 1); } ?>">Prev</a>
        </li>
        <li class="<?php if($pages >= $total_pages){ echo 'disabled'; } ?>">
            <a href="<?php if($pages >= $total_pages){ echo '#'; } else { echo "?pages=".($pages + 1); } ?>">Next</a>
        </li>
        <li><a href="?pages=<?php echo $total_pages; ?>">Last</a></li>
    </ul>
  <link rel="stylesheet" href="style.css">   
