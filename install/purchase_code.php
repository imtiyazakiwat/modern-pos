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

// Skip server connection check
// if(!checkValidationServerConnection() || !checkEnvatoServerConnection()) {
// 	if (is_ajax()) {
// 		$json['redirect'] = root_url().'install/index.php';
// 		echo json_encode($json);
// 		exit();
// 	} else {
// 		redirect('index.php');
// 	}
// }

$errors = array();
$success = array();
$info = array();

$errors['internet_connection'] = null;
$errors['purchase_username'] = null;
$errors['purchase_code'] = null;
$errors['config_error'] = null;

$ecnesil_path = DIR_INCLUDE.'config/purchase.php';
$config_path = ROOT . '/config.php';

function purchase_code_validation() 
{
    // Skip validation and always return true
    return true;
}

if ($request->server['REQUEST_METHOD'] == 'POST') 
{
    // Always redirect to next step
    $json['redirect'] = 'database.php';
    echo json_encode($json);
    exit();
}
?>

<?php 
$title = 'Validation-Modern POS';
include("header.php"); ?>
<?php include '../_inc/template/install/purchase_code.php'; ?>
<?php include("footer.php"); ?>
