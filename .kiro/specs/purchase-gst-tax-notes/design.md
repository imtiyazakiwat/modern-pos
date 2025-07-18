# Design Document

## Overview

This design document outlines the implementation approach for enhancing the purchase invoice system to automatically append GST number and tax information to purchase notes. The solution involves both frontend form enhancements and backend processing modifications to ensure seamless data flow and proper formatting.

## Architecture

The enhancement follows the existing MVC architecture pattern:

- **Frontend (View)**: Angular.js controller and HTML form modifications
- **Backend (Controller)**: PHP purchase processing script modifications  
- **Model**: Database interaction remains unchanged as we're using existing purchase_info table
- **Data Flow**: Form submission → Backend processing → Note formatting → Database storage

## Components and Interfaces

### Frontend Components

#### 1. Purchase Form Enhancement
- **Location**: Purchase creation form template
- **New Fields**:
  - GST Number input field (`supplier_gst`)
  - Tax Information textarea field (`tax_information`)
- **Validation**: Client-side validation for GST format and tax information length
- **Integration**: Fields integrated into existing form structure

#### 2. Angular Controller Updates
- **File**: `assets/itsolution24/angular/controllers/PurchaseController.js`
- **Enhancements**:
  - Add scope variables for GST and tax fields
  - Add watchers for field changes
  - Update form submission to include new fields
  - Add logging for debugging purposes

### Backend Components

#### 1. Purchase Processing Script
- **File**: `_inc/purchase.php`
- **Current State**: Already has partial implementation for GST and tax handling
- **Enhancements Needed**:
  - Improve note formatting logic
  - Add proper validation for GST and tax fields
  - Enhance error handling
  - Clean up debug logging

#### 2. Note Formatting Logic
```php
// Enhanced note formatting function
function formatPurchaseNoteWithTaxInfo($originalNote, $supplierGst, $taxInfo) {
    $noteAppend = '';
    
    if (!empty($supplierGst)) {
        $noteAppend .= "Supplier GST: " . trim($supplierGst) . "\n";
    }
    
    if (!empty($taxInfo)) {
        $noteAppend .= "Tax Info: " . trim($taxInfo) . "\n";
    }
    
    if (!empty($noteAppend)) {
        return !empty($originalNote) 
            ? $originalNote . "\n\n" . trim($noteAppend)
            : trim($noteAppend);
    }
    
    return $originalNote;
}
```

## Data Models

### Existing Database Schema
The implementation uses the existing `purchase_info` table structure:
- `purchase_note` field stores the combined notes including tax information
- No database schema changes required

### Data Format in Notes
```
[Original Purchase Notes]

Supplier GST: [GST_NUMBER]
Tax Info: [TAX_INFORMATION]
```

## Error Handling

### Frontend Validation
- GST number format validation (alphanumeric, specific length)
- Tax information length limits
- Required field validation if business rules require it

### Backend Validation
- Sanitize input data to prevent XSS
- Validate GST format against business requirements
- Handle empty/null values gracefully
- Maintain backward compatibility with existing data

### Error Scenarios
1. **Invalid GST Format**: Display user-friendly error message
2. **Tax Information Too Long**: Truncate or reject with warning
3. **Database Connection Issues**: Graceful fallback without losing data
4. **Form Submission Errors**: Preserve user input for retry

## Testing Strategy

### Unit Testing
- Test note formatting function with various input combinations
- Test GST validation logic
- Test form field serialization

### Integration Testing
- Test complete purchase creation flow with GST/tax data
- Test form submission and backend processing
- Test database storage and retrieval

### User Acceptance Testing
- Test purchase creation with GST and tax information
- Verify notes display correctly in purchase views
- Test edge cases (empty fields, special characters)
- Test backward compatibility with existing purchases

### Test Cases
1. **Happy Path**: Create purchase with both GST and tax info
2. **Partial Data**: Create purchase with only GST or only tax info
3. **Empty Fields**: Create purchase without GST/tax info
4. **Existing Notes**: Append to existing purchase notes
5. **Special Characters**: Handle special characters in GST/tax fields
6. **Long Text**: Handle long tax information text

## Implementation Considerations

### Performance
- Minimal impact as we're only adding string concatenation
- No additional database queries required
- Form submission remains efficient

### Security
- Input sanitization for XSS prevention
- SQL injection protection (already handled by existing code)
- Data validation on both frontend and backend

### Backward Compatibility
- Existing purchases without GST/tax info remain unchanged
- New fields are optional to maintain compatibility
- No breaking changes to existing functionality

### Maintainability
- Clean separation of note formatting logic
- Consistent error handling patterns
- Proper logging for debugging
- Code documentation and comments

## User Experience

### Form Design
- GST and tax fields positioned logically in the purchase form
- Clear labels and placeholder text
- Consistent styling with existing form elements
- Responsive design for mobile compatibility

### Feedback
- Real-time validation feedback
- Success/error messages for form submission
- Clear indication when tax info is appended to notes

### Accessibility
- Proper form labels for screen readers
- Keyboard navigation support
- Color contrast compliance
- Error message accessibility