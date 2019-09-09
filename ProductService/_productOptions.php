<?php

    function _productOptions_saveProductOptions($product_options) {
        $r = "
        INSERT INTO product_options (id_product, file, text, text_verso, nume, id_gravura) VALUES
        (   ".sqlNr($product_options['id_product']).", 
            ".sqlString($product_options['file']).", 
            ".sqlString($product_options['text']).", 
            ".sqlString($product_options['text_verso']).", 
            ".sqlString($product_options['nume']).",
            ".sqlNr($product_options['id_gravura'])."     
        )
        ";
        return $r;
    }

    function _productOptions_getProductOptionsByOptions($id_cart, $product_options) {
        $r = "
        SELECT po.id,
            cp.quantity
        FROM cart_product as cp
            INNER JOIN product_options as po
                ON po.id = cp.id_product_options
        WHERE
            cp.id_cart = ".sqlNr($id_cart)."
            AND po.id_product = ".sqlNr($product_options['id_product'])."
            AND po.file "._canBeNull(sqlString($product_options['file']))."
            AND po.text "._canBeNull(sqlString($product_options['text']))."
            AND po.text_verso "._canBeNull(sqlString($product_options['text_verso']))."
            AND po.nume "._canBeNull(sqlString($product_options['nume']))."
            AND po.id_gravura = ".sqlNr($product_options['id_gravura'])."
        LIMIT 1";
        return $r;
    }

    function _productOptions_getQuantity($id_product_options) {
        $r = "
        SELECT cp.quantity
        FROM cart_product as cp
        WHERE
            cp.id_product_options = ".sqlNr($id_product_options)."
        LIMIT 1";
        return $r;
    }

    function _productOptions_deleteProductOptions($id_product_options) {
        $r = "
        DELETE FROM product_options
        WHERE product_options.id = ".sqlNr($id_product_options)."
        ";
        return $r;
    }
    
    function _productOptions_deleteCartProduct($id_product_options) {
        $r = "
        DELETE FROM cart_product
        WHERE cart_product.id_product_options = ".sqlNr($id_product_options)."
        ";
        return $r;
    }

    function _canBeNull($string) {
        if (_isNullOrEmpty($string)) {
            return "IS NULL";
        }
        return "= ".$string;
    }

    function FillCartProduct($row, $just_quantity) {
        if ($just_quantity == true) {
            return array(
                    'id' => $row['id'],
                    'quantity' => $row['quantity']
                );
        } else {
            return array(
                'id' => $row['id'],
                'id_client' => $row['id_client'],
                'id_product_options' => $row['id_product_options'],
                'quantity' => $row['quantity'],
                'id_product' => $row['id_product'],
                'product_name' => $row['product_name'],
                'material_name' => $row['material_name'],
                'gramprice' => $row['gramprice'],
                'handicraftprice' => $row['handicraftprice'],
                'model_name' => $row['model_name'],
                'height' => $row['height'],
                'width' => $row['width'],
                'thickness' => $row['thickness'],
                'diameter' => $row['diameter'],
                'option_file' => $row['option_file'],
                'option_text' => $row['option_text'],
                'option_text_verso' => $row['option_text_verso'],
                'option_name' => $row['option_name'],
                'id_gravura' => $row['id_gravura'],
                'gravura_type' => $row['gravura_type'],
                'picture_path' => $row['picture_path'],
                'total_price' => $row['total_price']
            );
        }
	}
?>