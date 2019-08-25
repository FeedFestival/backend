<?php
/**
 * Created by PhpStorm.
 * User: dani
 * Date: 11/29/2016
 * Time: 12:14 AM
 */

function TryQuerry($conn, $sql, $scope_identity = false){
    mysqli_autocommit($conn, FALSE);

    $insert_id = 0;

    $r = mysqli_query($conn, $sql);
    $insert_id = $conn->insert_id;

    mysqli_commit($conn);

    if ($r){
        if ($scope_identity) {
            return $insert_id;
        }
        return $r;
    } else {
        //print_r(" - querry failed for:
        //".$sql);
        http_response_code(405);
        echo json_encode(
            array('Error' => "".$sql."
- Querry FAILED. ".mysqli_error($conn))
        );

        /* Rollback */
        mysqli_rollback($conn);

        mysqli_close($conn);
        exit;
    }
}
?>
