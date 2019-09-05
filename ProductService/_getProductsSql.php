<?php

    function product_getProducts($id_category = 0, $id_subcategory = 0) {
        $r = "
            SELECT product.id
                , product.name
                , product.description
                , product.picture_path

                , product.id_category
                , cat.description as category_description
                , product.id_subcategory
                , scat.description as subcategory_description

                , product.id_material
                , product.id_model

                , ((m.gramprice * md.grams) + m.handicraftprice + md.price) as product_price
            FROM product

            INNER JOIN category as cat on product.id_category = cat.id
            INNER JOIN category as scat on product.id_subcategory = scat.id

            INNER JOIN material as m
                ON product.id_material = m.id
            INNER JOIN model as md
                ON product.id_model = md.id
            WHERE 1 = 1
            ";

        if ($id_subcategory > 0) {
            $r .= " 
                AND product.id_category = ".$id_category."";
        }

        if ($id_subcategory > 0) {
            $r .= " 
                AND product.id_subcategory = ".$id_subcategory."";
        }

        return $r;
    }

    function product_getProduct($id_category = 0, $id_subcategory = 0) {
        $r = "
            SELECT product.id
                , product.name
                , product.description
                , product.picture_path

                , product.id_category
                , cat.description as category_description
                , product.id_subcategory
                , scat.description as subcategory_description

                , product.id_material,
                m.name,
                m.gramprice,
                m.handicraftprice,
                
                product.id_model, 
                md.name,
                md.grams,
                md.price,
                ms.height,
                ms.width,
                ms.thickness,
                ms.diameter,

                ((m.gramprice * md.grams) + m.handicraftprice + md.price) as product_price
            FROM product

            INNER JOIN category as cat on product.id_category = cat.id
            INNER JOIN category as scat on product.id_subcategory = scat.id

            INNER JOIN material as m
                ON product.id_material = m.id
            INNER JOIN model as md
                ON product.id_model = md.id
            INNER JOIN measure as ms
                ON md.id_measure = ms.id

            WHERE 1 = 1
            ";

        if ($id_subcategory > 0) {
            $r .= " 
                AND product.id_category = ".$id_category."";
        }

        if ($id_subcategory > 0) {
            $r .= " 
                AND product.id_subcategory = ".$id_subcategory."";
        }

        return $r;
    }
?>
