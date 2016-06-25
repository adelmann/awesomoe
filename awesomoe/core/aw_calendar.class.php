<?php

class aw_calendar extends aw_base
{
    protected $oActUser = 0;

    public function __construct()
    {
        parent::__construct();
        if (!empty($_SESSION['awid'])) {
            $userid = $_SESSION['awid'];
        }
    }


}