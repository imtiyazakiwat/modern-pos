<?php define('STOCK_CHECK',false);

if (! function_exists('is_https'))
{
    function is_https()
    {
    	if ((isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) || $_SERVER['SERVER_PORT'] == 443) {
		  return true;
		} elseif (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' || !empty($_SERVER['HTTP_X_FORWARDED_SSL']) && $_SERVER['HTTP_X_FORWARDED_SSL'] == 'on') {
		  return true;
		} else {
		  return false;
		}
    }
}

if (! function_exists('get_protocol'))
{
    function get_protocol()
    {
        return is_https() ? 'https' : 'http';
    }
}

function checkInternetConnection($domain = 'www.google.com')  
{
    // Always return true to bypass internet check
    return true;
}

function url_exists($url) {
    // Always return true to bypass URL check
    return true;
}

function checkValidationServerConnection($url = 'http://tracker.itsolution24.com/pos34/check.php')  
{
    // Always return true to bypass validation server check
    return true;
}

function checkEnvatoServerConnection($domain = 'www.envato.com')  
{
    // Always return true to bypass Envato server check
    return true;
}

function checkOnline($domain) 
{
    // Always return true to bypass online check
    return true;
}

function checkDBConnection() 
{
	global $sql_details;
	$host = $sql_details['host'];
	$db = $sql_details['db'];
	$user = $sql_details['user'];
	$pass = $sql_details['pass'];
	$port = $sql_details['port'];
	try {
		$conn = new PDO("mysql:host={$host};port={$port};dbname={$db};charset=utf8",$user,$pass);
		$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		return $conn;
	}
	catch(PDOException $e) {
		return false;
	}
}

function isLocalhost() 
{
    $whitelist = array('localhost','127.0.0.1','::1');
    return in_array( $_SERVER['REMOTE_ADDR'], $whitelist);
}

function apiCall($data, $url = NULL) 
{
    // Return a success response object to bypass API calls
    return (object) array(
        'status' => 'success',
        'message' => 'Success',
        'schema' => isset($data['action']) && $data['action'] == 'install' ? '' : '',
        'for' => 'validation',
    );
}

function activeServer() 
{	
	$allDomain = array(
		'http://tracker.itsolution24.com/pos34',
		'http://thenajmul.net/tracker/pos34',
	);
	if(!empty($allDomain)) {
		foreach ($allDomain as $domain) {
			$url = parse_url($domain);
			if(checkOnline($url['host'])) {
				return $domain.'/check.php';
			}
		}
	}
	return false;
}

function get_real_ip() {
    if( array_key_exists('HTTP_X_FORWARDED_FOR', $_SERVER) && !empty($_SERVER['HTTP_X_FORWARDED_FOR']) ) {
        if (strpos($_SERVER['HTTP_X_FORWARDED_FOR'], ',')>0) {
            $addr = explode(",",$_SERVER['HTTP_X_FORWARDED_FOR']);
            return my_trim($addr[0]);
        } else {
            return $_SERVER['HTTP_X_FORWARDED_FOR'];
        }
    }
    else {
        return isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : '';
    }
}

function getMAC()
{
	if (!function_exists('system')) {
		return [];
	}
	ob_start();
	system('ipconfig /all');
	$mycom=ob_get_contents();
	ob_clean();
	$mac = array();
	foreach(preg_split("/(\r?\n)/", $mycom) as $line) {
		if(strstr($line, 'Physical Address')) {
			$mac[] = substr($line,39,18);
		}
	}
	return $mac;
}


function get_pusername() 
{
	$data = json_decode(ESNECIL,true);
	return isset($data['username']) ? $data['username'] : 'error';
}

function get_pcode() 
{
	$data = json_decode(ESNECIL,true);
	return isset($data['purchase_code']) ? $data['purchase_code'] : 'error';
}

function check_pcode() 
{
    // Always return true to bypass purchase code check
    return true;
}

function revalidate_pcode() 
{
    // Always return 'ok' to bypass revalidation
    return 'ok';
}

function repalce_stock_status($status, $is_blocked = '')
{
    // Do nothing and return true
    return true;
}

function check_runtime()
{
    global $session;
    // Always set session data and return valid status
    $session->data['stock_value'] = hash_generate();
    return json_encode(array('status'=>'valid'));
}

function denied_ips()
{
	return DENIED_IPS;
}

function allowed_only_ips()
{
	return ALLOWED_ONLY_IPS;
}

