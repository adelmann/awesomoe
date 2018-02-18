<?php
session_start();
$run = new install();
$run->init();

class install
{

	protected $position = null;
	protected $dberror = null;

	protected $server   = null;
	protected $database = null;
	protected $username = null;
	protected $password = null;

	public function init() {
		if (!empty($_GET)) {
			$this->position = $_GET['step'];
		}

		include "header.tpl";

		if (!$this->position || $this->position == 1) {
			include "step1.tpl";
		} elseif($this->position == 2) {
			include "step2.tpl";
		} elseif($this->position == 3) {
			include "step3.tpl";
		} elseif($this->position == 4) {

			$_SESSION['aw_server'] =  trim($_GET['dbhost']);
			$_SESSION['aw_database'] =  trim($_GET['dbname']);
			$_SESSION['aw_username'] =  trim($_GET['dbuser']);
			$_SESSION['aw_password'] =  trim($_GET['dbpwd']);
			$this->getDBDatas();
			$dbconn = $this->checkDB();

			if (is_object($dbconn)){
				$tablecheck = $this->checkTables();
				if ($tablecheck == 1) {
					include "step4.tpl";
				} elseif ($tablecheck == 2) {

				?>
					<div class="alert alert-warning" role="alert">Es scheint schon Tabellen von awesomoe zu geben</div>
					<a href="index.php?step=3" class="btn btn-danger">Neue DB Daten angeben</a>
				<?php

				} elseif ($tablecheck == 3) {

				?>
					<div class="alert alert-warning" role="alert">Es existieren schon Tabellen in dieser DB</div>
					<a href="index.php?step=4&go=1" class="btn btn-danger">Dennoch installieren</a>
					<a href="index.php?step=3" class="btn btn-primary">Neue DB Daten angeben</a>
				<?php
				}
			} else {
				$dberror = $dbconn;
				include "step3.tpl";
			}
		} elseif($this->position == 5) {
			$this->getDBDatas();
			echo "Lade DB Informationen. ";
			$sqlInstall = explode(" ;",file_get_contents('src/_sql/install.sql', true));
			echo "<span class=\"label label-success\">√</span><br>";
			echo "installiere DB.";
			$conn = mysqli_connect($this->server, $this->username, $this->password, $this->database);
			foreach ($sqlInstall as $item) {
				if ($item != '') {
					$conn->query($item);
				}
			}
			echo "<span class=\"label label-success\">√</span><br>";
			echo "Erstelle Konfigurationsfile.";

			$myconfig = fopen("../config.php", "w") or die("Unable to open file!");
			chdir('..');
			$base_url="http://".$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"].'?').'/';
			$base_url = str_replace('setup/','',$base_url);
			$sUri = dirname($_SERVER["REQUEST_URI"].'?');
			$sUri = str_replace('/','',$sUri);

			$path = $_SERVER["DOCUMENT_ROOT"].$sUri.'/';
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

?>";
			fwrite($myconfig, $txt);
			fclose($myconfig);
			echo "<span class=\"label label-success\">√</span><br>";
			include "step5.tpl";
			session_abort();

		} elseif($this->position == 6) {
			$base_url="http://".$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"].'?').'/';
			$base_url = str_replace('setup/','',$base_url);

			echo "<h1>Installation erfolgreich</h1>";
			echo "<p>Die initialen Login Daten sind</p>";
			echo "<p>Benutzer: new@awesomoe.de</p>";
			echo "<p>Passwort: admin</p>";
			echo "<hr>";
			echo "<div style='color:#ee0000;'>";
			echo "<p>Nach dem Login bitte direkt den Benutzernamen(Mail) und das Passwort ändern.</p>";
			echo "<p>Bitte löschen Sie das Installationsverzeichnis komplett</p>";
			echo "<p>Link zum Login</p>";
			echo "</div>";

			echo "<a href='".$base_url."' class='btn btn-primary'>Zum Login</a>";
		}

		include "footer.tpl";

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
}
?>