<?php
class aw_notification extends aw_base
{
	/*
		Notification Table
		1=Comment,2=Worklog,3=Status,4=Description,5=Assignee,6=NewTask
		
		Notification User Setting:
		0=No Notification
		1=Only in Awesomoe Notification
		2=Only in Mail Notification
		3=Mail and in Awesomoe Notification
	*/
	
	public function __construct() {
		parent::__construct();	
	}

    /**
     * Returns all User Ids for Notification
     *
     * @return array
     */
    public function getAllUsers4Notification($iNotificationType) {

		if ($iNotificationType == '1') {
			$sNotificationColumn = 'awnotification2comment';
		} elseif ($iNotificationType == '2') {$sNotificationColumn = 'awnotification2worklog';
		} elseif ($iNotificationType == '3') {$sNotificationColumn = 'awnotification2state';
		} elseif ($iNotificationType == '4') {$sNotificationColumn = 'awnotification2description';
		} elseif ($iNotificationType == '5') {$sNotificationColumn = 'awnotification2assignee';
		} elseif ($iNotificationType == '6') {$sNotificationColumn = 'awnotification2newtask';}
		if (!empty($_GET)) {
			$awprojectid = $this->getParameter('awprojectid');
		} elseif(!empty($_POST)) {
			$awprojectid = $this->getParameter('project');
		}
		$sSelectUser = "
			SELECT users.awid, users.$sNotificationColumn
				FROM awusers as users
				INNER JOIN awusers2projects as u2p
					ON u2p.awuserid = users.awid
					AND u2p.awprojectid = '".$awprojectid."'
				LEFT JOIN awtasks as taskscreator
					ON taskscreator.awcreator = users.awid
				LEFT JOIN awtasks as tasksowner
					ON tasksowner.awowner = users.awid
				WHERE users.$sNotificationColumn != '0'
					AND users.awid != '".$_SESSION['awid']."'
				GROUP BY users.awid;
		";
		$oResult = $this->_db->query($sSelectUser,'assoc');
		echo $sSelectUser.'<hr>';
        return $oResult;
    }

