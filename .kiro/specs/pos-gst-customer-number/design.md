# Design Document

## Overview

This design document outlines the implementation of GST number capture functionality in the POS checkout process. The feature will add a customer GST number input field to the POS interface, store the GST number in the database, and display it on invoices as a note. The implementation follows the existing POS architecture and integrates seamlessly with the current checkout workflow.

## Architecture

The POS GST customer number feature will integrate with the existing POS system architecture:

- **Frontend**: Angular.js controller (PosController.js) manages the POS interface
- **Backend**: PHP handles form processing and database operations
- **Database**: MySQL stores GST numbers in the selling_info table
- **Templates**: PHP templates render the checkout form and invoice display

The feature will follow the existing data flow:
1. User enters GST number in POS checkout interface
2. Angular controller captures and validates the input
3. Data is sent to place_order.php via AJAX
4. PHP processes and stores GST number in database
5. Invoice templates display GST number when present

## Components and Interfaces

### Frontend Components

#### POS Interface Enhancement
- **Location**: Customer area in the POS checkout interface
- **Component**: New input field for customer GST number
- **Integration**: Added below existing customer selection area
- **Validation**: Client-side validation for format and length

#### Angular Controller Updates
- **File**: `assets/itsolution24/angular/controllers/PosController.js`
- **New Properties**:
  - `$scope.customerGstNumber`: Stores the GST number input
- **New Methods**:
  - GST number validation function
  - Integration with existing checkout process

### Backend Components

#### Payment Form Template
- **File**: `_inc/template/payment_form.php`
- **Enhancement**: Add hidden input field to pass GST number to checkout
- **Integration**: Include GST number in form serialization

#### Order Processing
- **File**: `_inc/place_order.php`
- **Enhancement**: Extract and validate GST number from POST data
- **Validation**: Server-side validation for GST number format

#### Invoice Model
- **File**: `_inc/model/invoice.php`
- **Enhancement**: Store GST number in database during invoice creation
- **Method**: Update `createInvoice()` method to handle GST number

### Database Schema

#### Table Modification
- **Table**: `selling_info`
- **New Column**: `customer_gst_number VARCHAR(15) NULL`
- **Purpose**: Store customer GST number for each transaction
- **Index**: Add index for reporting and search functionality

### Invoice Display

#### Invoice Templates
- **Files**: 
  - `_inc/template/purchase_invoice.php` (for reference)
  - POS receipt templates
- **Enhancement**: Display GST number in notes section when present
- **Format**: "Customer GST: [GST_NUMBER]"

## Data Models

### Customer GST Number Data Flow

```
POS Interface Input
    ↓
Angular Controller ($scope.customerGstNumber)
    ↓
Payment Form (hidden input: customer-gst-number)
    ↓
place_order.php ($_POST['customer-gst-number'])
    ↓
Invoice Model (createInvoice method)
    ↓
Database (selling_info.customer_gst_number)
    ↓
Invoice Display Templates
```

### Database Schema Changes

```sql
ALTER TABLE `selling_info` 
ADD COLUMN `customer_gst_number` VARCHAR(15) NULL 
AFTER `customer_mobile`;

CREATE INDEX idx_customer_gst_number 
ON selling_info(customer_gst_number);
```

### Data Validation Rules

- **Format**: Alphanumeric characters and hyphens only
- **Length**: Maximum 15 characters
- **Required**: Optional field (can be empty)
- **Storage**: Stored as-is without formatting changes

## Error Handling

### Client-Side Validation
- **Invalid Characters**: Show warning for non-alphanumeric characters (except hyphens)
- **Length Exceeded**: Prevent input beyond 15 characters
- **Visual Feedback**: Highlight field with error styling

### Server-Side Validation
- **Format Validation**: Validate alphanumeric pattern with hyphens
- **Length Validation**: Ensure maximum 15 characters
- **Error Response**: Return JSON error message for invalid input
- **Graceful Degradation**: Allow transaction to proceed if GST number is invalid (with warning)

### Database Error Handling
- **Column Constraints**: Handle NULL values gracefully
- **Migration Safety**: Ensure backward compatibility
- **Transaction Integrity**: Maintain ACID properties during invoice creation

## Testing Strategy

### Unit Testing
- **Frontend Validation**: Test GST number input validation functions
- **Backend Processing**: Test GST number extraction and storage
- **Database Operations**: Test invoice creation with GST numbers

### Integration Testing
- **Complete Checkout Flow**: Test end-to-end GST number capture and storage
- **Invoice Display**: Verify GST number appears correctly on invoices
- **Error Scenarios**: Test invalid input handling

### User Acceptance Testing
- **Cashier Workflow**: Test GST number entry during normal checkout
- **Invoice Generation**: Verify GST number appears on printed receipts
- **Optional Field**: Confirm transactions work without GST number

### Performance Testing
- **Database Impact**: Measure performance impact of additional column
- **Form Processing**: Ensure no significant delay in checkout process
- **Index Efficiency**: Verify GST number indexing doesn't impact performance

### Compatibility Testing
- **Browser Support**: Test across supported browsers
- **Mobile Devices**: Verify functionality on mobile POS interfaces
- **Existing Data**: Ensure backward compatibility with existing invoices

### Security Testing
- **Input Sanitization**: Test XSS prevention in GST number input
- **SQL Injection**: Verify parameterized queries prevent injection
- **Data Validation**: Test server-side validation bypassing attempts