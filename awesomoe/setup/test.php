<?php
/**
 * Created by PhpStorm.
 * User: baberowski
 * Date: 14.02.2018
 * Time: 20:07
 */

$base_url="http://".$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"].'?').'/';
$base_url = str_replace('setup/','',$base_url);
echo $base_url.'<br>';
$sUri = dirname($_SERVER["REQUEST_URI"].'?');
echo $sUri.'<br>';
$sUri = str_replace('/','',$sUri);
echo $sUri.'<br>';

$path = $_SERVER["DOCUMENT_ROOT"].$sUri.'/';
echo $path.'<br>';
$path = str_replace('setup','',$path);
echo $path.'<br>';