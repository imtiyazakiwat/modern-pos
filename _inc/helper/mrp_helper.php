<?php
/**
 * MRP Extraction Helper Function
 * Extracts MRP from product name using multiple patterns
 */

if (!function_exists('extract_mrp_from_name')) {
    /**
     * Extract MRP from product name
     * 
     * @param string $product_name Full product name with MRP
     * @return array ['name' => 'Product Name', 'mrp' => '540'] or ['name' => 'Product Name', 'mrp' => null]
     */
    function extract_mrp_from_name($product_name) {
        $mrp_value = null;
        $product_display_name = $product_name;
        
        // Pattern 1: Multiple numbers with underscore, last is MRP (e.g., "kurta_14_540")
        if (preg_match('/^(.+?)_\d+_(\d+(?:\.\d+)?)$/', $product_name, $matches)) {
            $product_display_name = trim($matches[1]);
            $mrp_value = trim($matches[2]);
        }
        // Pattern 2: Multiple numbers with dash, last is MRP (e.g., "kurta_14-540")
        elseif (preg_match('/^(.+?)_(\d+)-(\d+(?:\.\d+)?)$/', $product_name, $matches)) {
            $product_display_name = trim($matches[1]);
            $mrp_value = trim($matches[3]);
        }
        // Pattern 3: underscore/space followed by digits (e.g., "Product_50" or "Product _0.55")
        elseif (preg_match('/^(.+?)[\s_]+(\d+(?:\.\d+)?)$/', $product_name, $matches)) {
            $product_display_name = trim($matches[1]);
            $mrp_value = trim($matches[2]);
        }
        // Pattern 4: underscore + text + dash + digits (e.g., "tobacco_ui-800")
        elseif (preg_match('/^(.+?)_[a-zA-Z]+-(\d+(?:\.\d+)?)$/', $product_name, $matches)) {
            $product_display_name = trim($matches[1]);
            $mrp_value = trim($matches[2]);
        }
        // Pattern 5: dash followed by digits at the end (e.g., "Product-800")
        elseif (preg_match('/^(.+?)-(\d+(?:\.\d+)?)$/', $product_name, $matches)) {
            $product_display_name = trim($matches[1]);
            $mrp_value = trim($matches[2]);
        }
        
        // Handle case with colon-separated barcode
        if (strpos($product_display_name, ':') !== false) {
            $product_display_name = trim(explode(':', $product_display_name)[0]);
        }
        
        return array(
            'name' => $product_display_name,
            'mrp' => $mrp_value
        );
    }
}

if (!function_exists('get_product_mrp')) {
    /**
     * Get only MRP value from product name
     * 
     * @param string $product_name Full product name with MRP
     * @return string|null MRP value or null if not found
     */
    function get_product_mrp($product_name) {
        $result = extract_mrp_from_name($product_name);
        return $result['mrp'];
    }
}

if (!function_exists('get_product_display_name')) {
    /**
     * Get product name without MRP
     * 
     * @param string $product_name Full product name with MRP
     * @return string Product name without MRP
     */
    function get_product_display_name($product_name) {
        $result = extract_mrp_from_name($product_name);
        return $result['name'];
    }
}
