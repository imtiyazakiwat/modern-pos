# Requirements Document

## Introduction

This feature adds GST number capture functionality to the POS checkout process, allowing businesses to collect and store customer GST numbers during sales transactions. The GST number will be saved in the database and displayed on invoices as a note, similar to the existing purchase GST functionality.

## Requirements

### Requirement 1

**User Story:** As a cashier, I want to enter a customer's GST number during POS checkout, so that I can capture tax-related information for business customers.

#### Acceptance Criteria

1. WHEN I am at the POS checkout screen THEN the system SHALL display a "Customer GST Number" input field
2. WHEN I enter a GST number in the field THEN the system SHALL accept alphanumeric input up to 15 characters
3. WHEN I leave the GST number field empty THEN the system SHALL allow the transaction to proceed without requiring the field
4. WHEN I complete the checkout process with a GST number THEN the system SHALL save the GST number with the transaction

### Requirement 2

**User Story:** As a business owner, I want customer GST numbers to be stored in the database, so that I can maintain records for tax compliance and reporting.

#### Acceptance Criteria

1. WHEN a transaction is completed with a GST number THEN the system SHALL store the GST number in the invoice/transaction table
2. WHEN storing the GST number THEN the system SHALL associate it with the specific transaction ID
3. WHEN retrieving transaction data THEN the system SHALL include the GST number in the response
4. WHEN no GST number is provided THEN the system SHALL store NULL or empty value without causing errors

### Requirement 3

**User Story:** As a business owner, I want the customer GST number to appear on printed invoices, so that my customers have proper tax documentation.

#### Acceptance Criteria

1. WHEN generating an invoice with a GST number THEN the system SHALL display the GST number in the notes section
2. WHEN printing a receipt THEN the system SHALL include the GST number if present
3. WHEN viewing invoice details THEN the system SHALL show the customer GST number clearly labeled
4. WHEN no GST number exists THEN the system SHALL not display any GST-related information on the invoice

### Requirement 4

**User Story:** As a system administrator, I want the GST number functionality to integrate seamlessly with existing POS workflows, so that staff training and system changes are minimal.

#### Acceptance Criteria

1. WHEN the POS system loads THEN the GST number field SHALL be positioned logically within the existing checkout interface
2. WHEN using keyboard shortcuts or tab navigation THEN the GST number field SHALL be included in the natural flow
3. WHEN the system validates checkout data THEN it SHALL include GST number validation without breaking existing validation
4. WHEN generating reports THEN the system SHALL include GST number data in relevant transaction reports

### Requirement 5

**User Story:** As a cashier, I want basic validation on the GST number field, so that I can catch obvious input errors before completing the transaction.

#### Acceptance Criteria

1. WHEN I enter a GST number THEN the system SHALL validate the format is alphanumeric
2. WHEN I enter more than 15 characters THEN the system SHALL prevent additional input or show a warning
3. WHEN I enter special characters (except hyphens) THEN the system SHALL show a validation message
4. WHEN validation fails THEN the system SHALL highlight the field and display a clear error message
5. WHEN I correct the validation error THEN the system SHALL allow me to proceed with checkout