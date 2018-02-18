<?php

	if (!file_exists('config.php')) {
		if (!file_exists('setup/')) {
			die('No Setup');
		}
		header('Location: setup/');
	}
	require 'config.php';

    include_once('core/aw_autoloader.php');
	spl_autoload_register(array('asbg_autoloader', 'autoload'));

	require 'core/smarty/libs/Smarty.class.php';
	$smarty = new Smarty;
	$smarty->debugging = false;
	$smarty->caching = false;
	$smarty->cache_lifetime = 120;

	$oLang 			= new aw_lang();

	$oDB 			= new aw_db();
	$oUtils			= new aw_utils();
	$oConfig 		= new aw_config();

	$oAuth 			= new aw_auth();
	$oUsers 		= new aw_users();
	$oMedia 		= new aw_media();
	$oCalendar 		= new aw_calendar();
	$oProjects 		= new aw_projects();
	$oWorkflows 	= new aw_workflows();
	$oAwesomoe 		= new aw_awesomoe();
	$oPrioritys 	= new aw_priorititys();
	$oTasks 		= new aw_tasks();
	$oBreadCrumb 	= new aw_breadcrumb();
	$oMail 			= new aw_mail();
    $oNotification 	= new aw_notification();
	$oHistory 		= new aw_history();
	$oWorklog 		= new aw_worklog();
	$oComments 		= new aw_comments();
	$oReport 		= new aw_report();
	$smarty->assign("loginError", false);
	if ($oAuth->checklogin() != true) {
		if ( isset($_SESSION['awLoginError']) && $_SESSION['awLoginError'] === true ) {
			$smarty->assign("loginError", true);
			unset($_SESSION['awLoginError']);
		}
		$smarty->display('tpl/login.tpl');
	} else {
		$smarty->assign("myTaskCount", $oTasks->countMyTasks());
		$smarty->assign("myLastTasks", $oTasks->getLastWorkedTasks());
		$smarty->assign("myNotificationCount", $oNotification->getNotificationCounter());
		$smarty->assign("myNotifications", $oNotification->getAllNotification4User());
		$smarty->assign("startinfos", $oUsers->getStartInfos());
		$smarty->assign("myProjects", $oProjects->getProjects());
		if ((empty($_GET) || empty($_GET['cl'])) && (empty($_POST) || empty($_POST['cl']))) {
			$smarty->display('tpl/index.tpl');
		} else {
			if (!empty($_GET)) {
				$sClassName = $_GET['cl'];
			} elseif (!empty($_POST)) {
				$sClassName = $_POST['cl'];
			}
			$filePath = PATH . 'application/controllers/'. $sClassName . ".php";
			if (file_exists($filePath)) {
				include_once($filePath);
				${"o".$sClassName} = new $sClassName;
			}
		}
	}

?>
