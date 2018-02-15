{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="TASK"} {$aProject.awprefix} - {awmultilang ident="NEW"}
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
						<h3 class="box-title">{awmultilang ident="TASK"} {awmultilang ident="NEW"}</h3>
					</div>
					<form role="form" action="index.php" method="POST">
						<input type="hidden" name="cl" value="tasklist">
						<input type="hidden" name="fnc" value="save">
						<input type="hidden" name="awproject" value="{$aProject.awid}">
						<input type="hidden" name="project" value="{$aProject.awid}">
						<input type="hidden" name="awid" value="-1">
						<div class="box-body">
							<div class="form-group">
								<label for="awtitle">{awmultilang ident="NAME"}</label>
								<input type="text" placeholder="{awmultilang ident="NAME"}" id="awtitle" class="form-control" name="awtitle" value="">
							</div>
							<div class="form-group">
								<label for="awdescription">{awmultilang ident="DESCRIPTION"}</label>
								<textarea placeholder="" id="" rows="10"  name="awdescription" class="form-control texteditor"></textarea>
							</div>
							<div class="form-group">
								<label for="awestimate">{awmultilang ident="ESTIMATE"}</label>
								<input type="text" placeholder="0" id="awestimate" class="form-control" name="awestimate" value="">
							</div>
							<div class="form-group">
								<label for="awstart">{awmultilang ident="STARTDATE"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-calendar"></i>
									</div>
									<input type="text" id="awstart" placeholder="YYYY-MM-DD" class="form-control date" name="awstart" value="">
								</div><!-- /.input group -->
							</div><!-- /.form group -->
							<div class="form-group">
								<label for="awdeadline">{awmultilang ident="DEADLINE"}</label>
								<div class="input-group">
								  <div class="input-group-addon">
									<i class="fa fa-calendar"></i>
								  </div>
								  <input type="text" id="awdeadline" placeholder="YYYY-MM-DD" class="form-control date" name="awdeadline" value="">
								</div><!-- /.input group -->
							</div><!-- /.form group -->
                            {if $aActUser.awgroup == '1' || $aActUser.awgroup == '2'}
                                <div class="form-group">
                                    <label for="awworkflowpos">{awmultilang ident="WORKFLOWPOSITION"}</label><br>
                                    <select name="awworkflowpos" class="form-control">
                                        {foreach from=$aWorkflowSteps item=workflowitem }
                                            <option value="{$workflowitem.awid}">{$workflowitem.awname}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            {else}
                                <input type="hidden" name="awworkflowpos" value="1">
                            {/if}
							<div class="form-group">
								<label for="awprio">{awmultilang ident="TASKPRIO"}</label><br>
								<select name="awprio" class="form-control">
									{foreach from=$aPrio item=priority }
										<option value="{$priority.awid}">{$priority.awname}</option>
									{/foreach}
								</select>
							</div>
                            {if $aActUser.awgroup == '1' || $aActUser.awgroup == '2'}
                                <div class="form-group">
                                    <label for="awowner">{awmultilang ident="OWNER"}</label><br>

                                    <select name="awowner" class="form-control">
                                        <option value="0">{awmultilang ident="NOASSIGNEE"}</option>
                                        {foreach from=$oUser2Project item=aUser}
                                            <option value="{$aUser.awid}">{$oUser->getUserName($aUser.awid)}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            {else}
                                <input type="hidden" name="awowner" value="0">
                            {/if}
						</div><!-- /.box-body -->

						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=tasklist&project={$aProject.awid}">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			
			
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file="tpl/footer.tpl"}