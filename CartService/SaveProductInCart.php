<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
    include($dir."/Utils/_getId.php");
	include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_sqlUtils.php");
    include($dir."/Utils/_isNullOrEmpty.php");
    include($dir."/Utils/_saveImage.php");
    include($dir."/CartService/_cart.php");
    include($dir."/ProductService/_productOptions.php");
	
    $data = json_decode($_POST['data'], true);
    // $data = json_decode(file_get_contents('php://input'), true);

    // 1. verificam daca avem un cart in progress pe clientul trimis
    $id_cart = 0;
    $sql = _cart_getIdByClient($data['id_client']);
    $id_cart = _getId(TryQuerry($conn, $sql));

    if ($id_cart <= 0) {

        $sql = _cart_createEmptyInvoice();
        $id_invoice = TryQuerry($conn, $sql, true);

        $sql = _cart_createCart($id_invoice, $data['id_client']);
        $id_cart = TryQuerry($conn, $sql, true);
    }

    $exists = true;
    $quantity = 1;
    $id_product_options = 0;

    $sql = _productOptions_getProductOptionsByOptions($id_cart, $data);
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

        $hasFile = $data['file'] != '';
        if ($hasFile) {
            $fileName = _getImageName($data['file'], $id_cart, $data['id_client']);
            $data['file'] = $fileName;
        } else {
            $data['file'] = null;
        }

        if ($data['nume'] == '') {
            $data['nume'] = null;
        }

        if ($data['text'] == '') {
            $data['text'] = null;
        }

        if ($data['text_verso'] == '') {
            $data['text_verso'] = null;
        }

        $sql = _productOptions_saveProductOptions($data);
        $id_product_options = TryQuerry($conn, $sql, true);

        if ($hasFile) {
            _saveImage($fileName, $_FILES["picture_bytes"]["tmp_name"]);
        }
    }

    if ($exists) {
        $sql = _cart_updateProductInCart($id_cart, $id_product_options, $quantity);    
    } else {
        $sql = _cart_saveProductInCart($id_cart, $id_product_options, $quantity);
    }

    TryQuerry($conn, $sql);

    echo("Success");
?>