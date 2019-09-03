<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_getId.php");
	include($dir."/Utils/_TryQuerry.php");
	include($dir."/Utils/_sqlUtils.php");
    include($dir."/CartService/_cart.php");
    include($dir."/ProductService/_productOptions.php");
	// include($dir."/UserService/_fillClient.php");

    // $product = $_POST['data'];
    $data = json_decode(file_get_contents('php://input'), true);
    
    // 1. verificam daca avem un cart in progress pe clientul trimis
    $id_cart = 0;
    $sql = _cart_getIdByClient($data['options']['id_client']);
    $id_cart = _getId(TryQuerry($conn, $sql));

    if ($id_cart == 0) {

        // - daca nu, cream cart si luam id
        // - cream si invoice
        // TODO
    } else {

        // 2. verifica daca mai exista un produs in cart cu aceleasi proprietati
        // TODO.

        $sql = _productOptions_saveProductOptions($data['id'], $data['options']);
        $id_product_options = TryQuerry($conn, $sql, true);
        
        $quantity = 1;

        $sql = _cart_saveProductInCart($id_cart, $id_product_options, $quantity);
        TryQuerry($conn, $sql);
    }

    echo("Success");
?>