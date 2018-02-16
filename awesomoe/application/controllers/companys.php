<?php
ini_set('error_reporting', E_ALL);
/**
 * Class users
 */
class companys extends aw_companys
{

    public function __construct()
    {
        parent::__construct();
        global $smarty, $oCompanys;

        if (empty($_POST)) {
            if ($this->getParameter('cl') === "companys" && empty($this->getParameter('fnc'))) {
                $smarty->assign('oCompanys', $this->getAllCompanys());
                $smarty->display('tpl/administration/companys/companys-overview.tpl');
            } elseif ($this->getParameter('cl') === 'companys' && $this->getParameter('fnc') === 'edit') {
                $iCompanyId = $this->getParameter('company');
                $smarty->assign('aEditCompany', $this->getCompanyDatas($iCompanyId));
                $smarty->display('tpl/administration/companys/companys-edit.tpl');
            } elseif ($this->getParameter('cl') === 'companys' && $this->getParameter('fnc') == 'add') {
                $smarty->display('tpl/administration/companys/companys-add.tpl');
            } elseif (!empty($this->getParameter('cl')) == 'companys' && $this->getParameter('fnc') == 'delete') {
                $bResultStage = $this->delete();
                header('Location: index.php?cl=companys');
            }
        } else {
            if ($this->getParameter('fnc') == 'save' && $this->getParameter('cl') == 'companys') {
                $bResultStage = $oCompanys->save();
                header('Location: index.php?cl=companys');
            } elseif ($this->getParameter('fnc') == 'add' && $this->getParameter('cl') == 'companys') {
                $bResultStage = $oCompanys->save();
                header('Location: index.php?cl=companys');
            }
        }
    }
}