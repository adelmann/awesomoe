<?php

class aw_projects extends aw_base
{
	protected $oActUser = 0;
    private $iProjectID;
	public function __construct() {
		parent::__construct();
		if(!empty($_SESSION['awid'])) {
			$userid = $_SESSION['awid'];
			$aRights = $this->getRights4Projects();
		}

		$sActPID = $this->getParameter('project');
		if (is_numeric($sActPID)) {
            $this->iProjectID = $sActPID;
        } else {
            $sGetProjectIDSQL = "
                SELECT awid FROM awprojects WHERE awprefix = '".$sActPID."' LIMIT 1;
            ";
            $oResult = $this->_db->getOne($sGetProjectIDSQL,'assoc');
            $this->iProjectID = $oResult['awid'];
        }
	}
	
	protected function getRights4Projects() {
		global $oUsers;
		$aUserRights = $oUsers->getGroupRights();
	}
	
	public function getProject() {
		$sSelect = "SELECT * FROM awprojects WHERE awid = '".$this->iProjectID."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult;
	}
	
	public function getProjects() {
		global $oUsers;
		$aUserRights = $oUsers->getUserDatas($_SESSION['awid']);
		if ($aUserRights['awgroup'] == '1') {
			$sSelect = "SELECT * FROM awprojects";
		} else {
			$sSelect = "
				SELECT awprojects.* FROM awprojects
					INNER JOIN awusers2projects as u2p
					ON u2p.awuserid = '".$_SESSION['awid']."'
					and u2p.awprojectid = awprojects.awid
					#ORDER BY awprojects.awworkflowpos
			";
		}
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	public function getProjectName($id) {
		$sSelect = "SELECT awname FROM awprojects WHERE awid='".$id."'";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['awname'];
	}
	
	public function getTasks() {
		$sSelect = "
			SELECT tasks.*,prio.awname, prio.awcolor FROM awtasks as tasks
				LEFT JOIN awprio as prio
				ON prio.awid = tasks.awprio
			WHERE awproject = '".$this->iProjectID."';";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	public function getTask() {
		$sSelect = "
			SELECT tasks.*,prio.awname, prio.awcolor FROM awtasks as tasks
				LEFT JOIN awprio as prio
				ON prio.awid = tasks.awprio
			WHERE tasks.awproject = '".$this->iProjectID."' AND tasks.awid='".$this->getParameter('task')."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult;
	}
	
	
	public function countTasks($projectid) {
		$sSelect = "SELECT count(*) as count FROM awtasks WHERE awproject = '".$projectid."' AND awworkflowpos != '99';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['count'];
	}
	
	
	protected function delete() {
		$iProjectId = $this->iProjectID;
		$sDELETE = "
				DELETE FROM awprojects WHERE awprojects.awid = '".$iProjectId."';
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
	
	protected function save() {
		if ($this->getParameter('awid') != '-1') {
			$aSaveParams = $this->getAllParameter($_POST);
			ksort($aSaveParams);
			$sUpdateProject = "UPDATE awprojects SET ";
			//$countSave = count($aSaveParams);
			$countSave = 0;
			//$countSave = $countSave-1;
			$count = 0;
			$proof = 0;
			
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false) {
					$countSave++;
				}
			}
			$countSave = $countSave-1;
			
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid') {
					$sUpdateProject .= $key."='".$value."'";
					if ($count < $countSave) {
						$sUpdateProject .= ", ";
						$proof ++;
					}
				}
				$count++;
			}
			$sUpdateProject .= " WHERE awid='".$this->getParameter('awid')."';";
			foreach ($this->getAllParameter($_POST) as $key=>$value) {
				$sUser2ProjectSQL = '';
					$iUserPos = strpos($key,'user-');
					if ($iUserPos !== false) {
						$iUserId = str_replace("user-", "", $key);
						$sExistSelect = "SELECT * FROM awusers2projects WHERE awuserid = '".$iUserId."' AND awprojectid = '".$this->getParameter('awid')."'";
						$aResult = $this->_db->getOne($sExistSelect,'assoc');
						
						if(!empty($aResult) && $value=='0') {
							$sUser2ProjectSQL = "
								DELETE FROM awusers2projects WHERE awusers2projects.awprojectid = '".$this->getParameter('awid')."' AND awusers2projects.awuserid = '".$iUserId."';
							";
						} elseif(empty($aResult) && $value=='1') {
							$sUser2ProjectSQL = "
								INSERT INTO awusers2projects (awprojectid,awuserid) VALUES ('".$this->getParameter('awid')."', '".$iUserId."');
							";
						}

						if(!empty($sUser2ProjectSQL)) {
							$this->_db->startTransaction();
							try{
								$this->_db->query($sUser2ProjectSQL);
								$this->_db->commit();
							}
							catch(Exception $e){
								$this->_db->rollback();
								return false;
							};
						}
					}
			}
			
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
			//echo $sUpdateProject;die();
			$this->_db->startTransaction();
			try{				
				$iInsertId = $this->_db->query($sUpdateProject, 'id');
				$this->_db->commit();
				return $iInsertId;
			}
			catch(Exception $e){
				$this->_db->rollback();
				print_r($e);die();
				return false;
			};
			return true;
		}
	}
	
	public function saveProjectAvatar($sImageName){
		$aSaveParams = $this->getAllParameter($_POST);
		$sUpdate = "UPDATE awprojects SET awpicture = '".$sImageName."' WHERE awid = '".$aSaveParams['awid']."'";
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
	
}