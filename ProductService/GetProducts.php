<?php

    
    $dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_ToObject.php");
    include($dir."/ProductService/_getProductsSql.php");

    $subCategoryId = intval($_REQUEST["subCategoryId"]);

    // echo($subCategoryId);
	
	// get the user password for GameSparks
	$result = TryQuerry($conn, product_getProducts($subCategoryId));

	$arr = array();
	
	if (mysqli_num_rows($result) > 0) {
		while($row = $result->fetch_assoc()) {
			$arr[] = $row;
		}
	}
	# JSON-encode the response
	echo $json_response = json_encode($arr);

?>