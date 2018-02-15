{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROJECTS"}
			<small>Optional description</small>
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		{if $aActUser.awgroup == '1'}
			<a class="btn btn-app" href="index.php?cl=projects&fnc=add">
				<i class="fa fa-plus"></i> {awmultilang ident="NEWPROJECT"}
			</a>
		{/if}
		{if $aProjects|@count > 0}
			{foreach from=$aProjects item=project}
				<div class="row">
					<div class="col-md-12">
						<div class="box box-solid">
							<div class="box-header with-border">
								<h3 class="box-title"><a href="{$project.awprefix}">{$project.awname}</a></h3>
								{if $aActUser.awgroup == '1'}
									<div class="box-tools pull-right">
										<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
										<div class="btn-group">
										  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
										  <ul role="menu" class="dropdown-menu">
											<li><a href="index.php?cl=projects&fnc=edit&project={$project.awid}">{awmultilang ident="EDIT"}</a></li>
											<li><a href="index.php?cl=projects&fnc=delete&project={$project.awid}" onClick="confirm('{awmultilang ident="DELETETHISPROJECT"}')">{awmultilang ident="DELETE"}</a></li>
										  </ul>
										</div>
									</div>
								{/if}
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2 project">
										{if $project.awpicture}
											<a href="{$project.awprefix}">
												<img class="img-circle" src="media/projects/{$project.awpicture}">
											</a>
										{elseif $project.awprefix}
											<a href="{$project.awprefix}">
												<div class="img-circle">{$project.awprefix}</div>
											</a>
										{else}
											<a href="{$project.awprefix}">
												<div class="img-circle">{$project.awname}</div>
											</a>
										{/if}
									</div>
									<div class="col-sm-6">
										{if $project.awdescription != ''}
											{awmultilang ident="DESCRIPTION"}:<br>
											{$project.awdescription}
										{/if}
									</div>
									<div class="col-md-4">
									
										<div class="info-box">
											<span class="info-box-icon bg-yellow"><i class="fa fa-files-o"></i></span>
											<div class="info-box-content">
											  <span class="info-box-text">
												{if $project.awleader}{awmultilang ident="LEADER"}: {$oUser->getUserName($project.awleader)}<br>{/if}
												{if $project.awurl}{awmultilang ident="URL"}: <a href="{$project.awurl}" target="_blank">{$project.awurl}</a>{/if}
											  </span>
											  <span class="info-box-number">{awmultilang ident="TASKS"}: {$oProject->countTasks($project.awid)}</span>
											  
											</div><!-- /.info-box-content -->
										</div>
									</div>
								</div>
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
							{awmultilang ident="NOPROJECTAVAILABLE"}
						</div>
					</div>
				</div>
			</div>
		{/if}
	
		
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}