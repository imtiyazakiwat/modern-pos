<?php
// Test script for GST number database migration
require_once 'config.php';

// Database connection
$host = $sql_details['host'];
$dbname = $sql_details['db'];
$username = $sql_details['user'];
$password = $sql_details['pass'];
$port = $sql_details['port'];

try {
    $pdo = new PDO("mysql:host=$host;port=$port;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "Database connection successful!\n";
    
    // Check if customer_gst_number column already exists
    $stmt = $pdo->prepare("SHOW COLUMNS FROM selling_info LIKE 'customer_gst_number'");
    $stmt->execute();
    $columnExists = $stmt->fetch();
    
    if ($columnExists) {
        echo "Column 'customer_gst_number' already exists in selling_info table.\n";
    } else {
        echo "Column 'customer_gst_number' does not exist. Applying migration...\n";
        
        // Read and execute migration SQL
        $migrationSQL = file_get_contents('database_migrations/add_customer_gst_number.sql');
        
        // Split SQL statements (remove comments and empty lines)
        $statements = array_filter(
            array_map('trim', 
                preg_split('/;(?=(?:[^\']*\'[^\']*\')*[^\']*$)/', $migrationSQL)
            ), 
            function($stmt) {
                return !empty($stmt) && !preg_match('/^--/', $stmt) && $stmt !== 'DESCRIBE `selling_info`';
            }
        );
        
        foreach ($statements as $statement) {
            if (!empty(trim($statement))) {
                try {
                    $pdo->exec($statement);
                    echo "Executed: " . substr($statement, 0, 50) . "...\n";
                } catch (PDOException $e) {
                    echo "Error executing statement: " . $e->getMessage() . "\n";
                    echo "Statement: " . $statement . "\n";
                }
            }
        }
    }
    
    // Verify the column was added
    echo "\nVerifying table structure:\n";
    $stmt = $pdo->query("DESCRIBE selling_info");
    $columns = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $gstColumnFound = false;
    foreach ($columns as $column) {
        if ($column['Field'] === 'customer_gst_number') {
            $gstColumnFound = true;
            echo "✓ customer_gst_number column found:\n";
            echo "  Type: " . $column['Type'] . "\n";
            echo "  Null: " . $column['Null'] . "\n";
            echo "  Default: " . ($column['Default'] ?? 'NULL') . "\n";
            break;
        }
    }
    
    if (!$gstColumnFound) {
        echo "✗ customer_gst_number column not found!\n";
    }
    
    // Check if index exists
    echo "\nChecking indexes:\n";
    $stmt = $pdo->query("SHOW INDEX FROM selling_info WHERE Key_name = 'idx_customer_gst_number'");
    $index = $stmt->fetch();
    
    if ($index) {
        echo "✓ Index 'idx_customer_gst_number' found\n";
    } else {
        echo "✗ Index 'idx_customer_gst_number' not found!\n";
    }
    
    // Test with sample data
    echo "\nTesting with sample data:\n";
    
    // Insert test record
    $testInvoiceId = 'TEST_GST_' . time();
    $testGstNumber = '12ABCDE3456F7G8';
    
    $stmt = $pdo->prepare("
        INSERT INTO selling_info 
        (invoice_id, customer_mobile, customer_gst_number, created_by) 
        VALUES (?, ?, ?, 1)
    ");
    
    if ($stmt->execute([$testInvoiceId, '1234567890', $testGstNumber])) {
        echo "✓ Test record inserted successfully\n";
        
        // Retrieve test record
        $stmt = $pdo->prepare("SELECT customer_gst_number FROM selling_info WHERE invoice_id = ?");
        $stmt->execute([$testInvoiceId]);
        $result = $stmt->fetch();
        
        if ($result && $result['customer_gst_number'] === $testGstNumber) {
            echo "✓ Test record retrieved successfully: " . $result['customer_gst_number'] . "\n";
        } else {
            echo "✗ Failed to retrieve test record\n";
        }
        
        // Clean up test record
        $stmt = $pdo->prepare("DELETE FROM selling_info WHERE invoice_id = ?");
        $stmt->execute([$testInvoiceId]);
        echo "✓ Test record cleaned up\n";
        
    } else {
        echo "✗ Failed to insert test record\n";
    }
    
    echo "\nMigration test completed successfully!\n";
    
} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage() . "\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>