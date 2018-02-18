<?php

/**
 * Class aw_report
 */
class aw_report extends aw_base
{
    protected $oActUser = 0;

    /**
     * aw_report constructor.
     */
    public function __construct()
    {
        parent::__construct();
        if (!empty($_SESSION['awid'])) {
            $userid = $_SESSION['awid'];
        }
    }

    /**
     * save
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
    public function save() {
        if (!empty($this->getParameter('awusers'))) {
            $awusers = '';
            $iCount = 0;
            foreach ($this->getParameter('awusers') as $userId){
                if ($iCount == 0) {$userseperator='';} else {$userseperator=',';}
                $awusers .= "$userseperator$userId";
                $iCount ++;
            }
        } else {
            $awusers = '';
        }

        if (!empty($this->getParameter('awstates'))) {
            $awstates = '';
            $iCount = 0;
            foreach ($this->getParameter('awstates') as $stateId){
                if ($iCount == 0) {$stateseperator='';} else {$stateseperator=',';}
                $awstates .= "$stateseperator$stateId";
                $iCount ++;
            }
        } else {
            $awstates = '';
        }

        if ($this->getParameter('awid') == '-1') {
            $sSQL = "
                INSERT INTO awreports
                  (
                    awid,
                    awproject,
                    awbegins,
                    awends,
                    awstates,
                    awusers,
                    awname)
                  VALUES
                  (NULL, '".$this->getParameter('awproject')."','".$this->getParameter('awbegins')."','".$this->getParameter('awends')."','".$awstates."','".$awusers."','".$this->getParameter('awname')."');
            ";

        } else {
            $sSQL = "
                UPDATE awreports SET
                  awproject='".$this->getParameter('awproject')."',
                  awbegins='".$this->getParameter('awbegins')."',
                  awends='".$this->getParameter('awends')."',
                  awstates='".$awstates."',
                  awusers='".$awusers."',
                  awname='".$this->getParameter('awname')."'
                WHERE awid = '".$this->getParameter('awid')."'
            ";
        }

        $this->_db->startTransaction();
        try{
            $this->_db->query($sSQL);
            $this->_db->commit();
        }
        catch(Exception $e){
            echo $e;
            echo $sSQL;die();
            //echo $sUpdateTask;
            $this->_db->rollback();
            return false;
        };
    }

    /**
     * delete
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
    public function delete() {
        $iProjectid = $this->getParameter('awproject');
        $iAwid = $this->getParameter('awid');
        $sSQL = "
            DELETE FROM awreports WHERE awid = '".$iAwid."' AND awproject = '".$iProjectid."';
        ";
        $this->_db->startTransaction();
        try{
            $this->_db->query($sSQL);
            $this->_db->commit();
        }
        catch(Exception $e){
            echo $e;
            echo $sSQL;die();
            //echo $sUpdateTask;
            $this->_db->rollback();
            return false;
        };
    }

    /**
     * getAllReports4Project
     * -----------------------------------------------------------------------------------------------------------------
     * @return array
     */
    public function getAllReports4Project() {
        $iProjectID = $this->getParameter('project');
        $sSQL = "
            SELECT * FROM awreports WHERE awproject = '".$iProjectID."'
        ";
        $oResult = $this->_db->query($sSQL,'assoc');
        return $oResult;
    }

    /**
     * countAllReports4Project
     * -----------------------------------------------------------------------------------------------------------------
     * @return mixed
     */
    public function countAllReports4Project() {
        $iProjectID = $this->getParameter('project');
        $sSQL = "
			SELECT count(*) as countreports FROM awreports WHERE awproject = '".$iProjectID."';
		";
        $oResult = $this->_db->query($sSQL,'assoc');
        return $oResult[0]['countreports'];
    }

    /**
     * generateReport
     * -----------------------------------------------------------------------------------------------------------------
     * @return array
     */
    public function generateReport() {
        $iProjectID = $this->getParameter('awproject');
        $sBegins    = $this->getParameter('awbegins');
        $sEnds      = $this->getParameter('awends');
        $sStates    = $this->getParameter('awstates');
        $sUsers     = $this->getParameter('awusers');

        $sSQL = "
            SELECT tasks.awtitle, workflowsteps.awname as workflowpos, tasks.awworkflowpos, worklog.awdate, worklog.awtime, worklog.awdesc, user.awname, user.awlastname
                FROM awworklog as worklog
                INNER JOIN awtasks as tasks
                  ON tasks.awid = worklog.awtaskid
                  AND worklog.awprojectid = '$iProjectID'
                INNER JOIN awprojects as projects
                  ON tasks.awproject = projects.awid
                INNER JOIN awworkflow as workflows
                  ON projects.awworkflow = workflows.awid

        ";
        $iCountStates = count($sStates);
        $iCounter = 1;
        if (!empty($sStates)) {
            $sSQL .= " AND (";
            foreach ($sStates as $sState) {
                if ($sState == 'archive') {
                    $iState = '99';
                } else {
                    $iState = $sState;
                }
                if ($iCounter < $iCountStates) {$sOrOperator = ' OR';} else {$sOrOperator = '';}
                $sSQL .= " tasks.awworkflowpos = $iState$sOrOperator";
                $iCounter++;
            }
            $iCountUser = count($sUsers);
            $iCounter = 1;
            if (!empty($sUsers)) {
                $isAllAvailable = in_array('ALL', $sUsers);
                if ($isAllAvailable != '1') {
                    $sSQL .= "
                    ) AND (
                ";
                } else {
                    $sSQL .= " )";
                }
            } else {
                $sSQL .= " )";
            }

        }

        foreach ($sUsers as $sUser) {
            if ($sUser == 'ALL') {
                break;
            } else {
                $iUser = $sUser;
                if ($iCounter < $iCountUser) {$sOrOperator = ' OR';} else {$sOrOperator = '';}
                $sSQL .= " worklog.awuser = $iUser$sOrOperator";
            }
            $iCounter++;
        }

        $sSQL .= "
                INNER JOIN awusers as user
                    ON user.awid = worklog.awuser
                LEFT JOIN awworkflowsteps as workflowsteps
                    ON tasks.awworkflowpos = workflowsteps.awid
                WHERE worklog.awprojectid = '$iProjectID'
                  AND (worklog.awdate BETWEEN '$sBegins' AND '$sEnds')

        ";

        $oResult = $this->_db->query($sSQL,'assoc');
        return $oResult;
    }

    /**
     * workedtime
     * -----------------------------------------------------------------------------------------------------------------
     * @param $aResult
     * @return string
     */
    public function workedtime($aResult) {
		$hours = 0;
		$minutes = 0;
		foreach ($aResult as $timelog) {
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
}