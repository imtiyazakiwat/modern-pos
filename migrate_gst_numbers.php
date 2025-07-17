<?php
/*
| ----------------------------------------------------------------------------
| Migration script to extract GST numbers from invoice notes
| ----------------------------------------------------------------------------
*/
require_once "_init.php";

// Get all invoices with notes containing GST numbers
$sql = "SELECT * FROM `selling_info` WHERE `invoice_note` LIKE '%Customer GST Number:%'";
$statement = db()->prepare($sql);
$statement->execute();
$invoices = $statement->fetchAll(PDO::FETCH_ASSOC);

$updated = 0;

// Process each invoice to extract GST number and update the record
foreach ($invoices as $invoice) {
    $invoice_note = $invoice['invoice_note'];
    $gst_number = '';
    
    // Extract GST number from note using regex
    if (preg_match('/Customer GST Number:\s*([^\n]+)/', $invoice_note, $matches)) {
        $gst_number = trim($matches[1]);
        
        // Remove the GST number line from the note
        $new_note = preg_replace('/Customer GST Number:\s*[^\n]+\n?/', '', $invoice_note);
        $new_note = trim($new_note);
        
        // Update the record with extracted GST number
        $update_sql = "UPDATE `selling_info` SET `gst_number` = ?, `invoice_note` = ? WHERE `invoice_id` = ?";
        $update_statement = db()->prepare($update_sql);
        $update_statement->execute(array($gst_number, $new_note, $invoice['invoice_id']));
        
        $updated++;
    }
}

echo "Migration completed. Updated $updated records."; 