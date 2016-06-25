<?php
class aw_breadcrumb extends aw_base
{
	public function __construct() {
		parent::__construct();
		global $smarty;
		
		$smarty->assign("aBreadCrumb", $this->getBreadCrumbPath());
		
	}
	
	
	public function getBreadCrumbPath() {
		$aBreadcrumb = array();
		$oProjects = new aw_projects();
		$oTasks = new aw_tasks();
		if (!empty($this->getParameter('base'))) {$aBreadcrumb['base'] = $this->getParameter('cl');}
		if (!empty($this->getParameter('project'))) {$aBreadcrumb['project'] = $oProjects->getProjectName($this->getParameter('project'));}
		if (!empty($this->getParameter('task'))) {$aBreadcrumb['task'] = $oTasks->getTaskName($this->getParameter('task'));}
		if (!empty($this->getParameter('fnc'))) {$aBreadcrumb['fnc'] = $this->getParameter('fnc');}
		return $aBreadcrumb;
	}
}