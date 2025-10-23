# Item-wise Discount Implementation (₹ and %)

## Summary
Added item-wise discount column in POS system supporting both fixed amount (₹) and percentage (%) discounts.

## Changes Made

### 1. Frontend UI (admin/pos.php)
- Added "Disc %" column header in the invoice item table
- Added discount input field for each item row with placeholder "₹ or %"
- Input field accepts both fixed amounts and percentages

### 2. Controller Logic (assets/itsolution24/angular/controllers/PosController.js)
- Added `discountInput`, `discountType`, `discountPercent` and `discountAmount` properties to item objects
- Implemented `updateItemDiscount()` function to handle both discount types:
  - **Percentage**: Input with "%" symbol (e.g., "10%")
  - **Fixed Amount**: Direct number input (e.g., "50")
- Updated `updateItemQuantity()` to recalculate with discount when quantity changes
- Updated `DecreaseItemFromInvoice()` to maintain discount when decreasing quantity
- Updated `addItemToInvoice()` to recalculate with discount when increasing quantity
- Added event listener for `.item_discount` input changes

### 3. Styling (assets/itsolution24/css/pos/pos.css)
- Added styles for the discount column header (50px width, centered)
- Added styles for `.item_discount` input field with orange border and light background
- Updated table column widths to accommodate the new discount column

### 4. Payment Form (_inc/template/payment_form.php)
- Added hidden fields to pass `item_discount_type`, `item_discount_percent` and `item_discount_amount` to backend
- Added visual indicator showing discount next to item name in payment summary:
  - Shows "[-10%]" for percentage discounts
  - Shows "[-₹50.00]" for fixed amount discounts

## How It Works

### Discount Types

**1. Percentage Discount (%):**
- Enter value with % symbol (e.g., "10%", "15.5%")
- Calculates: Discount Amount = (Price × Quantity) × (Percentage / 100)
- Validation: Must be between 0-100%

**2. Fixed Amount Discount (₹):**
- Enter direct number (e.g., "50", "100.50")
- Deducts the exact amount from item total
- Validation: Must be less than item total and non-negative

### Calculation Flow
1. Base Amount = Price × Quantity
2. Discount Amount = Based on type (percentage or fixed)
3. Subtotal = Base Amount - Discount Amount
4. Total recalculates automatically

### Validation Rules
- Percentage: 0-100% only
- Fixed Amount: Must be less than item total
- Negative values not allowed
- Invalid inputs reset to 0
- Sound effects play on errors

### Persistence
Discount is maintained when:
- Increasing/decreasing quantity
- Changing item price
- Processing payment
- Viewing in payment summary

## Usage Examples

### Example 1: Percentage Discount
1. Add item: Product A (₹100 × 2 = ₹200)
2. Enter discount: "10%"
3. Result: Subtotal = ₹180 (₹200 - ₹20)
4. Payment summary shows: "Product A (x2 pcs) [-10%]"

### Example 2: Fixed Amount Discount
1. Add item: Product B (₹500 × 1 = ₹500)
2. Enter discount: "50"
3. Result: Subtotal = ₹450 (₹500 - ₹50)
4. Payment summary shows: "Product B (x1 pcs) [-₹50.00]"

### Example 3: Mixed Discounts
- Item 1: 10% discount
- Item 2: ₹25 fixed discount
- Item 3: No discount
- All calculate independently

## Technical Notes

- Each item stores its own discount type and amount
- Discount type is automatically detected from input (% symbol presence)
- Calculations use Angular's digest cycle for real-time updates
- Backend receives discount type, percentage, and calculated amount
- Compatible with existing tax, shipping, and global discount features
- Discount information is preserved in invoice data
