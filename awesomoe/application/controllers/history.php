<?php

/**
 * Class history
 */
class history extends aw_history
{
    public function __construct()
    {
        parent::__construct();
        global $smarty, $oTasks, $oUser;
        if ($this->getParameter('fnc') == 'getHistory') {
            $smarty->assign("oHistory", $this->getHistory4Task());
            $smarty->assign("aWorkflowSteps", $oTasks->getWorkflowList());
            $smarty->display('tpl/modal/history-task.tpl');
        }
    }
}