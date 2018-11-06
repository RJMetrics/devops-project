<?php
        

        $conn = mysqli_connect($host, $user, $pass);

        if (! $conn) {
        	die('Connection Failed ::' . mysqli_error());
        }

        echo 'Connection Succeeded !!';

        mysqli_select_db($conn, 'Customers');

        $query = "SELECT * 
                        FROM Users";
        $result = mysqli_query($conn, $query);

        mysqli_close($conn);

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>READ DATA</title>
</head>
<body>
	<h1> READING USERS</h1>
 <?php  if (mysqli_num_rows($results) > 0): ?>
        <h2>Results</h2>

        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Age</th>
                    <th>CreatedAt</th>
                </tr>
            </thead>
            <tbody>
        	<?php while($row = mysqli_fetch_object($result)): ?>
            	<tr>
                	<td><?php echo escape($row["FirstName"]); ?></td>
                	<td><?php echo escape($row["LastName"]); ?></td>
                	<td><?php echo escape($row["Age"]); ?></td>
                	<td><?php echo escape($row["CreatedAtTimestamp"]); ?> </td>
            	</tr>
        	<?php endwhile; ?>
        	</tbody>
    	</table>
    <?php else: ?>
        <blockquote>No results found </blockquote>
    <?php endif; ?> 


</body>
</html>