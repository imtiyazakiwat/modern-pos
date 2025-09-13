<?php
include ("_init.php");

echo "Testing database query...<br>";

try {
    // Test basic query
    $statement = $db->prepare("SELECT COUNT(*) as count FROM `products`");
    $statement->execute();
    $result = $statement->fetch(PDO::FETCH_ASSOC);
    echo "Total products: " . $result['count'] . "<br>";
    
    // Test the actual query we're using
    $query = "test";
    $statement = $db->prepare("
        SELECT p.p_id, p.p_name, p.p_code, p.sell_price, p.unit_id, p.category_id,
               u.unit_name, c.category_name
        FROM `products` p 
        LEFT JOIN `units` u ON p.unit_id = u.unit_id 
        LEFT JOIN `categories` c ON p.category_id = c.category_id 
        WHERE p.p_name LIKE ? OR p.p_code LIKE ? 
        ORDER BY p.p_name ASC LIMIT 10
    ");
    $statement->execute(array('%' . $query . '%', '%' . $query . '%'));
    $products = $statement->fetchAll(PDO::FETCH_ASSOC);
    
    echo "Query executed successfully. Found " . count($products) . " products.<br>";
    
    if (count($products) > 0) {
        echo "First product: " . print_r($products[0], true) . "<br>";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "<br>";
    echo "Stack trace: " . $e->getTraceAsString() . "<br>";
}
?>
