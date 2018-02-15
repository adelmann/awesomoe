{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			Dashboard
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	
	<!-- Main content -->
	<section class="content">
		<div class="row">
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-aqua">
                <div class="inner">
                  <h3>{$startinfos.starting}</h3>
                  <p>{awmultilang ident="NEWTASKS"}</p>
                </div>
                <div class="icon">
                  <i class="fa fa-fw fa-plus-circle"></i>
                </div>
                {*<a href="#" class="small-box-footer">{awmultilang ident="SHOW"} <i class="fa fa-arrow-circle-right"></i></a>*}
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-green">
                <div class="inner">
                  <h3>{$startinfos.solved}</h3>
                  <p>{awmultilang ident="SOLVEDTASKS"}</p>
                </div>
                <div class="icon">
                  <i class="fa fa-check"></i>
                </div>
                {*<a href="#" class="small-box-footer">{awmultilang ident="SHOW"} <i class="fa fa-arrow-circle-right"></i></a>*}
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-yellow">
                <div class="inner">
                  <h3>{$startinfos.endtime}</h3>
                  <p>{awmultilang ident="INTHEENDTIME"}</p>
                </div>
                <div class="icon">
                  <i class="fa fa-fw fa-battery-1"></i>
                </div>
                {*<a href="#" class="small-box-footer">{awmultilang ident="SHOW"} <i class="fa fa-arrow-circle-right"></i></a>*}
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-red">
                <div class="inner">
                  <h3>{$startinfos.overtime}</h3>
                  <p>{awmultilang ident="OVERTIME"}</p>
                </div>
                <div class="icon">
                  <i class="fa fa-fw fa-battery-empty"></i>
                </div>
                <a href="index.php?cl=tasklist&fnc=overtime" class="small-box-footer">{awmultilang ident="SHOW"} <i class="fa fa-arrow-circle-right"></i></a>
              </div>
            </div><!-- ./col -->
          </div><!-- /.row -->
			<div class="row">
				<section class="col-lg-7 connectedSortable">
                    <div class="box box-primary">
                    <div class="box-header">
                      <i class="ion ion-clipboard"></i>
                      <h3 class="box-title">To Do List</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body">
                      <ul class="todo-list">
                          {foreach from=$myLastTasks item=task}
                              <li>
                              {if $task.awcolor == 0}
                                  {assign var=priocolor value="label-default"}
                              {elseif $task.awcolor == 1}
                                  {assign var=priocolor value="label-success"}
                              {elseif $task.awcolor == 2}
                                  {assign var=priocolor value="label-warning"}
                              {elseif $task.awcolor == 3}
                                  {assign var=priocolor value="label-danger"}
                              {elseif $task.awcolor == 4}
                                  {assign var=priocolor value="label-primary"}
                              {else}
                                  {assign var=priocolor value="label-default"}
                              {/if}
                                  <a href="index.php?cl=tasklist&fnc=taskdetails&project={$task.awproject}&task={$task.awid}">
                                      <span class="text">{$task.awname} - {$task.awtitle}</span>
                                      <small class="label {$priocolor}">{$task.workflowpos}</small>
                                  </a>
                              </li>
                          {/foreach}
                      </ul>
                    </div><!-- /.box-body -->
                  </div>
                </section>
                <div class="col-lg-5">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                          <h3 class="box-title">{awmultilang ident="PROJECTS"}</h3>
                        </div>

                        <div class="box-body">
                            <ul class="todo-list">
                              {foreach from=$myProjects item=project}
                                  <li>
                                      <a href="index.php?cl=tasklist&project={$project.awid}">
                                          {if $project.awpicture}
                                              <img class="img-circle startindex" src="media/projects/{$project.awpicture}" >
                                          {elseif $project.awprefix}
                                              <div class="img-circle startindex">{$project.awprefix}</div>
                                          {else}
                                              <div class="img-circle startindex">{$project.awname}</div>
                                          {/if}
                                          <span class="text">{$project.awname}</span>
                                      </a>
                                  </li>
                              {/foreach}
                          </ul>
                        </div>
                    </div>
                </div>
			</div>

	</section>
</div>
{include file="tpl/footer.tpl"}