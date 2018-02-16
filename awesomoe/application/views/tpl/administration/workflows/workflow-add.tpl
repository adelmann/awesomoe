{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="WORKFLOW"} - {awmultilang ident="NEW"}
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
						<h3 class="box-title">{awmultilang ident="WORKFLOW"} {awmultilang ident="NEW"}</h3>
					</div>
					<form role="form" action="index.php" method="POST" id="modalform">
						<input type="hidden" name="cl" value="workflows">
						<input type="hidden" name="fnc" value="add">
						<input type="hidden" name="awid" value="-1">
						<div class="box-body">
							<div class="form-group">
								<label for="name">{awmultilang ident="NAME"}</label>
								<input type="text" placeholder="{awmultilang ident="NAME"}" id="name" class="form-control" name="awname" value="">
							</div>
						</div><!-- /.box-body -->

						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=workflows">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			
			
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}