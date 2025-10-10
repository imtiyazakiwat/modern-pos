<?php
/**
 * Test MRP Extraction Mechanism - Updated with Multiple Patterns
 * This file demonstrates how MRP is extracted from product names
 */

// Test cases
$test_products = [
    'kurta_14_540',           // NEW: Multiple numbers with underscore
    'kurta_14-540',           // NEW: Multiple numbers with dash
    'shirt_12_399.50',        // NEW: Multiple numbers with decimal MRP
    'Coca Cola 500ml_50',
    'Pepsi 1L_75.50',
    'Water Bottle_25',
    'Chips Pack_30.99',
    'Product Without MRP',
    'Product_With_Multiple_Underscores_100',
    'Product:Barcode123_45',
    'cm test _0.55',
    'tobacco_ui-800',
    'Product-500',
    'Item _99.99',
    'Test_abc-123.45',
    'jeans_32_1200',          // NEW: Size + MRP
    'dress_M-850',            // NEW: Size + MRP with dash
];

echo "=== MRP Extraction Test (Multiple Patterns) ===\n\n";

foreach ($test_products as $full_name) {
    echo "Input: '$full_name'\n";
    
    $mrp_value = null;
    $product_display_name = $full_name;
    $pattern_matched = false;
    $pattern_used = '';
    
    // Pattern 1: Multiple numbers with underscore, last is MRP (e.g., "kurta_14_540")
    if (preg_match('/^(.+?)_\d+_(\d+(?:\.\d+)?)$/', $full_name, $matches)) {
        $product_display_name = trim($matches[1]);
        $mrp_value = trim($matches[2]);
        $pattern_matched = true;
        $pattern_used = 'Pattern 1: name + number + underscore + MRP';
    }
    // Pattern 2: Multiple numbers with dash, last is MRP (e.g., "kurta_14-540")
    elseif (preg_match('/^(.+?)_(\d+)-(\d+(?:\.\d+)?)$/', $full_name, $matches)) {
        $product_display_name = trim($matches[1]);
        $mrp_value = trim($matches[3]);
        $pattern_matched = true;
        $pattern_used = 'Pattern 2: name + underscore + number + dash + MRP';
    }
    // Pattern 3: underscore/space followed by digits (e.g., "Product_50" or "Product _0.55")
    elseif (preg_match('/^(.+?)[\s_]+(\d+(?:\.\d+)?)$/', $full_name, $matches)) {
        $product_display_name = trim($matches[1]);
        $mrp_value = trim($matches[2]);
        $pattern_matched = true;
        $pattern_used = 'Pattern 3: underscore/space + digits';
    }
    // Pattern 4: underscore + text + dash + digits (e.g., "tobacco_ui-800")
    elseif (preg_match('/^(.+?)_[a-zA-Z]+-(\d+(?:\.\d+)?)$/', $full_name, $matches)) {
        $product_display_name = trim($matches[1]);
        $mrp_value = trim($matches[2]);
        $pattern_matched = true;
        $pattern_used = 'Pattern 4: underscore + text + dash + digits';
    }
    // Pattern 5: dash followed by digits at the end (e.g., "Product-800")
    elseif (preg_match('/^(.+?)-(\d+(?:\.\d+)?)$/', $full_name, $matches)) {
        $product_display_name = trim($matches[1]);
        $mrp_value = trim($matches[2]);
        $pattern_matched = true;
        $pattern_used = 'Pattern 5: dash + digits';
    }
    
    // Handle case with colon-separated barcode
    if (strpos($product_display_name, ':') !== false) {
        $product_display_name = trim(explode(':', $product_display_name)[0]);
    }
    
    echo "  → Product Name: '$product_display_name'\n";
    echo "  → MRP Value: " . ($mrp_value ? "₹$mrp_value" : "Not found") . "\n";
    echo "  → Pattern: " . ($pattern_used ? $pattern_used : "No pattern matched") . "\n";
    echo "  → Status: " . ($mrp_value ? "✓ Extracted" : "✗ No MRP") . "\n";
    echo "\n";
}

echo "=== Test Complete ===\n\n";

echo "=== Pattern Explanations ===\n";
echo "Pattern 1: /^(.+?)_\d+_(\d+(?:\.\d+)?)$/\n";
echo "  Matches: 'kurta_14_540', 'shirt_12_399.50', 'jeans_32_1200'\n";
echo "  Use case: Product with size/variant number + MRP\n\n";

echo "Pattern 2: /^(.+?)_(\d+)-(\d+(?:\.\d+)?)$/\n";
echo "  Matches: 'kurta_14-540', 'dress_M-850'\n";
echo "  Use case: Product with size/variant + dash + MRP\n\n";

echo "Pattern 3: /^(.+?)[\s_]+(\d+(?:\.\d+)?)$/\n";
echo "  Matches: 'Product_50', 'Product _0.55', 'Item_99.99'\n";
echo "  Use case: Simple product name + MRP\n\n";

echo "Pattern 4: /^(.+?)_[a-zA-Z]+-(\d+(?:\.\d+)?)$/\n";
echo "  Matches: 'tobacco_ui-800', 'Product_abc-123.45'\n";
echo "  Use case: Product with text code + MRP\n\n";

echo "Pattern 5: /^(.+?)-(\d+(?:\.\d+)?)$/\n";
echo "  Matches: 'Product-500', 'Item-99.99'\n";
echo "  Use case: Alternative dash separator\n\n";
?>
