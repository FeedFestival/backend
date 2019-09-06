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

    function product_getProduct($id_product) {
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
                m.name as material_name,
                m.gramprice as material_price,
                m.handicraftprice as material_handicraftprice,
                
                product.id_model, 
                md.name as model_name,
                md.grams as model_grams,
                md.price as model_price,

                md.id_measure,
                ms.height as measure_height,
                ms.width as measure_width,
                ms.thickness as measure_thickness,
                ms.diameter as measure_diameter,

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
                AND product.id = ".$id_product."";

        return $r;
    }

    function FillProduct($row) {
        return array(
            'id' => $row['id'],
            'name' => $row['name'],
            'description' => $row['description'],
            'picture_path' => $row['picture_path'],
            'id_category' => $row['id_category'],
            'id_subcategory' => $row['id_subcategory'],
            'material_name' => $row['material_name'],
            'material_price' => $row['material_price'],
            'material_handicraftprice' => $row['material_handicraftprice'],
            'model_name' => $row['model_name'],
            'model_grams' => $row['model_grams'],
            'model_price' => $row['model_price'],
            'id_measure' => $row['id_measure'],
            'measure_height' => $row['measure_height'],
            'measure_width' => $row['measure_width'],
            'measure_thickness' => $row['measure_thickness'],
            'measure_diameter' => $row['measure_diameter'],
            'product_price' => $row['product_price']
        );
    }
?>
