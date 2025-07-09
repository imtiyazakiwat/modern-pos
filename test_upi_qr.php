<?php
// Include initialization file
include ("_init.php");

// Set up test parameters
$amount = 100.00;
$store_name = store('name');
$ctn = 'TEST' . time();

// Create UPI URL
$upi_id = "8217291743@ybl"; // Change this to your actual UPI ID
$upi_url = "upi://pay?pa=" . urlencode($upi_id) . 
          "&pn=" . urlencode($store_name) . 
          "&am=" . $amount . 
          "&cu=INR" . 
          "&tn=" . urlencode("Order Payment - " . $ctn);

// Generate QR code
require_once(DIR_INCLUDE . '/src/phpqrcode/phpqrcode.php');

// Create directory if not exists
$qr_dir = DIR_STORAGE . 'temp/qrcodes/';
if (!file_exists($qr_dir)) {
    mkdir($qr_dir, 0755, true);
}

// Generate unique filename
$qr_file = $qr_dir . 'test_upi_' . $ctn . '.png';
$qr_web_path = root_url() . '/storage/temp/qrcodes/test_upi_' . $ctn . '.png';

// Generate QR code
QRcode::png($upi_url, $qr_file, 'M', 6, 2);

// Display the result
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UPI QR Code Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .qr-code {
            text-align: center;
            margin: 20px 0;
        }
        .info {
            background: #f9f9f9;
            padding: 10px;
            border-radius: 5px;
        }
        h1 {
            color: #333;
        }
        pre {
            background: #f5f5f5;
            padding: 10px;
            border-radius: 3px;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>UPI QR Code Test</h1>
        
        <div class="qr-code">
            <?php if (file_exists($qr_file)): ?>
                <img src="<?php echo $qr_web_path; ?>" alt="UPI QR Code">
                <p>QR Code generated successfully!</p>
            <?php else: ?>
                <p>Failed to generate QR code.</p>
            <?php endif; ?>
        </div>
        
        <div class="info">
            <h3>Test Parameters:</h3>
            <ul>
                <li><strong>Amount:</strong> ₹<?php echo $amount; ?></li>
                <li><strong>Store Name:</strong> <?php echo $store_name; ?></li>
                <li><strong>Transaction Reference:</strong> <?php echo $ctn; ?></li>
                <li><strong>UPI ID:</strong> <?php echo $upi_id; ?></li>
            </ul>
            
            <h3>UPI URL:</h3>
            <pre><?php echo $upi_url; ?></pre>
            
            <h3>File Path:</h3>
            <pre><?php echo $qr_file; ?></pre>
        </div>
    </div>
</body>
</html> 