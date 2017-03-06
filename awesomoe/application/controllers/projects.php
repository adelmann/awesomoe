<?php

class projects extends aw_projects
{

    public function __construct()
    {
        parent::__construct();
        global $smarty, $oUsers, $oWorkflows, $oMedia;
        $smarty->assign("aProjects", $this->getProjects());

        if (empty($_POST)) {
            if (empty($this->getParameter('fnc')) && $this->getParameter('cl') === 'projects') {
                $objProjects = new aw_projects();
                $smarty->assign("oProject", $objProjects);
                $smarty->display('tpl/project/projects.tpl');
            } elseif ($this->getParameter('fnc') === 'edit' && $this->getParameter('cl') === 'projects') {
                $smarty->assign('oProject', $this->getProject());
                $smarty->assign('oUser2Project',
                    $oUsers->getUsersFromProject());
                $smarty->assign('oUsersRel2Project',
                    $oUsers->getAllUsersRel2Project());
                $smarty->assign('oWorkflows2Project',
                    $oWorkflows->getWorkflows());
                $smarty->display('tpl/project/projects-edit.tpl');
            } elseif ($this->getParameter('fnc') === 'add' && $this->getParameter('cl') === 'projects') {
                $smarty->assign('oUsersRel2Project',
                    $oUsers->getAllUsersRel2Project());
                $smarty->display('tpl/project/projects-add.tpl');
            } elseif ($this->getParameter('fnc') === 'delete' && $this->getParameter('cl') === 'projects') {
                $bResultStage = $this->delete();
                header('Location: index.php?cl=projects');
            }
        } else {
            if ($this->getParameter('fnc') === 'save' && $this->getParameter('cl') === 'projects') {
                $ResultStage = $this->save();
                if (!empty($ResultStage) && is_bool($ResultStage) == true) {
                    header('Location: index.php?cl=projects&fnc=edit&project=' . $this->getParameter('awid'));
                } elseif (is_int($ResultStage) == true) {
                    header('Location: index.php?cl=projects&fnc=edit&project=' . $ResultStage);
                }
                //$smarty->display('tpl/profile.tpl');
            } elseif ($this->getParameter('fnc') === 'saveavatar' && $this->getParameter('cl') === 'projects') {
                $oMedia->loadProjectAvatar();
                header('Location: index.php?cl=projects');
            }
        }
    }
}

