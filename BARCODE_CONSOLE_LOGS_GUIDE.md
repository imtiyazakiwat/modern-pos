# Barcode Print Console Logs Guide

## Overview
Console logs have been added to `admin/barcode_print.php` to track the entire barcode generation process, including MRP extraction and price formatting.

---

## Console Log Sections

### 1. **Barcode Generation Start**
```
========================================
BARCODE GENERATION STARTED
========================================
```
Indicates the beginning of the barcode generation process.

---

### 2. **Selected Fields**
```
--- SELECTED FIELDS ---
Field: site_name = 1
Field: product_name = 1
Field: p_code = 1
Field: price = 1
Field: currency = 1
```
Shows which fields are selected to be displayed on the barcode (checkboxes from the form).

---

### 3. **Layout Settings**
```
--- LAYOUT SETTINGS ---
Per Page: 12
Page Layout: a4
```
Shows the selected barcode layout and page format.

---

### 4. **Barcode Summary**
```
--- BARCODE SUMMARY ---
Total Products: 3
Total Barcodes to Generate: 15
```
Shows how many unique products and total barcodes will be generated.

---

### 5. **Product Data** (For each product)
```
=== PRODUCT DATA ===
Product ID: 123
Product Code: PROD001
Full Product Name (from DB): Coca Cola 500ml_50
Sell Price: 45.00
Purchase Price: 35.00
Quantity in Stock: 100
```
Shows all the raw data retrieved from the database for each product.

---

### 6. **MRP Extraction** (For each barcode)
```
--- MRP EXTRACTION START ---
Full Name Input: "Coca Cola 500ml_50"
✓ MRP Pattern Matched!
Regex Matches: ["Coca Cola 500ml_50","Coca Cola 500ml","50"]
Extracted Product Name: "Coca Cola 500ml"
Extracted MRP Value: "50"
--- MRP EXTRACTION END ---
```

**If MRP is found:**
- Shows the regex pattern matched successfully
- Displays all regex match groups
- Shows the extracted product name (without MRP)
- Shows the extracted MRP value

**If MRP is NOT found:**
```
--- MRP EXTRACTION START ---
Full Name Input: "Product Without MRP"
✗ MRP Pattern NOT Matched
Product will display without MRP
--- MRP EXTRACTION END ---
```

**If colon is detected in name:**
```
Colon detected in name
Before colon trim: "Product:Barcode123"
After colon trim: "Product"
```

---

### 7. **Price Display**
```
--- PRICE DISPLAY ---
Raw Sell Price: 45.00
Formatted Sell Price: 45
MRP will be displayed: 50
Currency will be shown: ₹
--- END PRICE DISPLAY ---
```

Shows:
- Raw sell price from database
- Formatted sell price (trailing zeros removed)
- Whether MRP will be displayed
- Whether currency symbol will be shown

**If no MRP:**
```
MRP will NOT be displayed (no value)
```

---

### 8. **Barcode Generation Progress**
```
Generating barcode 1 of 5 for this product
Barcode HTML generated and added to array

Generating barcode 2 of 5 for this product
Barcode HTML generated and added to array
...
```
Shows progress for each barcode being generated.

---

### 9. **Product Complete**
```
=== END PRODUCT ===
```
Marks the end of processing for one product.

---

### 10. **Generation Complete**
```
========================================
ALL BARCODES GENERATED SUCCESSFULLY
Total barcodes in array: 15
========================================
```
Final summary showing all barcodes were generated successfully.

---

## How to View Console Logs

### In Browser:
1. Open the barcode print page in your browser
2. Press `F12` or right-click and select "Inspect"
3. Go to the "Console" tab
4. Generate barcodes
5. View the detailed logs

### Example Console Output:
```
========================================
BARCODE GENERATION STARTED
========================================

--- SELECTED FIELDS ---
Field: site_name = 1
Field: product_name = 1
Field: p_code = 1
Field: price = 1

--- LAYOUT SETTINGS ---
Per Page: 12
Page Layout: a4

--- BARCODE SUMMARY ---
Total Products: 2
Total Barcodes to Generate: 10

=== PRODUCT DATA ===
Product ID: 45
Product Code: PROD123
Full Product Name (from DB): Coca Cola 500ml_50
Sell Price: 45.00
Purchase Price: 35.00
Quantity in Stock: 100

Generating barcode 1 of 5 for this product

--- MRP EXTRACTION START ---
Full Name Input: "Coca Cola 500ml_50"
✓ MRP Pattern Matched!
Regex Matches: ["Coca Cola 500ml_50","Coca Cola 500ml","50"]
Extracted Product Name: "Coca Cola 500ml"
Extracted MRP Value: "50"
--- MRP EXTRACTION END ---

--- PRICE DISPLAY ---
Raw Sell Price: 45.00
Formatted Sell Price: 45
MRP will be displayed: 50
Currency will be shown: ₹
--- END PRICE DISPLAY ---

Barcode HTML generated and added to array

[... continues for all barcodes ...]

========================================
ALL BARCODES GENERATED SUCCESSFULLY
Total barcodes in array: 10
========================================
```

---

## Debugging Tips

### If MRP is not showing on barcode:

1. **Check Product Data section:**
   - Look at "Full Product Name (from DB)"
   - Verify it has the format: `ProductName_MRP`

2. **Check MRP Extraction section:**
   - If you see "✗ MRP Pattern NOT Matched", the product name doesn't have MRP appended
   - Check the regex matches to see what was captured

3. **Check Price Display section:**
   - If you see "MRP will NOT be displayed (no value)", the extraction failed

### If product name looks wrong:

1. **Check MRP Extraction section:**
   - Look at "Extracted Product Name" to see what will be displayed
   - Check if colon trimming occurred

### If prices are wrong:

1. **Check Product Data section:**
   - Verify "Sell Price" is correct
   - Verify "Purchase Price" is correct

2. **Check Price Display section:**
   - Compare "Raw Sell Price" vs "Formatted Sell Price"

---

## Regex Pattern Explanation

The MRP extraction uses this regex pattern:
```regex
/(.*)_(\d+(?:\.\d+)?)$/
```

**Breakdown:**
- `(.*)` - Captures everything before underscore (product name)
- `_` - Matches the underscore separator
- `(\d+(?:\.\d+)?)` - Captures digits with optional decimal (MRP)
- `$` - Ensures match is at the end of string

**Examples:**
- `Coca Cola_50` → Name: "Coca Cola", MRP: "50"
- `Pepsi 1L_75.50` → Name: "Pepsi 1L", MRP: "75.50"
- `Water_Bottle_25` → Name: "Water_Bottle", MRP: "25"
- `Product` → No match (no MRP)

---

## Files Modified

- `admin/barcode_print.php` - Added comprehensive console logging

---

## Notes

- Console logs are only visible in the browser's developer console
- They do not affect the printed barcode output
- Logs use `addslashes()` to safely escape special characters
- All logs are wrapped in `<script>console.log()</script>` tags
- Logs can be removed in production if needed (search for `console.log` in the file)
