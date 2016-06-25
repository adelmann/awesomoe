<?php
	class tasklist extends aw_tasks
	{

		public function __construct() {
			parent::__construct();
			global $smarty,$oUsers,$oWorkflows,$oProjects,$oWorklog,$oMedia;

			if (!empty($this->getParameter('fnc')) && $this->getParameter('fnc') != 'allmeasowner') {
				$smarty->assign("aWorkflowSteps", $this->getWorkflowList());
			}
			if (empty($_POST)) {
				if (empty($this->getParameter('fnc')) && $this->getParameter('cl') == 'tasklist') {
					$smarty->assign("aProject", $oProjects->getProject());
					$smarty->assign("aTasks", $this->getTasks());
					$smarty->assign("aPrio", $this->getPrioList());
					$smarty->assign('oWorkflows2Project',$oWorkflows->getWorkflow($this->getParameter('project')));
					if (empty($this->getParameter('view'))) {
						$smarty->assign('bTasklistView','agile');
					} elseif($this->getParameter('view') == 'agile') {
						$smarty->assign('bTasklistView','agile');
					} elseif($this->getParameter('view') == 'list') {
						$smarty->assign('bTasklistView','list');
					} elseif($this->getParameter('view') == 'archive') {
						$smarty->assign('bTasklistView','archive');
						$smarty->assign("aTasks", $this->getArchive());
					} elseif($this->getParameter('view') == 'calendar'){
						$smarty->assign('bTasklistView','calendar');
					}
					$objProjects = new aw_projects();
					$smarty->assign("oProject", $objProjects);
					$smarty->display('tpl/task/task-list.tpl');
				} elseif ($this->getParameter('fnc') == 'edit' && $this->getParameter('cl') == 'tasklist') {
					$smarty->assign("aProject", $oProjects->getProject());
					$smarty->assign("aTask", $this->getTask());
					$smarty->assign("aPrio", $this->getPrioList());
					$smarty->assign('oUser2Project',$oUsers->getUsersFromProject());
					$smarty->display('tpl/task/task-edit.tpl');
				} elseif ($this->getParameter('fnc') == 'add' && $this->getParameter('cl') == 'tasklist') {
					$smarty->assign('oUser2Project',$oUsers->getUsersFromProject());
					$smarty->assign("aPrio", $this->getPrioList());
					$smarty->assign("aProject", $oProjects->getProject());
					$smarty->display('tpl/task/task-add.tpl');
				} elseif ($this->getParameter('fnc') == 'delete' && $this->getParameter('cl') == 'tasklist') {
					$bResultStage = $this->delete();
					header('Location: index.php?cl=tasklist&project='.$this->getParameter('project'));
				} elseif ($this->getParameter('fnc') == 'deletemedia' && $this->getParameter('cl') == 'tasklist') {
					$bResultStage = $oMedia->deleteMedia();
					header('Location: index.php?cl=tasklist&fnc=taskdetails&project='.$this->getParameter('project').'&task='.$this->getParameter('task'));
				} elseif ($this->getParameter('fnc') == 'tasklist' && $this->getParameter('cl') == 'tasklist' && !empty($this->getParameter('project'))) {
					$smarty->assign("oUsers", $oUsers);
				} elseif ($this->getParameter('fnc') == 'taskdetails' && $this->getParameter('cl') == 'tasklist' && !empty($this->getParameter('project'))) {
					$smarty->assign("aProject", $oProjects->getProject());
					$smarty->assign("aTask", $this->getTask());
					$smarty->assign('oWorklogs',$oWorklog->getWorklog4Task());
					$smarty->assign('oUser2Project',$oUsers->getUsersFromProject());
					$smarty->assign("sRemainingtime", $this->getRemainingTime());
					$smarty->assign("sWorkedTime", $this->workedtime());
					$smarty->assign("sMediaList", $oMedia->getFiles2Task());
					$smarty->assign("iMaxSteps", $this->maxSteps());
					$smarty->assign("oAllActivitys", $this->getAllActivitys());
					$smarty->display('tpl/task/task-details.tpl');
				} elseif($this->getParameter('fnc') == 'changestate' && $this->getParameter('cl') == 'tasklist' && !empty($this->getParameter('awprojectid'))) {
					$this->changeTaskState();
				} elseif($this->getParameter('fnc') == 'changeassignee' && $this->getParameter('cl') == 'tasklist' && !empty($this->getParameter('awprojectid'))) {
					$this->changeAssignee();
				} elseif ($this->getParameter('fnc') == 'allmeasowner' && $this->getParameter('cl') == 'tasklist') {
					$smarty->assign("aTasks", $this->getOnlyMyTasks());
					$smarty->display('tpl/task/task-mylist.tpl');
				} elseif ($this->getParameter('fnc') == 'overtime' && $this->getParameter('cl') == 'tasklist') {
					$smarty->assign("aTasks", $this->getOverTimedTasks());
					$smarty->display('tpl/task/task-overtime.tpl');
				} elseif($this->getParameter('fnc') == 'set2archive' && $this->getParameter('cl') == 'tasklist' && !empty($this->getParameter('project')) && !empty($this->getParameter('task'))) {
					$this->set2archive();
				}
				//changestate
			} else {
				if ($this->getParameter('fnc') == 'save' && $this->getParameter('cl') == 'tasklist') {
					$ResultStage = $this->save();
					if ($this->getParameter('awid') == '-1') {
						$sSelectTaskId = "
							SELECT awid
								FROM awtasks
								WHERE awid = '".$ResultStage."'
								ORDER BY awid desc limit 1;
							";
						$oResult = $this->_db->query($sSelectTaskId,'assoc');
						$taskId = $oResult[0]['awid'];
					} else {
						$taskId = $this->getParameter('awid');
					}
					header('Location: index.php?cl=tasklist&fnc=taskdetails&project='.$this->getParameter('project').'&task='.$taskId);
				} elseif ($this->getParameter('fnc') == 'uploadFiles' && $this->getParameter('cl') == 'tasklist') {
					$oMedia->loadMedia2Task();
				}
			}
		}

		protected function getRights4Projects() {
			global $oUsers;
			$aUserRights = $oUsers->getGroupRights();
		}

	}
?>