<?php 
ob_start();
session_start();
define('START', true);
include ("_init.php");

$json = array();

if (defined('INSTALLED')) {
	if (is_ajax()) {
		$json['redirect'] = root_url().'index.php';
		echo json_encode($json);
		exit();
	} else {
		header('Location: ../index.php');
	}
}

// Skip purchase code check
// if (!check_pcode()) {
//	if (is_ajax()) {
//		$json['redirect'] = root_url().'install/database.php';
//		echo json_encode($json);
//		exit();
//	} else {
//		redirect('database.php');
//	}
// }

$errors = array();
$success = array();
$info = array();

$errors['timezone'] = null;
$errors['index_validation'] = null;

if(!checkDBConnection()) {
	redirect("database.php");
}

function set_timezone($timezone) 
{
	global $request, $errors;
	$index_path = ROOT . '/_init.php';
	chmod($index_path, FILE_WRITE_MODE);
	if (is_writable($index_path) === false) {
		$errors['index_validation'] = 'Init file is unwritable';
		return false;
	} else {
		// Instead of making API calls, directly modify the _init.php file to set timezone
		$file_content = file_get_contents($index_path);
		
		// Add timezone setting to _init.php
		$timezone_code = "\n// Timezone\n";
		$timezone_code .= "\$timezone = '{$timezone}';\n";
		$timezone_code .= "if(function_exists('date_default_timezone_set')) date_default_timezone_set(\$timezone);\n";
		
		// Find a good place to insert the timezone code
		$pos = strpos($file_content, "// Timezone");
		if ($pos !== false) {
			// If timezone section already exists, replace it
			$pattern = "/\/\/ Timezone.*?date_default_timezone_set\([^)]+\);/s";
			$file_content = preg_replace($pattern, $timezone_code, $file_content);
		} else {
			// Otherwise insert it before the end
			$pos = strrpos($file_content, "?>");
			if ($pos !== false) {
				$file_content = substr($file_content, 0, $pos) . $timezone_code . substr($file_content, $pos);
			} else {
				$file_content .= $timezone_code;
			}
		}
		
		// Write the modified content back to the file
		file_put_contents($index_path, $file_content);
		return true;
	}
}

if ($request->server['REQUEST_METHOD'] == 'POST') 
{
	if (!isset($request->post['timezone']) || empty($request->post['timezone'])) {

		$errors['timezone'] = 'Timezone field is required.';

	} else {

		$timezone = $request->post['timezone'];
		set_timezone($timezone);

		if(!$errors['timezone'] || !$errors['index_validation']) {
			$session->data['timezone'] = $timezone;
			$json['redirect'] = 'site.php';
		} else {
			$json = array_filter($errors);
		}
		echo json_encode($json);
		exit();
	} 
	$json = array_filter($errors);
	echo json_encode($json);
	exit();
}
?>

<?php 
$title = 'Timezone-Modern POS';
include("header.php"); ?>

<?php include '../_inc/template/install/timezone.php'; ?>

<?php include("footer.php"); ?>
