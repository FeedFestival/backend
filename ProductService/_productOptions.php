<?php

    function _productOptions_saveProductOptions($id_product, $product_options) {
        $r = "
        INSERT INTO product_options (id_product, file, text, nume, id_gravura) VALUES
        (   ".sqlNr($id_product).", 
            ".sqlString($product_options['file']).", 
            ".sqlString($product_options['text']).", 
            ".sqlString($product_options['nume']).",
            ".sqlNr($product_options['gravura']['id'])."     
        )
        ";
        return $r;
    }

    function _productOptions_getProductOptionsByOptions($id_cart, $id_product, $product_options) {
        $r = "
        SELECT po.id,
            cp.quantity
        FROM cart_product as cp
            INNER JOIN product_options as po
                ON po.id = cp.id_product_options
        WHERE
            cp.id_cart = ".sqlNr($id_cart)."
            AND po.id_product = ".sqlNr($id_product)."
            AND po.file "._canBeNull(sqlString($product_options['file']))."
            AND po.text "._canBeNull(sqlString($product_options['text']))."
            AND po.nume "._canBeNull(sqlString($product_options['nume']))."
            AND po.id_gravura = ".sqlNr($product_options['gravura']['id'])."
        LIMIT 1";
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
            
        }
	}
?>