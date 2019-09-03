<?php

    function _isNullOrEmpty($question){
        return (!isset($question) || trim($question)==='');
    }

    function category_getCategories($categoryId = 0){
        $r = "
            SELECT category.id
                , category.description
                , category.level
            FROM category
            ";

        if ($categoryId > 0) {
            $r .= "
                INNER JOIN categories_subcategories 
                    ON categories_subcategories.id_category = ".$categoryId."
                    		AND categories_subcategories.id_subcategory = category.id";
        }

        $r .= " 
            WHERE 1 = 1
            ";

        if ($categoryId > 0) {
            $r .= "
                AND category.level = 2
                ";
        } else {
            $r .= " 
                AND category.level = 1";
        }

        return $r;
    }
?>
