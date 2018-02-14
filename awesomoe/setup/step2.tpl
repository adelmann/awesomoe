<h3>PHP Version</h3>
<?php
	$errors = 0;

	if (version_compare(phpversion(), '5.6.16', '<')) {
    	$errors++;
    	echo "<span class='label label-warning'>X</span> ";
		$this->translateContent('PHP2LOW');
	} else {
		echo "<span class='label label-success'>√</span> ",
		$this->translateContent('PHPOKAY');
	}

?>
<h3><?php $this->translateContent('chmodRULES');?></h3>
<?php
	if (is_writable('../media/')) {
    	echo '<p><span class="label label-success">√</span> ';
		$this->translateContent('mediaCHMODOK');
		echo '</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> ';
		$this->translateContent('mediaCHMODNO');
		echo '</p>';
	}

	if (is_writable('../media/profile')) {
    	echo '<p><span class="label label-success">√</span> ';
		$this->translateContent('mediapCHMODOK');
		echo '</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> ';
		$this->translateContent('mediapCHMODNO');
		echo '</p>';
	}
	
	if (is_writable('../media/projects')) {
    	echo '<p><span class="label label-success">√</span> ';
		$this->translateContent('mediaproCHMODOK');
		echo '</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> ';
		$this->translateContent('mediaproCHMODNO');
		echo '</p>';
	}
	
	if (is_writable('../media/taskfiles')) {
    	echo '<p><span class="label label-success">√</span> ';
		$this->translateContent('mediatasCHMODOK');
		echo '</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> ';
		$this->translateContent('mediatasCHMODNO');
		echo '</p>';
	}
	
	if (is_writable('../tmp')) {
    	echo '<p><span class="label label-success">√</span> ';
		$this->translateContent('mediatmpCHMODOK');
		echo '</p>';
	} else {
		$errors++;
   	 	echo '<p><span class="label label-danger">X</span> ';
		$this->translateContent('mediatmpCHMODNO');
		echo '</p>';
	}
	
	if ($errors == 0) {
?>
<a href="index.php?step=3" class="btn btn-primary"><?php $this->translateContent('NEXT'); ?></a>
<?php
} else {
?>
<div class="alert alert-warning" role="alert">
	<?php $this->translateContent('HELPCHMODCONENT'); ?>

</div>
<a href="index.php?step=2" class="btn btn-primary"><?php $this->translateContent('HELPCHMODUPDATE'); ?></a>
<?php
} 
?>