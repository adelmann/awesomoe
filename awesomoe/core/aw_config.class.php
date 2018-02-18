<?php

/**
 * Class aw_config
 */
class aw_config extends aw_supercfg
{

	protected $_aConfigParams = array();

    /**
     * aw_config constructor.
     */
	public function __construct() {

		global $oDB,$oConfig;
		$this->_db = $oDB;
		$this->loadVarsFromDB();
			
	}

    /**
     * getConfigParam
     * -----------------------------------------------------------------------------------------------------------------
     * @param string $sName
     * @return mixed
     */
    public function getConfigParam( $sName ) {

        if ( isset( $this->$sName ) ) {
            return $this->$sName;
        } elseif ( isset ( $this->_aConfigParams[$sName] ) ) {
            return $this->_aConfigParams[$sName];
        }
    }

    /**
     * setConfigParam
     * -----------------------------------------------------------------------------------------------------------------
     * @param string $sName
     * @param string $sValue
     */
	public function setConfigParam( $sName, $sValue ) {

        if ( isset( $this->$sName ) ) {
            $this->$sName = $sValue;
        } else {
            $this->_aConfigParams[$sName] = $sValue;
        }
    }

    /**
     * loadVarsFromDB
     * -----------------------------------------------------------------------------------------------------------------
     */
	protected function loadVarsFromDB() {

		$sSelectVars = "
				SELECT * FROM awconfig
		";
		$oResult = $this->_db->query($sSelectVars,'assoc');
		if ( $oResult != false ) {
			foreach ($oResult as $item) {
				$sVarName = $item['awvarname'];
                $sVarType = $item['awvartype'];
                $sVarVal  = $item['awvarvalue'];
                switch ( $sVarType ) {
                    case 'arr':
                    case 'aarr':
                        $this->setConfigParam( $sVarName, unserialize( $sVarVal ) );
                        break;
                    case 'bool':
                        $this->setConfigParam( $sVarName, ( $sVarVal == 'true' || $sVarVal == '1' ) );
                        break;
                    default:
                        $this->setConfigParam( $sVarName, $sVarVal );
                        break;
                }
			}
        }
	}

    /**
     * save
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
    protected function save() {

        unset($_POST['cl']);
        unset($_POST['fnc']);
        $oBase = new aw_base();
        $aSaveParams = $oBase->getAllParameter($_POST);
        $sUpdate = '';
        foreach ($aSaveParams as $key=>$value) {
            $this->_db->startTransaction();
            $sUpdate = 'UPDATE awconfig SET awvarvalue="'.$value.'" WHERE awvarname = "'.$key.'";';
            try{
                $this->_db->query($sUpdate);
                $this->_db->commit();
            }
            catch(Exception $e){
                $this->_db->rollback();
                return false;
            };
        }
        return true;
    }
}