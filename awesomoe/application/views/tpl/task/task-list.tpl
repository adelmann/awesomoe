{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROJECT"} - {$aProject.awname}
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">
							{awmultilang ident="PROJECTINFO"}
						</h3>
						{if $aActUser.awgroup == '1'}
							<div class="box-tools pull-right">
								<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
								<div class="btn-group">
								  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
								  <ul role="menu" class="dropdown-menu">
									<li><a href="index.php?cl=projects&fnc=edit&project={$aProject.awid}">{awmultilang ident="EDIT"}</a></li>
								  </ul>
								</div>
							</div>
						{/if}
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-sm-2">
								{if $aProject.awpicture}
										<img class="img-circle" src="media/projects/{$aProject.awpicture}">
								{elseif $aProject.awprefix}
										<div class="img-circle">{$aProject.awprefix}</div>
								{else}
										<div class="img-circle">{$aProject.awname}</div>
								{/if}
							</div>
							<div class="col-sm-6">
								{$aProject.awdescription|html_entity_decode}<br>
							</div>
							<div class="col-sm-4">
								{if $aProject.awleader}{awmultilang ident="LEADER"}: {$oUser->getUserName($aProject.awleader)}<br>{/if}
								{if $aProject.awurl}{awmultilang ident="URL"}: <a href="{$aProject.awurl}" target="_blank">{$aProject.awurl}</a><br>{/if}
								{if $oProject->countTasks($aProject.awid) > 0}{awmultilang ident="TASKS"}: {$oProject->countTasks($aProject.awid)}{/if}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

			<a class="btn btn-app" href="index.php?cl=tasklist&fnc=add&project={$aProject.awid}">
				<i class="fa fa-plus"></i> {awmultilang ident="NEWTASK"}
			</a>
			<a class="btn btn-app" href="index.php?cl=tasklist&project={$aProject.awid}&view=list">
				<i class="fa fa-bars"></i> {awmultilang ident="LISTVIEW"}
			</a>
			<a class="btn btn-app" href="index.php?cl=tasklist&project={$aProject.awid}&view=agile">
				<i class="fa fa-th-large"></i> {awmultilang ident="AGILEVIEW"}
			</a>
			<a class="btn btn-app" href="index.php?cl=tasklist&project={$aProject.awid}&view=archive">
				<i class="fa fa-file-archive-o"></i> {awmultilang ident="ARCHIVE"}
			</a>
			<a class="btn btn-app" href="index.php?cl=tasklist&project={$aProject.awid}&view=calendar">
				<i class="fa fa-calendar"></i> {awmultilang ident="CALENDAR"}
			</a>
			{if $aActUser.awgroup == '1'}
				<a class="btn btn-app" href="index.php?cl=report&project={$aProject.awid}">
					<i class="fa fa-calculator"></i> {awmultilang ident="REPORT"}
				</a>
			{/if}

		{if $aTasks|@count > 0}

			{if $bTasklistView == 'list' }
				{foreach from=$oWorkflows2Project item=workflow}
						<div class="box">
							<div class="box-header with-border">
							  <h3 class="box-title">{$workflow.awname}</h3>
							  <div class="box-tools pull-right">
								<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
							  </div><!-- /.box-tools -->
							</div><!-- /.box-header -->
							<div class="box-body" style="display: block;">
													
								{foreach from=$aTasks item=task}
									{if $task.awworkflowpos == $workflow.awid}
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
												<div class="box {$priocolor} box-solid">
													<div class="box-header with-border">
														{$aProject.awprefix}-{$task.awnumber}
														<h3 class="box-title"><a href="index.php?cl=tasklist&fnc=taskdetails&project={$aProject.awid}&task={$task.awid}">{$task.awtitle}</a></h3>
														
														{if $aActUser.awgroup == '1'}
															<div class="box-tools pull-right">
																<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
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
									{/if}
								{/foreach}
							</div><!-- /.box-body -->
					  </div>
					{/foreach}
			{elseif $bTasklistView == 'archive' }
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
							<div class="box {$priocolor} box-solid">
								<div class="box-header with-border">
									{$aProject.awprefix}-{$task.awnumber}
									<h3 class="box-title"><a href="index.php?cl=tasklist&fnc=taskdetails&project={$aProject.awid}&task={$task.awid}">{$task.awtitle}</a></h3>

									{if $aActUser.awgroup == '1'}
										<div class="box-tools pull-right">
											<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
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
			{elseif $bTasklistView == 'calendar' }
				<div class="row">
					<div class="col-md-12">
						<div class="workflowtitle">
							<h3>{awmultilang ident="CALENDAR"}</h3>
						</div>
						<div class="row">
							<div class="col-md-9">
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
														title: '`$aProject.awprefix` - `$task.awtitle`',
														start: '`$start|date_format:"%Y-%m-%d"`',
														end: '`$task.awdeadline|date_format:"%Y-%m-%d"`',
														backgroundColor: '`$priocolor`',
														borderColor: '`$priocolor`',
														url: 'index.php?cl=tasklist&fnc=taskdetails&project=`$aProject.awid`&task=`$task.awid`'
													},
												"}
											{/if}

										{/foreach}
									</div><!-- /.box-body -->
								</div>
							</div>
							<div class="col-md-3">
								<div class="box box-primary">
									<div class="box-header with-border">
										<h3>{awmultilang ident="LEGEND"} {awmultilang ident="PRIORITY"}</h3>
									</div>
									<div class="box-body">

										{foreach from=$aPrio item=priority }
											{if $priority.awcolor == 0}
												{assign var=priocolor value="default"}
											{elseif $priority.awcolor == 1}
												{assign var=priocolor value="primary"}
											{elseif $priority.awcolor == 2}
												{assign var=priocolor value="warning"}
											{elseif $priority.awcolor == 3}
												{assign var=priocolor value="danger"}
											{elseif $priority.awcolor == 4}
												{assign var=priocolor value="primary"}
											{else}
												{assign var=priocolor value="success"}
											{/if}

											<p><small class="label label-{$priocolor}"><i class="fa fa-signal"></i> {$priority.awname}</small></p>
										{/foreach}
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			{else}

				{assign var=workflowcount value=$oWorkflows2Project|@count}
				{if $workflowcount > 0 }
					{* iAgileType = 1 -> table View *}
					{if $iAgileType == 1}
						<div class="table-responsive">
							<table class="table">
								<thead>
								<tr>
									{foreach from=$oWorkflows2Project item=workflow}
										<td><h3 class="box-title">{$workflow.awname}</h3></td>
									{/foreach}
								</tr>
								</thead>
								<tr>
									{foreach from=$oWorkflows2Project item=workflow name="agileproject"}
										<td>
											{foreach from=$aTasks item=task}
												{if ($task.awworkflowpos == $smarty.foreach.agileproject.iteration) || ($task.awworkflowpos == 0 && $smarty.foreach.agileproject.iteration == 1)}
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
													<div class="box {$priocolor}">
														<div class="box-header with-border">
															<a href="index.php?cl=tasklist&fnc=taskdetails&project={$aProject.awid}&task={$task.awid}">
																{$aProject.awprefix}-{$task.awnumber}<br>
																{$task.awname}

															</a>
															<span class="pull-right image small">
															{if $oUser->getUserAvatar($task.awowner)}
																<img src="media/profile/{$oUser->getUserAvatar($task.awowner)}" class="img-circle" alt="{$oUser->getUserName($task.awowner)}">
															{elseif $task.awowner != '0'}
																<span class="noavatar">{$oUser->getUserInitial($task.awowner)}</span>
															{/if}
														</span>
														</div>
														<div class="box-body">
															<h4 class="box-title">{$task.awtitle}</h4>
														</div>
													</div>
												{/if}
											{/foreach}
										</td>
									{/foreach}
								</tr>
							</table>
						</div>

					{* iAgileType = 2 -> normal bootstrap Div Row *}
					{elseif $iAgileType == 2}
						<div class="row">
							{math equation="floor(x / y)" x=12 y=$workflowcount assign="gridsize"}
							{foreach from=$oWorkflows2Project item=workflow name="agileproject"}
								<div class="col-md-{$gridsize}">
									<div class="workflowtitle">
										<h3>{$workflow.awname}</h3>
									</div>
									<div class="row">
										<div class="col-md-12">
											{foreach from=$aTasks item=task}
												{if ($task.awworkflowpos == $smarty.foreach.agileproject.iteration) || ($task.awworkflowpos == 0 && $smarty.foreach.agileproject.iteration == 1)}
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
													<div class="box {$priocolor}">
														<div class="box-header with-border">
															<a href="index.php?cl=tasklist&fnc=taskdetails&project={$aProject.awid}&task={$task.awid}">
																{$aProject.awprefix}-{$task.awnumber}<br>
																{$task.awname}

															</a>
															<span class="pull-right image small">
															{if $oUser->getUserAvatar($task.awowner)}
																<img src="media/profile/{$oUser->getUserAvatar($task.awowner)}" class="img-circle" alt="{$oUser->getUserName($task.awowner)}">
															{elseif $task.awowner != '0'}
																<span class="noavatar">{$oUser->getUserInitial($task.awowner)}</span>
															{/if}
														</span>
														</div>
														<div class="box-body">
															<h4 class="box-title">{$task.awtitle}</h4>
														</div>
													</div>
												{/if}
											{/foreach}
										</div>
									</div>
								</div>
							{/foreach}
						</div>
					{/if}


					<div class="row"><hr></div>
					
				{/if}
			{/if}
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