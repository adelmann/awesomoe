<?php
class notification extends aw_notification
{
    public function __construct() {
        parent::__construct();
        global $smarty,$oTasks,$oUser;
        if (!empty($this->getParameter('fnc')) && $this->getParameter('id')) {
            $this->setNotificationToRead($this->getParameter('id'));
        }

    }

}