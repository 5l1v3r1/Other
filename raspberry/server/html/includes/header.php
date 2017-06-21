<?php
	# Page Title
	$siteTitle = "GreenBerry";
	session_start();

	$refresh = '';

	if((isset($_POST['refresh']))&&(is_numeric($_POST['refresh']))&&($_POST['refresh'] > 0)&&($_POST['refresh'] <= 50)) {
	    $refresh = $_POST['refresh'];
	} else {
	    $refresh = 15;
	}
?>

<!DOCTYPE html>
<html>
	<head>
        <!-- CSS Stylesheet(s) -->
        <link href="css/main.css" rel="stylesheet">
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
		<link rel="stylesheet" href="css/master.css">
		
		<!-- Javascript -->
		<script src="js/jquery.js" type="text/javascript"></script>
		<script src="js/materialize.min.js" type="text/javascript"></script>
		
		<!-- Metadata -->
		<meta charset="UTF-8">
		<meta name="author" content="Michael Gottburg">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="description" content="RedHat Neuchâtel Office Plants Video Live Feed">
        
        <meta http-equiv="refresh" content="<?php echo($refresh) ?>" >
		
		<title>
            <?php echo($siteTitle) ?>
		</title>
		
		<style>
			#map {
		     height: 80%;
		     width: 60%;
		     margin: auto;
		     border: 3px solid #73AD21;
		     padding: 10px;
			}
		</style>
    </head>
