# MRP Saving and Display Mechanism Documentation

## Overview
This document explains how the MRP (Maximum Retail Price) is saved in the database and how it's displayed in barcodes in your POS system.

---

## 1. MRP Storage in Database

### How MRP is Saved

**Location:** `_inc/product.php`

The MRP is **NOT stored in a separate database column**. Instead, it's **appended to the product name** using an underscore separator.

#### Code Flow (Lines 147-150 and 217-220):

```php
// During Product Creation (CREATE action)
if (isset($request->post['p_mrp']) && !empty($request->post['p_mrp'])) {
    $request->post['p_name'] = $request->post['p_name'] . "_" . $request->post['p_mrp'];
}

// During Product Update (UPDATE action)
if (isset($request->post['p_mrp']) && !empty($request->post['p_mrp'])) {
    $request->post['p_name'] = $request->post['p_name'] . "_" . $request->post['p_mrp'];
}
```

### Example:
- **User Input:**
  - Product Name: `Coca Cola 500ml`
  - MRP: `50`

- **Stored in Database (p_name column):**
  - `Coca Cola 500ml_50`

### Database Table
The modified product name is stored in the `products` table in the `p_name` column:

```sql
INSERT INTO `products` (p_type, p_name, p_code, hsn_code, barcode_symbology, category_id, unit_id, p_image, description) 
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
```

---

## 2. MRP Input Form

**Location:** `_inc/template/product_create_form.php` (Lines 127-134)

There's a dedicated MRP input field in the product creation form:

```php
<div class="form-group">
    <label for="p_mrp" class="col-sm-3 control-label">
        <?php echo "MRP"; ?><i class="required">*</i>
    </label>
    <div class="col-sm-7">
        <input type="text" class="form-control" id="p_mrp" 
               value="<?php echo isset($request->post['p_mrp']) ? $request->post['p_mrp'] : null; ?>" 
               name="p_mrp" required>
    </div>
</div>
```

---

## 3. MRP Extraction and Display in Barcodes

**Location:** `admin/barcode_print.php` (Lines 296-313)

When generating barcodes, the system **parses the product name** to extract the MRP value.

### Parsing Logic:

```php
// Parse product name for MRP
$full_name = $product['p_name'];
$mrp_value = null;
$product_display_name = $full_name;

// Look for '_' followed by digits pattern (matching storage format)
if (preg_match('/(.*)_(\d+(?:\.\d+)?)$/', $full_name, $matches)) {
    $product_display_name = trim($matches[1]);
    $mrp_value = trim($matches[2]);
}

// Handle case with colon-separated barcode
if (strpos($product_display_name, ':') !== false) {
    $product_display_name = trim(explode(':', $product_display_name)[0]);
}
```

### Pattern Explanation:
The regex pattern now correctly uses **underscore (_)** to match the storage format:
- Pattern: `/(.*)_(\d+(?:\.\d+)?)$/`
- Breakdown:
  - `(.*)` - Captures everything before the underscore (product name)
  - `_` - Matches the underscore separator
  - `(\d+(?:\.\d+)?)` - Captures digits with optional decimal (MRP value)
  - `$` - Ensures match is at the end of string
- This correctly extracts: `ProductName_123` or `ProductName_123.50`

### ✅ Fixed:
The storage and extraction formats now match:
- **Storage format:** `ProductName_MRP` (underscore)
- **Extraction format:** `ProductName_MRP` (underscore)

The barcode parsing now correctly extracts MRP from stored product names.

---

## 4. Barcode Display

**Location:** `admin/barcode_print.php` (Lines 327-341)

Once extracted, the MRP is displayed on the barcode:

