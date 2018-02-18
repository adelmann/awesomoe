<?php

/**
 * Class aw_auth
 */
class aw_auth extends aw_base
{

    /**
     * checklogin
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
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
                        $_SESSION['awLoginError'] = true;
						return false;
					}
				}
			}
			return false;
		}
	}

    /**
     * dologout
     * -----------------------------------------------------------------------------------------------------------------
     */
	public function dologout() {

	    $_SESSION = array();
		session_destroy();
	}

    /**
     * checkLoginDatas
     * -----------------------------------------------------------------------------------------------------------------
     * @param array $aDatas
     * @return object
     */
	protected function checkLoginDatas($aDatas) {

	    if (!empty($aDatas['mail']) && !empty($aDatas['password'])) {
			$oUserDatas = $this->getUserDatas4Login($aDatas['mail'],$aDatas['password']);
			return $oUserDatas;
		}
	}

    /**
     * getUserDatas4Login
     * -----------------------------------------------------------------------------------------------------------------
     * @param $sMail
     * @param $sPassword
     * @return array
     */
    protected function getUserDatas4Login($sMail,$sPassword) {

        $sSelect = "SELECT * FROM awusers WHERE awmail ='".$sMail."' AND awpassword = '".md5($sPassword)."';";
        $oResult = $this->_db->query($sSelect,'assoc');
        return $oResult;
	}

    /**
     * make_safe
     * -----------------------------------------------------------------------------------------------------------------
     * really dont know what i want do with this...
     * @param $variable
     * @return mixed
     */
	public function make_safe($variable) {

   		//$variable = strip_tags(mysqli_real_escape_string($variable));
   		return $variable; 
   	}
}