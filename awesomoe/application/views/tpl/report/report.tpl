{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <input type="hidden" id="projectid" name="project" value="{$aProject.awid}">
    <section class="content-header">
        <h1>
            {awmultilang ident="PROJECT"} {awmultilang ident="REPORTS"}- <a href="index.php?cl=tasklist&project={$aProject.awid}">{$aProject.awname}</a>
        </h1>
        {include file="tpl/breadcrumb.tpl"}
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            {awmultilang ident="REPORT"}
                        </h3>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p>{awmultilang ident="REPORTDESCRIPTION"}</p><br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs pull-right">
                                        {assign var=countReports value=$oReportsCount+1}
                                        {if !empty($oReports)}
                                            {foreach from=$oReports item=report}
                                                <li {if !empty($iAwid)}{if $iAwid == $report.awid}class="active"{/if}{/if} id="open{$report.awid}"><a data-toggle="tab" href="#tab_{$countReports}-{$countReports}" aria-expanded="true">{$report.awname}</a></li>
                                                {assign var=countReports value=$countReports-1}
                                            {/foreach}
                                        {/if}
                                        <li {if empty($iAwid)}class="active"{/if}><a data-toggle="tab" href="#tab_1-1" aria-expanded="false">{awmultilang ident="NEW"}</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="tab_1-1" class="tab-pane {if empty($iAwid)}active{/if}">
                                            <form role="form" action="index.php" method="POST">
                                                <input type="hidden" name="cl" value="report">
                                                <input type="hidden" name="fnc" value="save">
                                                <input type="hidden" name="awproject" value="{$aProject.awid}">
                                                <input type="hidden" name="awid" value="-1">
                                                <div class="form-group">
                                                    <label for="awbegins">{awmultilang ident="BEGINFROM"}</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <input type="text" id="awbegins" placeholder="YYYY-MM-DD" class="form-control datealltime" name="awbegins" value="{if !empty($aTask.awdeadline)}{$aTask.awdeadline}{/if}">
                                                    </div><!-- /.input group -->
                                                </div><!-- /.form group -->
                                                <div class="form-group">
                                                    <label for="awends">{awmultilang ident="ENDTO"}</label>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <input type="text" id="awends" placeholder="YYYY-MM-DD" class="form-control datealltime" name="awends" value="{if !empty($aTask.awdeadline)}{$aTask.awdeadline}{/if}">
                                                    </div><!-- /.input group -->
                                                </div><!-- /.form group -->

                                                <div class="form-group">
                                                    <label for="awstates">{awmultilang ident="STATES"}</label>
                                                    <select name="awstates[]" class="form-control multiselect" multiple="multiple" data-placeholder="{awmultilang ident="SELECTSTATES"}" style="width: 100%;">
                                                        {foreach from=$oWorkflows2Project item=workflowitem }
                                                            <option value="{$workflowitem.awid}">{$workflowitem.awname}</option>
                                                        {/foreach}
                                                        <option value="archive">{awmultilang ident="ARCHIVE"}</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="awusers">{awmultilang ident="USERS"}</label><br>
                                                    <select name="awusers[]" class="form-control multiselect" multiple="multiple" data-placeholder="{awmultilang ident="SELECTUSERS"}" style="width: 100%;">
                                                        <option value="ALL">{awmultilang ident="ALLUSERS"}</option>
                                                        {foreach from=$oUser2Project item=users }
                                                            <option value="{$users.awid}">{$users.awname} {$users.awlastname}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <div class="input-group-btn">
                                                                    <input type="submit" class="btn btn-primary" value="{awmultilang ident="SAVEAS"}">
                                                                </div><!-- /btn-group -->
                                                                <input type="text" class="form-control" data-cip-id="cIPJQ342845655" placeholder="{awmultilang ident="NEWREPORT"}" name="awname">

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div><!-- /.tab-pane -->
                                        {assign var=countReports value=$oReportsCount+1}
                                        {foreach from=$oReports item=report}
                                            <div id="tab_{$countReports}-{$countReports}" class="tab-pane{if !empty($iAwid)}{if $iAwid == $report.awid} active{/if}{/if}">
                                                <form role="form" action="index.php" method="POST">
                                                    <input type="hidden" name="cl" value="report">
                                                    <input type="hidden" name="fnc" class="fnc" value="save">
                                                    <input type="hidden" name="awproject" value="{$aProject.awid}">
                                                    <input type="hidden" name="awid" value="{$report.awid}">
                                                    <div class="form-group">
                                                        <label for="awbegins">{awmultilang ident="BEGINFROM"}</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon">
                                                                <i class="fa fa-calendar"></i>
                                                            </div>
                                                            <input type="text" id="awbegins" placeholder="YYYY-MM-DD" class="form-control datealltime" name="awbegins" value="{if !empty($report.awbegins)}{$report.awbegins}{/if}">
                                                        </div><!-- /.input group -->
                                                    </div><!-- /.form group -->
                                                    <div class="form-group">
                                                        <label for="awends">{awmultilang ident="ENDTO"}</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon">
                                                                <i class="fa fa-calendar"></i>
                                                            </div>
                                                            <input type="text" id="awends" placeholder="YYYY-MM-DD" class="form-control datealltime" name="awends" value="{if $report.awends}{$report.awends}{/if}">
                                                        </div><!-- /.input group -->
                                                    </div><!-- /.form group -->

                                                    <div class="form-group">
                                                        {assign var=aActStates value=","|explode:$report.awstates}
                                                        <label for="awstates">{awmultilang ident="STATES"}</label>
                                                        <select name="awstates[]" class="form-control multiselect" multiple="multiple" data-placeholder="{awmultilang ident="SELECTSTATES"}" style="width: 100%;">
                                                            {foreach from=$oWorkflows2Project item=workflowitem }
                                                                <option value="{$workflowitem.awid}"{if in_array($workflowitem.awid, $aActStates)} selected="selected"{/if}>{$workflowitem.awname}</option>
                                                            {/foreach}
                                                            <option value="archive"{if in_array('archive', $aActStates)} selected="selected"{/if}>{awmultilang ident="ARCHIVE"}</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group"></select>
                                                        {assign var=aActUsers value=","|explode:$report.awusers}
                                                        <label for="awusers">{awmultilang ident="USERS"}</label><br>
                                                        <select name="awusers[]" class="form-control multiselect" multiple="multiple" data-placeholder="{awmultilang ident="SELECTUSERS"}" style="width: 100%;">
                                                            <option value="ALL"{if in_array('ALL', $aActUsers)} selected="selected"{/if}>{awmultilang ident="ALLUSERS"}</option>
                                                            {foreach from=$oUser2Project item=users }
                                                                <option value="{$users.awid}"{if in_array($users.awid, $aActUsers)} selected="selected"{/if}>{$users.awname} {$users.awlastname}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <div class="input-group">
                                                                    <div class="input-group-btn">
                                                                        <input type="submit" class="btn btn-default" value="{awmultilang ident="SAVEAS"}">
                                                                    </div><!-- /btn-group -->
                                                                    <input type="text" class="form-control" data-cip-id="cIPJQ342845655" placeholder="{awmultilang ident="NEWREPORT"}" name="awname" value="{$report.awname}">

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <input type="submit" class="btn btn-primary" id="generateReport" value="{awmultilang ident="GENERATEREPORT"}">
                                                        </div>
                                                    </div>
                                                </form>
                                                <form role="form" action="index.php" method="POST">
                                                    <input type="hidden" name="cl" value="report">
                                                    <input type="hidden" name="fnc" value="delete">
                                                    <input type="hidden" name="awproject" value="{$aProject.awid}">
                                                    <input type="hidden" name="awid" value="{$report.awid}">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <input type="submit" class="btn btn-default" value="{awmultilang ident="DELETE"}">
                                                        </div>
                                                    </div>
                                                </form>
                                            </div><!-- /.tab-pane -->
                                            {assign var=countReports value=$countReports-1}
                                        {/foreach}
                                    </div><!-- /.tab-content -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file="tpl/footer.tpl"}