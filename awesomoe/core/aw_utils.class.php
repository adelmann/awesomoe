<?php

/**
 * Class aw_utils
 */
class aw_utils extends aw_supercfg
{
    /**
     * writeToLog
     * -----------------------------------------------------------------------------------------------------------------
     * @param $sContent
     * @param $sFileName
     */
    public function writeToLog($sContent,$sFileName) {
        $sCurrent = file_get_contents("log/".$sFileName);
        $sFileName = fopen("log/".$sFileName, "w") or die("Unable to open file!");

        fwrite($sFileName, $sCurrent.$sContent.PHP_EOL);
        fclose($sFileName);
    }

}