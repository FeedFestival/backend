<?php

    function _cart_getCurrentCart($id_client) {
        $r = "
        SELECT
            c.id,
            c.id_client,
            cp.id_product_options,
            cp.quantity,
            p.id as id_product,
            p.name as product_name,
            m.name as material_name,
            m.gramprice,
            m.handicraftprice,
            md.name as model_name,
            ms.height,
            ms.width,
            ms.thickness,
            ms.diameter,
            po.file as option_file,
            po.text as option_text,
            po.text_verso as option_text_verso,
            po.nume as option_name,
            g.id as id_gravura,
            g.type as gravura_type,
            p.picture_path,
            IF(g.id=3, 
                (((m.gramprice * md.grams) + m.handicraftprice + md.price) + 10) * cp.quantity,
                ((m.gramprice * md.grams) + m.handicraftprice + md.price) * cp.quantity
                )
            AS total_price
        FROM cart as c
            INNER JOIN cart_product as cp 
                ON c.id = cp.id_cart
            INNER JOIN product_options as po
                ON po.id = cp.id_product_options
            INNER JOIN product as p
                ON po.id_product = p.id
            INNER JOIN gravura as g
                ON po.id_gravura = g.id
            INNER JOIN material as m
                ON p.id_material = m.id
            INNER JOIN model as md
                ON p.id_model = md.id
            INNER JOIN measure as ms
                ON md.id_measure = ms.id
        WHERE
            c.is_in_progress = 1
            AND c.id_client = ".sqlNr($id_client)."
        ";

        return $r;
    }
    
    function _cart_getIdByClient($id_client) {
        $r = "
        SELECT id 
        FROM cart
        WHERE id_client = ".sqlNr($id_client)."
            AND is_in_progress = 1
        ";

        return $r;
    }

    function _cart_saveProductInCart($id_cart, $id_product_options, $quantity) {
        $r = "
        INSERT INTO cart_product (id_cart, id_product_options, quantity) VALUES
        (".sqlNr($id_cart).", ".sqlNr($id_product_options).", ".sqlNr($quantity).");
        ";
        return $r;
    }

    function _cart_updateProductInCart($id_cart, $id_product_options, $quantity) {
        $r = "
        UPDATE cart_product SET quantity = ".sqlNr($quantity)."
        WHERE id_cart = ".sqlNr($id_cart)." AND id_product_options = ".sqlNr($id_product_options)."
        ";
        return $r;
    }

    function _cart_createEmptyInvoice() {
        $r = "
        INSERT INTO invoice (quantity, price, vat_price, total_price) VALUES
        (0, 0, 0, 0);
        ";
        return $r;
    }
    
    function _cart_createCart($id_invoice, $id_client) {
        $r = "
        INSERT INTO cart (id_invoice, id_client, is_in_progress) VALUES
        (".sqlNr($id_invoice).", ".sqlNr($id_client).", 1);
        ";
        return $r;
    }

    function _cart_changeQuantity($id_product_options, $quantity) {

        $r = "
        UPDATE cart_product SET
            quantity = ".sqlNr($quantity)."
        WHERE id_product_options = ".sqlNr($id_product_options)."
        ";
        return $r;
    }
?>