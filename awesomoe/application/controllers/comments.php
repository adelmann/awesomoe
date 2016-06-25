<?php
	class comments extends aw_comments
	{
	
		public function __construct() {
			parent::__construct();
			global $smarty,$oUsers;
			if ($this->getParameter('fnc') == 'save') {
				if ($this->save() == false) {
					$smarty->display('tpl/modal/action-failed.tpl');
				} else {
					$smarty->display('tpl/modal/action-done.tpl');
				}
			} elseif ($this->getParameter('fnc') == 'getCommentsLog') {
				$smarty->assign("oComments", $this->getComment4Task());
				$smarty->display('tpl/modal/comments-task.tpl');
			} elseif ($this->getParameter('fnc') == 'getEditComments') {
				$smarty->assign("oComments", $this->getComment4Task());
				$smarty->assign("oComments2Edit", $this->getComment2Edit());
				$smarty->display('tpl/modal/modal-comment.tpl');
			} elseif ($this->getParameter('fnc') == 'deleteComment') {
				$this->deleteComment();
			} elseif ($this->getParameter('fnc') == 'getCommentForm') {
				$smarty->assign("oComments", $this->getComment4Task());
				$smarty->assign("project",$this->getParameter('project'));
				$smarty->assign("task", $this->getParameter('task'));
				$smarty->display('tpl/modal/modal-comment.tpl');
			}
			
		}
	}