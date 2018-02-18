<?php
session_start();
$run = new install();
$run->init();

class install
{
	protected $_alang;
	protected $position = null;
	protected $dberror = null;

	protected $server   = null;
	protected $database = null;
	protected $username = null;
	protected $password = null;

	public function init() {

		/* load language */
		/* Default language for users */
		$config['def_lang'] = 'de';
		/* Auto detect language for user */
		$lang_code 		= substr($_SERVER['HTTP_ACCEPT_LANGUAGE'],0,2);
		$auto_lang 		=  'lang/'. $lang_code . ".php";
		$default_lang 	=  'lang/de.php';

		if (isset($_COOKIE["awesomoeSetup"])) {
			define('LANGUAGE', 'lang/'.$_COOKIE["awesomoeSetup"].'.php');
		} else {
			if(file_exists($auto_lang)) {
				define('LANGUAGE', $auto_lang);
			} else {
				define('LANGUAGE', $default_lang);
			}
		}

		require_once(LANGUAGE);

		$this->_alang = $aLang;


		if (!empty($_GET)) {
			$this->position = $_GET['step'];
		}

		include "header.tpl";

		if (!$this->position || $this->position == 1) {
			include "step1.tpl";
		} elseif($this->position == 2) {
			$_SESSION['aw_language'] = trim($_GET['language']);
			$_SESSION['aw_Check4Updates'] = trim($_GET['Check4Updates']);
			include "step2.tpl";
		} elseif($this->position == 3) {
			include "step3.tpl";
		} elseif($this->position == 4) {

			$_SESSION['aw_server'] = trim($_GET['dbhost']);
			$_SESSION['aw_database'] = trim($_GET['dbname']);
			$_SESSION['aw_username'] = trim($_GET['dbuser']);
			$_SESSION['aw_password'] = trim($_GET['dbpwd']);
			$this->getDBDatas();
			$dbconn = $this->checkDB();

			if (is_object($dbconn)) {
				$tablecheck = $this->checkTables();
				if ($tablecheck == 1) {
					include "step4.tpl";
				} elseif ($tablecheck == 2) {

					?>
					<div class="alert alert-warning" role="alert"><?php $this->translateContent('TABLESEXIST');?></div>
					<a href="index.php?step=3" class="btn btn-danger"><?php $this->translateContent('NEWDBDATAS');?></a>
					<?php

				} elseif ($tablecheck == 3) {

					?>
					<div class="alert alert-warning" role="alert"><?php $this->translateContent('EXISTINGTABLES');?></div>
					<a href="index.php?step=4&go=1" class="btn btn-danger"><?php $this->translateContent('INSTALLHARD');?></a>
					<a href="index.php?step=3" class="btn btn-primary"><?php $this->translateContent('NEWDBDATAS');?></a>
					<?php
				}
			} else {
				$dberror = $dbconn;
				include "step3.tpl";
			}
		} elseif($this->position == 5) {
			include "step5.tpl";
		} elseif($this->position == 6) {
			$this->getDBDatas();
			$this->translateContent('LOADDBINFO');
			$sqlInstall = explode(" ;",file_get_contents('src/_sql/install.sql', true));
			echo "<span class=\"label label-success\">√</span><br>";
			$this->translateContent('INSTALLDB');
			$conn = mysqli_connect($this->server, $this->username, $this->password, $this->database);
			foreach ($sqlInstall as $item) {
				if ($item != '') {
					$conn->query($item);
				}
			}

			// Add User
			$sUserLName 	= $_GET['userlname'];
			$sUserFname 	= $_GET['userfname'];
			$sUsermail 		= $_GET['usermail'];
			$sUserpassword 	= $_GET['userpassword'];
			$sModifiedPWD	= md5($sUserpassword);

			$sAddUserSQL = "
				INSERT INTO `awusers` (`awid`, `awmail`, `awpassword`, `awname`, `awlastname`, `awcompany`, `awphone`, `awmobile`, `awzip`, `awcity`, `awstreet`, `awcountry`, `awgender`, `awavatar`, `awlastlogin`, `awurl`, `awposition`, `awadded`, `awstate`, `awgroup`, `awupdate`) VALUES
									  (1, '".$sUsermail."', '".$sModifiedPWD."', '".$sUserFname."', '".$sUserLName."', 1, '', '', '', '', '', 7, 3, '', NOW(), '', '', NOW(), 0, 1, NOW()) ;
			";

			$conn->query($sAddUserSQL);
			echo "<span class=\"label label-success\">√</span><br>";
			$this->translateContent('INSTALLADMIN');

			echo "<span class=\"label label-success\">√</span><br>";
			$this->translateContent('CREATECONFIG');

			$myconfig = fopen("../config.php", "w") or die("Unable to open file!");
			chdir('..');
			$base_url="http://".$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"].'?').'/';
			$base_url = str_replace('setup/','',$base_url);
			$sUri = dirname($_SERVER["REQUEST_URI"].'?');

			$path = $_SERVER["DOCUMENT_ROOT"].$sUri.'/';
			$path = str_replace('//','/',$path);
			$path = str_replace('setup','',$path);
			$txt = "<?php
			define('PATH', '$path');
			define('URL', '$base_url');
                
			/** @name database information */
				define('DBHOST', '$this->server');
				define('DBNAME', '$this->database');
				define('DBUSER', '$this->username');
				define('DBPWD', '$this->password');
                
                
				date_default_timezone_set('Europe/Berlin');
            ";
            if (isset($_SESSION['aw_server'])) {

			$txt .= "
			define('DEFAULTLANG', '".$_SESSION['aw_server']."');";
            }

			if (isset($_SESSION['aw_Check4Updates'])) {

				$txt .= "
			define('CHECK4UPDATES', '".$_SESSION['aw_Check4Updates']."');";
			}

            $txt .= "
			define('AUTOSELECTLANG', true);
?>";

            fwrite($myconfig, $txt);
			fclose($myconfig);
			echo "<span class=\"label label-success\">√</span><br>";
			include "step6.tpl";
			session_abort();

		} elseif($this->position == 7) {
			$base_url="http://".$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"].'?').'/';
			$base_url = str_replace('setup/','',$base_url);

			$this->translateContent('INSTALLDONE');
			echo "<a href='index.php?step=999' class='btn btn-danger'>";$this->translateContent('DELSETUP');echo "</a><br>";
			echo "<a href='".$base_url."' class='btn btn-primary'>";
			$this->translateContent('TOLOGIN');
			echo "</a>";
		}  elseif($this->position == 999) {

            $sUri = dirname($_SERVER["REQUEST_URI"].'?');

            $path = $_SERVER["DOCUMENT_ROOT"].$sUri.'/';
			$base_url = str_replace('//','/',$path);

			$this->deleteDir($base_url);

			$base_url="http://".$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"].'?').'/';
			$redirectURL = str_replace('setup/','',$base_url);
			header('Location: '.$redirectURL);
		}

		include "footer.tpl";
	}

