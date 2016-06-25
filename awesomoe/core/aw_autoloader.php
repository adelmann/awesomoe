<?php
class asbg_autoloader {
	const BASE_DIR = __DIR__;
    const FILE_EXTENSION = '.class.php';
		 
    public static function autoload($className) {
            $className = str_replace('\\', DIRECTORY_SEPARATOR, $className);
            $filePath = asbg_autoloader::BASE_DIR . DIRECTORY_SEPARATOR . $className . asbg_autoloader::FILE_EXTENSION;
			if (file_exists($filePath)) {
                // Datei zur Klasse includen, falls sie denn existiert
                include_once($filePath);
            }
        }

}
