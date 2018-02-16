<?php
ini_set('error_reporting', E_ALL);
/**
 * Class users
 */
class users extends aw_users
{

    public function __construct()
    {
        parent::__construct();
        global $smarty, $oUsers, $oCompanys;

        if (empty($_POST)) {
            if ($this->getParameter('cl') === "users" && empty($this->getParameter('fnc'))) {
                $smarty->assign('oUsers', $this->getAllUsers());
                $smarty->display('tpl/administration/users/users-overview.tpl');
            } elseif ($this->getParameter('cl') === 'users' && $this->getParameter('fnc') === 'edit') {
                $userid = $this->getParameter('user');
                $smarty->assign('aCompanys', $oCompanys->getAllCompanys());
                $smarty->assign('aEditUser', $this->oChoosenUser($userid));
                $smarty->display('tpl/administration/users/users-edit.tpl');
            } elseif ($this->getParameter('cl') === 'users' && $this->getParameter('fnc') == 'add') {
                $smarty->display('tpl/administration/users/users-add.tpl');
            } elseif (!empty($this->getParameter('cl')) == 'users' && $this->getParameter('fnc') == 'delete') {
                $bResultStage = $this->delete();
                header('Location: index.php?cl=users');
            }
        } else {
            if ($this->getParameter('fnc') == 'save' && $this->getParameter('cl') == 'users') {
                $bResultStage = $oUsers->save();
                header('Location: index.php?cl=users');
            } elseif ($this->getParameter('fnc') == 'add' && $this->getParameter('cl') == 'users') {
                $bResultStage = $oUsers->save();
                header('Location: index.php?cl=users');
            }
        }
    }
}