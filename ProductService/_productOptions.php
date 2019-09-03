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
?>