<?php

    function IsNullOrEmptyString($question){
        return (!isset($question) || trim($question)==='');
    }

    function product_getProducts($subCategoryId = 0){
        $r = "
            SELECT product.Id
                , product.Name
                , product.Description
                , product.PicturePath
                , product.SubCategoryId
                , product.id_material, product.id_measure, product.id_model
                , cat.Description as categoryDescription
                , scat.Description as subCategoryDescription
            FROM product
            INNER JOIN category as cat on product.CategoryId = cat.Id
            INNER JOIN category as scat on product.SubCategoryId = scat.Id
            WHERE 1 = 1
            ";

        if ($subCategoryId > 0) {
            $r .= " 
                AND product.SubCategoryId = ".$subCategoryId."";
        }

        return $r;
    }
?>
