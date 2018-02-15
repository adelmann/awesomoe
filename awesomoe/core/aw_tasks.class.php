<?php

class aw_tasks extends aw_base
{
	protected $oActUser = 0;
    private $iProjectID;
	public function __construct() {
		parent::__construct();
		if(!empty($_SESSION['awid'])) {
			$userid = $_SESSION['awid'];
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
	
	public function getTasts4Project() {
		global $oUsers;
		$aUserRights = $oUsers->getUserDatas($_SESSION['awid']);
		if ($aUserRights['awgroup'] == '1') {
			$sSelect = "SELECT * FROM awprojects";
		} else {
			$sSelect = "
				SELECT awtasks.* FROM awtasks
					INNER JOIN awusers2projects as u2p
						ON u2p.awuserid = '".$_SESSION['awid']."'
						AND u2p.awprojectid = awprojects.awid
					INNER JOIN awtasks as tasks
						ON tasks.awproject = '".$this->iProjectID."'
			";
		}
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	public function countMyTasks() {
		$sCountTasks = "
			SELECT count(*) as counttasks FROM awtasks WHERE awowner = '".$_SESSION['awid']."' AND awworkflowpos != '99'
		";
		$oResult = $this->_db->query($sCountTasks,'assoc');
		return $oResult[0]['counttasks'];
	}
	public function getLastWorkedTasks() {
		$sGetLastTasks = "
			SELECT tasks.*,prio.awname,prio.awcolor,projects.awname, workflow.awname as workflowpos FROM awtasks as tasks
				LEFT JOIN awprio as prio
					ON prio.awid = tasks.awprio 
				LEFT JOIN awprojects as projects
					ON projects.awid = tasks.awproject
				LEFT JOIN awworkflowsteps as workflow
					ON workflow.awworkflow = projects.awworkflow
					AND workflow.awid = tasks.awworkflowpos
			WHERE tasks.awowner = '".$_SESSION['awid']."' AND tasks.awworkflowpos != '99' ORDER BY tasks.awprio DESC
		";
		$oResult = $this->_db->query($sGetLastTasks,'assoc');
		return $oResult;
	}
	
	public function getTaskName($id) {
		$sSelect = "SELECT awtitle FROM awtasks WHERE awid='".$id."'";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['awtitle'];
	}
	
	public function getTasks() {
		$sSelect = "
			SELECT tasks.*,prio.awname, prio.awcolor FROM awtasks as tasks
				LEFT JOIN awprio as prio
				ON prio.awid = tasks.awprio
			WHERE awproject = '".$this->iProjectID."' ORDER BY tasks.awprio DESC;";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}

	public function getArchive() {
		$sSelect = "
			SELECT tasks.*,prio.awname, prio.awcolor FROM awtasks as tasks
				LEFT JOIN awprio as prio
				ON prio.awid = tasks.awprio
			WHERE awproject = '".$this->iProjectID."' AND awworkflowpos = 99 ORDER BY tasks.awprio DESC;";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}


	
	public function getOnlyMyTasks() {
		$sSelect = "
			SELECT tasks.*,prio.awname, prio.awcolor, project.awname as projectname
				FROM awtasks as tasks
				LEFT JOIN awprio as prio
					ON prio.awid = tasks.awprio
				INNER JOIN awprojects as project
					ON project.awid = tasks.awproject
			WHERE awowner = '".$_SESSION['awid']."' AND awworkflowpos != '99' ORDER BY tasks.awprio DESC;";
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
		$oResult['awdescription'] = stripslashes($oResult['awdescription']);
		return $oResult;
	}
	
	public function getWorkflowList() {
        if (!empty($this->iProjectID)) {
            $projectid = $this->iProjectID;
        } else {
            $projectid = $this->getParameter('awprojectid');
        }
		$sSelect = "
			SELECT steps.*
			FROM awworkflowsteps as steps
				INNER JOIN awprojects as projects
					ON projects.awid='".$projectid."'
				INNER JOIN awworkflow as workflow
					ON workflow.awid = projects.awworkflow
			
			WHERE steps.awworkflow = projects.awworkflow
			GROUP BY steps.awid;";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}

	public function maxSteps() {
		if (!empty($this->iProjectID)) {
			$projectid = $this->iProjectID;
		} else {
			$projectid = $this->getParameter('awprojectid');
		}

		$sSelect = "
			SELECT max(steps.awsort) as maxstep
				FROM awworkflowsteps as steps
				INNER JOIN awprojects as projects
				ON projects.awid='".$projectid."'
				WHERE steps.awworkflow = projects.awworkflow;
		";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult[0]['maxstep'];
	}

	public function set2archive(){
		$sUpdateTask = "UPDATE awtasks SET awworkflowpos = '99' WHERE awproject='".$this->iProjectID."' AND awid='".$this->getParameter('task')."'";
		$this->_db->startTransaction();
			try{
				$this->_db->query($sUpdateTask);
				$this->_db->commit();
			}
			catch(Exception $e){
				$this->_db->rollback();
				return false;
			};
	}

	public function getPrioList() {
		$sSelect = "SELECT * FROM awprio ORDER BY awsort;";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	public function getUser2Project() {
		$sSelect = "SELECT * FROM awprio;";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}

	protected function save() {
		$oHistory = new aw_history();
		if ($this->getParameter('awid') != '-1') {
			$aSaveParams = $this->getAllParameter($_POST);
			ksort($aSaveParams);
			$sUpdateTask = "UPDATE awtasks SET ";
			$countSave = 0;
			
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false) {
					$countSave++;
				}
			}

			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid') {
					if ($key == 'awdescription') {
						$sUpdateTask .= $key."='".addslashes($value)."',";
					} else {
						$sUpdateTask .= $key."='".$value."',";
					}

				}
			}
			$sUpdateTask .= "awupdate='".date("Y-m-d H:i:s")."' WHERE awid='".$this->getParameter('awid')."';";
			$oNotification = new aw_notification();
			$oNotification->notificationHandler(4);

			$oHistory->getOriginalval2Compare('2','1',$this->getAllParameter($_POST));

			$this->_db->startTransaction();
			try{
				$this->_db->query($sUpdateTask);
				$this->_db->commit();
			}
			catch(Exception $e){
				//echo $sUpdateTask;
				$this->_db->rollback();
				return false;
			};

			return true;
		} else {
			$aSaveParams = $this->getAllParameter($_POST);
			$sUpdateTask = "INSERT INTO awtasks ";
			$countSave = count($aSaveParams);
			$countSave = $countSave-6;
			$count = 0;
			$maxCounter = $this->getLastId();
			$maxCounter = $maxCounter+1;
			$keynames = '';
			$keyvals = '';
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid' && $key != 'awnumber') {
					if ($key == 'awdescription') {
						$keynames .= $key . ",";
						$keyvals .= "'" . addslashes($value) . "',";
						$count++;
					} elseif ($key == 'awstart' || $key == 'awdeadline') {
						$keynames .= $key . ",";
						if ($value == null || $value == '') {
							$keyvals .= "NULL,";
						} else {
							$keyvals .= "'" . $value . "',";
						}

						$count++;
					} else {
						if ($value == '') {
							$value = '0';
						}
						$keynames .= $key.",";
						$keyvals .= "'".$value."',";
						$count++;
					}
				}
			}
			$keynames .= "awnumber,awcreate,awcreator, awupdate";
			$keyvals .= $maxCounter.",'".date("Y-m-d H:i:s")."','".$_SESSION['awid']."','".date("Y-m-d H:i:s")."'";
			$sUpdateTask .= "(".$keynames.") VALUES (".$keyvals.")";
			$oHistory->getOriginalval2Compare('2','2',$this->getAllParameter($_POST));
			$this->_db->startTransaction();
			try{
				$iInsertId = $this->_db->query($sUpdateTask, 'id');
				$this->_db->commit();
				return $iInsertId;
			}
			catch(Exception $e){
				$this->_db->rollback();
				return false;
			};

			$oNotification = new aw_notification();
			$oNotification->notificationHandler(6);
			return true;
		}
	}
	
	protected function getLastId(){
		$sSelect = "SELECT max(awnumber) as count FROM awtasks WHERE awproject='".$this->iProjectID."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['count'];
	}
	
	protected function delete() {
		$iProjectId = $this->iProjectID;
		$iTaskId = $this->getParameter('task');
		$sDELETE = "
				DELETE FROM awtasks WHERE awproject = '".$iProjectId."' AND awid = '".$iTaskId."';
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
	
	protected function changeTaskState() {
		$sUpdateTask = "UPDATE awtasks SET awworkflowpos = '".$this->getParameter('awworkflowpos')."' WHERE awproject='".$this->getParameter('awprojectid')."' AND awid = '".$this->getParameter('awtaskid')."'";
		$_GET['awid'] = $this->getParameter('awtaskid');

		$oNotification = new aw_notification();
		$oNotification->notificationHandler(3);

		$oHistory = new aw_history();
		$oHistory->getOriginalval2Compare('2','1',$_GET);

		$this->_db->startTransaction();
		try{
			$this->_db->query($sUpdateTask);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		return true;
	}
	
	protected function changeAssignee() {
		$iOwner =  (int)$this->getParameter('awowner');
		$sUpdateTask = "UPDATE awtasks SET awowner = '".$iOwner."' WHERE awproject='".$this->getParameter('awprojectid')."' AND awid = '".$this->getParameter('awtaskid')."'";
		$_GET['awid'] = $this->getParameter('awtaskid');

		$oNotification = new aw_notification();
		$oNotification->notificationHandler(5);

		$oHistory = new aw_history();
		$oHistory->getOriginalval2Compare('2','1',$_GET);
		$this->_db->startTransaction();
		try{
			$this->_db->query($sUpdateTask);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		return true;
	}
	
	public function getRemainingTime() {
		$taskinfo = $this->getTask();
		$createdate = StrToTime($taskinfo['awcreate']);
		$deadlinedate = StrToTime ($taskinfo['awdeadline']);
		$diff = $deadlinedate-$createdate;
		$hours = $diff / ( 60 * 60 );
		return $diff;
	}
	
	public function workedtime() {
		$sSelect = "SELECT awtime FROM awworklog WHERE awtaskid='".$this->getParameter('task')."' AND awprojectid='".$this->iProjectID."';";
		$oResult = $this->_db->query($sSelect,'assoc');
		$hours = 0;
		$minutes = 0;
		foreach ($oResult as $timelog) {
			$aTime = explode(":", $timelog['awtime']);
			$hours = $hours + intval($aTime[0]);
			if (($minutes + intval($aTime[1]))<60) {
				$minutes = $minutes + intval($aTime[1]);
			} else {
				$calcMinutes = $minutes + intval($aTime[1]);
				$hours = $hours + 1;
				$minutes = $calcMinutes - 60;
			}
		}
		
		return $hours.':'.$minutes;
	}

	public function getAllActivitys() {
		$iProjectId = $this->iProjectID;
		$iTaskId = $this->getParameter('task');

		// Worklog
		$sWorklogSelect = "SELECT awdate,awuser,awdesc as awworklogdesc, awtime FROM awworklog WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' ORDER BY awdate;";

		// Comments
		$sCommentsSelect = "SELECT awdate,awuser,awdesc as awcommentsdesc FROM awcomments WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' ORDER BY awdate;";

		// History
		$sHistorySelect = "SELECT awdate,awuser,awfield,awpreval,awafterval FROM awhistory WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' ORDER BY awdate;";

		$aWorklogResult = $this->_db->query($sWorklogSelect,'assoc');
		$aCommentsResult = $this->_db->query($sCommentsSelect,'assoc');
		$aHistoryResult = $this->_db->query($sHistorySelect,'assoc');

		$result = array_merge($aWorklogResult, $aCommentsResult, $aHistoryResult);
		$resultnew = $this->array_sort_by_column($result, 'awdate');
		return $result;
	}

	public function array_sort_by_column(&$array, $column, $direction = SORT_ASC) {
		$reference_array = array();

		foreach($array as $key => $row) {
			$reference_array[$key] = $row[$column];
		}

		array_multisort($reference_array, $direction, $array);
	}
	
	
	public function getOverTimedTasks() {
		$sSelect = "
			SELECT tasks.*,prio.awname, prio.awcolor, project.awname as projectname
				FROM awtasks as tasks
				LEFT JOIN awprio as prio
					ON prio.awid = tasks.awprio
				INNER JOIN awprojects as project
					ON project.awid = tasks.awproject
			WHERE awowner = '".$_SESSION['awid']."' AND awdeadline != '0000-00-00' AND awworkflowpos != '99' AND unix_timestamp(awdeadline) < unix_timestamp(CURDATE()) ORDER BY tasks.awprio DESC;";
		$oResult = $this->_db->query($sSelect,'assoc');

		return $oResult;
	}
}
	