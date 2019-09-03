<?php

    function _getId($result){
        if (mysqli_num_rows($result) < 1) {
            return -1;
        } else {
            while($row = $result->fetch_assoc()) {
                return $row['id'];
            }
        }
    }
?>