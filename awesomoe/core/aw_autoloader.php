<?php

/**
 * Class asbg_autoloader
 */
class asbg_autoloader
{
	const BASE_DIR = __DIR__;
    const FILE_EXTENSION = '.class.php';

    /**
     * autoload
     * -----------------------------------------------------------------------------------------------------------------
     * @param string $sClassName
     */
    public static function autoload($sClassName) {

        $sClassName = str_replace('\\', DIRECTORY_SEPARATOR, $sClassName);
        $sFilePath = asbg_autoloader::BASE_DIR . DIRECTORY_SEPARATOR . $sClassName . asbg_autoloader::FILE_EXTENSION;
        if (file_exists($sFilePath)) {
            include_once($sFilePath);
        }
    }
}
