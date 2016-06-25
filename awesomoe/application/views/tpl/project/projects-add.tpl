{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROJECTS"} - {awmultilang ident="NEW"}
			<small>Optional description</small>
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-th"></i>
						<h3 class="box-title">{awmultilang ident="PROJECTS"} {awmultilang ident="NEW"}</h3>
					</div>
					<form role="form" action="index.php" method="POST">
						<input type="hidden" name="cl" value="projects">
						<input type="hidden" name="fnc" value="save">
						<input type="hidden" name="awid" value="-1">
						<div class="box-body">
							<div class="form-group">
								<label for="name">{awmultilang ident="NAME"}</label>
								<input type="text" placeholder="{awmultilang ident="NAME"}" id="name" class="form-control" name="awname" value="">
							</div>
							<div class="form-group">
								<label for="prefix">{awmultilang ident="PREFIX"}</label>
								<input type="text" placeholder="{awmultilang ident="PREFIX"}" id="prefix" class="form-control" name="awprefix" value="">
							</div>
							<div class="form-group">
								<label for="url">{awmultilang ident="URL"}</label>
								<input type="text" placeholder="{awmultilang ident="URL"}" id="url" class="form-control" name="awurl" value="">
							</div>
							<div class="form-group">
								<label for="url">{awmultilang ident="DESCRIPTION"}</label>
								<textarea placeholder="{awmultilang ident="ENTER..."}" rows="3"  name="awdescription" class="form-control"></textarea>
							</div>
							
						</div><!-- /.box-body -->

						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=projects">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			
			
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}