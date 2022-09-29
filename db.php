<?php

// Docker variables are put in SERVER, not ENV

$hostname = "mariadb";
$username = $_SERVER["MYSQL_USER"];
$password = $_SERVER["MYSQL_PASSWORD"];
$database = "mysql";

$conn = mysqli_connect($hostname, $username, $password, $database)
	or die("Connection failed: " . mysqli_connect_error() . "\n");

$query = mysqli_query($conn, "SELECT user, password, host FROM user")
	or die("Query failed: " . mysqli_error($conn) . "\n");

echo "
<style>
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
		margin-left:auto;
		margin-right:auto;
		padding: 10px;
	}
</style>\n";

echo "<table>";
echo "<tr><td>"."user"."</td><td>"."password"."</td><td>"."host"."</td></tr>";
while ($row = mysqli_fetch_array($query)) {
	$user = $row['user'];
	$password = $row['password'];
	$host = $row['host'];
	echo "<tr><td>".$user."</td><td>".$password."</td><td>".$host."</td></tr>";
}
echo "</table>";

?>
