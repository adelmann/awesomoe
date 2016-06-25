<?php

class aw_base extends aw_supercfg
{
	protected $_db;
	public function __construct() {
		if (session_id() == "") {
			//ini_set('session.save_path',realpath(dirname($_SERVER['DOCUMENT_ROOT']) . '/'));
			session_start();
		}
		global $smarty,$oConfig,$oDB,$oUsers,$oUtils,$oBreadCrumb;
		$this->_oConfig = $oConfig;
		$this->_utils 	= $oUtils;
		$this->_db 		= $oDB;
		$sTitle = $this->_oConfig->getConfigParam('sTitle');
		$smarty->assign("sTitle", $sTitle);
		$smarty->assign("tpldir", URL.'application/views/');
		$smarty->assign("mediadir", 'media/');
		$smarty->assign("oUser", $oUsers);
	}

	public function getParameter($var, $blUnescaped = false) {
		//Check POST
		if (!empty($_POST[$var])) { $sParameter = $_POST[$var];}
		elseif (!empty($_GET[$var])) {$sParameter = $_GET[$var];}
		else {$sParameter = null;}

		if ($blUnescaped == false) {
			$sParameter = str_replace(
					array('&', '<', '>', '"', "'", chr(0), '\\', "\n", "\r"),
					array('&amp;', '&lt;', '&gt;', '&quot;', '&#039;', '', '&#092;', '&#10;', '&#13;'),
					$sParameter
			);
		}
		return $sParameter;
	}

	public function getAllParameter($aVar){
		$aReturn = null;
		foreach ($aVar as $key=>$value){
			$aReturn[$key] = $this->getParameter($key);
		}
		return $aReturn;
	}
}

?>