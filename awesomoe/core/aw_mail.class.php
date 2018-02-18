<?php

/**
 * Class aw_mail
 */
class aw_mail
{
    /**
     * aw_mail constructor.
     */
    public function __construct() {

    }

    /**
     * sendmail
     * -----------------------------------------------------------------------------------------------------------------
     * @param string $sRecipient
     * @param string $sSubject
     * @param string $sContent
     */
    public function sendmail($sRecipient,$sSubject,$sContent){

        global $oConfig;
        $this->_oConfig = $oConfig;
        $sTitle = $this->_oConfig->getConfigParam('sTitle');
        $sSendName = $this->_oConfig->getConfigParam('sMailName');
        $sSendMail = $this->_oConfig->getConfigParam('sMailAdress');
        $header =
            'MIME-Version: 1.0'. "\r\n" .
            'Content-type: text/html; charset=utf-8'. "\r\n" .
            'From: ' . $sSendMail . "\r\n" .
            'Reply-To: ' . $sSendMail . "\r\n" .
            'X-Mailer: PHP/' . phpversion();

        mail($sRecipient, $sTitle.' - '.$sSubject, $sContent, $header);
    }
}