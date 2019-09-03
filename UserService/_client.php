<?php

    function _client_getClient($id){
        $r = "
        SELECT 
            id,
            id_device,
            email,
            password,
            salt,
            lastname,
            firstname,
            phone,
            address1,
            address2,
            city,
            county
        FROM client 
        WHERE 1 = 1
            AND id_device = NULL
            AND id = ".sqlNr($id)."
        ";
        // AND id_device = NULL
        return $r;
    }

?>