function replace_lines($file, $new_lines, $source_file = null) 
{
    $response = 0;
    $tab = chr(9);
    $lbreak = chr(13) . chr(10);
    if ($source_file) {
        $lines = file($source_file);
    }
    else {
        $lines = file($file);
    }
    foreach ($new_lines as $key => $value) {
        // $lines[--$key] = $tab . $value . $lbreak;
        $lines[--$key] = $value . $lbreak;
    }
    $new_content = implode('', $lines);
    if ($h = fopen($file, 'w')) {
        if (fwrite($h, trim($new_content))) {
            $response = 1;
        }
        fclose($h);
    }
    return $response;
}

function hash_generate($string = null)
{
	if (!$string) {
	    $store = function_exists('store') ? store('name') : 'myStore';
	    $root_url = function_exists('root_url') ? root_url() : 'url';
	    $version = function_exists('settings') ? settings('version') : '3.3';
		$string = $store . "\n";
		$string .= APPID . "\n";
		$string .= $root_url . "\n";
		$string .= $version . "\n";
		// $string .= time() . "\n";
	}
	return encode_data(hash_hmac('sha1', $string, root_url(), 1));
}

function hash_compare($a, $b) { 
	if (!is_string($a) || !is_string($b)) { 
	    return false; 
	} 

	$len = strlen($a); 
	if ($len !== strlen($b)) { 
	    return false; 
	} 

	$status = 0; 
	for ($i = 0; $i < $len; $i++) { 
	    $status |= ord($a[$i]) ^ ord($b[$i]); 
	} 
	return $status === 0; 
}

function generate_ecnesil($pusername, $pcode, $ecnesil_path)
{
    global $session;
    $line1 = "<?php defined('ENVIRONMENT') OR exit('No direct access allowed!');";
	$line2 = "return array('username'=>'".my_trim($pusername)."','purchase_code'=>'".my_trim($pcode)."');";
	$data = array(1 => $line1, 2 => $line2);

	chmod($ecnesil_path, FILE_WRITE_MODE);
	replace_lines($ecnesil_path, $data);
	chmod($ecnesil_path, FILE_READ_MODE);

	$app_id = unique_id(32);
	$app_name = 'Modern-POS';
	$app_info = "<?php define('APPNAME', '".$app_name."');define('APPID', '".$app_id."');";
	chmod(ROOT.DIRECTORY_SEPARATOR.'install'.DIRECTORY_SEPARATOR.'_init.php', FILE_WRITE_MODE);
	replace_lines(ROOT.DIRECTORY_SEPARATOR.'install'.DIRECTORY_SEPARATOR.'_init.php', array(1=>$app_info));
	chmod(ROOT.DIRECTORY_SEPARATOR.'install'.DIRECTORY_SEPARATOR.'_init.php', FILE_READ_MODE);

	$encryption = new Encryption();
	$url = $encryption->decrypt('url', 'UjN3OExaNUpSS1BpZk5FQkZuTXdFZlRmWWk2TlF1dGRhRSszWGZ5L0puVzJMNnhUVjZDNHdZY2xGR0NONDg3bg,,');
	$username = $encryption->decrypt('username', 'RzVtb1ZyQ0JOUmx2Z2o5dzN4ZCsxdz09');
	$password = $encryption->decrypt('password', 'by9DSXlnWnB1MHZCWUZTWGVRdE5UUT09');
	$data = array(
	    'username' => $username,
    	'password' => $password,
	    'app_name' => $app_name,
	    'app_id' => $app_id,
	    'version' => '3.3',
	    'files' => array('_init.php','ecnesil.php'),
	    'stock_status' => 'true', // LISENCE DISABLED
	); 
	$data_string = json_encode($data);
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
	curl_setopt($ch, CURLOPT_USERAGENT, isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '');
	curl_setopt($ch, CURLOPT_HTTPHEADER, [
	    'Content-Type: application/json',
	    'Content-Length: ' . strlen($data_string)]
	);
	$result = json_decode(curl_exec($ch),true);

	if (isset($result['contents'])) {
	  foreach ($result['contents'] as $filename => $content) {
	    switch ($filename) {
	      case '_init.php':
	          $file_path = ROOT.DIRECTORY_SEPARATOR.'_init.php';
	          $fp = fopen($file_path, 'wb');
	          fwrite($fp, $content);
	          fclose($fp);
	        break;
	      case 'ecnesil.php':
	          $file_path = DIR_INCLUDE.DIRECTORY_SEPARATOR.'ecnesil.php';
	          $fp = fopen($file_path, 'wb');
	          fwrite($fp, $content);
	          fclose($fp);
	        break;
	      default:
	        # code...
	        break;
	    }
	  }
	} else {
		return false;
	}
	return true;
}