# Modern POS Update Guide

## File Structure Overview

### Key Files in the POS System

- **`admin/pos.php`** - Main POS interface entry point
- **`assets/itsolution24/angular/controllers/PosController.js`** - Main Angular controller for POS functionality
- **`assets/itsolution24/angular/modals/PaymentFormModal.js`** - Payment form modal (source)
- **`assets/itsolution24/angularmin/modal.js`** - Minified version of all modals (including payment)
- **`assets/itsolution24/jsmin/pos.js`** - Minified version of POS JavaScript
- **`assets/itsolution24/js/pos/success-modal.js`** - Success modal that appears after payment completion
- **`assets/itsolution24/js/pos/invoice-patch.js`** - Patch for invoice functionality

### Configuration Files

- **`config.php`** - Main configuration file
  - Contains `USECOMPILEDASSET` setting that determines whether to use original or minified JS

## Understanding the Payment Flow

1. User clicks "Pay" button in POS interface
2. `payNow()` function in `PosController.js` is triggered
3. `PaymentFormModal` is opened
4. User completes payment via modal
5. Payment is processed via AJAX request
6. Success modal appears with invoice ID
7. User can print or view the invoice

## How to Update Payment Functionality

### Method 1: Updating Success Modal (Recommended)

The easiest way to modify the payment flow is by editing the success modal that appears after payment completion:

1. Locate `assets/itsolution24/js/pos/success-modal.js`
2. This file overrides the default `swal` (SweetAlert) function
3. Modify the buttons in the success modal to add custom functionality
4. Add handlers for each button action

**Example: Adding a "View Invoice" button**

```javascript
// In success-modal.js
return originalSwal({
    title: "Success",
    text: text,
    icon: "success",
    buttons: {
        view: {  // Add this button
            text: "View Invoice",
            value: "view",
            visible: !!invoiceNumber,
            className: "btn-info"
        },
        print: {
            text: "Print Invoice",
            value: "print",
            visible: !!invoiceNumber,
            className: "btn-success"
        },
        ok: {
            text: "OK",
            value: "ok",
            visible: true,
            className: "btn-default"
        }
    }
}).then((value) => {
    if (value === "view" && invoiceNumber) {
        // Redirect to invoice view page
        window.location.href = window.baseUrl + "admin/view_invoice.php?invoice_id=" + invoiceNumber;
    } else if (value === "print" && invoiceNumber) {
        // Print functionality
        // ...
    }
});
```

### Method 2: Updating Payment Modal Source

If you need to modify the payment modal directly:

1. Edit `assets/itsolution24/angular/modals/PaymentFormModal.js` (source file)
2. If `USECOMPILEDASSET` is `true`, also update:
   - `assets/itsolution24/angularmin/modal.js`
   - `assets/itsolution24/jsmin/pos.js`
   - `assets/itsolution24/jsmin/main.js` (if present)

**Example: Adding a Custom Button to Payment Modal**

```javascript
// In PaymentFormModal.js template section
"<div class=\"modal-footer\">" +
    "<button ng-click=\"closePaymentFormModal();\" type=\"button\" class=\"btn btn-danger radius-50\"><i class=\"fa fa-fw fa-close\"></i> Close</button>" +
    "<button ng-click=\"goToInvoice();\" type=\"button\" class=\"btn btn-info radius-50\"><i class=\"fa fa-fw fa-file-text\"></i> Go to Invoice</button>" +
    "<button ng-click=\"checkout();\" type=\"button\" class=\"btn btn-success radius-50\"><i class=\"fa fa-fw fa-money\"></i> Checkout &rarr;</button>" +
"</div>"
```

Then add the corresponding function:

```javascript
// In PaymentFormModal.js controller section
$scope.goToInvoice = function() {
    // Function implementation
    // ...
};
```

## Working with Minified Files

### Understanding USECOMPILEDASSET

The `USECOMPILEDASSET` setting in `config.php` determines whether the system uses:

- `true`: Minified JavaScript files (from `jsmin/` and `angularmin/` folders)
- `false`: Original source files (from `js/` and `angular/` folders)

### When Making Changes

If `USECOMPILEDASSET` is `true`, you must update **both** the source files and the minified versions:

1. Update source file (e.g., `assets/itsolution24/angular/modals/PaymentFormModal.js`)
2. Update minified version in `assets/itsolution24/angularmin/modal.js`
3. Update minified version in `assets/itsolution24/jsmin/pos.js` (if applicable)
4. Update minified version in `assets/itsolution24/jsmin/main.js` (if applicable)

If `USECOMPILEDASSET` is `false`, you only need to update the source files.

### Temporarily Setting USECOMPILEDASSET to false

For easier development, you can temporarily set `USECOMPILEDASSET` to `false` in `config.php`:

```php
define('USECOMPILEDASSET', false);
```

This allows you to work with only the source files during development.

## Best Practices for POS Updates

1. **Always test changes in a development environment first**
2. **Understand the component relationships**:
   - The POS system uses Angular for UI components
   - Modals are defined in separate files but compiled into `modal.js`
   - Success messages are handled by the custom SweetAlert implementation
3. **Make incremental changes** and test after each modification
4. **Document your changes** for future reference
5. **Check browser console** for JavaScript errors
6. **Clear browser cache** if changes aren't appearing

## Common Issues and Solutions

### Changes Not Appearing

- Check if you're editing the correct file (source vs. minified)
- Check `USECOMPILEDASSET` setting in `config.php`
- Clear browser cache (Ctrl+F5 or Cmd+Shift+R)
- Check browser console for errors

### Payment Process Not Working

- Check for JavaScript errors in the console
- Verify AJAX endpoints are responding correctly
- Ensure payment modal is calling the correct methods

### Redirection Not Working

- Check that the URL format is correct
- Verify that the invoice ID is being correctly passed
- Check for any JavaScript errors preventing redirection

## Additional Resources

- Angular documentation: https://angularjs.org/
- SweetAlert documentation: https://sweetalert.js.org/
- Modern POS documentation (if available) 