<?php
	$dir = $_SERVER['DOCUMENT_ROOT']."/StJ";
    include($dir."/_connect.php");
	include($dir."/Utils/_TryQuerry.php");
    include($dir."/Utils/_sqlUtils.php");
    include($dir."/Utils/_isNullOrEmpty.php");
    include($dir."/CartService/_cart.php");
    include($dir."/ProductService/_productOptions.php");
    
    $client = json_decode($_POST['client'], true);

    

    $msg = "First line of text\nSecond line of text";
    $msg = wordwrap($msg,70);

    mail($client['email'],"Comanda ta",$msg);

    var_dump($client);
    return;
    
    echo("Success");
?>