```php
<?php if (isset($request->post['fields']['price']) && $request->post['fields']['price']):?>
    <div style="margin: 0 auto; padding: 0; display: flex; justify-content: center; width: 100%; text-align: center; gap: 0;">
        <?php if ($mrp_value): ?>
            <div style="font-size: 10px; margin-right: 0; text-align: left; margin-left: 0; width: 40%; padding-left: 3px; font-weight: bold;">
                <span>MRP:<?php if (isset($request->post['fields']['currency']) && $request->post['fields']['currency']): ?><?php echo get_currency_code();?><?php endif;?><?php echo $mrp_value;?></span>
            </div>
        <?php endif;?>
        <div style="font-weight: bold; font-size: 10px; text-align: right; width: 40%; padding-right: 3px; margin-left: -15px;">
            <span>SALE:
            <?php if (isset($request->post['fields']['currency']) && $request->post['fields']['currency']):?>
            <?php echo get_currency_code();?> 
            <?php endif;?>
            <?php 
            $price = $product['sell_price'];
            $formatted_price = rtrim(rtrim(number_format($price, 2, '.', ''), '0'), '.');
            echo $formatted_price;
            ?></span>
        </div>
    </div>
<?php endif;?>
```

### Barcode Layout:
```
┌─────────────────────────┐
│   Store Name            │
│   Product Name          │  <- Trimmed (without MRP)
│   Product Code          │
│   ||||||||||||||||      │  <- Barcode
│   MRP: ₹50  SALE: ₹45   │  <- MRP and Sale Price
└─────────────────────────┘
```

---

## 5. Product Name Trimming

The product name displayed on the barcode is **trimmed** to remove the MRP suffix:

```php
<div style="margin-bottom: 0; padding-bottom: 0; text-align: center;">
    <span class="barcode_name"><?php echo $product_display_name;?></span>
</div>
```

Where `$product_display_name` contains only the product name without the MRP value (extracted using regex).

---

## 6. Summary of the Flow

### Product Creation:
1. User enters product name: `Coca Cola 500ml`
2. User enters MRP: `50`
3. System appends MRP to name: `Coca Cola 500ml_50`
4. Stored in database `products.p_name` column

### Barcode Generation:
1. System retrieves product: `Coca Cola 500ml_50`
2. Regex extracts:
   - Product Name: `Coca Cola 500ml`
   - MRP Value: `50` (if pattern matches)
3. Displays on barcode:
   - Product Name: `Coca Cola 500ml`
   - MRP: `₹50`
   - Sale Price: `₹45`

---

## 7. ✅ Fixed Issues

### Issue 1: Separator Mismatch (RESOLVED)
- **Previous Problem:** Storage used underscore `_` but extraction used dash `-`
- **Impact:** MRP was not being extracted correctly from stored product names
- **Fix Applied:** Updated regex pattern in `barcode_print.php` to use underscore
- **New Pattern:** `/(.*)_(\d+(?:\.\d+)?)$/`
- **Status:** ✅ FIXED - Storage and extraction now both use underscore

### Improvements Made:
1. Changed regex from dash to underscore: `/(.*)-(\d+)/` → `/(.*)_(\d+(?:\.\d+)?)$/`
2. Added support for decimal MRP values: `(\d+(?:\.\d+)?)`
3. Added end-of-string anchor `$` to ensure accurate matching

---

## 8. Database Schema

The MRP is **not a separate column**. The relevant columns in the `products` table are:

```sql
CREATE TABLE `products` (
    `p_id` INT PRIMARY KEY AUTO_INCREMENT,
    `p_name` VARCHAR(255),  -- Contains: "ProductName_MRP"
    `p_code` VARCHAR(100),
    `p_type` VARCHAR(50),
    `category_id` INT,
    `unit_id` INT,
    -- other columns...
);
```

---

## 9. Key Files Involved

1. **`_inc/product.php`** - Handles MRP appending to product name
2. **`_inc/template/product_create_form.php`** - MRP input field
3. **`admin/barcode_print.php`** - MRP extraction and barcode display
4. **`_inc/model/product.php`** - Database operations (stores the modified name)

---

## Conclusion

The MRP mechanism works by:
1. **Appending** MRP to product name with underscore during creation/update
2. **Storing** the combined string in the `p_name` database column
3. **Extracting** MRP using regex when generating barcodes
4. **Displaying** product name (trimmed) and MRP separately on barcode

The system does **not use a dedicated MRP column** in the database, which is an unconventional approach that may cause issues with product name searches and data integrity.
