{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROFILE"} - {awmultilang ident="EDITAVATAR"}
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
						<i class="fa fa-user"></i>
						<h3 class="box-title">{awmultilang ident="PROFILE"} {awmultilang ident="EDITAVATAR"}</h3>
					</div>
					<form role="form" name="uploadAvatar" enctype="multipart/form-data" action="index.php" method="POST" >
						<input type="hidden" name="cl" value="profile">
						<input type="hidden" name="fnc" value="saveavatar">
						<input type="hidden" name="awid" value="{$aActUser.awid}">
						<div class="box-body">
							<div class="form-group">
								{if $oUser->getUserAvatar($aActUser.awid)}
									<img src="{$mediadir}/profile/{$oUser->getUserAvatar($aActUser.awid)}" class="img-circle" alt="User Image" />
								{else}
									{awmultilang ident="NOVATAR"}
								{/if}
							</div>
							<div class="form-group">
								<label for="lastname">{awmultilang ident="UPLOADNEWAVATAR"}</label>
								<input class="btn btn-default" type="file" placeholder="{awmultilang ident="NEWAVATAR"}" name="uploadavatar" size="60" maxlength="255" >
							</div>
						</div><!-- /.box-body -->
						
						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=profile">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			
			
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}