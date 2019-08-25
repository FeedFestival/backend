<?php
/**
 * Created by PhpStorm.
 * User: dani
 * Date: 11/29/2016
 * Time: 12:14 AM
 */

// session_start();

// $servername = "localhost";
// $username = "id1570128_simionescudani07"; // "root"
// $password = "fire4test"; // ""
// $dbName = "id1570128_game_crib"; // "game_crib"

$servername = "localhost";
$username = "root";
$password = "";
$dbName = "StJ";


// Make Connection
$conn = new mysqli($servername, $username, $password, $dbName);

// Check Connection
if (!$conn){
    die("Connection Failed. ". mysqli_connect_error());
}
// else {
//     echo("Connected");
// }

// header("Pragma: no-cache");
// header("Cache-Control: no-cache")
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header('P3P: CP="CAO PSA OUR"'); // Makes IE to support cookies
header("Content-Type: application/json; charset=utf-8");

	
?>