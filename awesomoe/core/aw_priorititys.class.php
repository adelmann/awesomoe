<?php

class aw_priorititys extends aw_base
{
	public function __construct() {
		parent::__construct();
	}
	
	public function getAllPrioritys() {
		$sSelect = "SELECT * FROM awprio ORDER BY awsort";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}
	
	public function getPriority() {
		$sSelect = "SELECT * FROM awprio WHERE awid = '".$this->getParameter('priority')."';";
		$oResult = $this->_db->query($sSelect,'assoc');
		return $oResult;
	}

	protected function delete() {
		$iPrioID = $this->getParameter('priority');
		$sDELETE = "
				DELETE FROM awprio WHERE awprio.awid = '".$iPrioID."';
			";
		$this->_db->startTransaction();
		try{
			$this->_db->query($sDELETE);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		return true;
	}
	
	protected function save() {
		if ($this->getParameter('awid') != '-1') {
			$aSaveParams = $this->getAllParameter($_POST);
			ksort($aSaveParams);
			$sUpdateProject = "UPDATE awprio SET ";
			$countSave = 0;
			$count = 0;
			$proof = 0;
			
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false) {
					$countSave++;
				}
			}
			$countSave = $countSave-1;
			
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid') {
					$sUpdateProject .= $key."='".$value."'";
					if ($count < $countSave) {
						$sUpdateProject .= ", ";
						$proof ++;
					}
				}
				$count++;
			}
			$sUpdateProject .= " WHERE awid='".$this->getParameter('awid')."';";
						
			$this->_db->startTransaction();
			try{
				
				
				$this->_db->query($sUpdateProject);
				$this->_db->commit();
			}
			catch(Exception $e){
				$this->_db->rollback();
				return false;
			};
			return true;
		} else {
			$aSaveParams = $this->getAllParameter($_POST);
			$sUpdateProject = "INSERT INTO awprio ";
			$countSave = count($aSaveParams);
			$countSave = $countSave-4;
			$count = 0;
			$keynames = '';
			$keyvals = '';
			foreach ($aSaveParams as $key=>$value) {
				$iPos = strpos($key,'aw');
				if ($iPos !== false && $key !='awid') {
					$keynames .= $key;
					$keyvals .= "'".$value."'";
					if ($count < $countSave) {
						$keynames .= ",";
						$keyvals .= ",";
					}
					$count++;
				}
			}
			$sUpdateProject .= "(".$keynames.") VALUES (".$keyvals.")";
					
			$this->_db->startTransaction();
			try{				
				$this->_db->query($sUpdateProject);
				$this->_db->commit();
			}
			catch(Exception $e){
				$this->_db->rollback();
				return false;
			};
			return true;
		}
	}
}