# MRP Patterns - Quick Summary

## ✅ All Supported Formats

Your barcode system now handles **5 different MRP formats**:

### 1. Size/Variant with Underscore
```
kurta_14_540      → Name: "kurta", MRP: "540"
shirt_12_399.50   → Name: "shirt", MRP: "399.50"
jeans_32_1200     → Name: "jeans", MRP: "1200"
```
**Pattern:** `ProductName_Number_MRP`

---

### 2. Size/Variant with Dash
```
kurta_14-540      → Name: "kurta", MRP: "540"
dress_M-850       → Name: "dress", MRP: "850"
shirt_L-499       → Name: "shirt", MRP: "499"
```
**Pattern:** `ProductName_Number-MRP`

---

### 3. Simple Underscore/Space
```
Product_50        → Name: "Product", MRP: "50"
cm test _0.55     → Name: "cm test", MRP: "0.55"
Item_99.99        → Name: "Item", MRP: "99.99"
```
**Pattern:** `ProductName_MRP` or `ProductName _MRP`

---

### 4. Text Code with Dash
```
tobacco_ui-800    → Name: "tobacco", MRP: "800"
Product_abc-123   → Name: "Product", MRP: "123"
```
**Pattern:** `ProductName_TextCode-MRP`

---

### 5. Simple Dash
```
Product-500       → Name: "Product", MRP: "500"
Item-99.99        → Name: "Item", MRP: "99.99"
```
**Pattern:** `ProductName-MRP`

---

## 🎯 Your Examples - All Working!

| Input | Product Name | MRP | Status |
|-------|-------------|-----|--------|
| `cm test _0.55` | cm test | 0.55 | ✅ Works |
| `tobacco_ui-800` | tobacco | 800 | ✅ Works |
| `kurta_14_540` | kurta | 540 | ✅ Works |
| `kurta_14-540` | kurta | 540 | ✅ Works |

---

## 🔍 How to Check in Console

When you generate barcodes, you'll see:

```javascript
--- MRP EXTRACTION START ---
Full Name Input: "kurta_14_540"
Pattern 1 matched: name + number + underscore + MRP
✓ MRP Pattern Matched!
Extracted Product Name: "kurta"
Extracted MRP Value: "540"
--- MRP EXTRACTION END ---
```

---

## 📝 Recommendations

### For New Products:
- **With size/variant:** Use `ProductName_Size_MRP` (e.g., `kurta_14_540`)
- **Without size:** Use `ProductName_MRP` (e.g., `Product_50`)

### For Existing Products:
All formats are supported - no need to change anything!

---

## 🧪 Test It

Run the test file to see all patterns:
```bash
php test_mrp_extraction.php
```

---

## 📊 Pattern Detection Order

1. Check for size + underscore + MRP
2. Check for size + dash + MRP
3. Check for simple underscore + MRP
4. Check for text code + dash + MRP
5. Check for simple dash + MRP

**Most specific patterns are checked first!**

---

## ✨ Result

Your barcode system is now **super flexible** and handles all your product naming formats! 🎉

Whether you have:
- Products with sizes (`kurta_14_540`)
- Products with variants (`tobacco_ui-800`)
- Simple products (`Product_50`)

**All will display correctly with MRP extracted!**
