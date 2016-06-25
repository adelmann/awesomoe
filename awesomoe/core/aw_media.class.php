<?php

class aw_media extends aw_base
{
	public function __construct() {
		parent::__construct();
	}
	
	public function loadAvatar() {
		global $oUsers,$oProjects;
		$filename = $_FILES['uploadavatar']['name'];
		$filename = str_replace(" ", "_", "$filename"); 
		$filename = htmlentities($filename); 
		$filename = strtolower($filename);
		$dateityp = GetImageSize($_FILES['uploadavatar']['tmp_name']); 
		if($dateityp[2] == 2) { 
			if($_FILES['uploadavatar']['size'] <  2048000) {
				if($_FILES['uploadavatar']['size'] <  2048000) { 
					move_uploaded_file($_FILES['uploadavatar']['tmp_name'], PATH."tmp/media/$filename"); 
					$file        = PATH."tmp/media/$filename"; 
					$target    	 = PATH."media/profile/$filename"; 
					$max_width   = "150";
					$max_height  = "150";
					$quality     = "90";
					$src_img     = imagecreatefromjpeg($file); 
					$picsize     = getimagesize($file); 
					$src_width   = $picsize[0]; 
					$src_height  = $picsize[1]; 
							   
					if($src_width > $src_height){ 
						if($src_width > $max_width){ 
							$convert = $max_width/$src_width; 
							$dest_width = $max_width; 
							$dest_height = ceil($src_height*$convert); 
						} else { 
							$dest_width = $src_width; 
							$dest_height = $src_height; 
						} 
					} else { 
						if($src_height > $max_height){ 
							$convert = $max_height/$src_height; 
							$dest_height = $max_height; 
							$dest_width = ceil($src_width*$convert); 
						} else { 
							$dest_height = $src_height; 
							$dest_width = $src_width; 
						} 
					} 
					$dst_img = imagecreatetruecolor($dest_width,$dest_height); 
					imagecopyresampled($dst_img, $src_img, 0, 0, 0, 0, $dest_width, $dest_height, $src_width, $src_height); 
					imagejpeg($dst_img, $target, $quality); 
					unlink(PATH."tmp/media/$filename");
					$oUsers->saveUserAvatar($filename);
				}
			}
		}
	}
	
	public function loadProjectAvatar() {
		global $oProjects;
		$filename = $_FILES['uploadavatar']['name'];
		$filename = str_replace(" ", "_", "$filename"); 
		$filename = htmlentities($filename); 
		$filename = strtolower($filename);
		$dateityp = GetImageSize($_FILES['uploadavatar']['tmp_name']); 
		if($dateityp[2] == 2) { 
			if($_FILES['uploadavatar']['size'] <  2048000) {
				if($_FILES['uploadavatar']['size'] <  2048000) { 
					move_uploaded_file($_FILES['uploadavatar']['tmp_name'], PATH."tmp/media/$filename"); 
					$file        = PATH."tmp/media/$filename"; 
					$target    	 = PATH."media/projects/$filename"; 
					$max_width   = "150";
					$max_height  = "150";
					$quality     = "90";
					$src_img     = imagecreatefromjpeg($file); 
					$picsize     = getimagesize($file); 
					$src_width   = $picsize[0]; 
					$src_height  = $picsize[1]; 
							   
					if($src_width > $src_height){ 
						if($src_width > $max_width){ 
							$convert = $max_width/$src_width; 
							$dest_width = $max_width; 
							$dest_height = ceil($src_height*$convert); 
						} else { 
							$dest_width = $src_width; 
							$dest_height = $src_height; 
						} 
					} else { 
						if($src_height > $max_height){ 
							$convert = $max_height/$src_height; 
							$dest_height = $max_height; 
							$dest_width = ceil($src_width*$convert); 
						} else { 
							$dest_height = $src_height; 
							$dest_width = $src_width; 
						} 
					} 
					$dst_img = imagecreatetruecolor($dest_width,$dest_height); 
					imagecopyresampled($dst_img, $src_img, 0, 0, 0, 0, $dest_width, $dest_height, $src_width, $src_height); 
					imagejpeg($dst_img, $target, $quality); 
					unlink(PATH."tmp/media/$filename");
					$oProjects->saveProjectAvatar($filename);
				}
			}
		}
	}
	
	public function loadMedia2Task() {
		global $oUsers;
		$filename = $_FILES['upload']['name'];
		$filename = str_replace(" ", "_", "$filename"); 
		$filename = htmlentities($filename); 
		$filename = strtolower($filename);
		$userid = $_SESSION['awid'];
		$ext = pathinfo("$filename", PATHINFO_EXTENSION);
		$sNewFileName = substr(md5(time()*rand()), 0, 22).'.'.$ext;
		move_uploaded_file($_FILES['upload']['tmp_name'], PATH."media/taskfiles/$sNewFileName");

		$sUpdate = "INSERT INTO awmedia (awid, awproject, awtask, awfilename, awnewfilename, awuserid) VALUES (NULL, '".$this->getParameter('projectid')."', '".$this->getParameter('taskid')."', '".$filename."', '".$sNewFileName."', '".$userid."');";
		$this->_db->startTransaction();
		try{
			$this->_db->query($sUpdate);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
		return true;
	}
	
	public function getFiles2Task() {
		$sSelectMedias = "
			SELECT * FROM awmedia WHERE awproject = '".$this->getParameter('project')."' && awtask = '".$this->getParameter('task')."'
		";
		$oResult = $this->_db->query($sSelectMedias,'assoc');
		return $oResult;
	}
	
	public function deleteMedia() {
		$iTaskId = $this->getParameter('task');
		$iProjectId = $this->getParameter('project');
		$iFileId = $this->getParameter('fileid');
		
		$sSelectMedia = "
			SELECT * FROM awmedia WHERE awproject = '".$iProjectId."' && awtask = '".$iTaskId."' && awid= '".$iFileId."'
		";
		$oResult = $this->_db->getOne($sSelectMedia,'assoc');
		$sFile2Delete = PATH."media/taskfiles/".$oResult['awnewfilename'];
		unlink($sFile2Delete);
		$sDeleteSQL = 'DELETE FROM awmedia WHERE awid ="'.$iFileId.'" && awtask="'.$iTaskId.'" && awproject ="'.$iProjectId.'"';
		
		$this->_db->startTransaction();
		try{
			$this->_db->query($sDeleteSQL);
			$this->_db->commit();
		}
		catch(Exception $e){
			$this->_db->rollback();
			return false;
		};
	}
}