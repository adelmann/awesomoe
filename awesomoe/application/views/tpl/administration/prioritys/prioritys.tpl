{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PRIORITYS"}
			<small>Optional description</small>
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		{if $aActUser.awgroup == '1'}
			<a class="btn btn-app" href="index.php?cl=prioritys&fnc=add">
				<i class="fa fa-plus"></i> {awmultilang ident="NEWPRIORITY"}
			</a>
		{/if}
		{if $aPrioritys|@count > 0}
			{foreach from=$aPrioritys item=priority}
				<div class="row">
					<div class="col-md-12">
						{if $priority.awcolor == 0}
							{assign var=priocolor value="box-default"}
						{elseif $priority.awcolor == 1}
							{assign var=priocolor value="box-success"}
						{elseif $priority.awcolor == 2}
							{assign var=priocolor value="box-warning"}
						{elseif $priority.awcolor == 3}
							{assign var=priocolor value="box-danger"}
						{elseif $priority.awcolor == 4}
							{assign var=priocolor value="box-primary"}
						{else}
							{assign var=priocolor value="box-default"}
						{/if}
						<div class="box {$priocolor}">
							<div class="box-header with-border">
								<h3 class="box-title"><a href="index.php?cl=prioritys&fnc=edit&priority={$priority.awid}">{$priority.awname}</a></h3>
								{if $aActUser.awgroup == '1'}
									<div class="box-tools pull-right">
										<div class="btn-group">
										  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
										  <ul role="menu" class="dropdown-menu">
											<li><a href="index.php?cl=prioritys&fnc=edit&priority={$priority.awid}">{awmultilang ident="EDIT"}</a></li>
											<li><a href="index.php?cl=prioritys&fnc=delete&priority={$priority.awid}" onClick="confirm('{awmultilang ident="DELETETHISPROJECT"}')">{awmultilang ident="DELETE"}</a></li>
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
							{awmultilang ident="NOPRIORITYSAVAILABLE"}
						</div>
					</div>
				</div>
			</div>
		{/if}
	
		
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}