    /**
     * Add Notification Entry in DB
     *
     * @return array
     */
    public function addDBNotification($user,$iNotificationType){
		$actDateTime = date('Y-m-d H:i:s');
		if (!empty($_GET)) {
			$awprojectid = $this->getParameter('awprojectid');
			$awtaskid = $this->getParameter('awtaskid');
		} elseif(!empty($_POST)) {
			$awprojectid = $this->getParameter('project');
			$awtaskid = $this->getParameter('awid');
		}
		// Handler for New Tasks
		if ($iNotificationType == '6') {
			$sSelectTaskId = "
			SELECT awid
				FROM awtasks
				WHERE awtitle = '".$this->getParameter('awtitle')."'
				ORDER BY awid desc limit 1;
			";
			$oResult = $this->_db->query($sSelectTaskId,'assoc');
			$awtaskid = $oResult[0]['awid'];
		}
		$sAddDBNotification= "INSERT INTO awnotifications (awuserid,awchanginguser,awprojectid,awtaskid,awtype,awdatetime,awisread) VALUES ('".$user['awid']."','".$_SESSION['awid']."','".$awprojectid."','".$awtaskid."','".$iNotificationType."','".$actDateTime."','0')";
		$this->_db->startTransaction();
		try{
			$this->_db->query($sAddDBNotification);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
	}

    /**
     * Send Notification via Mail
     *
     * @return array
     */
    public function sendMailNotification($user,$iNotificationType){
		global $smarty,$oLang,$oMail;
		$actDateTime = date('Y-m-d H:i:s');
		if (!empty($_GET)) {
			$awprojectid = $this->getParameter('awprojectid');
			$awtaskid = $this->getParameter('awtaskid');
		} elseif(!empty($_POST)) {
			$awprojectid = $this->getParameter('project');
			$awtaskid = $this->getParameter('awid');
		}
		// Handler for New Tasks
		if ($iNotificationType == '6') {
			$sSelectTaskId = "
			SELECT awid
				FROM awtasks
				WHERE awtitle = '".$this->getParameter('awtitle')."'
				ORDER BY awid desc limit 1;
			";
			$oResult = $this->_db->query($sSelectTaskId,'assoc');
			$awtaskid = $oResult[0]['awid'];
		}
		$sSelectUserMail = "
			SELECT awmail
				FROM awusers
				WHERE awid = '".$user['awid']."';
			";
		$oUserResult = $this->_db->getOne($sSelectUserMail,'assoc');

		$sSelectTaskName = "
			SELECT awtitle
				FROM awtasks
				WHERE awid = '".$awtaskid."'
				AND awproject = '".$awprojectid."'
			";
		$oTaskResult = $this->_db->query($sSelectTaskName,'assoc');
		$awtaskname = $oTaskResult[0]['awtitle'];

		$smarty->assign('awuserid',$user['awid']);
		$smarty->assign('awchanginguser',$_SESSION['awid']);
		$smarty->assign('awprojectid',$awprojectid);
		$smarty->assign('awtaskid',$awtaskid);
		$smarty->assign('awtaskname',$awtaskname);
		$smarty->assign('awtype',$iNotificationType);
		$smarty->assign('awdatetime',$actDateTime);
		$sMailContent  = $smarty->fetch('tpl/mail/header.tpl');
		$sMailContent .= $smarty->fetch('tpl/mail/notification.tpl');
		$sMailContent .= $smarty->fetch('tpl/mail/footer.tpl');
		$sSubject = $oLang->translateString('TASKCHANGE');
		$oMail->sendmail($oUserResult['awmail'],$sSubject,$sMailContent);

	}



	/**
	 * Notification Handler
	 */
	public function notificationHandler($iNotificationType){

		$aUserIds = $this->getAllUsers4Notification($iNotificationType);
        foreach ($aUserIds as $key=>$user) {
            if (
				(isset($user['awnotification2state']) && $user['awnotification2state'] == '1') ||
				(isset($user['awnotification2assignee']) && $user['awnotification2assignee'] == '1') ||
				(isset($user['awnotification2worklog']) && $user['awnotification2worklog'] == '1') ||
				(isset($user['awnotification2comment']) && $user['awnotification2comment'] == '1') ||
				(isset($user['awnotification2description']) && $user['awnotification2description'] == '1') ||
				(isset($user['awnotification2newtask']) && $user['awnotification2newtask'] == '1')
			){
                $this->addDBNotification($user,$iNotificationType);
            } elseif (
				(isset($user['awnotification2state']) && $user['awnotification2state'] == '2') ||
				(isset($user['awnotification2assignee']) && $user['awnotification2assignee'] == '2') ||
				(isset($user['awnotification2worklog']) && $user['awnotification2worklog'] == '2') ||
				(isset($user['awnotification2comment']) && $user['awnotification2comment'] == '2') ||
				(isset($user['awnotification2description']) && $user['awnotification2description'] == '2') ||
				(isset($user['awnotification2newtask']) && $user['awnotification2newtask'] == '2')
			){
                $this->sendMailNotification($user,$iNotificationType);
            } elseif (
				(isset($user['awnotification2state']) && $user['awnotification2state'] == '3') ||
				(isset($user['awnotification2assignee']) && $user['awnotification2assignee'] == '3')  ||
				(isset($user['awnotification2worklog']) && $user['awnotification2worklog'] == '3') ||
				(isset($user['awnotification2comment']) && $user['awnotification2comment'] == '3') ||
				(isset($user['awnotification2description']) && $user['awnotification2description'] == '3') ||
				(isset($user['awnotification2newtask']) && $user['awnotification2newtask'] == '3')
			){
				$this->addDBNotification($user,$iNotificationType);
                $this->sendMailNotification($user,$iNotificationType);
            }
        }
	}

	public function getNotificationCounter(){
		$sCount = "
			SELECT COUNT(awid) as countNotifications
				FROM awnotifications
				WHERE awuserid = '".$_SESSION['awid']."' AND awisread != '1'
		";
		$oResult = $this->_db->query($sCount,'assoc');
		return $oResult[0]['countNotifications'];
	}

	public function getAllNotification4User(){
		$sCount = "
			SELECT notification.*, projects.awname as projectname, tasks.awtitle as taskname, users.awname as username, users.awlastname as userlastname
				FROM awnotifications as notification
				LEFT JOIN awprojects as projects
					ON projects.awid = notification.awprojectid
				LEFT JOIN awtasks as tasks
					ON tasks.awid = notification.awtaskid
				LEFT JOIN awusers as users
					ON users.awid = notification.awchanginguser
				WHERE awuserid = '".$_SESSION['awid']."' AND awisread != '1'
		";
		$oResult = $this->_db->query($sCount,'assoc');
		return $oResult;
	}

	public function setNotificationToRead($awid) {
		$sUpdateNotification = "
			UPDATE awnotifications SET awisread='1' WHERE awid='".$awid."' AND awuserid='".$_SESSION['awid']."'
		";
		$this->_db->startTransaction();
		try{
			$this->_db->query($sUpdateNotification);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
	}

}