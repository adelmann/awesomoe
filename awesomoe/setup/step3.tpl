<?php
	if ($this->dberror) {
?>
	<div class="alert alert-warning" role="alert">
		<p>Es konnte keine Verbindung zur Datenbank hergestellt werden!</p>
		<p>Fehler:</p>
		<p>
<?php
	echo $dberror; 
?>
		</p>
	</div>

<?php
	}
?>

<form action="index.php" name="dbconn" method="GET">
<div class="form-group">
	<label for="dbhost">DB Server</label>
	<input type="text" name="dbhost" class="form-control" id="basic-url" aria-describedby="basic-addon3">
</div>
<div class="form-group">
	<label for="dbname">DB Name</label>
	<input type="text" name="dbname" class="form-control" id="basic-url" aria-describedby="basic-addon3">
</div>
<div class="form-group">
	<label for="dbuser">DB User</label>
	<input type="text" name="dbuser" class="form-control" id="basic-url" aria-describedby="basic-addon3">
</div>
<div class="form-group">
	<label for="dbpwd">DB PWD</label>
	<input type="password" name="dbpwd" class="form-control" id="basic-url" aria-describedby="basic-addon3">
</div>
<input type="hidden" name="step" value="4">
<input type="submit" class="btn btn-primary" value="Zugang prüfen und weiter"/>
</form>
