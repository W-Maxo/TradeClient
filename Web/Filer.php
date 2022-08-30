<?
$KeyFile    = '/home/eurasial/service/TAUpd/Keys.xml';
$ExeVerFile = '/home/eurasial/service/TAUpd/Version.xml';
$key        = 'CFB3F031-A7D5-4295-908F-AD10E3A735FC';
$postName   = 'TAData';
$homeDir    = '/home/eurasial/service/';
$sysDir     = '/home/eurasial/service/TAUpd/';
$reqDir     = '/home/eurasial/service/REQ/';
$ansFileK   = '08d63777c29e6040a723a7433169ca02';
$UseMySQL   = True;

define('DB_NAME', 'eurasial_TradeClient');
define('DB_USER', 'eurasial_Trade');
define('DB_PASSWORD', 'm3wIG22R{MD*');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');

define("MAX_IDLE_TIME", 60);

mb_internal_encoding("UTF-8");

if ($UseMySQL) {
	include_once('medoo.php');
	 
	$database = new medoo(array(
		'database_type' => 'mysql',
		'database_name' => DB_NAME,
		'server' => DB_HOST,
		'username' => DB_USER,
		'password' => DB_PASSWORD,
		'port' => 3306,
		'charset' => DB_CHARSET,
		'option' => array(
			PDO::ATTR_CASE => PDO::CASE_NATURAL
		)
	));
}

$fileR = "Stock_rest.zip"; 		$fileMR = hash('MD5', $key . $fileR);
$fileX = "TradeClient.exe";		$fileMX = hash('MD5', $key . $fileX);
$file0 = "Info.zip";			$fileM0 = hash('MD5', $key . $file0);
$file1 = "Splash.zip";			$fileM1 = hash('MD5', $key . $file1);

$file3 = "Arrearage_Cr.zip";	$fileM3 = hash('MD5', $key . $file3);
$file4 = "Clients_Cr.zip";		$fileM4 = hash('MD5', $key . $file4);
$file5 = "Sales_Cr.zip";		$fileM5 = hash('MD5', $key . $file5);
$file6 = "Ts.xml";				$fileM6 = hash('MD5', $key . $file6);
$file7 = "SDP.zip";				$fileM7 = hash('MD5', $key . $file7);
$file8 = "Disc.zip";			$fileM8 = hash('MD5', $key . $file8);

$AllArrFile = array(
    $fileM0 => $file0,
    $fileM1 => $file1,
	$fileMR => $fileR,
	$fileM6 => $file6,
	$fileM7 => $file7
);

$CustomArrFile = array(
    $fileM2 => $file2,
    $fileM3 => $file3,
    $fileM4 => $file4,
    $fileM5 => $file5,
	$fileM8 => $file8
);

$ExeArrFile = array(
    $fileMX => $fileX
);

function file_force_download($file)
{
    if (file_exists($file)) {
        if (ob_get_level()) {
            ob_end_clean();
        }
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename='.basename($file));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: no-cache');
        header('Pragma: public');
        header('Content-Length: '.filesize($file));
        readfile($file);
        exit;
    } else {
        echo 'ERRNFF';
    }
}

function aes128Encrypt($key, $data)
{
    $padding = 16 - (strlen($data) % 16);
    $data .= str_repeat(chr($padding), $padding);
    return mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, str_repeat("\0", 16));
}

function aes128Decrypt($key, $data)
{
    $data    = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, str_repeat("\0", 16));
    $padding = ord($data[strlen($data) - 1]);
    return substr($data, 0, -$padding);
}

function dataDecrypt($input, $key)
{
    $encr = base64_decode($input);
    $key  = strtoupper(hash('MD5', $key));
    $key  = strtoupper(hash('MD5', $key));
    return aes128Decrypt(substr($key, 0, 16), $encr);
}

function getExtension($filename)
{
    $path_info = pathinfo($filename);
    return $path_info['extension'];
}

function getOnlineUsers($ssp){
	if ($directory_handle = opendir($ssp)) {
		$count = 0;
					
		while ( false !== ($file = readdir( $directory_handle))) {
			if($file != '.' && $file != '..'){
				if(time() - filemtime($ssp.$file) < MAX_IDLE_TIME * 60) {
					$count++;
				}
			}
		}
		closedir($directory_handle);
		return $count;		
	} else {
		return false;
	}
}

