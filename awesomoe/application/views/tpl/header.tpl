<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>{$sTitle}</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="{$tpldir}src/themefiles/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <!--<link href="{$tpldir}src/font-awesome.min.css" rel="stylesheet" type="text/css" />-->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
     <!--<link href="{$tpldir}src/ionicons.min.css" rel="stylesheet" type="text/css" />-->
	<link href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="{$tpldir}src/themefiles/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="{$tpldir}src/themefiles/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    {*<link href="{$tpldir}src/themefiles/dist/css/skins/{$sSkin}.min.css" rel="stylesheet" type="text/css" />*}
    <link href="{$tpldir}src/themefiles/dist/css/aw.css" rel="stylesheet" type="text/css" />
	<link href="{$tpldir}src/themefiles/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
	<link href="{$tpldir}src/style.css" rel="stylesheet" type="text/css" />
	<link href="{$tpldir}src/themefiles/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="{$tpldir}src/themefiles/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />

    <!-- Select2 -->
	<link href="{$tpldir}src/themefiles/plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
	<link href="{$tpldir}src/themefiles/plugins/timepicker/bootstrap-timepicker.min.css" rel="stylesheet"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <script src="{$tpldir}src/aw_main.js"></script>
    <![endif]-->
  </head>
  <body class="{$sSkin} fixed">
	
    <div class="wrapper">

      <!-- Main Header -->
      <header class="main-header">

        <!-- Logo -->
        <a href="index.php" class="logo">{$sTitle}</a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">{awmultilang ident="TOGGLENAVIGATION"}</span>
          </a>
          <!-- Navbar Right Menu -->
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
			{*
              <!-- Messages: style can be found in dropdown.less-->
              <li class="dropdown messages-menu">
                <!-- Menu toggle button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-envelope-o"></i>
                  <span class="label label-success">4</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">{awmultilang ident="YOUHAVE"} 4 {awmultilang ident="MESSAGES"}</li>
                  <li>
                    <!-- inner menu: contains the messages -->
                    <ul class="menu">
                      <li><!-- start message -->
                        <a href="#">
                          <div class="pull-left">
                            <!-- User Image -->
                            <img src="{$mediadir}/profile/{$oUser->getUserAvatar($aActUser.awid)}" class="img-circle" alt="User Image"/>
                          </div>
                          <!-- Message title and timestamp -->
                          <h4>                            
                            Support Team
                            <small><i class="fa fa-clock-o"></i> 5 mins</small>
                          </h4>
                          <!-- The message -->
                          <p>Why not buy a new awesome theme?</p>
                        </a>
                      </li><!-- end message -->                      
                    </ul><!-- /.menu -->
                  </li>
                  <li class="footer"><a href="#">See All Messages</a></li>
                </ul>
              </li><!-- /.messages-menu -->
			*}
              <!-- Notifications Menu -->
              <li class="dropdown notifications-menu">
                <!-- Menu toggle button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-bell-o"></i>
                  {if $myNotificationCount >= 1}<span class="label label-warning">{$myNotificationCount}</span>{/if}
                </a>
                <ul class="dropdown-menu">
                  <li class="header">{awmultilang ident="YOUHAVE"} {$myNotificationCount} {awmultilang ident="NEW"} {awmultilang ident="NOTIFICATIONS"}</li>
                  <li>
                    <!-- Inner Menu: contains the notifications -->
                    <ul class="menu">
                      {foreach from=$myNotifications item=notification}
                        <li class="notification-{$notification.awid}"><!-- start notification -->
                          <a href="index.php?cl=tasklist&fnc=taskdetails&project={$notification.awprojectid}&task={$notification.awtaskid}">
                            {$notification.projectname} - {$notification.taskname}<br>
                            {awmultilang ident="CHANGEON"}: {$notification.awdatetime}<br>
                            {awmultilang ident="TYPE"}:
                            {if $notification.awtype == '1'}
                              {awmultilang ident="NEWCOMMENT"}
                            {elseif  $notification.awtype == '2'}
                              {awmultilang ident="NEWWORKLOG"}
                            {elseif  $notification.awtype == '3'}
                              {awmultilang ident="STATECHANGE"}
                            {elseif  $notification.awtype == '4'}
                              {awmultilang ident="DESCRIPTIONCHANGE"}
                            {elseif  $notification.awtype == '5'}
                              {awmultilang ident="NEWASSIGNEE"}
                            {elseif  $notification.awtype == '6'}
                              {awmultilang ident="NEWTASK"}
                            {/if}
                            <br>
                            {awmultilang ident="USER"}: {$notification.username} {$notification.userlastname}<br>
                          </a>
                        </li><!-- end notification -->
                      {/foreach}
                    </ul>
                  </li>
                  {*<li class="footer"><a href="#">View all</a></li>*}
                </ul>
              </li>
			  
              <!-- Tasks Menu -->
              <li class="dropdown tasks-menu">
                <!-- Menu Toggle Button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-flag-o"></i>
                  {if $myTaskCount >= 1}<span class="label label-danger">{$myTaskCount}</span>{/if}
                </a>
                <ul class="dropdown-menu">
                  <li class="header">{awmultilang ident="YOUHAVE"} {$myTaskCount} {awmultilang ident="TASKS"}</li>
                  <li>
                    <!-- Inner menu: contains the tasks -->
                    <ul class="menu">
					{foreach from=$myLastTasks item=task}
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
						<li class="headtasks {$priocolor}">
							<a href="index.php?cl=tasklist&fnc=taskdetails&project={$task.awproject}&task={$task.awid}">
								<h3>{$task.awname} - {$task.awtitle}</h3>
								<small class="pull-right">{$task.awname}</small>
								<small>{$task.workflowpos}</small>
								
							</a>
						</li>
					{/foreach}
                                         
                    </ul>
                  </li>
                  <li class="footer">
                    <a href="index.php?cl=tasklist&fnc=allmeasowner">{awmultilang ident="VIEWALLTASKS"}</a>
                  </li>
                </ul>
              </li>
              <!-- User Account Menu -->
              <li class="dropdown user user-menu">
                <!-- Menu Toggle Button -->
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  {if $oUser->getUserAvatar($aActUser.awid) != ''}
                    <!-- The user image in the navbar-->
                    <img src="{$mediadir}/profile/{$oUser->getUserAvatar($aActUser.awid)}" class="user-image" alt="User Image"/>
                  {/if}
                  <!-- hidden-xs hides the username on small devices so only the image appears. -->
                  <span class="hidden-xs">{$aActUser.awname} {$aActUser.awlastname}</span>
                </a>
                <ul class="dropdown-menu">
                  <!-- The user image in the menu -->
                  <li class="user-header">
                    {if $oUser->getUserAvatar($aActUser.awid) != ''}
                    <img src="{$mediadir}/profile/{$oUser->getUserAvatar($aActUser.awid)}" class="img-circle" alt="User Image" />
                    {/if}
                    <p>
                      {$aActUser.awname} {$aActUser.awlastname} - {$aActUser.awposition}
                      <small>{awmultilang ident="MEMBERSINCE"}  {$aActUser.awadded}</small>
                    </p>
                  </li>
                  <!-- Menu Body -->
                  {*<li class="user-body">
                    <div class="col-xs-4 text-center">
                      <a href="#">Followers</a>
                    </div>
                    <div class="col-xs-4 text-center">
                      <a href="#">Sales</a>
                    </div>
                    <div class="col-xs-4 text-center">
                      <a href="#">Friends</a>
                    </div>
                  </li>*}
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="?cl=profile" class="btn btn-default btn-flat">{awmultilang ident="PROFILE"}</a>
                    </div>
                    <div class="pull-right">
                      <a href="?logoff=true" class="btn btn-default btn-flat">{awmultilang ident="LOGOUT"}</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>
