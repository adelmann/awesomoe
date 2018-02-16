<aside class="main-sidebar">
    {if isset($smarty.get.cl)}
        {assign var=actclass value=$smarty.get.cl}
    {else}
        {assign var=actclass value=""}
    {/if}
    {if isset($smarty.get.fnc)}
        {assign var=actfnc value=$smarty.get.fnc}
    {else}
        {assign var=actfnc value=""}
    {/if}
    <!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

	  <!-- Sidebar user panel (optional) -->
	  <div class="user-panel">
		<div class="pull-left image">
			{if $oUser->getUserAvatar($aActUser.awid) != ''}
		  		<img src="{$mediadir}/profile/{$oUser->getUserAvatar($aActUser.awid)}" class="img-circle" alt="User Image" />
			{/if}
		</div>
		<div class="pull-left info">
            <p>{$aActUser.awname} {$aActUser.awlastname}</p>
            <p>{$aActUser.awposition}</p>
		  {*<!-- Status -->
		  <a href="#"><i class="fa fa-circle text-success"></i> Online</a>*}
		</div>
	  </div>

	  {*<!-- search form (Optional) -->
	  <form action="#" method="get" class="sidebar-form">
		<div class="input-group">
		  <input type="text" name="q" class="form-control" placeholder="Search..."/>
		  <span class="input-group-btn">
			<button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
		  </span>
		</div>
	  </form>
	  <!-- /.search form -->*}

	  <!-- Sidebar Menu -->
	  <ul class="sidebar-menu">
		<li class="header">{awmultilang ident="MENU"}</li>
		<!-- Optionally, you can add icons to the links -->
		<li{if $actclass == 'projects' || ($actclass == 'tasklist' && $actfnc != 'allmeasowner')} class="active"{/if}><a href="index.php?cl=projects"><i class="fa fa-th"></i> <span>{awmultilang ident="PROJECTS"}</span></a></li>
		<li{if $actclass == 'tasklist' && $actfnc == 'allmeasowner'} class="active"{/if}><a href="index.php?cl=tasklist&fnc=allmeasowner"><i class="fa fa-bars"></i> <span>{awmultilang ident="TASKS"}</span></a></li>
		<li><a href="index.php?cl=calendar"><i class="fa fa-calendar"></i> <span>{awmultilang ident="CALENDAR"}</span></a></li>
		{if $aActUser.awgroup == '1'}
			<li class="treeview{if $actclass == 'workflows' || $actclass == 'users' || $actclass == 'config' || $actclass == 'prioritys' || $actclass == 'companys'} active{/if}">
			  <a href="#"><i class="fa fa-cogs"></i><span>{awmultilang ident="ADMINISTRATION"}</span> <i class="fa fa-angle-left pull-right"></i></a>
			  <ul class="treeview-menu">
				<li{if $actclass == 'workflows'} class="active"{/if}><a href="index.php?cl=workflows"><i class="fa fa-circle-o"></i> {awmultilang ident="WORKFLOW"}</a></li>
				<li{if $actclass == 'users'} class="active"{/if}><a href="index.php?cl=users"><i class="fa fa-circle-o"></i> {awmultilang ident="USER"}</a></li>
				{*<li><a href="#"><i class="fa fa-circle-o"></i> {awmultilang ident="GROUPS"}</a></li>*}
				<li{if $actclass == 'companys'} class="active"{/if}><a href="index.php?cl=companys"><i class="fa fa-circle-o"></i> {awmultilang ident="COMPANYS"}</a></li>
				{*<li><a href="#"><i class="fa fa-circle-o"></i> {awmultilang ident="PLUGINS"}</a></li>*}
				<li{if $actclass == 'config'} class="active"{/if}>
                    <a href="#"><i class="fa fa-circle-o"></i> {awmultilang ident="CONFIGURATION"}   <i class="fa fa-angle-left pull-right"></i></a>
                    <ul class="treeview-menu{if $actclass == 'config'} active{/if}">
                        <li{if $actclass == 'config' && $actfnc == ''} class="active"{/if}><a href="index.php?cl=config"><i class="fa fa-building-o"></i> {awmultilang ident="BASECONFIG"}</a></li>
                        <li{if $actclass == 'config' && $actfnc == 'mail'} class="active"{/if}><a href="index.php?cl=config&fnc=mail"><i class="fa fa-envelope-o"></i> {awmultilang ident="MAILCONFIG"}</a></li>
						{*<li><a href="#"><i class="fa fa-circle-o"></i> {awmultilang ident="MAILCONFIG"}</a></li>*}
                    </ul>
                </li>
				{*<li><a href="#"><i class="fa fa-circle-o"></i> {awmultilang ident="PROJECTCUSTOMFIELDS"}</a></li>
				<li><a href="#"><i class="fa fa-circle-o"></i> {awmultilang ident="TASKCUSTOMFIELDS"}</a></li>*}
				<li{if $actclass == 'prioritys'} class="active"{/if}><a href="index.php?cl=prioritys"><i class="fa fa-circle-o"></i> {awmultilang ident="TASKPRIORITYS"}</a></li>
			  </ul>
			</li>
		{/if}
	  </ul><!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
  </aside>