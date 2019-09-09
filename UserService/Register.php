<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
	include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_sqlUtils.php");
    include($dir."/Utils/_isNullOrEmpty.php");
    include($dir."/UserService/_login.php");
    include($dir."/UserService/_client.php");
    
    $client = json_decode($_POST['client'], true);

    $id_device = null;

    $sql = _getClientDevice($client['id']);
    $result = TryQuerry($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        while($row = $result->fetch_assoc()) {
            $id_device = $row['id_device'];
        }
    }

    $sql = _registerClient($client);
    $result = TryQuerry($conn, $sql);
    echo("SUCCESS");
?>