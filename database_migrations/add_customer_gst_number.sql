-- Migration: Add customer GST number support to POS system
-- Date: 2025-07-16
-- Description: Adds customer_gst_number column to selling_info table for GST number storage

-- Add customer_gst_number column to selling_info table
ALTER TABLE `selling_info` 
ADD COLUMN `customer_gst_number` VARCHAR(15) NULL 
AFTER `customer_mobile`;

-- Add index for efficient querying of GST numbers
CREATE INDEX `idx_customer_gst_number` 
ON `selling_info`(`customer_gst_number`);

-- Verify the column was added successfully
DESCRIBE `selling_info`;