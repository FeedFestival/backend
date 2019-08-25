<?php

    function IsNullOrEmptyString($question){
        return (!isset($question) || trim($question)==='');
    }

    function category_getCategories($categoryId = 0){
        $r = "
            SELECT category.Id
                , category.Description
                , category.Level
            FROM category
            ";

        if ($categoryId > 0) {
            $r .= "
                INNER JOIN categories_subcategories 
                    ON categories_subcategories.CategoryId = ".$categoryId."
                    		AND categories_subcategories.SubCategoryId = category.Id";
        }

        $r .= " 
            WHERE 1 = 1
            ";

        if ($categoryId > 0) {
            $r .= "
                AND category.Level = 2
                ";
        } else {
            $r .= " 
                AND category.Level = 1";
        }

        return $r;
    }
?>
