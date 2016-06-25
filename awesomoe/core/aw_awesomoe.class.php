<?php

class aw_awesomoe extends aw_supercfg
{
	public function __construct() {
		global $oDB,$smarty,$oConfig;

		$this->_oConfig = $oConfig;
		$sTitle = $this->_oConfig->getConfigParam('sTitle');
        $sCopyright = $this->_oConfig->getConfigParam('sCopyright');
		$sMailName = $this->_oConfig->getConfigParam('sMailName');
		$sMailAdress = $this->_oConfig->getConfigParam('sMailAdress');
        $sCopyrightLink = $this->_oConfig->getConfigParam('sCopyrightLink');
        $sFooterInfo = $this->_oConfig->getConfigParam('sFooterInfo');
        $sSkin = $this->_oConfig->getConfigParam('sSkin');
        $iDays4NewTasks = $this->_oConfig->getConfigParam('iDays4NewTasks');
        $iDays4EndTime = $this->_oConfig->getConfigParam('iDays4EndTime');
		$smarty->assign("sTitle", $sTitle);
		$smarty->assign("sCopyright", $sCopyright);
		$smarty->assign("sCopyrightLink", $sCopyrightLink);
		$smarty->assign("sFooterInfo", $sFooterInfo);
		$smarty->assign("sMailName", $sMailName);
		$smarty->assign("sMailAdress", $sMailAdress);
		$smarty->assign("sSkin", $sSkin);
		$smarty->assign("iDays4NewTasks", $iDays4NewTasks);
		$smarty->assign("iDays4EndTime", $iDays4EndTime);
		$smarty->assign("tpldir", URL.'application/views/');
		$smarty->assign("mainUrl", URL);
		$smarty->assign("mediadir", URL.'media/');
	}
}