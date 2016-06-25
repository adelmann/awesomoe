<?php
class report extends aw_report
{

    public function __construct() {
        parent::__construct();
        global $smarty,$oUsers,$oWorkflows,$oProjects,$oWorklog,$oMedia;
        $smarty->assign("aProject", $oProjects->getProject());

        if (!empty($this->getParameter('fnc')) && $this->getParameter('fnc') != 'allmeasowner') {
            $smarty->assign("aWorkflowSteps", $this->getWorkflowList());
        }

        if (empty($_POST)) {
            if (empty($this->getParameter('fnc')) && $this->getParameter('cl') == 'report') {
                $smarty->assign('oWorkflows2Project',$oWorkflows->getWorkflow($this->getParameter('project')));
                $smarty->assign('oUser2Project',$oUsers->getUsersFromProject());
                $smarty->assign("oProject", $oProjects);
                $smarty->assign("oReports", $this->getAllReports4Project());
                $smarty->assign("oReportsCount", $this->countAllReports4Project());
                if ($this->getParameter('awid')) {$smarty->assign("iAwid", $this->getParameter('awid'));}
                $smarty->display('tpl/report/report.tpl');
            }
        } else {
            if ($this->getParameter('fnc') == 'save' && $this->getParameter('cl') == 'report') {
                $this->save();
                if (!empty($this->getParameter('awid')) && $this->getParameter('awid') != '-1') {$sReportId="&awid=".$this->getParameter('awid');}
                else {
                    $sReportId="";
                }
                header('Location: index.php?cl=report&project='.$this->getParameter('awproject').$sReportId);
            } elseif ($this->getParameter('fnc') == 'delete' && $this->getParameter('cl') == 'report') {
                $this->delete();
                header('Location: index.php?cl=report&project='.$this->getParameter('awproject'));
            } elseif ($this->getParameter('fnc') == 'generateReport' && $this->getParameter('cl') == 'report'){
            	$aReport = $this->generateReport();
                $smarty->assign("aReport", $aReport);
                $smarty->assign("aReportName", $this->getParameter('awname'));
                $smarty->assign("iProject", $this->getParameter('awproject'));
                $smarty->assign("iAwid", $this->getParameter('awid'));
                $smarty->assign("sWorkedTime", $this->workedtime($aReport));
                $smarty->display('tpl/report/report-list.tpl');
            }
        }
    }
}
?>