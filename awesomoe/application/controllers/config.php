<?php

/**
 * Class config
 */
class config extends aw_config
{
    public function __construct()
    {
        parent::__construct();
        global $smarty;
        $oBase = new aw_base();

        if (empty($_POST)) {
            if ($oBase->getParameter('cl') == "config" && empty($oBase->getParameter('fnc'))) {
                $smarty->display('tpl/administration/config-base.tpl');
            } elseif (!empty($oBase->getParameter('cl')) == "config" && $oBase->getParameter('fnc') == "mail") {
                $smarty->display('tpl/administration/config-mail.tpl');
            }
        } else {
            if ($oBase->getParameter('fnc') == 'save' && $oBase->getParameter('cl') == 'config') {
                $bResultStage = $this->save();
                if ($oBase->getParameter('fnc') == "mail") {
                    header('Location: index.php?cl=config&fnc=mail');
                } else {
                    header('Location: index.php?cl=config');
                }
            }
        }
    }
}