# MRP Extraction Patterns Documentation

## Overview
The barcode system now supports **multiple patterns** to extract MRP from product names stored in different formats.

---

## Supported Patterns

### Pattern 1: Multiple Numbers with Underscore (Size/Variant + MRP)
**Regex:** `/^(.+?)_\d+_(\d+(?:\.\d+)?)$/`

**Matches:**
- `kurta_14_540` → Name: "kurta", MRP: "540"
- `shirt_12_399.50` → Name: "shirt", MRP: "399.50"
- `jeans_32_1200` → Name: "jeans", MRP: "1200"

**Format:** `ProductName_SizeOrNumber_MRP`

**Use Case:** Products with size/variant numbers where the last number is the MRP.

---

### Pattern 2: Number + Dash + MRP
**Regex:** `/^(.+?)_(\d+)-(\d+(?:\.\d+)?)$/`

**Matches:**
- `kurta_14-540` → Name: "kurta", MRP: "540"
- `dress_M-850` → Name: "dress", MRP: "850"
- `shirt_L-499` → Name: "shirt", MRP: "499"

**Format:** `ProductName_Size-MRP`

**Use Case:** Products with size/variant followed by dash and MRP.

---

### Pattern 3: Underscore/Space + Digits
**Regex:** `/^(.+?)[\s_]+(\d+(?:\.\d+)?)$/`

**Matches:**
- `Product_50` → Name: "Product", MRP: "50"
- `Product _0.55` → Name: "Product", MRP: "0.55"
- `cm test _0.55` → Name: "cm test", MRP: "0.55"
- `Item_99.99` → Name: "Item", MRP: "99.99"

**Format:** `ProductName_MRP` or `ProductName _MRP`

**Use Case:** Simple product name with MRP.

---

### Pattern 4: Underscore + Text + Dash + Digits
**Regex:** `/^(.+?)_[a-zA-Z]+-(\d+(?:\.\d+)?)$/`

**Matches:**
- `tobacco_ui-800` → Name: "tobacco", MRP: "800"
- `Product_abc-123.45` → Name: "Product", MRP: "123.45"
- `Item_mrp-50` → Name: "Item", MRP: "50"

**Format:** `ProductName_text-MRP`

**Use Case:** Products with text codes between underscore and dash.

---

### Pattern 5: Dash + Digits
**Regex:** `/^(.+?)-(\d+(?:\.\d+)?)$/`

**Matches:**
- `Product-500` → Name: "Product", MRP: "500"
- `Item-99.99` → Name: "Item", MRP: "99.99"
- `Coca Cola-50` → Name: "Coca Cola", MRP: "50"

**Format:** `ProductName-MRP`

**Use Case:** Alternative dash separator format.

---

## Pattern Priority

The patterns are checked in order (most specific to least specific):
1. **Pattern 1** (name + number + underscore + MRP) - e.g., `kurta_14_540`
2. **Pattern 2** (name + underscore + number + dash + MRP) - e.g., `kurta_14-540`
3. **Pattern 3** (underscore/space + digits) - e.g., `Product_50`
4. **Pattern 4** (underscore + text + dash + digits) - e.g., `tobacco_ui-800`
5. **Pattern 5** (dash + digits) - e.g., `Product-500`

**Why this order?**
- More specific patterns are checked first to avoid false matches
- Pattern 1 & 2 handle products with size/variant numbers
- Pattern 3 handles simple cases
- Pattern 4 & 5 are fallbacks for alternative formats

If no pattern matches, the product displays without MRP.

---

## Examples from Your Database

### Example 1: ✅ Working
```
Input: "cm test _0.55"
Pattern Matched: Pattern 1
Product Name: "cm test"
MRP Value: "0.55"
```

### Example 2: ✅ Now Working (Fixed!)
```
Input: "tobacco_ui-800"
Pattern Matched: Pattern 4
Product Name: "tobacco"
MRP Value: "800"
```

