<?php

    
    $dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_TryQuerry.php");
    // include($dir."/Utils/_ToObject.php");
    include($dir."/ProductService/_getProductsSql.php");

	$id_product = intval($_REQUEST["id_product"]);

	$sql = product_getProduct($id_product);
    // echo($sql);
	$result = TryQuerry($conn, $sql);

    $product = new stdClass();

	if (mysqli_num_rows($result) > 0) {
		while($row = $result->fetch_assoc()) {
			$product = FillProduct($row);
		}
	}
	# JSON-encode the response
	echo $json_response = json_encode($product);

?>