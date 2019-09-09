<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
	include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_sqlUtils.php");
    include($dir."/Utils/_isNullOrEmpty.php");
    include($dir."/CartService/_cart.php");
    include($dir."/ProductService/_productOptions.php");
    
    $id_product_options = $_POST['id_product_options'];
    $increase = $_POST['increase'] == "True";

    $quantity = 0;

    $sql = _productOptions_getQuantity($id_product_options);
    $result = TryQuerry($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        while($row = $result->fetch_assoc()) {
            $quantity = (int)$row['quantity'];
        }
    }

    if ($quantity == 1 && $increase == false) {

        $sql = _productOptions_deleteCartProduct($id_product_options);
        var_dump($sql);
        TryQuerry($conn, $sql);

        $sql = _productOptions_deleteProductOptions($id_product_options);
        var_dump($sql);
        // return;
        TryQuerry($conn, $sql);
    } else {

        if ($increase == true) {
            $quantity = $quantity + 1;
        } else {
            $quantity = $quantity - 1;
        }
        
        $sql = _cart_changeQuantity($id_product_options, $quantity);
        TryQuerry($conn, $sql);
    }

    echo("Success");
?>