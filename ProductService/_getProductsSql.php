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
            FROM product
            WHERE 1 = 1
            ";

        if ($subCategoryId > 0) {
            $r .= " 
                AND product.SubCategoryId = ".$subCategoryId."";
        }

        return $r;
    }
?>
