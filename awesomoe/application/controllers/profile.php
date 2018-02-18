<?php

/**
 * Class profile
 */
class profile extends aw_users
{

    /**
     * profile constructor.
     */
    public function __construct()
    {
        parent::__construct();
        global $smarty, $oUsers, $oMedia;
        if (empty($_POST)) {
            if (empty($this->getParameter('fnc')) && $this->getParameter('cl') === 'profile') {
                $smarty->display('tpl/account/profile.tpl');
            } elseif ($this->getParameter('fnc') == 'edit' && $this->getParameter('cl') === 'profile') {
                $smarty->display('tpl/account/profile-edit.tpl');
            } elseif ($this->getParameter('fnc') == 'editavatar' && $this->getParameter('cl') === 'profile') {
                $smarty->display('tpl/account/profile-editavatar.tpl');
            }
        } else {
            if ($this->getParameter('fnc') === 'save' && $this->getParameter('cl') === 'profile') {
                $bResultStage = $oUsers->save();
                header('Location: index.php?cl=profile');
                //$smarty->display('tpl/profile.tpl');
            } elseif ($this->getParameter('fnc') === 'saveavatar' && $this->getParameter('cl') === 'profile') {
                $oMedia->loadAvatar();
                //$bResultStage = $oUsers->saveUserAvatar($_FILES['uploadavatar']['name']);
                header('Location: index.php?cl=profile');
            } elseif ($this->getParameter('fnc') === 'uploadFiles' && $this->getParameter('cl') === 'profile') {
                echo "taskid=" . $this->getParameter('tskid');
                echo "<hr>";
                print_r($_FILES);
                $oMedia->loadMedia2Task();
            } else {
                echo "Möglicherweise eine Dateiupload-Attacke!\n";
            }
        }
    }
}

