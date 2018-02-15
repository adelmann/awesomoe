{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROJECTS"} - {awmultilang ident="EDIT"}
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-th"></i>
						<h3 class="box-title">{awmultilang ident="PROJECTS"} {awmultilang ident="EDIT"}</h3>
					</div>
					<form role="form" action="index.php" method="POST">
						<input type="hidden" name="cl" value="projects">
						<input type="hidden" name="fnc" value="save">
						<input type="hidden" name="awid" value="{$oProject.awid}">
						<div class="box-body">
							<div class="form-group">
								<label for="name">{awmultilang ident="NAME"}</label>
								<input type="text" placeholder="{awmultilang ident="NAME"}" id="name" class="form-control" name="awname" value="{$oProject.awname}">
							</div>
							<div class="form-group">
								<label for="prefix">{awmultilang ident="PREFIX"}</label>
								<input type="text" placeholder="{awmultilang ident="PREFIX"}" id="prefix" class="form-control" name="awprefix" value="{$oProject.awprefix}">
							</div>
							<div class="form-group">
								<label for="url">{awmultilang ident="URL"}</label>
								<input type="text" placeholder="{awmultilang ident="URL"}" id="url" class="form-control" name="awurl" value="{$oProject.awurl}">
							</div>
							<div class="form-group">
								<label for="url">{awmultilang ident="DESCRIPTION"}</label>
								<textarea placeholder="{awmultilang ident="ENTER..."}" rows="3"  name="awdescription" class="form-control">{$oProject.awdescription}</textarea>
							</div>
							<div class="form-group">
								<label for="url">{awmultilang ident="WORKFLOW"}</label>
								<select class="form-control" name="awworkflow">
									{foreach from=$oWorkflows2Project item=itemworkflow name=workflows}
										<option value="{$itemworkflow.awid}"{if $oProject.awworkflow == $itemworkflow.awid} selected="selected"{/if}>{$itemworkflow.awname}</option>
									{/foreach}
								</select>
							</div>
							{if $oUser2Project|@count > 0}
								<div class="form-group">
									<label for="leader">{awmultilang ident="LEADER"}</label>
									<select class="form-control" name="awleader">
										<option value="">{awmultilang ident="NOTSET"}</option>
										{foreach from=$oUser2Project item=itemuser name=User2Project}
											<option value="{$smarty.foreach.User2Project.iteration}"{if $oProject.awleader == $smarty.foreach.User2Project.iteration} selected="selected"{/if}>{$itemuser.awname} {$itemuser.awlastname}</option>
										{/foreach}
									</select>
								</div>
							{/if}
							
							{if $oUsersRel2Project|@count > 0}
								<div class="form-group">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<th style="width: 10px">{awmultilang ident="ON"}</th>
												<th style="width: 10px">{awmultilang ident="OF"}</th>
												<th>{awmultilang ident="NAME"}</th>
											</tr>
											{foreach from=$oUsersRel2Project item=aUser}
												<tr>
													<td><input type="radio" name="user-{$aUser.awid}" value="1" {if !empty({$aUser.awprojectid})}checked=""{/if}></td>
													<td><input type="radio" name="user-{$aUser.awid}" value="0" {if empty({$aUser.awprojectid})}checked=""{/if}></td>
													<td>
														{$aUser.awname} {$aUser.awlastname}
													</td>
												</tr>
											{/foreach}
										<tbody>
									</table>
								</div>
							{/if}
							
							
						</div><!-- /.box-body -->

						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=projects">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			<div class="col-md-6">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-th"></i>
						<h3 class="box-title">{awmultilang ident="PROJECTSAVATAR"} {awmultilang ident="EDIT"}</h3>
					</div>
					<form role="form" name="uploadAvatar" enctype="multipart/form-data" action="index.php" method="POST" >
						<input type="hidden" name="cl" value="projects">
						<input type="hidden" name="fnc" value="saveavatar">
						<input type="hidden" name="awid" value="{$oProject.awid}">
						<div class="box-body">
							<div class="form-group project">
								{if $oProject.awpicture}
									<a href="index.php?cl=tasklist&project={$oProject.awid}">
										<img class="img-circle" src="media/projects/{$oProject.awpicture}">
									</a>
								{elseif $oProject.awprefix}
									<a href="index.php?cl=tasklist&project={$oProject.awid}">
										<div class="img-circle">{$oProject.awprefix}</div>
									</a>
								{else}
									<a href="index.php?cl=tasklist&project={$oProject.awid}">
										<div class="img-circle">{$oProject.awname}</div>
									</a>
								{/if}
							</div>
							<div class="form-group">
								<label for="lastname">{awmultilang ident="UPLOADNEWAVATAR"}</label>
								<input class="btn btn-default" type="file" placeholder="{awmultilang ident="NEWAVATAR"}" name="uploadavatar" size="60" maxlength="255" >
							</div>
						</div><!-- /.box-body -->
						
						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="CHANGE"}</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}