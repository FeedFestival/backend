<?php

    
    $dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_ToObject.php");
    include($dir."/CategoryService/_getCategoriesSql.php");

    $categoryId = intval($_REQUEST["categoryId"]);
    
    // echo($categoryId);

	// get the user password for GameSparks
	$result = TryQuerry($conn, category_getCategories($categoryId));

	$arr = array();
	
	if (mysqli_num_rows($result) > 0) {
		while($row = $result->fetch_assoc()) {
			$arr[] = $row;
		}
	}
	# JSON-encode the response
	echo $json_response = json_encode($arr);

?>