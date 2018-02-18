<?php

/**
 * Class calendar
 */
class calendar extends aw_calendar
{
    /**
     * calendar constructor.
     */
    public function __construct()
    {
        parent::__construct();
        global $smarty, $oUsers, $oTasks, $oProjects;

        $smarty->assign('aTasks', $oTasks->getOnlyMyTasks());
        $smarty->display('tpl/calendar/calendar.tpl');
    }

}

