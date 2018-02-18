<?php

/**
 * Class aw_calendar
 */
class aw_calendar extends aw_base
{
    protected $oActUser = 0;

    /**
     * aw_calendar constructor.
     */
    public function __construct() {

        parent::__construct();
        if (!empty($_SESSION['awid'])) {
            $userid = $_SESSION['awid'];
        }
    }
}