{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="OVERTIMETASKS"}
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		{if $aTasks|@count > 0}
			{foreach from=$aTasks item=task}
				<div class="row">
					<div class="col-md-12">
						{if $task.awcolor == 0}
							{assign var=priocolor value="box-default"}
						{elseif $task.awcolor == 1}
							{assign var=priocolor value="box-success"}
						{elseif $task.awcolor == 2}
							{assign var=priocolor value="box-warning"}
						{elseif $task.awcolor == 3}
							{assign var=priocolor value="box-danger"}
						{elseif $task.awcolor == 4}
							{assign var=priocolor value="box-primary"}
						{else}
							{assign var=priocolor value="box-default"}
						{/if}
						<div class="box {$priocolor} box-solid {if $task.awcolor != 3 || $task.awcolor != 2}collapsed-box{/if}">
							<div class="box-header with-border">
							
								<h3 class="box-title"><a href="index.php?cl=tasklist&fnc=taskdetails&project={$task.awproject}&task={$task.awid}">{$task.awtitle}</a></h3>
								
								{if $aActUser.awgroup == '1'}
									<div class="box-tools pull-right">
										<button data-widget="collapse" class="btn btn-box-tool"><i class="fa {if $task.awcolor != 3 || $task.awcolor != 2}fa-plus{else}fa-minus{/if}"></i></button>
										<div class="btn-group">
										  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
										  <ul role="menu" class="dropdown-menu">
											<li><a href="index.php?cl=tasklist&fnc=edit&task={$aTask.awid}&project={$aProject.awid}">{awmultilang ident="EDIT"}</a></li>
											<li><a href="index.php?cl=tasklist&fnc=delete&project={$task.awid}" onClick="confirm('{awmultilang ident="DELETETHISPROJECT"}')">{awmultilang ident="DELETE"}</a></li>
										  </ul>
										</div>
									</div>
								{/if}
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-sm-12">
										<span class="pull-right">{$task.awname}</span>
										{awmultilang ident="DESCRIPTION"}<br>
										{$task.awdescription}
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
							{awmultilang ident="NOTASKSAVAILABLE"}
						</div>
					</div>
				</div>
			</div>
		{/if}
	
		
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}