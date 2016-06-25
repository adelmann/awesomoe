<?php
	class worklog extends aw_worklog
	{
	
		public function __construct() {
			parent::__construct();
			global $smarty,$oUsers;
			if (!empty($this->getParameter('fnc')) && $this->getParameter('fnc') == 'save') {
				if ($this->save() == false) {
					$smarty->display('tpl/modal/action-failed.tpl');
				} else {
					$smarty->display('tpl/modal/action-done.tpl');
				}
			} elseif ($this->getParameter('fnc') == 'getWorkLog') {
				$smarty->assign("oWorklogs", $this->getWorklog4Task());
				$smarty->display('tpl/modal/worklogs-task.tpl');
			} elseif ($this->getParameter('fnc') == 'getEditLog') {
				$smarty->assign("oWorklogs", $this->getWorklog4Task());
				$smarty->assign("oWorklogs2Edit", $this->getWorklog2Edit());
				$smarty->display('tpl/modal/modal-timelog.tpl');
			} elseif ($this->getParameter('fnc') == 'deleteWorklog') {
				$this->deleteWorklog();
			} elseif ($this->getParameter('fnc') == 'getLogForm') {
				$smarty->assign("oWorklogs", $this->getWorklog4Task());
				$smarty->assign("project", $this->getParameter('project'));
				$smarty->assign("task", $this->getParameter('task'));
				$smarty->display('tpl/modal/modal-timelog.tpl');
			}
		}
	}