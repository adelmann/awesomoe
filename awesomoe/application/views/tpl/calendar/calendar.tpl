{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="CALENDAR"}
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	
	<section class="content">
		<div class="row">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-12">
								<div class="box box-primary">
									<div class="box-body no-padding">
										<!-- THE CALENDAR -->
										<div id="calendar"></div>
										{assign var=calendatentrys value=""}
										{foreach from=$aTasks item=task}
											{if $task.awcolor == 0}
												{assign var=priocolor value="#d2d6de"}
											{elseif $task.awcolor == 1}
												{assign var=priocolor value="#00a65a"}
											{elseif $task.awcolor == 2}
												{assign var=priocolor value="#f39c12"}
											{elseif $task.awcolor == 3}
												{assign var=priocolor value="#dd4b39"}
											{elseif $task.awcolor == 4}
												{assign var=priocolor value="#3c8dbc"}
											{else}
												{assign var=priocolor value="#d2d6de"}
											{/if}

											{if $task.awstart != '0000-00-00' && $task.awstart != ''}
												{assign var=start value=$task.awstart}
											{else}
												{assign var=start value=$task.awcreate}
											{/if}
											{if $task.awdeadline != '0000-00-00' && $task.awdeadline != '' && $start != '0000-00-00' && $start !='' && $start != '0000-00-00 00:00:00'}
												{assign var=calendatentrys value="`$calendatentrys`
													{
														title: '`$task.projectname` - `$task.awtitle`',
														start: '`$start|date_format:"%Y-%m-%d"`',
														end: '`$task.awdeadline|date_format:"%Y-%m-%d"`',
														backgroundColor: '`$priocolor`',
														borderColor: '`$priocolor`',
														url: 'index.php?cl=tasklist&fnc=taskdetails&project=`$task.awproject`&task=`$task.awid`'
													},
												"}
											{/if}

										{/foreach}
									</div><!-- /.box-body -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
	
	
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}