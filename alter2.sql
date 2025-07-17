-- Add GST number column to selling_info table
ALTER TABLE `selling_info` ADD COLUMN `gst_number` VARCHAR(50) DEFAULT NULL AFTER `customer_mobile`; 