-- Add show_upi_qr preference to stores
ALTER TABLE `stores` ADD `show_upi_qr` tinyint(1) NOT NULL DEFAULT 0 AFTER `auto_print`;

-- Update store with default values
UPDATE `stores` SET `show_upi_qr` = 0 WHERE `store_id` > 0; 