<?php

// Docker variables are put in SERVER, not ENV

$hostname = "mariadb";
$username = $_SERVER["MYSQL_USER"];
$password = $_SERVER["MYSQL_PASSWORD"];
$database = $_SERVER["DB_NAME"];

$conn = mysqli_connect($hostname, $username, $password, $database)
	or die("Connection failed: " . mysqli_connect_error() . "\n");

mysqli_select_db($conn, $database)
	or die ("Database selection failed\n");

$query = mysqli_query($conn, "SHOW TABLES;")
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
echo "<tr><td>"."Tables in $database"."</td></tr>";
while ($row = mysqli_fetch_array($query)) {
	$host = $row["Tables_in_$database"];
	echo "<tr><td>".$host."</td></tr>";
}
echo "</table>";

?>
