<?php

class aw_auth extends aw_base
{
	public function checklogin() {
		if (isset($_SESSION['awmail']) && isset($_SESSION['awid'])) {
			if (!empty($this->getParameter('logoff'))) {
				$this->dologout();
				return false;
			}
			return true;
		} else {
			if (!empty($this->getParameter('login'))) {
				$login = $this->make_safe($this->getParameter('login'));
				if (!empty($login)) {
					$oUserDatas = $this->checkLoginDatas($this->getAllParameter($_POST));
					if (!empty($oUserDatas)) {
						$_SESSION['awmail']	= $oUserDatas[0]['awmail'];
						$_SESSION['awid']	= $oUserDatas[0]['awid'];
						$this->_userid = $oUserDatas[0]['awid'];
						header('Location: index.php');
						return true;
					} else {
						return false;
					}
				}
			}
			return false;
		}
	}
	
	public function dologout() {
		$_SESSION = array();
		session_destroy();
	}
	
	protected function checkLoginDatas($datas) {
		if (!empty($datas['mail']) && !empty($datas['password'])) {
			$oUserDatas = $this->getUserDatas4Login($datas['mail'],$datas['password']);
			return $oUserDatas;
		}
	}
	
	protected function getUserDatas4Login($mail,$password) {
			$sSelect = "SELECT * FROM awusers WHERE awmail ='".$mail."' AND awpassword = '".md5($password)."';";
			$oResult = $this->_db->query($sSelect,'assoc');
			return $oResult;
	}
	
	public function make_safe($variable) {
   		//$variable = strip_tags(mysqli_real_escape_string($variable));
   		return $variable; 
   	}
}
?>