### Example 3: ✅ New Pattern (Size + MRP)
```
Input: "kurta_14_540"
Pattern Matched: Pattern 1
Product Name: "kurta"
MRP Value: "540"
```

### Example 4: ✅ New Pattern (Size-MRP)
```
Input: "kurta_14-540"
Pattern Matched: Pattern 2
Product Name: "kurta"
MRP Value: "540"
```

---

## Console Log Output

When generating barcodes, you'll see which pattern matched:

```javascript
--- MRP EXTRACTION START ---
Full Name Input: "tobacco_ui-800"
Pattern 2 matched: underscore + text + dash + digits
✓ MRP Pattern Matched!
Regex Matches: ["tobacco_ui-800","tobacco","800"]
Extracted Product Name: "tobacco"
Extracted MRP Value: "800"
--- MRP EXTRACTION END ---
```

---

## Pattern Breakdown

### Pattern 1: `/^(.+?)[\s_]+(\d+(?:\.\d+)?)$/`
- `^` - Start of string
- `(.+?)` - Capture product name (non-greedy)
- `[\s_]+` - One or more spaces or underscores
- `(\d+(?:\.\d+)?)` - Capture digits with optional decimal
- `$` - End of string

### Pattern 2: `/^(.+?)_[a-zA-Z]+-(\d+(?:\.\d+)?)$/`
- `^` - Start of string
- `(.+?)` - Capture product name (non-greedy)
- `_` - Underscore separator
- `[a-zA-Z]+` - One or more letters (not captured)
- `-` - Dash separator
- `(\d+(?:\.\d+)?)` - Capture digits with optional decimal
- `$` - End of string

### Pattern 3: `/^(.+?)-(\d+(?:\.\d+)?)$/`
- `^` - Start of string
- `(.+?)` - Capture product name (non-greedy)
- `-` - Dash separator
- `(\d+(?:\.\d+)?)` - Capture digits with optional decimal
- `$` - End of string

---

## Testing

Run the test file to see all patterns in action:
```bash
php test_mrp_extraction.php
```

**Output:**
```
=== MRP Extraction Test (Multiple Patterns) ===

Input: 'cm test _0.55'
  → Product Name: 'cm test'
  → MRP Value: ₹0.55
  → Pattern: Pattern 1: underscore/space + digits
  → Status: ✓ Extracted

Input: 'tobacco_ui-800'
  → Product Name: 'tobacco'
  → MRP Value: ₹800
  → Pattern: Pattern 2: underscore + text + dash + digits
  → Status: ✓ Extracted

Input: 'Product-500'
  → Product Name: 'Product'
  → MRP Value: ₹500
  → Pattern: Pattern 3: dash + digits
  → Status: ✓ Extracted
```

---

## Recommendations

### For New Products:
Use **Pattern 1** format for consistency:
- `ProductName_MRP`
- Example: `Coca Cola_50`

### For Existing Products:
All three patterns are supported, so no need to update existing data.

---

## Edge Cases Handled

✅ Decimal MRP values: `Product_50.50`
✅ Spaces before underscore: `Product _50`
✅ Multiple underscores in name: `Product_With_Underscores_100`
✅ Text between underscore and dash: `tobacco_ui-800`
✅ Colon in product name: `Product:Code_50`

---

## What Doesn't Match

❌ No separator: `Product50`
❌ Letters after separator: `Product_abc`
❌ Multiple dashes: `Product-abc-50` (would match Pattern 3 incorrectly)
❌ MRP in middle: `Product_50_Extra`

---

## Files Modified

- `admin/barcode_print.php` - Updated MRP extraction logic
- `test_mrp_extraction.php` - Updated test cases

---

## Summary

Your barcode system now intelligently detects MRP from multiple formats:
1. Standard format: `Product_50`
2. Special format: `tobacco_ui-800`
3. Alternative format: `Product-50`

Both of your examples now work correctly! 🎉
