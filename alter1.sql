-- Add UPI payment method if not exists
INSERT INTO `pmethods` (`name`, `code_name`, `details`, `created_at`, `updated_at`) 
SELECT 'UPI Payment', 'upi', 'Payment through UPI (Unified Payments Interface) with dynamic QR code', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1 FROM `pmethods` WHERE `code_name` = 'upi'
);

-- Get the UPI pmethod_id (whether just inserted or already existing)
SET @upi_pmethod_id = (SELECT `pmethod_id` FROM `pmethods` WHERE `code_name` = 'upi');

-- Add UPI payment method to stores where not already added
INSERT INTO `pmethod_to_store` (`ppmethod_id`, `store_id`, `status`, `sort_order`)
SELECT @upi_pmethod_id, s.store_id, 1, COALESCE(
    (SELECT MAX(sort_order) + 1 FROM `pmethod_to_store` WHERE store_id = s.store_id),
    1
)
FROM `stores` s
WHERE NOT EXISTS (
    SELECT 1 FROM `pmethod_to_store` 
    WHERE ppmethod_id = @upi_pmethod_id AND store_id = s.store_id
); 