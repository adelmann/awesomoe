<?php

/**
 * Class mail
 */
class mail extends aw_mail
{

    /**
     * mail constructor.
     */
    public function __construct() {
        parent::__construct();
        global $smarty,$oTasks,$oUser;
        if ($this->getParameter('fnc') == 'mailNotification') {
            $sMailContent  = $smarty->display('tpl/mail/header.tpl');
            $sMailContent .= $smarty->display('tpl/mail/notification.tpl');
            $sMailContent .= $smarty->display('tpl/mail/footer.tpl');
            sendmail($sRecipient,$sSubject,$sContent);
        }
    }
}