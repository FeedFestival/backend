<?php

    function IsNullOrEmptyString($question){
        return (!isset($question) || trim($question)==='');
    }

    function product_getProducts($subCategoryId = 0){
        $r = "
            SELECT product.id
                , product.name
                , product.description
                , product.picture_path
                , product.id_subcategory
                , product.id_material, product.id_model
                , cat.description as categoryDescription
                , scat.description as subCategoryDescription
            FROM product
            INNER JOIN category as cat on product.id_category = cat.id
            INNER JOIN category as scat on product.id_subcategory = scat.id
            WHERE 1 = 1
            ";

        if ($subCategoryId > 0) {
            $r .= " 
                AND product.id_subcategory = ".$subCategoryId."";
        }

        return $r;
    }
?>
