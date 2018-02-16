<?php

class aw_users extends aw_base
{
	protected $oActUser = 0;
	public function __construct() {
		parent::__construct();
		global $smarty;
		if(!empty($_SESSION['awid'])) {
			$userid = $_SESSION['awid'];
			$this->oActUser = $this->getUserDatas($userid);
			$smarty->assign("aActUser", $this->oActUser);
		}
	}

	public function getUserDatas($iId) {
		$sSelect = "
          SELECT awusers.*, awcompanys.awname as awcompanyname
            FROM awusers
             LEFT JOIN awcompanys
              ON awcompanys.awid = awusers.awcompany
            WHERE awusers.awid = '".$iId."';";
		//echo md5($password);
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult;
	}

    public function oChoosenUser($iId) {
        $sSelect = "SELECT * FROM awusers WHERE awid = '".$iId."';";
        //echo md5($password);
        $oResult = $this->_db->getOne($sSelect,'assoc');
        return $oResult;
    }



	public function getUserName($iId) {
		$sSelect = "SELECT awname,awlastname FROM awusers WHERE awid = '".$iId."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['awname'].' '.$oResult['awlastname'];
	}
	public function getUserInitial($iId) {
		$sSelect = "SELECT awname,awlastname FROM awusers WHERE awid = '".$iId."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return substr(str_pad($oResult['awname'],1),0,1).' '.substr(str_pad($oResult['awlastname'],1),0,1);
	}
	public function getUserAvatar($iId){
		$sSelect = "SELECT awavatar FROM awusers WHERE awid = '".$iId."';";
		$oResult = $this->_db->getOne($sSelect,'assoc');
		return $oResult['awavatar'];
	}
	public function saveUserAvatar($sImageName){
		$aSaveParams = $this->getAllParameter($_POST);
		$sUpdate = "UPDATE awusers SET awavatar = '".$sImageName."' WHERE awid = '".$this->getParameter('awid')."'";
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


	public function getAllUsersRel2Project() {
        if ($this->getParameter('project') != null) {
            $sSelect = "
                SELECT awusers.awid,awusers.awname,awusers.awlastname,awusers2projects.awprojectid FROM awusers
                    LEFT JOIN awusers2projects
                        ON awusers2projects.awprojectid = '".$this->getParameter('project')."'
                        AND awusers2projects.awuserid = awusers.awid
            ;";
            $oResult = $this->_db->query($sSelect,'assoc');
            return $oResult;
        }
        return null;
	}

    public function getAllUsers() {
        $sSelect = "
            SELECT users.*,GROUP_CONCAT(projects.awname SEPARATOR ', ') as projects
                FROM awusers as users
                    LEFT JOIN awusers2projects as user2project
                        ON user2project.awuserid = users.awid
                    LEFT JOIN awprojects as projects
                        ON projects.awid = user2project.awprojectid
                GROUP BY users.awid
        ";
        $oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;

    }


	public function getGroupRights() {
		$sSelectGroup = "
			SELECT awgroups.* FROM awgroups
				INNER JOIN awusers
					ON awusers.awid = '".$_SESSION['awid']."'
					AND awusers.awgroup = awgroups.awid
		";
		$oResult = $this->_db->query($sSelectGroup,'assoc');
		return $oResult;
	}

	public function getUsersFromProject() {
		$sSelect = "
			SELECT awusers.awname,awusers.awlastname,awusers.awid FROM awusers
				INNER JOIN awusers2projects
					ON awusers2projects.awprojectid = '".$this->getParameter('project')."'
					AND awusers2projects.awuserid = '".$_SESSION['awid']."'
		";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}

	protected function save() {
		$aSaveParams = $this->getAllParameter($_POST);
        $actDateTime = date('Y-m-d H:i:s');
        if ($aSaveParams['awid'] != '-1') {
            $sUpdate = "UPDATE awusers SET ";
            $this->_db->startTransaction();
            foreach ($aSaveParams as $key=>$value) {
                $iPos = strpos($key,'aw');
                if ($iPos !== false && $key != 'awid' && $key != 'awpassword') {
                    $sUpdate .= $key."='".$value."',";
                }
            }
            $sUpdate .= " awupdate = '".$actDateTime."'";
            if ($aSaveParams['awpassword'] != '') {
                $sUpdate .= ", awpassword = '".md5($aSaveParams['awpassword'])."'";
            } else {
                unset($aSaveParams['awpassword']);
            }
            try{

                $sUpdate .= " WHERE awid='".$aSaveParams['awid']."';";
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
            $sUpdate = "INSERT INTO awusers ";
            foreach ($aSaveParams as $key=>$value) {
                $iPos = strpos($key,'aw');
                if ($iPos !== false && $key !='awid' && $key !='awpassword') {
                    $keynames .= $key.",";
                    $keyvals .= "'".$value."',";
                } elseif($key =='awpassword') {
                    $keynames .= $key.",";
                    $keyvals .= "'".md5($value)."',";
                }
            }
            $keynames .= 'awupdate,awadded,awlastlogin,awgroup';
            $keyvals .= "'".$actDateTime."','".$actDateTime."','".$actDateTime."',3";
            $sUpdate .= "(".$keynames.") VALUES (".$keyvals.")";
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

    protected function delete() {
        $iUserId = $this->getParameter('user');
        $sDELETE = "
				DELETE FROM awusers WHERE awid = '".$iUserId."';
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

    public function getStartInfos() {
        global $oConfig,$oProjects;

        $iNewTasksCount = $oConfig->getConfigParam('iDays4NewTasks');
        $iEndTimeCount  = $oConfig->getConfigParam('iDays4EndTime');
        $iCountStarting = 0;
        $iCountEndTime  = 0;
        $iCountOverTime = 0;
        $iSolvedtasks   = 0;

        $aProjects = $oProjects->getProjects();
        $actdate = date('Y-m-d');

        foreach ($aProjects as $value) {
            $sSQL = "
                SELECT awcreate,awstart,awdeadline,awtitle,awowner
                    FROM awtasks
                    WHERE awproject = '".$value['awid']."'
                        AND awworkflowpos != '99'
            ";
            $oResult = $this->_db->query($sSQL,'assoc');

            foreach ($oResult as $entry) {

                if ($entry['awstart'] != '0000-00-00') {
                    $startDate = $entry['awstart'];
                    $interval = date_diff(date_create($startDate), date_create($actdate));
                    if ($iNewTasksCount >= $interval->format('%a')) {
                        $iCountStarting++;
                    }

                } else {
                    $startDate = $entry['awcreate'];
                    $interval = date_diff(date_create($startDate), date_create($actdate));
                    if ($iNewTasksCount >= $interval->format('%a')) {
                        $iCountStarting++;
                    }
                }
                if ($entry['awdeadline'] != '0000-00-00' && $entry['awowner'] == $_SESSION['awid']) {

				   if (strtotime($entry['awdeadline']) < time()) {
                        $iCountOverTime++;
                    }
                }

                $interval = date_diff(date_create($entry['awdeadline']), date_create($actdate));
                if ($interval->format('%a') <= $iEndTimeCount) {
                    $iCountEndTime++;
                }

            }

            $sSolvedTasksSQL = "
                SELECT COUNT(awid) as count
                    FROM awtasks
                    WHERE awproject = '".$value['awid']."'
                        AND awworkflowpos = '99'
                        AND awowner='".$_SESSION['awid']."'
            ";
            $oResult = $this->_db->query($sSolvedTasksSQL,'assoc');
            $iSolvedtasks = $iSolvedtasks + $oResult[0]['count'];


        }
        $aReturn = array(
            'starting'  => $iCountStarting,
            'endtime'   => $iCountEndTime,
            'overtime'  => $iCountOverTime,
            'solved'    => $iSolvedtasks
        );
        return $aReturn;
    }
	

}