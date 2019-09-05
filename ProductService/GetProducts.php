<?php

    
    $dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_ToObject.php");
    include($dir."/ProductService/_getProductsSql.php");

	$id_category = intval($_REQUEST["id_category"]);
	$id_subcategory = intval($_REQUEST["id_subcategory"]);

	$sql = product_getProducts($id_category, $id_subcategory);
	// echo($sql);
	$result = TryQuerry($conn, $sql);

	$arr = array();
	
	if (mysqli_num_rows($result) > 0) {
		while($row = $result->fetch_assoc()) {
			$arr[] = $row;
		}
	}
	# JSON-encode the response
	echo $json_response = json_encode($arr);

?>