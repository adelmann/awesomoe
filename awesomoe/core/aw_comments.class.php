<?php
class aw_comments extends aw_base
{
	public function __construct() {
		parent::__construct();	
	}
	
	public function save() {
		$actDateTime = date('Y-m-d H:i:s');
		if (!empty($this->getParameter('awid'))) {
			$sSaveComment  = "UPDATE awcomments SET awdesc = '".addslashes($this->getParameter('awdesc'))."' WHERE awid = '".$this->getParameter('awid')."'";
		} else {
			$sSaveComment = "INSERT INTO awcomments (awprojectid,awtaskid,awdesc,awdate,awuser) VALUES ('".$this->getParameter('awprojectid')."','".$this->getParameter('awtaskid')."','".addslashes($this->getParameter('awdesc'))."','".$actDateTime."','".$_SESSION['awid']."')";
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
		$oNotification->notificationHandler(1);
		return true;
	}
	
	public function getComment4Task() {
		$iProjectId = $this->getParameter('project');
		$iTaskId = $this->getParameter('task');
		$sSelect = "SELECT * FROM awcomments WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' ORDER BY awdate;";
		$aResult = $this->_db->query($sSelect,'assoc');
		if (!empty($aResult['awdesc'])){$aResult['awdesc'] = stripslashes($aResult['awdesc']);}
		return $aResult;
	}
	
	public function getComment2Edit() {
		$iProjectId = $this->getParameter('project');
		$iTaskId = $this->getParameter('task');
		$iCommentId = $this->getParameter('awcommentid');
		$sSelect = "SELECT * FROM awcomments WHERE awprojectid = '".$iProjectId."' AND awtaskid = '".$iTaskId."' and awid = '".$iCommentId."';";
		$aResult = $this->_db->getOne($sSelect,'assoc');
		return $aResult;
	}
	
	public function deleteComment() {
		$iProjectId = $this->getParameter('project');
		$iTaskId = $this->getParameter('task');
		$iCommentId = $this->getParameter('awcommentid');
		$sDELETE = "
				DELETE FROM awcomments WHERE awprojectid  = '".$iProjectId."' AND awid = '".$iCommentId."' AND awtaskid = '".$iTaskId."';
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