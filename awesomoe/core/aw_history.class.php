<?php
class aw_history extends aw_base
{
	public function __construct() {
		parent::__construct();	
	}


	public function getOriginalval2Compare($table,$type,$aVals) {
		if ($table == '1') {
			$sSelect = "SELECT * FROM awworklog WHERE awprojectid = '".$aVals['awprojectid']."' AND awtaskid = '".$aVals['awtaskid']."' AND awid='".$aVals['awid']."';";
			$aOldVals = $this->_db->getOne($sSelect,'assoc');
			
			$result = array_diff($aVals, $aOldVals);
			
			$aOnlyChanges = array();
			foreach ($result as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false) {
					$this->addHistoryEntry('1',$aOldVals[$key],$value,$aVals['awprojectid'],$aVals['awtaskid'],$key);
				}
			}
		} elseif($table == '2') {
			$sSelect = "SELECT * FROM awtasks WHERE awid='".$aVals['awid']."';";
			$aOldVals = $this->_db->getOne($sSelect,'assoc');
			if (is_array($aOldVals)){
				$result = array_diff($aVals, $aOldVals);
			} else {
				$result = $aVals;
			}

			$aOnlyChanges = array();
			foreach ($result as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false) {
					$this->addHistoryEntry('2',$aOldVals[$key],$value,$aOldVals['awproject'],$aOldVals['awid'],$key);
				}
			}
		}
	}
	
	public function addHistoryEntry($awtype,$awpreval = null,$awafterval,$awprojectid,$awtaskid,$awfield){
		$actDateTime = date('Y-m-d H:i:s');
		$sInsertHistory = "INSERT INTO awhistory (awtype,awpreval,awafterval,awdate,awuser,awprojectid,awtaskid,awfield) VALUES ('".$awtype."','".$awpreval."','".$awafterval."','".$actDateTime."','".$_SESSION['awid']."','".$awprojectid."','".$awtaskid."','".$awfield."')";
		//echo $sInsertHistory;
		$this->_db->startTransaction();
		try{
			$this->_db->query($sInsertHistory);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		return true;
	}
	
	public function getHistory4Task() {
		$iProjectId = $this->getParameter('project');
		$iTaskId = $this->getParameter('task');
		$sSelect = "SELECT * FROM awhistory WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' ORDER BY awdate;";
		$aResult = $this->_db->query($sSelect,'assoc');
		return $aResult;
	}
}
	