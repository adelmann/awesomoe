<?php

/**
 * Class aw_db
 */
class aw_db extends aw_supercfg
{
	private $connection;

    /**
     * aw_db constructor.
     */
	public function __construct() {

        $this->_utils		= new aw_utils();
		$this->connect(DBHOST,DBNAME,DBUSER,DBPWD);
	}

    /**
     * connect
     * -----------------------------------------------------------------------------------------------------------------
     * @param $host
     * @param $database
     * @param $username
     * @param $password
     * @throws Exception
     */
    public function connect($host, $database, $username, $password){

        @$this->connection = new mysqli($host, $username, $password, $database);
        if (mysqli_connect_errno()) {
            throw new Exception(__METHOD__.'::'.mysqli_connect_error());
        };
    }

    /**
     * close
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
    public function close(){

        if (!$this->connection) return false;
        $this->connection->close();
    }

    /**
     *  query
     * -----------------------------------------------------------------------------------------------------------------
     *
     * @param $sSql
     * @param string $sReturn
     * @param int $sResult_mode
     * @return array
     * @throws Exception
     */
    public function query($sSql, $sReturn='affected', $sResult_mode=MYSQLI_USE_RESULT){

        if (!$this->connection) throw new Exception('Connection missing');
        $aData = array();
        if ($result = $this->connection->query($sSql, $sResult_mode)) {
            if ($sReturn=='affected'){ $aData = $this->connection->affected_rows; }
            elseif ($sReturn=='num'){ $aData = $result->num_rows; }
            elseif ($sReturn=='id'){ $aData = $this->connection->insert_id; }
            elseif ($sReturn=='assoc'){ while ($row = $result->fetch_assoc()) $aData[] = $row; }
            elseif ($sReturn=='numeric'){ while ($row = $result->fetch_assoc()) $row = $result->fetch_array(MYSQLI_NUM); }
            elseif ($sReturn=='fields'){ while ($row = $result->fetch_fields()) $aData[] = $row; }
            if (is_object($result)) $result->close();
        } else {
            $this->_utils->writeToLog(date("m-d-y H:m:s").':: sql :'.$sSql,'sql_exception.log');
            throw new Exception(__METHOD__.'::'.$this->connection->error.'::'.$sSql);
        };
        return $aData;
    }

    /**
     * getOne
     * -----------------------------------------------------------------------------------------------------------------
     * @param $sSql
     * @param string $sReturn
     * @param int $sResult_mode
     * @return mixed|null
     * @throws Exception
     */
    public function getOne($sSql, $sReturn='affected', $sResult_mode=MYSQLI_USE_RESULT){

        if (!$this->connection) throw new Exception('Connection missing');
        $aData = array();
        if ($result = $this->connection->query($sSql, $sResult_mode)){
            if ($sReturn=='affected'){ $aData = $this->connection->affected_rows; }
            elseif ($sReturn=='num'){ $aData = $result->num_rows; }
            elseif ($sReturn=='id'){ $aData = $this->connection->insert_id; }
            elseif ($sReturn=='assoc'){ while ($row = $result->fetch_assoc()) $aData[] = $row; }
            elseif ($sReturn=='numeric'){ while ($row = $result->fetch_assoc()) $row = $result->fetch_array(MYSQLI_NUM); }
            elseif ($sReturn=='fields'){ while ($row = $result->fetch_fields()) $aData[] = $row; }
            if (is_object($result)) $result->close();
        } else {
            $this->_utils->writeToLog(date("m-d-y H:m:s").':: sql :'.$sSql,'sql_exception.log');
            throw new Exception(__METHOD__.'::'.$this->connection->error.'::'.$sSql);
        };
        if (!empty($aData)) {
            return $aData[0];
        } else {
            return null;
        }
    }


    /**
     * startTransaction
     * -----------------------------------------------------------------------------------------------------------------
     * @param string $isolation_level
     * @return bool
     */
    public function startTransaction($isolation_level="SERIALIZABLE"){

        if (!$this->connection) return false;
        $isolation_level = strtoupper($isolation_level);
        $ok = $this->query("SET TRANSACTION ISOLATION LEVEL {$isolation_level};", "bool");
        $ok = ($ok && $this->query("SET AUTOCOMMIT=0;", "bool"));
        return ($ok && $this->query("START TRANSACTION;", "bool"));
    }

    /**
     * commit
     * -----------------------------------------------------------------------------------------------------------------
     *
     * @return bool
     */
    public function commit() {

        if (!$this->connection) return false;
        if (!$this->query("COMMIT;", "bool")) return false;
        $this->query("SET AUTOCOMMIT=1;", "bool");
        return true;
    }

    /**
     * rollback
     * -----------------------------------------------------------------------------------------------------------------
     * @return bool
     */
    public function rollback() {

        if (!$this->connection) return false;
        if (!$this->query("ROLLBACK;", "bool")) return false;
        $this->query("SET AUTOCOMMIT=1;");
        return true;
    }
}