function UserInBase($guid, $database){
	$res = $database->select("Clients", "GUID", Array(
		"GUID" => $guid
	));
	
	return (count($res) > 0);	
}

function UserID($guid, $database){
	$res = $database->select("Clients", Array("ID", "GUID"), Array(
		"GUID" => $guid
	));
	
	if (count($res) > 0) {
		return $res[0]["ID"];
	}	
	else
	{
		return -1;
	}
}

function ActualExeVer($ExeVerFile) {
if (file_exists($ExeVerFile)) {					
		$xml      = simplexml_load_file($ExeVerFile);
		return $xml->attributes()->Exe;
	}
	else return "";
}

function ActualExeVerSQL($database) {
	$res = $database->select("ExeVersions", Array("Version", "Current"), Array(
		"Current" => 1
	));

	if (count($res) > 0) {
		return Trim($res[0]["Version"]);
	}	
	else
	{
		return "";
	}
}

if (isset($_GET['rem'])) {
    
	$decr = trim($_GET['rem']);
	
	if ($decr === '4ff56aa088565ac36d940e30a33510c8') {	
		if ($UseMySQL === True) {
			$CDate = time();
			$ret = array(); 
			
			$DMax = date("Y-m-d H:i:s", $CDate);
			$DMin = date("Y-m-d H:i:s", $CDate - 3600);
			
			$data = $database->query("SELECT Count(DISTINCT Client) as cnt FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();
			
			$DMax = date("Y-m-d H:i:s", $CDate);
			$DMin = date("Y-m-d H:i:s", $CDate - 86400);
			
			$dataD = $database->query("SELECT Count(DISTINCT Client) as cnt FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();
			
			$DMax = date("Y-m-d H:i:s", $CDate);
			$DMin = date("Y-m-d H:i:s", $CDate - (86400 * 30));
			
			$dataM = $database->query("SELECT Count(DISTINCT Client) as cnt FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();
			
			echo 'Online users: '.$data[0]["cnt"].' ('.$dataD[0]["cnt"].' Польз./24 ч.; '.$dataM[0]["cnt"].' Польз./1 м.)'; 
		}
		else
		{
			session_start();
			echo 'Online users: '.getOnlineUsers($sysDir.'/TimeLog/').'<br />';
			session_destroy();
		}
	}
	
	if ($decr === '83009602920cec616f60adb40a2bb548') {	
		if ($UseMySQL === True) {
			$CDate = time();
			$ret = array(); 
			
			//$DMax = date("Y-m-d H:i:s", $CDate);
			//$DMin = date("Y-m-d H:i:s", $CDate - 3600);
			
			//$data = $database->query("SELECT Count(Client) as cnt FROM Requests WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();
			
			$DMax = date("Y-m-d H:i:s", $CDate);
			$DMin = date("Y-m-d H:i:s", $CDate - 86400);
			
			$dataD = $database->query("SELECT Count(Client) as cnt FROM Requests WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();
			
			$DMax = date("Y-m-d H:i:s", $CDate);
			$DMin = date("Y-m-d H:i:s", $CDate - (86400 * 30));
			
			$dataM = $database->query("SELECT Count(Client) as cnt FROM Requests WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();
			
			echo 'Кол-во заявок: '.$dataD[0]["cnt"].' Заявок/24 ч.; '.$dataM[0]["cnt"].' Заявок/1 м.'; 
		}
		else
		{
			//session_start();
			//echo 'Online users: '.getOnlineUsers($sysDir.'/TimeLog/').'<br />';
			//session_destroy();
		}
	}
	
	if (($decr === '3ba9b5256dfeb47ba867501ea90d03e5') AND $UseMySQL) {	
		$CDate = time();
		$ret = array();
		
		for ($i = 24; $i >= 0; $i--) { 
		
			$DMax = date("Y-m-d H:i:s", $CDate - ($i * 3600));
			$DMin = date("Y-m-d H:i:s", $CDate - (($i + 1) * 3600));

			$data = $database->query("SELECT Count(DISTINCT Client) as cnt FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();

			$ret[] = array(($CDate - ($i * 3600)) * 1000, (int)$data[0]["cnt"]);
		}
		
		header("content-type: application/json");
		echo json_encode($ret);
	}
	
	if (($decr === 'd5228c067b95f1d1d591f6f9a7be4363') AND $UseMySQL) {	
		$CDate = time();
		$ret = array();
		
		for ($i = 24; $i >= 0; $i--) { 
		
			$DMax = date("Y-m-d H:i:s", $CDate - ($i * 3600));
			$DMin = date("Y-m-d H:i:s", $CDate - (($i + 1) * 3600));
			///
			$data = $database->query("SELECT COUNT(*) as cnt FROM Requests WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();

			$ret[] = array(($CDate - ($i * 3600)) * 1000, (int)$data[0]["cnt"]);
		}
		
		header("content-type: application/json");
		echo json_encode($ret);
	}
	
	if (($decr === '84f66a2fdf10e7a2f4998d602ad0dc8b') AND $UseMySQL) {	
		$CDate = time();
		$ret = array();
		
		for ($i = 168; $i >= 0; $i--) { 
		
			$DMax = date("Y-m-d H:i:s", $CDate - ($i * 3600));
			$DMin = date("Y-m-d H:i:s", $CDate - (($i + 1) * 3600));

			$data = $database->query("SELECT Count(DISTINCT Client) as cnt FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();

			$ret[] = array(($CDate - ($i * 3600)) * 1000, (int)$data[0]["cnt"]);
		}
		
		header("content-type: application/json");
		echo json_encode($ret);
	}
	
	if (($decr === 'd45c8fe232afde3944dcce2c10a15219') AND $UseMySQL) {	
		$CDate = time();
		$ret = array();
		
		for ($i = 168; $i >= 0; $i--) { 
		
			$DMax = date("Y-m-d H:i:s", $CDate - ($i * 3600));
			$DMin = date("Y-m-d H:i:s", $CDate - (($i + 1) * 3600));

			$data = $database->query("SELECT COUNT(*) as cnt FROM Requests WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s')")->fetchAll();

			$ret[] = array(($CDate - ($i * 3600)) * 1000, (int)$data[0]["cnt"]);
		}
		
		header("content-type: application/json");
		echo json_encode($ret);
	}
	
	if (($decr === '1d6b630c530562734bc84ea9df530744') AND $UseMySQL) {	
		$CDate = time();
		$ret = array(); 
		
		$DMax = date("Y-m-d H:i:s", $CDate);
		$DMin = date("Y-m-d H:i:s", $CDate - (3600 * 24 * 7));
			
		$data = $database->query("SELECT  Count(DISTINCT Client) as Cnt, ExeFileVer FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s') GROUP BY ExeFileVer")->fetchAll();

		$sum=0;
		foreach ($data as $it) $sum+=$it['Cnt'];
			
		foreach ($data as $it){
			$cn = (int)$it['Cnt'];
			$pc = round(($cn / $sum) * 100, 2);  
			$vr = trim($it['ExeFileVer']);
			
			if (trim(ActualExeVerSQL($database)) === $vr) {
				$ret[] = array('name'=>$vr, 'y'=>$pc, 'sliced'=>true, 'selected'=>true);
			}
			else
			{
				$ret[] = array($vr, $pc);
			}
		}
			
		header("content-type: application/json");
		echo json_encode($ret);
	}
	
	if (($decr === '84afefefa7fe167778b080fce5b315c7') AND $UseMySQL) {	
		$CDate = time();
		$ret = array(); 
		
		$DMax = date("Y-m-d H:i:s", $CDate);
		$DMin = date("Y-m-d H:i:s", $CDate - (3600 * 24 * 7));
			
		$data = $database->query("SELECT  Count(DISTINCT Client) as Cnt, OSVersion FROM Visits WHERE DT BETWEEN STR_TO_DATE('".$DMin."', '%Y-%m-%d %H:%i:%s') AND STR_TO_DATE('".$DMax."', '%Y-%m-%d %H:%i:%s') GROUP BY OSVersion")->fetchAll();

		$sum=0;
		foreach ($data as $it) $sum+=$it['Cnt'];
			
		foreach ($data as $it){
			$cn = (int)$it['Cnt'];
			$pc = round(($cn / $sum) * 100, 2);  
			$vr = trim($it['OSVersion']);
			$vr = str_replace('Service Pack', 'SP', $vr);
			$vr = str_replace('Microsoft', 'MS', $vr);
			$vr = str_replace('Windows', 'Win', $vr);
			
			if ('Win 7 Ultimate  -  SP 1' === $vr) {
				$ret[] = array('name'=>$vr, 'y'=>$pc, 'sliced'=>true, 'selected'=>true);
			}
			else
			{
				$ret[] = array($vr, $pc);
			}
		}
			
		header("content-type: application/json");
		echo json_encode($ret);
	}
	
	if (($decr === 'f501741a001447a5da3a2f7dd13ed2d9') AND $UseMySQL) {	
		if (file_exists($KeyFile)) {      
			$xml = simplexml_load_file($KeyFile);
			  
			foreach ($xml->children() as $second_gen) {
				$guid = (string)$second_gen['ID'];
				
				if (UserInBase($guid, $database)) {
					//echo 'Aval';
				}
				else
				{
					$database->insert("Clients", Array(
						"GUID" => $guid
					));
				}
			}
			echo "OK";
		}	
	}
}

if (isset($_GET['ref'])) {
    session_start();
	
	$decr = $_GET['ref'];
    
    if ($_SESSION['auth'] === 'OK') {
                
		if (strlen($decr) > 32) {
			if (getExtension($decr) === 'xml') {
				$path = $homeDir.$_SESSION['xDir'].'/ANS/'.$decr;
				if (!isset($_GET['del'])) {
					file_force_download($path);
				} else {
					if (file_exists($path)) unlink($path);
				}
			}
		} else {
			$gfile = $AllArrFile[$decr];
			
			if (!isset($gfile)) {
				$gfile = $CustomArrFile[$decr];
				
				if (isset($gfile)) {
					$gfile = $homeDir.$_SESSION['xDir'].'/'.$gfile;
				} else {
					$gfile = $ExeArrFile[$decr];
					if (isset($gfile)) {
						$gfile = $sysDir.$gfile;
					}
				}
			} else {
				$gfile = $sysDir.$gfile;
			}
			
			if (isset($gfile)) {
				file_force_download($gfile);
			}
			
			if ($descr = 'c316ea10bd57cd5150667c3da4c0a352') {
				session_destroy();
			}
		}
    }
}

function CheckGUID($decr, $KeyFile) {
	if (file_exists($KeyFile)) {        
        $xml = simplexml_load_file($KeyFile);
                
        foreach ($xml->children() as $second_gen) {
            if (strcmp($second_gen['ID'], $decr) === 1) {
                $res = 1;
                Break;
            }
        }    
        return ($res === 1);
				
	} else {
        echo 'OPENKERROR';
		return False;
    }
}

if (!empty($_POST)) {
    if (array_key_exists($postName, $_POST)) {
        try {
            $decr = dataDecrypt($_POST[$postName], $key);
 
                if ($UseMySQL ? UserInBase($decr, $database) : CheckGUID($decr, $KeyFile)) {
                    if (array_key_exists('TADir', $_POST)) {
                        $DDir = dataDecrypt($_POST['TADir'], $key);
						
						if (array_key_exists('TAREQ', $_POST)) {
							$TReq = dataDecrypt($_POST['TAREQ'], $key);
							
							if ('<?xml' <> substr($TReq, 0, 5)) {
								$TReq = base64_decode($TReq);
							}
							
							if ($UseMySQL) {
								$UserID = UserID($decr, $database);
							
								$database->insert("Requests", Array(
										"Client" => $UserID,
										"IP" => $_SERVER["REMOTE_ADDR"],
										"DT" => date("Y-m-d H:i:s"),
										"Req" => $TReq
								));
							}
							else
							{
								$Debugfile = $reqDir.'/Debug/'.$decr.'.xml';
								
								$fd = fopen($Debugfile, 'w');
								
								fwrite($fd, $TReq); 
								fclose($fd);
							}

							$doc = new DOMDocument('1.0', 'utf-8');
							$doc->loadXML(iconv("cp1251", "utf-8", $TReq)); 

							foreach ($doc->getElementsByTagName('Requests') as $feeditem) {
								$nodes = $feeditem->getElementsByTagName('Request');
								$TReqFileName = $nodes->item(0)->getAttribute('UID');
								Break;
							}		

							$filename = $reqDir.'/'.$TReqFileName;
							$newfile = $reqDir.'/History/'.$TReqFileName.'.xml';

							if ($doc->save($filename) === FALSE) {
								echo 'NOREC';
							} else {
								$docTest = new DOMDocument('1.0', 'utf-8');
								$docTest->load($filename);

								foreach ($docTest->getElementsByTagName('Requests') as $feeditem) {
									$nodes = $feeditem->getElementsByTagName('Request');
									$TReqFileNameTest = $nodes->item(0)->getAttribute('UID');
									Break;
								}
								
								if ($TReqFileNameTest === $TReqFileName)
								{
									copy($filename, $newfile);
									
									if (rename($filename, $filename.'.xml') === TRUE) {
										echo 'SENDOK';
									} else {
										echo 'NOREC';
									}
								} else {
									echo 'NOREC';
								}
							}
						}
						else {
							session_start();
							
							$_SESSION['auth'] = 'OK';
							$_SESSION['xDir'] = $DDir;
							
							echo 'RESOK@';
							
							foreach ($AllArrFile as $arrKey => $value) {
								$fileName     = $sysDir.'/'.$value;
								$time_file    = filemtime($fileName);
								$ConvTimeFile = date('YmdHis', $time_file);
								echo $arrKey.'='.$ConvTimeFile.'='.filesize($fileName).'@';
							}
							
							foreach ($CustomArrFile as $arrKey => $value) {
								$fileName     = $homeDir.$DDir.'/'.$value;
								$time_file    = filemtime($fileName);
								$ConvTimeFile = date('YmdHis', $time_file);
								echo $arrKey.'='.$ConvTimeFile.'='.filesize($fileName).'@';
							}
	
							$ExeVer  = "";
							
							if ($UseMySQL) {
								$ExeVer   = ActualExeVerSQL($database);
							}
							else
							{
								$ExeVer   = ActualExeVer($ExeVerFile);
							}
								
							$fileName = $sysDir.'/'.$fileX;
							echo $fileMX.'='.$ExeVer.'='.filesize($fileName).'@';
					
							echo $ansFileK.'=';
							
							$handle = opendir($homeDir.$DDir.'/ANS/');
							if ($handle != false)
							{
								while (false !== ($file = readdir($handle))) {
									if (getExtension($file) === 'xml')
									{
										echo $file.'~';
									}
								}
								closedir($handle);
							}
							
							echo '@';
							
							if (array_key_exists('TInf', $_POST)) {
								$TInf = dataDecrypt($_POST['TInf'], $key);								
								
								$TInf = $TInf.'IP='.$_SERVER["REMOTE_ADDR"];
								
								if ($UseMySQL) {
									$UserID = UserID($decr, $database);
								
									$textAr = explode("\n", $TInf);

									$textAr = array_filter($textAr, 'trim');

									$ExeFileVer = "";
									$ExeMD5 = "";
									$OSVersion = "";
									$SystemInfo = "";
									$ProcessorName = "";
									
									foreach($textAr as $line){
										$TmpV = explode("=", $line);
										
										switch ($TmpV[0]) {
											case "ExeFileVer":
												$ExeFileVer = $TmpV[1];
												break;
											case "ExeMD5":
												$ExeMD5 = $TmpV[1];
												Break;
											case "OSVersion":
												$OSVersion = $TmpV[1];
												Break;
											case "SystemInfo":
												$SystemInfo = $TmpV[1];
												Break;
											case "ProcessorName":
												$ProcessorName = $TmpV[1];
												Break;
										}										
									}
								
									$database->insert("Visits", Array(
										"Client" => $UserID,
										"IP" => $_SERVER["REMOTE_ADDR"],
										"DT" => date("Y-m-d H:i:s"),
										"ExeFileVer" => $ExeFileVer,
										"ExeMD5" => $ExeMD5,
										"OSVersion" => $OSVersion,
										"SystemInfo" => $SystemInfo,
										"ProcessorName" => $ProcessorName
									));
								}
								else
								{
									$f = fopen($sysDir.'/TimeLog/'.$DDir.'_Time.log', 'w');
									fwrite($f, $TInf); 
									fclose($f);
								}
							}
						}
                    }
                } else {
                    echo 'NOK';
                }
        }
        catch (Exception $e) {
            echo 'ERROR';
        }
    }
} else {
	//echo '|'.ActualExeVerSQL($database).'|';
}
?>