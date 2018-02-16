{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="WORKFLOW"} - {awmultilang ident="EDIT"}
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content" id="workflowedit">
		<span class="btn btn-app" id="addWorkflowStep">
			<i class="fa fa-plus"></i> {awmultilang ident="NEWSTEP"}
		</span>
		<div class="row">
			<div class="col-md-12">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-th"></i>
						<h3 class="box-title">{awmultilang ident="WORKFLOW"} {awmultilang ident="EDIT"}</h3>
					</div>
					<form role="form" action="index.php" method="POST">
						<input type="hidden" name="cl" value="workflows">
						<input type="hidden" name="fnc" value="save">
						<input type="hidden" name="awid" value="{$oWorkflowID}">
						<div class="box-body">
                            <table class="table table-bordered" id="workflowsteps">
                                <tbody>
                                <tr>
                                  <th>Name</th>
                                  <th>Aktion</th>
                                </tr>
                                {assign var=workflowitemcount value=$oWorkflow|@count}
                                {foreach from=$oWorkflow item=workflowitem name=workflowitem}
									{if $workflowitem.awid == ''}
										{assign var=wfawid value='0'}
									{else}
										{assign var=wfawid value=$workflowitem.awid}
									{/if}
                                    <tr class="datas">
                                        <td>
                                            <input type="text" placeholder="{awmultilang ident="NAME"}" id="name" class="form-control" name="awname-{$wfawid}-sort{$smarty.foreach.workflowitem.iteration}" value="{$workflowitem.awname}">
                                        </td>
                                      <td>
                                        <div class="btn-group">
                                            {if $smarty.foreach.workflowitem.iteration != 1}
                                                <span class="btn btn-default btn-flat sortup"><i class="fa fa-arrow-up"></i></span>
                                            {/if}
                                            {if $smarty.foreach.workflowitem.iteration != $workflowitemcount}
                                                <span class="btn btn-default btn-flat sortdown"><i class="fa fa-arrow-down"></i></span>
                                            {/if}
                                          <span class="btn btn-default btn-flat delstep"><i class="fa fa-minus"></i></span>
                                        </div>
                                      </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
						</div>
						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=workflows">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			<form role="form" id="deleteworkflowitem" action="index.php" method="POST">
				<input type="hidden" name="cl" value="workflows">
				<input type="hidden" name="fnc" value="deletestep">
				<input type="hidden" name="awid" value="{$oWorkflowID}">
				<input type="hidden" name="delitem" value="">
				
			</form>
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}