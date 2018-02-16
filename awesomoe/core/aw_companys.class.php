<?php

class aw_companys extends aw_base
{
	protected $oActCompany = 0;

	public function __construct() {
		parent::__construct();
		global $smarty;
	}
	
	public function getCompanyDatas($iId) {
		$sSelect = "SELECT * FROM awcompanys WHERE awid = '".$iId."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult;
	}

    public function getCompanyName($iId) {
		$sSelect = "SELECT awname FROM awcompanys WHERE awid = '".$iId."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['awname'];
	}
	public function getCompanyAvatar($iId){
		$sSelect = "SELECT awavatar FROM awcompanys WHERE awid = '".$iId."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['awavatar'];
	}
	public function saveUserAvatar($sImageName){
		$aSaveParams = $this->getAllParameter($_POST);
		$sUpdate = "UPDATE awcompanys SET awavatar = '".$sImageName."' WHERE awid = '".$this->getParameter('awid')."'";
		$this->_db->startTransaction();
		try{
			$this->_db->query($sUpdate);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		return true;
	}

    public function getAllCompanys() {
        $sSelect = "SELECT * FROM awcompanys";
        $oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
    }
	
	protected function save() {
        $this->_utils->writeToLog(date("m-d-y H:m:s").':: comes in save :'.PHP_EOL,'companys.log');
		$aSaveParams = $this->getAllParameter($_POST);
        $actDateTime = date('Y-m-d H:i:s');

        if ($aSaveParams['awid'] != '-1') {
            $this->_utils->writeToLog(date("m-d-y H:m:s").'::UPDATE :'.PHP_EOL,'companys.log');
            $sUpdate = "UPDATE awcompanys SET ";
            $this->_db->startTransaction();
            foreach ($aSaveParams as $key=>$value) {
                $iPos = strpos($key,'aw');
                if ($iPos !== false && $key != 'awid') {
                    $sUpdate .= $key."='".$value."',";
                }
            }
            $sUpdate .= " awupdate = '".$actDateTime."'";

            try{

                $sUpdate .= " WHERE awid='".$aSaveParams['awid']."';";
                $this->_utils->writeToLog(date("m-d-y H:m:s").'::sql:'.$sUpdate.' :'.PHP_EOL,'companys.log');
                $this->_db->query($sUpdate);
                $this->_db->commit();
            }
            catch(Exception $e){
                $this->_db->rollback();
                return false;
            };
            return true;
        } else {
            $keynames = '';
            $keyvals = '';
            $sUpdate = "INSERT INTO awcompanys ";
            foreach ($aSaveParams as $key=>$value) {
                $iPos = strpos($key,'aw');
                if ($iPos !== false && $key !='awid') {
                    $keynames .= $key.",";
                    $keyvals .= "'".$value."',";
                }
            }
            $keynames .= 'awupdate,awadded';
            $keyvals .= "'".$actDateTime."','".$actDateTime."'";
            $sUpdate .= "(".$keynames.") VALUES (".$keyvals.")";
            $this->_db->startTransaction();
            try{
                $this->_utils->writeToLog(date("m-d-y H:m:s").'::sql:'.PHP_EOL.$sUpdate.PHP_EOL,'companys.log');
                $this->_db->query($sUpdate);
                $this->_db->commit();
            }
            catch(Exception $e){
                $this->_db->rollback();
                return false;
            };
            return true;
        }
	}

    protected function delete() {
        $iCompanyId = $this->getParameter('company');
        $sDELETE = "
				DELETE FROM awcompanys WHERE awid = '".$iCompanyId."';
			";
        $this->_db->startTransaction();
        try{
            $this->_db->query($sDELETE);
            $this->_db->commit();
        }
        catch(Exception $e){
            $this->_db->rollback();
            return false;
        };
        return true;
    }

}