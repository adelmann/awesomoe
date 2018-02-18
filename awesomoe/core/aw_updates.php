<?php

class aw_utils extends aw_supercfg {

    public function areChecksEnables() {
        return true;
    }

    public function areWeOnline() {

    }

    public function getMainVersion()
    {
        if ($this->areChecksEnables() === true) {
            $sVersion = file_get_contents('http://awesomoe.de/aw.version');
            return $sVersion;
        } else{
            return '0.0.0';
        }
    }
}