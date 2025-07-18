# Implementation Plan

- [x] 1. Set up database schema for GST number storage
  - Create database migration to add customer_gst_number column to selling_info table
  - Add index for GST number column for efficient querying
  - Test database schema changes with sample data
  - _Requirements: 2.1, 2.2_

- [ ] 2. Implement POS interface GST number input field
  - Add GST number input field to the customer area in admin/pos.php
  - Position the field logically within the existing customer selection interface
  - Apply consistent styling with existing form elements
  - _Requirements: 1.1, 4.1_

- [ ] 3. Add client-side validation for GST number input
  - Implement JavaScript validation function for alphanumeric format with hyphens
  - Add maximum length validation (15 characters)
  - Create visual feedback for validation errors
  - Integrate validation with existing form validation workflow
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ] 4. Update Angular POS controller to handle GST number
  - Add customerGstNumber property to PosController scope
  - Implement GST number validation function in Angular controller
  - Integrate GST number with existing customer selection workflow
  - Ensure GST number is included in checkout data flow
  - _Requirements: 1.1, 1.4, 4.2_

- [ ] 5. Modify payment form template to include GST number
  - Add hidden input field for customer GST number in payment_form.php
  - Ensure GST number is properly serialized with form data
  - Test form submission includes GST number in POST data
  - _Requirements: 1.4, 4.3_

- [ ] 6. Update order processing to handle GST number
  - Modify place_order.php to extract GST number from POST data
  - Add server-side validation for GST number format and length
  - Implement error handling for invalid GST number input
  - Pass GST number to invoice creation process
  - _Requirements: 2.3, 5.1, 5.2, 5.3_

- [ ] 7. Enhance invoice model to store GST number
  - Update createInvoice method in _inc/model/invoice.php to handle GST number
  - Modify database insertion query to include customer_gst_number field
  - Ensure GST number is stored correctly during invoice creation
  - Handle NULL values gracefully when GST number is not provided
  - _Requirements: 2.1, 2.2, 2.4_

- [ ] 8. Update invoice display templates to show GST number
  - Modify invoice templates to display GST number in notes section
  - Add conditional display logic to show GST number only when present
  - Format GST number display as "Customer GST: [GST_NUMBER]"
  - Ensure GST number appears on both screen and printed invoices
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

- [ ] 9. Implement comprehensive testing for GST number functionality
  - Create test cases for client-side validation functions
  - Test complete checkout workflow with GST number input
  - Verify GST number storage and retrieval from database
  - Test invoice display with and without GST numbers
  - Test error handling for invalid GST number inputs
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 2.1, 2.2, 2.3, 2.4, 3.1, 3.2, 3.3, 3.4, 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ] 10. Ensure backward compatibility and system integration
  - Test existing POS functionality remains unaffected
  - Verify keyboard navigation includes GST number field
  - Ensure GST number field integrates with existing tab order
  - Test system performance with GST number functionality enabled
  - Validate that existing invoices without GST numbers display correctly
  - _Requirements: 4.1, 4.2, 4.3, 4.4_