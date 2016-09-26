<?php

/**
 * Class prioritys
 */
class prioritys extends aw_priorititys
{

    public function __construct()
    {
        parent::__construct();
        global $smarty, $oUsers;
        $smarty->assign("aPrioritys", $this->getAllPrioritys());
        if (empty($_POST)) {
            if (empty($this->getParameter('fnc')) && $this->getParameter('cl') === 'prioritys') {
                $smarty->display('tpl/administration/prioritys.tpl');
            } elseif ($this->getParameter('fnc') === 'edit' && $this->getParameter('cl') === 'prioritys') {
                $smarty->assign('oPriority', $this->getPriority());
                $smarty->assign('oPriorityID', $this->getParameter('priority'));
                $smarty->display('tpl/administration/prioritys-edit.tpl');
            } elseif ($this->getParameter('fnc') === 'add' && $this->getParameter('cl') === 'prioritys') {
                $smarty->display('tpl/administration/prioritys-add.tpl');
            } elseif ($this->getParameter('fnc') === 'delete' && $this->getParameter('cl') === 'prioritys') {
                $bResultStage = $this->delete();
                header('Location: index.php?cl=prioritys');
            } elseif ($this->getParameter('fnc') === 'tasklist' && $this->getParameter('cl') === 'prioritys' && !empty($this->getParameter('workflow'))) {
                $smarty->display('tpl/administration/prioritys.tpl');
            } else {
                $smarty->display('tpl/administration/prioritys.tpl');
            }
        } else {
            if ($this->getParameter('fnc') === 'save' && $this->getParameter('cl') === 'prioritys') {
                $bResultStage = $this->save();
                header('Location: index.php?cl=prioritys');
            } elseif ($this->getParameter('fnc') === 'delete' && $this->getParameter('cl') === 'prioritys') {
                $bResultStage = $this->delete();
                header('Location: index.php?cl=prioritys&fnc=edit&priority=' . $this->getParameter('awid'));
            } elseif ($this->getParameter('fnc') === 'add' && $this->getParameter('cl') === 'prioritys') {
                $bResultStage = $this->addWorkflow();
                header('Location: index.php?cl=prioritys');
            }
        }
    }
}