# Item Discount Database Fix

## Issue
The item-wise discount was being calculated in the frontend but not properly saved to the database. The invoice model was dividing the global discount equally among all items instead of using the individual item discount amounts.

## Root Cause
In `_inc/model/invoice.php`, the `$product_discount` variable was calculated as:
```php
$product_discount = $discount_amount / $total_items;
```

This meant every item got an equal share of the global discount, ignoring the individual item discounts set in the POS.

## Fix Applied

### 1. Updated Invoice Model (_inc/model/invoice.php)

**Changed Line ~195:**
```php
// REMOVED: Global discount calculation
// $product_discount = $discount_amount / $total_items;
```

**Changed Line ~228:**
```php
// ADDED: Use individual item discount if provided, otherwise fallback to global
$product_discount = isset($product['item_discount_amount']) ? floatval($product['item_discount_amount']) : ($discount_amount / $total_items);
```

### 2. Payment Form Already Sends Data (_inc/template/payment_form.php)
The payment form already sends:
- `item_discount_type` (percentage or plain)
- `item_discount_percent` (the percentage value)
- `item_discount_amount` (the calculated amount)

### 3. Database Schema
The `selling_item` table already has the `item_discount` field:
```sql
`item_discount` decimal(25,4) NOT NULL DEFAULT 0.0000
```

## Result

Now when you:
1. Add items to POS
2. Set item discount (e.g., "4%" or "50")
3. Process payment

The individual item discounts are:
- ✅ Calculated correctly in frontend
- ✅ Sent to backend via payment form
- ✅ Saved to `selling_item.item_discount` field
- ✅ Reflected in invoice total
- ✅ Displayed in invoice view

## Example

**Before Fix:**
- Item 1: ₹100 × 2 = ₹200, Discount: 4% = ₹8
- Item 2: ₹50 × 1 = ₹50, Discount: 4% = ₹2
- Database saved: Both items got equal discount (₹5 each from global ₹10)
- Invoice showed: Wrong amounts

**After Fix:**
- Item 1: ₹100 × 2 = ₹200, Discount: 4% = ₹8 → Subtotal: ₹192
- Item 2: ₹50 × 1 = ₹50, Discount: 4% = ₹2 → Subtotal: ₹48
- Database saves: Item 1 discount = ₹8, Item 2 discount = ₹2
- Invoice shows: Correct amounts (₹192 + ₹48 = ₹240)

## Testing

To verify the fix:
1. Create a new invoice in POS
2. Add 2 items with different prices
3. Set different discounts (e.g., Item 1: 10%, Item 2: ₹25)
4. Complete payment
5. Check invoice - amounts should reflect individual discounts
6. Check database `selling_item` table - `item_discount` field should show correct values

## Files Modified
- `_inc/model/invoice.php` - Fixed discount calculation logic in both `createInvoice()` and `putOrderOnHold()` functions
- `_inc/template/payment_form.php` - Already sending discount data (verified, no changes needed)
- `assets/itsolution24/angular/controllers/PosController.js` - Frontend discount calculation (supports ₹ and %)
- `admin/pos.php` - UI for entering discounts with placeholder "₹ or %"

## Functions Updated
1. **createInvoice()** - Now uses individual item discounts when creating invoices
2. **putOrderOnHold()** - Now uses individual item discounts when holding orders
