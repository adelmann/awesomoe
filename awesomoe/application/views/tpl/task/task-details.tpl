{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<input type="hidden" id="projectid" name="project" value="{$aProject.awid}">
	<input type="hidden" id="taskid" name="task" value="{$aTask.awid}">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROJECT"} - <a href="index.php?cl=tasklist&project={$aProject.awid}">{$aProject.awname}</a>
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		{if $aTask.awworkflowpos != 99 }
			{if $aActUser.awgroup == '1'  || $aActUser.awgroup == '2'}
				<a class="btn btn-app" href="index.php?cl=tasklist&fnc=edit&task={$aTask.awid}&project={$aProject.awid}">
					<i class="fa fa-edit"></i> {awmultilang ident="EDIT"}
				</a>
			{/if}
			<span class="btn btn-app" id="addcomment">
			<i class="fa fa-comment"></i> {awmultilang ident="COMMENT"}
		</span>
			{if $aActUser.awgroup == '1'  || $aActUser.awgroup == '2'}
				<span class="btn btn-app" id="assigntask">
                <i class="fa fa-th-large"></i> {awmultilang ident="ASSIGN"}
            </span>
				<span class="btn btn-app" id="logtime">
                <i class="fa fa-th-large"></i> {awmultilang ident="LOG"}
            </span>
			{/if}
		{/if}
		<span class="btn btn-app" id="changeState">
			<i class="fa fa-th-large"></i> {awmultilang ident="CHANGESTATE"}
		</span>
		{if ($aActUser.awgroup == '1'  || $aActUser.awgroup == '2')  && $iMaxSteps == $aTask.awworkflowpos}
			<span class="btn btn-app" id="archiveTask">
                <i class="fa fa-check"></i> {awmultilang ident="ARCHIVE"}
            </span>
		{/if}
		<div class="row">
			<div class="col-md-12">
				{if $aTask.awcolor == 0}
					{assign var=priocolor value="box-default"}
				{elseif $aTask.awcolor == 1}
					{assign var=priocolor value="box-success"}
				{elseif $aTask.awcolor == 2}
					{assign var=priocolor value="box-warning"}
				{elseif $aTask.awcolor == 3}
					{assign var=priocolor value="box-danger"}
				{elseif $aTask.awcolor == 4}
					{assign var=priocolor value="box-primary"}
				{else}
					{assign var=priocolor value="box-default"}
				{/if}
				<div class="box {$priocolor}">
					<div class="box-header with-border">
						<h3 class="box-title">
							{awmultilang ident="TASKINFO"} - {$aProject.awprefix}-{$aTask.awnumber}
						</h3>
						{if $aActUser.awgroup == '1'}
							<div class="box-tools pull-right">
								<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
								<div class="btn-group">
								  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
								  <ul role="menu" class="dropdown-menu">
									<li><a href="index.php?cl=tasklist&fnc=edit&task={$aTask.awid}&project={$aProject.awid}">{awmultilang ident="EDIT"}</a></li>
									<li><a href="index.php?cl=tasklist&fnc=delete&task={$aTask.awid}&project={$aProject.awid}">{awmultilang ident="DELETETHISTASK"}</a></li>
								  </ul>
								</div>
							</div>
						{/if}
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-sm-8">
								<h4>{$aTask.awtitle}</h4>
								<p>{awmultilang ident="DESCRIPTION"}:</p>
								{$aTask.awdescription|unescape:'html'}
							</div>
							<div class="col-sm-4">
								{if $aTask.awprio}{awmultilang ident="PRIORITY"}: {$aTask.awname}<br>{/if}
								{if $aTask.awowner}{awmultilang ident="CREATOR"}: {$oUser->getUserName($aTask.awcreator)}<br>{/if}
								{if $aTask.awowner}{awmultilang ident="ASSIGNEE"}: {$oUser->getUserName($aTask.awowner)}<br>{/if}
								{if $aTask.awstart != '0000-00-00'}{awmultilang ident="STARTDATE"}: {$aTask.awstart|date_format:"%A, %B %e, %Y"}<br>{/if}
								{if $aTask.awdeadline != '0000-00-00'}{awmultilang ident="DEADLINE"}: {$aTask.awdeadline|date_format:"%A, %B %e, %Y"}<br>{/if}
								{if $aTask.awcreate != '0000-00-00 00:00:00'}{awmultilang ident="CREATE"}: {$aTask.awcreate|date_format:"%A, %B %e, %Y - %H:%M:%S"}<br>{/if}
								{if $aTask.awupdate != '0000-00-00 00:00:00'}{awmultilang ident="UPDATED"}: {$aTask.awupdate|date_format:"%A, %B %e, %Y - %H:%M:%S"}<br>{/if}
								{if  $aTask.awestimate|strtotime > $sWorkedTime|strtotime}{$sRemainingtime} {awmultilang ident="HOURSTOEND"}<br>{/if}
								{if $aTask.awestimate}{awmultilang ident="ESTIMATE"}: {$aTask.awestimate}<br>{/if}
								{awmultilang ident="WORKED"}: {$sWorkedTime}<br>
								{awmultilang ident="WORKFLOWPOSITION"}:
								{foreach from=$aWorkflowSteps item=workflowitem }
									{if $workflowitem.awsort == $aTask.awworkflowpos}{$workflowitem.awname}{/if}
								{/foreach}
								{if $aTask.awworkflowpos == 99}{awmultilang ident="ARCHIVE"}{/if}
								<br>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="box box-default">
					<div class="box-header with-border">
						<h3 class="box-title">
							{awmultilang ident="TASKMEDIA"}
						</h3>
						<div class="box-tools pull-right">
							<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<form action="index.php" method="POST" enctype="multipart/form-data" class="uploadform">
									<span class="btn btn-default btn-file" id="addfile">
										<i class="fa fa-plus"></i> 
										{awmultilang ident="ADDFILE"}
										<input name="files" type="file" multiple="multiple" class="" id="upload-files" />
									</span>
									<div class="progress-group ninja">
										<span class="progress-text">{awmultilang ident="UPLOADSFILE"}</span>
										<span class="progress-number"></span>
										<div class="progress sm">
											<div class="progress-bar progress-bar-aqua" style="width: 0%"></div>
										</div>
									</div>
								</form>
								{if $sMediaList}
									<hr>
									<div class="box-body">
									{foreach from=$sMediaList item=media }
										<div class="row">
											<div class="col-sm-12">
												{if $aActUser.awgroup == '1'}<span class="pull-right"><a href="index.php?cl=tasklist&fnc=deletemedia&task={$aTask.awid}&project={$aProject.awid}&fileid={$media.awid}">{awmultilang ident="DELETE"}</a></span>{/if}
												<a href="media/taskfiles/{$media.awnewfilename}" title="{$media.awfilename}" target="_blank">{$media.awfilename}</a>
												<hr>
											</div>
										</div>
									{/foreach}
									</div>
								{else}
									{awmultilang ident="NOMEDIAADDED"}
								{/if}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs pull-right">
					  <li class="" id="openhistory"><a data-toggle="tab" href="#tab_4-4" aria-expanded="true">{awmultilang ident="HISTORY"}</a></li>
					  <li class="" id="openComments"><a data-toggle="tab" href="#tab_3-3" aria-expanded="true">{awmultilang ident="COMMENTS"}</a></li>
					  <li class="" id="openWorklog"><a data-toggle="tab" href="#tab_2-2" aria-expanded="true">{awmultilang ident="WORKLOG"}</a></li>
					  <li class="active"><a data-toggle="tab" href="#tab_1-1" aria-expanded="false">{awmultilang ident="ALL"}</a></li>
					  
					  <li class="pull-left header"><i class="fa fa-th"></i> {awmultilang ident="ACTIVITYS"}</li>
					</ul>
					<div class="tab-content">
						<div id="tab_1-1" class="tab-pane active">
							{foreach from=$oAllActivitys item=activity}
								{if !empty($activity.awfield)}
									<div class="row">
										<div class="col-sm-12">
											{if $oUser->getUserAvatar($activity.awuser)}
												<img src="media/profile/{$oUser->getUserAvatar($activity.awuser)}" class="img-circle user-image-small" alt="{$oUser->getUserName($activity.awuser)}">
												{$oUser->getUserName($activity.awuser)}
											{/if}
											{awmultilang ident="MADECHANGES"} {$activity.awdate}
										</div>
									</div>
									<div class="row">
										<div class="col-sm-2"><b>{awmultilang ident="FIELD"}</b></div>
										<div class="col-sm-5"><b>{awmultilang ident="ORIGINALVALUE"}</b></div>
										<div class="col-sm-5"><b>{awmultilang ident="NEWVALUE"}</b></div>
									</div>
									<div class="row">
										<div class="col-sm-2">
											{if $activity.awfield == 'awworkflowpos'}
												{awmultilang ident="WORKFLOWPOSITION"}
											{elseif $activity.awfield == 'awtitle'}
												{awmultilang ident="TITLE"}
											{elseif $activity.awfield == 'awdescription'}
												{awmultilang ident="DESCRIPTION"}
											{elseif $activity.awfield == 'awestimate'}
												{awmultilang ident="ESTIMATE"}
											{elseif $activity.awfield == 'awdeadline'}
												{awmultilang ident="DEADLINE"}
											{elseif $activity.awfield == 'awowner'}
												{awmultilang ident="OWNER"}
											{else}
												{awmultilang ident=$activity.awfield|upper}
											{/if}
										</div>
										<div class="col-sm-5">
											{if $activity.awfield == 'awworkflowpos'}
												{foreach from=$aWorkflowSteps item=workflowitem }
													{if $workflowitem.awid == $activity.awpreval}{$workflowitem.awname}{/if}
												{/foreach}
											{elseif $activity.awfield == 'awowner'}
												{if $oUser->getUserAvatar($activity.awpreval)}
													<img src="media/profile/{$oUser->getUserAvatar($activity.awpreval)}" class="img-circle user-image-small" alt="{$oUser->getUserName($activity.awpreval)}">
												{/if}
												{$oUser->getUserName($activity.awpreval)}
											{else}
												{$activity.awpreval}
											{/if}


										</div>
										<div class="col-sm-5">
											{if $activity.awfield == 'awworkflowpos'}
												{foreach from=$aWorkflowSteps item=workflowitem }
													{if $workflowitem.awid == $activity.awafterval}{$workflowitem.awname}{/if}
												{/foreach}
											{elseif $activity.awfield == 'awowner'}
												{if $oUser->getUserAvatar($activity.awafterval)}
													<img src="media/profile/{$oUser->getUserAvatar($activity.awafterval)}" class="img-circle user-image-small" alt="{$oUser->getUserName($activity.awafterval)}">
												{/if}
												{$oUser->getUserName($activity.awafterval)}
											{else}
												{$activity.awafterval}
											{/if}
										</div>
										<div class="col-sm-12">
											<hr>
										</div>
									</div>
								{/if}
								{if !empty($activity.awworklogdesc)}
									<div class="row">
										<div class="col-sm-12">
											{if $oUser->getUserAvatar($activity.awuser)}
												<img src="media/profile/{$oUser->getUserAvatar($activity.awuser)}" class="img-circle user-image-small" alt="{$oUser->getUserName($activity.awuser)}">
												{$oUser->getUserName($activity.awuser)}
											{/if}
											{awmultilang ident="LOGGEDWORK"} {$activity.awdate}
										</div>
									</div>
									<div class="row">
										<div class="col-sm-2">
											{awmultilang ident="TIMESPENT"}
										</div>
										<div class="col-sm-10">
											{$activity.awtime}<br>
											{$activity.awworklogdesc}
										</div>
										<div class="col-sm-12">
											<hr>
										</div>
									</div>
								{/if}
								{if !empty($activity.awcommentsdesc)}
									<div class="row">
										<div class="col-sm-12">
											{if $oUser->getUserAvatar($activity.awuser)}
												<img src="media/profile/{$oUser->getUserAvatar($activity.awuser)}" class="img-circle user-image-small" alt="{$oUser->getUserName($activity.awuser)}">
												{$oUser->getUserName($activity.awuser)}
											{else}
												{$oUser->getUserName($activity.awuser)}
											{/if}
											{awmultilang ident="COMMENT"} {$activity.awdate}
										</div>
									</div>
									<div class="row">
										<div class="col-sm-10">
											{$activity.awcommentsdesc}
										</div>
										<div class="col-sm-12">
											<hr>
										</div>
									</div>
								{/if}
								{*


								*}
							{/foreach}
						</div><!-- /.tab-pane -->
						<div id="tab_2-2" class="tab-pane">
						</div><!-- /.tab-pane -->
						<div id="tab_3-3" class="tab-pane">
						</div><!-- /.tab-pane -->
						<div id="tab_4-4" class="tab-pane">

						</div><!-- /.tab-pane -->
					</div><!-- /.tab-content -->
				</div>
		  	</div>
	  	</div>
		
		
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file="tpl/modal/modal-timelog.tpl" project=$aProject.awid task=$aTask.awid}
{include file="tpl/modal/modal-changeState.tpl" project=$aProject.awid task=$aTask.awid}
{include file="tpl/modal/modal-assign.tpl" project=$aProject.awid task=$aTask.awid}
{include file="tpl/modal/modal-comment.tpl" project=$aProject.awid task=$aTask.awid}

{include file="tpl/footer.tpl"}