<?php

/**
 * Class aw_worklog
 */
class aw_worklog extends aw_base
{
    /**
     * aw_worklog constructor.
     */
	public function __construct() {
		parent::__construct();
		
	}

    /**
     * save
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
	public function save() {
		$actDateTime = date('Y-m-d H:i:s');
		$oHistory = new aw_history();
		if (!empty($this->getParameter('awid'))) {
			$sSaveComment  = "UPDATE awworklog SET awdesc = '".$this->getParameter('awdesc')."',awtime='".$this->getParameter('awtime')."' WHERE awid = '".$this->getParameter('awid')."'";
		} else {
			$sSaveComment = "INSERT INTO awworklog (awprojectid,awtaskid,awtime,awdesc,awdate,awuser) VALUES ('".$this->getParameter('awprojectid')."','".$this->getParameter('awtaskid')."','".$this->getParameter('awtime')."','".$this->getParameter('awdesc')."','".$actDateTime."','".$_SESSION['awid']."')";
		}
		$this->_db->startTransaction();
		try{
			$this->_db->query($sSaveComment);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		$oNotification = new aw_notification();
		$oNotification->notificationHandler(2);
		return true;
	}

    /**
     * getWorklog4Task
     * -----------------------------------------------------------------------------------------------------------------
     * @return array
     */
	public function getWorklog4Task() {
		$iProjectId = $_GET['project'];
		$iTaskId = $_GET['task'];
		$sSelect = "SELECT * FROM awworklog WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' ORDER BY awdate;";
		$aResult = $this->_db->query($sSelect,'assoc');
		return $aResult;
	}

    /**
     * getWorklog2Edit
     * -----------------------------------------------------------------------------------------------------------------
     * @return array
     */
	public function getWorklog2Edit() {
		$iProjectId = $this->getParameter('project');
		$iTaskId = $this->getParameter('task');
		$iWorklogId = $this->getParameter('awworklogid');
		$sSelect = "SELECT * FROM awworklog WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' and awid = '".$iWorklogId."';";
		$aResult = $this->_db->getOne($sSelect,'assoc');
		return $aResult;
	}

    /**
     * deleteWorklog
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
	public function deleteWorklog() {
		$iProjectId = $this->getParameter('project');
		$iTaskId = $this->getParameter('task');
		$iWorklogId = $this->getParameter('awworklogid');
		$sDELETE = "
				DELETE FROM awworklog WHERE awprojectid  = '".$iProjectId."' AND awid = '".$iWorklogId."' AND awtaskid = '".$iTaskId."';
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