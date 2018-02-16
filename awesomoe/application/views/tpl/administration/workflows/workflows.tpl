{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="WORKFLOWS"}
			<small>Optional description</small>
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		{if $aActUser.awgroup == '1'}
			<a class="btn btn-app" href="index.php?cl=workflows&fnc=add">
				<i class="fa fa-plus"></i> {awmultilang ident="NEWWORKFLOW"}
			</a>
		{/if}
		{if $aWorkflows|@count > 0}
			{foreach from=$aWorkflows item=workflow}
				<div class="row">
					<div class="col-md-12">
						<div class="box box-solid">
							<div class="box-header with-border">
								<h3 class="box-title"><a href="index.php?cl=workflows&fnc=edit&workflow={$workflow.awid}">{$workflow.awname}</a></h3>
								{if $aActUser.awgroup == '1'}
									<div class="box-tools pull-right">
										<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
										<div class="btn-group">
										  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
										  <ul role="menu" class="dropdown-menu">
											<li><a href="index.php?cl=workflows&fnc=edit&workflow={$workflow.awid}">{awmultilang ident="EDIT"}</a></li>
											{if $workflow.awid != '1'}<li><a href="index.php?cl=workflows&fnc=delete&workflow={$workflow.awid}" onClick="confirm('{awmultilang ident="DELETETHISPROJECT"}')">{awmultilang ident="DELETE"}</a></li>{/if}
										  </ul>
										</div>
									</div>
								{/if}
							</div>
						</div>
					</div>
					
				</div>
			{/foreach}
		{else}
			<div class="row">
				<div class="col-md-12">
					<div class="box box-solid">
						<div class="box-header with-border">
							<h3 class="box-title"></h3>
						</div>
						<div class="box-body">
							{awmultilang ident="NOWORKFLOWAVAILABLE"}
						</div>
					</div>
				</div>
			</div>
		{/if}
	
		
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}