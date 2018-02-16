<?php

/**
 * Class workflows
 */
class workflows extends aw_workflows
{

    public function __construct()
    {
        parent::__construct();
        global $smarty, $oUsers;
        $smarty->assign('aWorkflows', $this->getWorkflows());
        //$smarty->assign("aProject", $this->getProject());

        if (empty($_POST)) {
            if (empty($this->getParameter('fnc')) && $this->getParameter('cl') === 'workflows') {
                $smarty->display('tpl/administration/workflows/workflows.tpl');
            } elseif ($this->getParameter('fnc') === 'edit' && $this->getParameter('cl') === 'workflows') {
                $smarty->assign('oWorkflow', $this->getWorkflow());
                $smarty->assign('oWorkflowID', $this->getParameter('workflow'));
                $smarty->display('tpl/administration/workflows/workflow-edit.tpl');
            } elseif ($this->getParameter('fnc') === 'add' && $this->getParameter('cl') === 'workflows') {
                $smarty->display('tpl/administration/workflows/workflow-add.tpl');
            } elseif ($this->getParameter('fnc') === 'delete' && $this->getParameter('cl') === 'workflows') {
                $bResultStage = $this->delete();
                header('Location: index.php?cl=workflows');
            } elseif ($this->getParameter('fnc') === 'tasklist' && $this->getParameter('cl') === 'workflows' && !empty($this->getParameter('workflow'))) {
                $smarty->display('tpl/administration/workflows/workflows.tpl');
            } else {
                $smarty->display('tpl/administration/workflows/workflows.tpl');
            }
        } else {
            if ($this->getParameter('fnc') === 'save' && $this->getParameter('cl') === 'workflows') {
                $bResultStage = $this->save();
                header('Location: index.php?cl=workflows');
            } elseif ($this->getParameter('fnc') === 'deletestep' && $this->getParameter('cl') === 'workflows') {
                $bResultStage = $this->deletestep();
                header('Location: index.php?cl=workflows&fnc=edit&workflow=' . $this->getParameter('awid'));
            } elseif ($this->getParameter('fnc') === 'add' && $this->getParameter('cl') === 'workflows') {
                $bResultStage = $this->addWorkflow();
                header('Location: index.php?cl=workflows');
            }
        }
    }
}

?>