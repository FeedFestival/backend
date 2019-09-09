<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
	include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_sqlUtils.php");
    include($dir."/Utils/_isNullOrEmpty.php");
    include($dir."/CartService/_cart.php");
    include($dir."/ProductService/_productOptions.php");
    
    $id_client = intval($_REQUEST["id_client"]);

    $arr = array();

    $sql = _cart_getCurrentCart($id_client);
    $result = TryQuerry($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        while($row = $result->fetch_assoc()) {
            // $product_options = FillCartProduct($row, true);
            $arr[] = $row;
		}
    }
    
	# JSON-encode the response
	echo $json_response = json_encode($arr);
?>