{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <input type="hidden" id="projectid" name="project" value="{$aProject.awid}">
    <section class="content-header">
        <h1>
            <a href="index.php?cl=tasklist&project={$iProject}">{awmultilang ident="PROJECT"}</a> - <a href="index.php?cl=report&project={$iProject}&awid={$iAwid}">{awmultilang ident="REPORT"}</a> - {$aReportName}
        </h1>
        {include file="tpl/breadcrumb.tpl"}
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">{awmultilang ident="TIMEBOOKINGS"}</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body table-responsive no-padding">
                    	<div id="accordion" class="box-group">
                    	<table class="table">
                            	<th>{awmultilang ident="TITLE"}</th>
                                	<th>{awmultilang ident="WORKFLOWPOS"}</th>
                                	<th>{awmultilang ident="BOOKEDTIME"}</th>
                                	<th>{awmultilang ident="DATE"}</th>
                                	<th>{awmultilang ident="BOOKINUSER"}</th>
                            	</tr>     
                    		{foreach from=$aReport item=reportitem name="reportiteration"}
                            				<tr>
                                				<td><a class="collapsed" aria-expanded="false" data-toggle="collapse" data-parent="#accordion" href="#step-{$smarty.foreach.reportiteration.iteration}">{$reportitem.awtitle}</a></td>
                                				<td>
                                    				{if $reportitem.workflowpos == ''}
                                        				{awmultilang ident="ARCHIVE"}
                                    				{else}
                                        				{$reportitem.workflowpos}
                                    				{/if}
                                				</td>
                                				<td>{$reportitem.awtime}</td>
                                				<td>{$reportitem.awdate}</td>
                                				<td>{$reportitem.awname} {$reportitem.awlastname}</td>
                            				</tr>
                            				<tr>
                            					<td colspan="5" class="panel-collapse collapse" id="step-{$smarty.foreach.reportiteration.iteration}" aria-expanded="false" style="height: 0px;">
	                            					{$reportitem.awdesc}
                            					</td>
                            				</tr>
                            {/foreach}
                            </table>	
                        </div> 
                    		
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>
        <div class="row">
        	<div class="col-md-12">
        		<div class="box">
                    <div class="box-header">
                        <h3 class="box-title">{awmultilang ident="TIMEBOOKINGSALL"}</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body table-responsive">
        				<b>{awmultilang ident="BOOKEDHOURSANDMINUTES"}: {$sWorkedTime}</b>
        			</div>
        		</div>
       		</div>
        </div>
    </section>
</div><!-- /.content-wrapper -->

{include file="tpl/footer.tpl"}