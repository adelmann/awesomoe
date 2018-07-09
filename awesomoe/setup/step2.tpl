<h3>PHP Version</h3>

<h3><?php $this->translateContent('chmodRULES');?></h3>

	
<?php
if ($this->errors === 0) {
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