    public static function deleteDir($dirPath) {
        if (!is_dir($dirPath)) {
            throw new InvalidArgumentException("$dirPath must be a directory");
        }
        if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
            $dirPath .= '/';
        }
        $files = glob($dirPath . '*', GLOB_MARK);
        foreach ($files as $file) {
            if (is_dir($file)) {
                self::deleteDir($file);
            } else {
                unlink($file);
            }
        }
        rmdir($dirPath);
    }


	public function checkDB() {
		try {
			$dbh = new PDO("mysql:host=$this->server;dbname=$this->database",$this->username,$this->password);
			$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			return $dbh;
		} catch(PDOException $e) {
			return $e->getMessage();
		}
	}

	public function checkTables() {
		$conn = mysqli_connect($this->server, $this->username, $this->password, $this->database);
		$sql = "SHOW TABLES FROM ".trim($_GET['dbname']);
		$result = $conn->query($sql);
		if (!$result) {
    		return '1';
    	} else {
    		$sql = "SHOW TABLES LIKE 'awprojects'";
    		$numrows = $conn->query($sql);
			if(mysqli_num_rows($numrows) > 0) {
				return '2';
			} else {
				return '1';
			}
    		
    	}
	}

	public function getDBDatas() {
		$this->server   = $_SESSION['aw_server'];
		$this->database = $_SESSION['aw_database'];
		$this->username = $_SESSION['aw_username'];
		$this->password = $_SESSION['aw_password'];
	}

	public function translateContent($ident) {
		if (empty($this->_alang[$ident]) || !isset($this->_alang[$ident])) {
			echo $ident;
		}
		echo $this->_alang[$ident];
	}
}
?>