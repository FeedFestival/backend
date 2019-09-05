<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_getId.php");
	include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_sqlUtils.php");
    include($dir."/Utils/_isNullOrEmpty.php");
    include($dir."/CartService/_cart.php");
    include($dir."/ProductService/_productOptions.php");
	// include($dir."/UserService/_fillClient.php");

    // $product = $_POST['data'];
    $data = json_decode(file_get_contents('php://input'), true);
    
    // 1. verificam daca avem un cart in progress pe clientul trimis
    $id_cart = 0;
    $sql = _cart_getIdByClient($data['options']['id_client']);
    $id_cart = _getId(TryQuerry($conn, $sql));

    if ($id_cart <= 0) {

        $sql = _cart_createEmptyInvoice();
        $id_invoice = TryQuerry($conn, $sql, true);

        $sql = _cart_createCart($id_invoice, $data['options']['id_client']);
        $id_cart = TryQuerry($conn, $sql, true);
    }

    $exists = true;
    $quantity = 1;
    $id_product_options = 0;

    $sql = _productOptions_getProductOptionsByOptions($id_cart, $data['id'], $data['options']);
    $result = TryQuerry($conn, $sql);
    if (mysqli_num_rows($result) > 0) {
        while($row = $result->fetch_assoc()) {
            $product_options = FillCartProduct($row, true);
            $id_product_options = $product_options['id'];
            $quantity = ($product_options['quantity'] = $product_options['quantity'] + 1);
        }
    }
    
    if ($id_product_options <= 0) {

        $exists = false;
        $sql = _productOptions_saveProductOptions($data['id'], $data['options']);
        $id_product_options = TryQuerry($conn, $sql, true);
    }

    if ($exists) {
        $sql = _cart_updateProductInCart($id_cart, $id_product_options, $quantity);    
    } else {
        $sql = _cart_saveProductInCart($id_cart, $id_product_options, $quantity);
    }

    TryQuerry($conn, $sql);

    echo("Success");
?>