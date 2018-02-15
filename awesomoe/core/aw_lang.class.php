<?php
	class aw_lang 
	{
		protected $_alang;
	
		public function __construct() {
			/* Default language for users */
			$config['def_lang'] = 'de';
			/* Auto detect language for user */
			$config['auto_lang'] = 'yes';
			
			$default_lang = PATH . 'application/views/lang/'. $config['def_lang'] . "/lang.php";
			/* Check if  language letters greater then 0 and language file exist */
			if(strlen($config['def_lang'])>0 and file_exists($default_lang)) {
				/* If auto_lang  equals to yes, search for  language file and use it */
			   if($config['auto_lang'] == 'yes') {
				  $lang_code = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'],0,2);
				  $auto_lang =  PATH . 'application/views/lang/'. $lang_code . "/lang.php";
				  if(file_exists($auto_lang)) {
					 define('LANGUAGE', $auto_lang);
				  } else {
					 define('LANGUAGE', $default_lang);
				  }
			   } else {
				  define('LANGUAGE', $default_lang);
			   }
			   require_once(LANGUAGE);
			   $this->_alang = $aLang;
			} else {
			    echo "awesomoe<hr>def_lang not defined and/or file does not exist<br>";
				echo 'Just check the config.php in your awesomoe root or<br>';
				echo 'contact awesomoe for support<br>';
				echo '<a href="http://awesomoe.de">http://awesomoe.de</a><br>';
			    die('');
			}
		}
		
		public function translateString($ident) {
			if (empty($this->_alang[$ident])) {
				return $ident;
			}
			return $this->_alang[$ident];
		}	
	}
?>