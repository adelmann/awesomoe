<h3>PHP Version</h3>
<?php
	$errors = 0;

	if (version_compare(phpversion(), '5.6.16', '<')) {
    	$errors++;
    	echo "<span class='label label-warning'>X</span> Die vorhandene PHP Version liegt unter der empfohlenen Version. Es kann dadurch zu Fehlern kommen!";
	} else {
		echo "<span class='label label-success'>√</span> Die PHP Version sollte passen.";
	}

?>
<h3>Schreibrechte auf Verzeichnise</h3>
<?php
	if (is_writable('../media/')) {
    	echo '<p><span class="label label-success">√</span> /media hat die korrekten Schreibrechte.</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> /media hat nicht die korrekten Schreibrechte.</p>';
	}

	if (is_writable('../media/profile')) {
    	echo '<p><span class="label label-success">√</span> /media/profile hat die korrekten Schreibrechte.';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> /media/profile hat nicht die korrekten Schreibrechte.</p>';
	}
	
	if (is_writable('../media/projects')) {
    	echo '<p><span class="label label-success">√</span> /media/projects hat die korrekten Schreibrechte.</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> /media/projects hat nicht die korrekten Schreibrechte.</p>';
	}
	
	if (is_writable('../media/taskfiles')) {
    	echo '<p><span class="label label-success">√</span> /media/taskfiles hat die korrekten Schreibrechte.</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> /media/taskfiles hat nicht die korrekten Schreibrechte.</p>';
	}
	
	if (is_writable('../tmp')) {
    	echo '<p><span class="label label-success">√</span> /tmp hat die korrekten Schreibrechte.</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> /tmp hat nicht die korrekten Schreibrechte.</p>';
	}
	
	if ($errors == 0) {
?>
<a href="index.php?step=3" class="btn btn-primary">Weiter</a>
<?php
} else {
?>
<div class="alert alert-warning" role="alert">
	<p>Bei Problemen mit den Schreibrechten prüfen Sie bitte folgende Verzeichnisse:</p>
	<ul>
	<li>/media</li>
	<li>/media/profile</li>
	<li>/media/projects</li>
	<li>/media/taskfiles</li>
	<li>/tmp</li>
	</ul>
	Hier müssen die Rechte auf 777 stehen.
</div>
<a href="index.php?step=2" class="btn btn-primary">aktualisieren / neu prüfen</a>
<?php
} 
?>