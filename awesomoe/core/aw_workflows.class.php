<?php
class aw_workflows extends aw_base
{
	public function __construct() {
		parent::__construct();
		if(!empty($_SESSION['awid'])) {
			$userid = $_SESSION['awid'];
			$aRights = $this->getRights4Projects();
		}
	}
	
	
	public function getWorkflows() {
		global $oUsers;
		$aUserRights = $oUsers->getUserDatas($_SESSION['awid']);
		if ($aUserRights['awgroup'] == '1') {
			$sSelect = "SELECT * FROM awworkflow";
		}
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	protected function getRights4Projects() {
		global $oUsers;
		$aUserRights = $oUsers->getGroupRights();
	}
	
	public function getWorkflow($workflowid = false) {
		if ($workflowid == false) {
			$sSelect = "SELECT * FROM awworkflowsteps WHERE awworkflow = '".$this->getParameter('workflow')."' ORDER BY awsort;";
		} else {
			$sGetWorkflow = "SELECT awworkflow FROM awprojects where awid ='".$workflowid."';";
			$aResult = $this->_db->getOne($sGetWorkflow,'assoc');
			$sSelect = "SELECT * FROM awworkflowsteps WHERE awworkflow = '".$aResult['awworkflow']."' ORDER BY awsort;";
		}
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	
	protected function save() {
		if ($this->getParameter('awid') != '-1') {
			$aSaveParams = $this->getAllParameter($_POST);
			global $oUtils;
			$countSave = count($aSaveParams);
			$countSave = $countSave-1;
			$count = 0;
			
			foreach ($aSaveParams as $key=>$value) {

				$iStepID = preg_replace('/awname-/','',$key);
				$iStepID = preg_replace('/-sort[0-9]/','',$iStepID);
				$iSort = preg_replace('/(.*?)-sort/','',$key);
				$oUtils->writeToLog(date("m-d-y H:m:s").':: sql :'.$iStepID. ' key:'.$key.' sort:'.$iSort,'sql_exception.log');


				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid') {
					if ($iStepID == 0) {
						$sUpdateProject = "REPLACE INTO awworkflowsteps (awworkflow,awname,awsort) VALUES ('".$this->getParameter('awid')."','".$value."','".$iSort."');";
					} else {
						$sUpdateProject = "REPLACE INTO awworkflowsteps (awid,awworkflow,awname,awsort) VALUES ('".$iStepID."','".$this->getParameter('awid')."','".$value."','".$iSort."');";
					}
					$oUtils->writeToLog(date("m-d-y H:m:s").':: sql :'.$sUpdateProject,'sql_exception.log');
					$this->_db->startTransaction();
					try{
						$this->_db->query($sUpdateProject);
						$this->_db->commit();
					}
					catch(Exception $e){
						$this->_db->rollback();
						return false;
					};
				}
			}
		} else {
			$aSaveParams = $this->getAllParameter($_POST);
			$sUpdateProject = "INSERT INTO awprojects ";
			$countSave = count($aSaveParams);
			$countSave = $countSave-4;
			$count = 0;
			$keynames = '';
			$keyvals = '';
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid') {
					$keynames .= $key;
					$keyvals .= "'".$value."'";
					if ($count < $countSave) {
						$keynames .= ",";
						$keyvals .= ",";
					}
					$count++;
				}
			}
			$sUpdateProject .= "(".$keynames.") VALUES (".$keyvals.")";
			die($sUpdateProject);
					
			$this->_db->startTransaction();
			try{				
				$this->_db->query($sUpdateProject);
				$this->_db->commit();
			}
			catch(Exception $e){
				$this->_db->rollback();
				return false;
			};
			return true;
		}
	}
	
	protected function deletestep() {
		$iAwid = $this->getParameter('awid');
		$iWorkflowStepId = $this->getParameter('delitem');
		$sDELETE = "
				DELETE FROM awworkflowsteps WHERE awworkflow = '".$iAwid."' AND awsort = '".$iWorkflowStepId."'
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

	/* TODO */
	protected function delete() {
		$iWorkflow = $this->getParameter('workflow');
		$sDELETE = "
				DELETE FROM awworkflow WHERE awworkflow.awid = '".$iWorkflow."';
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
	
	protected function addWorkflow() {
		if ($this->getParameter('awid') == '-1') {
			$sUpdateProject = "INSERT INTO awworkflow (awname) VALUES ('".$this->getParameter('awname')."');";
			$this->_db->startTransaction();
			try{				
				$this->_db->query($sUpdateProject);
				$this->_db->commit();
			}
			catch(Exception $e){
				$this->_db->rollback();
				return false;
			};
			return true;
		}
	}
	
}