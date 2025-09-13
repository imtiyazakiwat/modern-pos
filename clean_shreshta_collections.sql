-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2025 at 10:51 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shreshta_collections`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL,
  `account_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account_details` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `initial_balance` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `account_no` varchar(255) NOT NULL,
  `contact_person` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone_number` varchar(14) DEFAULT NULL,
  `opening_date` datetime DEFAULT NULL,
  `url` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `total_deposit` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_withdraw` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_transfer_from_other` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_transfer_to_other` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `account_name`, `account_details`, `initial_balance`, `account_no`, `contact_person`, `phone_number`, `opening_date`, `url`, `total_deposit`, `total_withdraw`, `total_transfer_from_other`, `total_transfer_to_other`, `created_at`, `updated_at`) VALUES
(1, 'Default Account', 'This is a default account for any store', 0.0000, '1234567890', 'iAngryboy', '+880133333333', '2019-05-15 08:27:03', 'http://itsolution24.com', 0.0000, 0.0000, 0.0000, 0.0000, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(2, 'Default', 'default', 0.0000, '1000000000000000', 'default', '11111111111111', NULL, '', 0.0000, 0.0000, 0.0000, 0.0000, '2025-07-03 08:43:15', '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `bank_account_to_store`
--

CREATE TABLE `bank_account_to_store` (
  `ba2s` int(10) UNSIGNED NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `deposit` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `withdraw` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `transfer_from_other` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `transfer_to_other` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bank_account_to_store`
--

INSERT INTO `bank_account_to_store` (`ba2s`, `store_id`, `account_id`, `deposit`, `withdraw`, `transfer_from_other`, `transfer_to_other`, `status`, `sort_order`) VALUES
(1, 1, 2, 0.0000, 0.0000, 0.0000, 0.0000, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bank_transaction_info`
--

CREATE TABLE `bank_transaction_info` (
  `info_id` int(10) UNSIGNED NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `transaction_type` text DEFAULT NULL,
  `is_substract` tinyint(1) NOT NULL DEFAULT 0,
  `is_hide` tinyint(1) NOT NULL DEFAULT 0,
  `account_id` int(10) UNSIGNED NOT NULL,
  `source_id` int(11) DEFAULT NULL,
  `exp_category_id` int(11) DEFAULT NULL,
  `ref_no` varchar(100) NOT NULL COMMENT 'e.g. Transaction ID, Check No.',
  `invoice_id` varchar(100) DEFAULT NULL,
  `title` varchar(250) NOT NULL,
  `details` text DEFAULT NULL,
  `from_account_id` int(10) UNSIGNED DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `image` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_transaction_price`
--

CREATE TABLE `bank_transaction_price` (
  `price_id` int(11) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `info_id` int(11) DEFAULT NULL,
  `ref_no` varchar(100) NOT NULL COMMENT 'e.g. Transaction ID, Check No.',
  `amount` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boxes`
--

CREATE TABLE `boxes` (
  `box_id` int(10) UNSIGNED NOT NULL,
  `box_name` varchar(100) NOT NULL,
  `code_name` varchar(55) DEFAULT NULL,
  `box_details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `boxes`
--

INSERT INTO `boxes` (`box_id`, `box_name`, `code_name`, `box_details`) VALUES
(1, 'Common Box', 'common', 'Common Box details here...');

-- --------------------------------------------------------

--
-- Table structure for table `box_to_store`
--

CREATE TABLE `box_to_store` (
  `id` int(11) NOT NULL,
  `box_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `box_to_store`
--

INSERT INTO `box_to_store` (`id`, `box_id`, `store_id`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(10) UNSIGNED NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `code_name` varchar(100) NOT NULL,
  `brand_details` longtext DEFAULT NULL,
  `brand_image` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`, `code_name`, `brand_details`, `brand_image`, `created_at`, `updated_at`) VALUES
(1, 'No brand', 'no_brand', '', NULL, '2025-07-03 08:43:15', '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `brand_to_store`
--

CREATE TABLE `brand_to_store` (
  `b2s_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL DEFAULT 0,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `brand_to_store`
--

INSERT INTO `brand_to_store` (`b2s_id`, `brand_id`, `store_id`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `categorys`
--

CREATE TABLE `categorys` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category_slug` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `category_details` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `category_image` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categorys`
--

INSERT INTO `categorys` (`category_id`, `category_name`, `category_slug`, `parent_id`, `category_details`, `category_image`, `created_at`, `updated_at`) VALUES
(1, 'uncategory', 'uncategory', 0, 'this is a category details, simple text will be display here', NULL, '2025-07-03 08:43:15', '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `category_to_store`
--

CREATE TABLE `category_to_store` (
  `c2s_id` int(11) NOT NULL,
  `ccategory_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category_to_store`
--

INSERT INTO `category_to_store` (`c2s_id`, `ccategory_id`, `store_id`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `symbol_left` varchar(255) NOT NULL,
  `symbol_right` varchar(255) NOT NULL,
  `decimal_place` char(1) NOT NULL,
  `value` decimal(25,4) NOT NULL DEFAULT 1.0000,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`currency_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_place`, `value`, `created_at`) VALUES
(1, 'United States Dollar', 'USD', '$', '', '2', 1.0000, '2025-07-03 08:43:15'),
(2, 'Pound Sterling', 'GBP', '£', '', '2', 0.6125, '2025-07-03 08:43:15'),
(3, 'Euro', 'EUR', '€', '', '2', 0.7846, '2025-07-03 08:43:15'),
(4, 'Hong Kong Dollar', 'HKD', 'HK$', '', '2', 7.8222, '2025-07-03 08:43:15'),
(5, 'Indian Rupee', 'INR', '₹', '', '2', 64.4000, '2025-07-03 08:43:15'),
(6, 'Russian Ruble', 'RUB', '₽', '', '2', 56.4036, '2025-07-03 08:43:15'),
(7, 'Chinese Yuan', 'CNY', '¥', '', '2', 6.3451, '2025-07-03 08:43:15'),
(8, 'Australian Dollar', 'AUD', '$', '', '2', 1.2654, '2025-07-03 08:43:15'),
(9, 'Bangladeshi Taka', 'BDT', '৳', '', '2', 0.0000, '2025-07-03 08:43:15'),
(10, 'Pakistani Rupee ', 'PKR', '₨.', '', '2', 0.0000, '2025-07-03 08:43:15'),
(11, 'Croatian Kuna', 'HRK', 'kn', '', '2', 0.0000, '2025-07-03 08:43:15'),
(12, 'Malaysian Ringgit', 'MYR', 'RM', '', '2', 0.0000, '2025-07-03 08:43:15'),
(13, 'Saudi riyal', 'SAR', 'SR', '', '2', 0.0000, '2025-07-03 08:43:15'),
(14, 'Canadian Dollar', 'CAD', 'CAD $', '', '2', 0.0000, '2025-07-03 08:43:15'),
(17, 'Bitcoin', 'BTC', 'B', '', '0', 1.0000, '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `currency_to_store`
--

CREATE TABLE `currency_to_store` (
  `ca2s_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `currency_to_store`
--

INSERT INTO `currency_to_store` (`ca2s_id`, `currency_id`, `store_id`, `status`, `sort_order`) VALUES
(4, 4, 1, 1, 0),
(11, 11, 1, 1, 0),
(12, 12, 1, 1, 0),
(13, 13, 1, 1, 0),
(14, 14, 1, 1, 0),
(16, 8, 1, 1, 0),
(44, 1, 1, 1, 0),
(45, 2, 1, 1, 0),
(46, 3, 1, 1, 0),
(47, 9, 1, 1, 0),
(48, 7, 1, 1, 0),
(49, 6, 1, 1, 0),
(50, 5, 1, 1, 0),
(51, 10, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `customer_mobile` varchar(14) DEFAULT NULL,
  `customer_address` text DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `customer_sex` tinyint(1) NOT NULL DEFAULT 1,
  `customer_age` int(10) UNSIGNED DEFAULT NULL,
  `gtin` varchar(100) DEFAULT NULL,
  `customer_city` varchar(100) DEFAULT NULL,
  `customer_state` varchar(100) DEFAULT NULL,
  `customer_country` varchar(100) DEFAULT NULL,
  `is_giftcard` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `customer_email`, `customer_mobile`, `customer_address`, `dob`, `customer_sex`, `customer_age`, `gtin`, `customer_city`, `customer_state`, `customer_country`, `is_giftcard`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Walking Customer', 'wc@itsolution24.com', '0170000000000', 'BD', '1993-01-01', 1, 20, '147258', 'AN', 'AN', 'US', 0, 'c33367701511b4f6020ec61ded352059', '2025-07-03 08:43:15', '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `customer_to_store`
--

CREATE TABLE `customer_to_store` (
  `c2s_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `balance` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `due` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer_to_store`
--

INSERT INTO `customer_to_store` (`c2s_id`, `customer_id`, `store_id`, `balance`, `due`, `status`, `sort_order`) VALUES
(1, 1, 1, 0.0000, 0.0000, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_transactions`
--

CREATE TABLE `customer_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('purchase','add_balance','substract_balance','due_paid','others') NOT NULL,
  `reference_no` varchar(55) DEFAULT NULL,
  `ref_invoice_id` varchar(55) DEFAULT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL,
  `pmethod_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `balance` decimal(25,4) DEFAULT 0.0000,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `returnable` enum('no','yes') NOT NULL DEFAULT 'no',
  `note` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attachment` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categorys`
--

CREATE TABLE `expense_categorys` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category_slug` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `category_details` longtext CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sell_return` tinyint(1) NOT NULL DEFAULT 0,
  `sell_delete` tinyint(1) NOT NULL DEFAULT 0,
  `loan_delete` tinyint(1) NOT NULL DEFAULT 0,
  `loan_payment` tinyint(1) NOT NULL DEFAULT 0,
  `giftcard_sell_delete` tinyint(1) NOT NULL DEFAULT 0,
  `topup_delete` tinyint(1) NOT NULL DEFAULT 0,
  `product_purchase` tinyint(1) NOT NULL DEFAULT 0,
  `stock_transfer` tinyint(1) NOT NULL DEFAULT 0,
  `due_paid` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_hide` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expense_categorys`
--

INSERT INTO `expense_categorys` (`category_id`, `category_name`, `category_slug`, `parent_id`, `category_details`, `sell_return`, `sell_delete`, `loan_delete`, `loan_payment`, `giftcard_sell_delete`, `topup_delete`, `product_purchase`, `stock_transfer`, `due_paid`, `status`, `is_hide`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'Employee Salary', 'employee_salary', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(2, 'Showroom Rent', 'showroom_rent', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(3, 'Electricity Bill + Dish', 'electricity_bill_+_dish', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(4, 'Advertisements', 'advertisements', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(5, 'Bonous', 'bonous', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(6, 'Others', 'others', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(7, 'Returnable', 'returnable', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(8, 'Sell Return', 'sell_return', 0, '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(9, 'Product Purchase', 'product_purchase', 0, '', 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(10, 'Sell Delete', 'sell_delete', 0, '', 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(11, 'Loan Delete', 'loan_delete', 0, '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(12, 'Giftcard Topup Delete', 'giftcard_topup_delete', 0, '', 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(13, 'Giftcard Sell Delete', 'giftcard_sell_delete', 0, '', 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(14, 'Loan Payment', 'loan_payment', 0, '', 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(15, 'Due Paid to Supplier', 'due_paid_to_supplier', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `card_no` varchar(20) NOT NULL,
  `value` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `balance` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `expiry` date DEFAULT NULL,
  `created_by` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_topups`
--

CREATE TABLE `gift_card_topups` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `card_id` varchar(20) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holding_info`
--

CREATE TABLE `holding_info` (
  `info_id` int(11) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `order_title` varchar(255) NOT NULL,
  `ref_no` varchar(100) NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `customer_mobile` varchar(20) DEFAULT NULL,
  `invoice_note` text DEFAULT NULL,
  `total_items` smallint(6) DEFAULT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holding_item`
--

CREATE TABLE `holding_item` (
  `id` int(11) NOT NULL,
  `ref_no` varchar(100) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `item_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `brand_id` int(11) DEFAULT 0,
  `sup_id` int(11) NOT NULL DEFAULT 0,
  `item_name` varchar(100) NOT NULL,
  `item_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_discount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `tax_method` enum('inclusive','exclusive') NOT NULL DEFAULT 'exclusive',
  `taxrate_id` int(10) UNSIGNED NOT NULL,
  `tax` varchar(20) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `item_quantity` int(10) UNSIGNED NOT NULL,
  `item_total` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holding_price`
--

CREATE TABLE `holding_price` (
  `price_id` int(11) NOT NULL,
  `ref_no` varchar(100) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `subtotal` decimal(25,4) DEFAULT 0.0000,
  `discount_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `discount_amount` decimal(25,4) DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `order_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `shipping_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `shipping_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `others_charge` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payable_amount` decimal(25,4) DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_sources`
--

CREATE TABLE `income_sources` (
  `source_id` int(10) UNSIGNED NOT NULL,
  `source_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` enum('credit','debit') NOT NULL DEFAULT 'credit',
  `source_slug` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `source_details` longtext CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `for_sell` tinyint(1) NOT NULL DEFAULT 0,
  `for_purchase_return` tinyint(1) NOT NULL DEFAULT 0,
  `for_due_collection` tinyint(1) NOT NULL DEFAULT 0,
  `for_loan` tinyint(1) NOT NULL DEFAULT 0,
  `for_giftcard_sell` tinyint(1) NOT NULL DEFAULT 0,
  `for_topup` tinyint(1) NOT NULL DEFAULT 0,
  `for_stock_transfer` tinyint(1) NOT NULL DEFAULT 0,
  `for_purchase_delete` tinyint(1) NOT NULL DEFAULT 0,
  `for_expense_delete` tinyint(1) NOT NULL DEFAULT 0,
  `profitable` enum('yes','no') NOT NULL DEFAULT 'yes',
  `show_in_income` enum('yes','no') NOT NULL DEFAULT 'yes',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_hide` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `income_sources`
--

INSERT INTO `income_sources` (`source_id`, `source_name`, `type`, `source_slug`, `parent_id`, `source_details`, `for_sell`, `for_purchase_return`, `for_due_collection`, `for_loan`, `for_giftcard_sell`, `for_topup`, `for_stock_transfer`, `for_purchase_delete`, `for_expense_delete`, `profitable`, `show_in_income`, `status`, `is_hide`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'Sell', 'credit', 'sell', 0, '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 'yes', 'no', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(2, 'Purchase Return', 'credit', 'purchase_return', 0, '', 0, 1, 0, 0, 0, 0, 0, 0, 0, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(3, 'Due Collection', 'credit', 'due_collection', 0, '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 'yes', 'no', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(4, 'Others', 'credit', 'others', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 'yes', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(5, 'Loan Taken', 'credit', 'loan_taken', 0, '', 0, 0, 0, 1, 0, 0, 0, 0, 0, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(6, 'Giftcard Sell', 'credit', 'giftcard_sell', 0, '', 0, 0, 0, 0, 1, 0, 0, 0, 0, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(7, 'Giftcard Topup', 'credit', 'giftcard_topup', 0, '', 0, 0, 0, 0, 0, 1, 0, 0, 0, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(8, 'Stock Transfer', 'credit', 'stock_transfer', 0, '', 0, 0, 0, 0, 0, 0, 1, 0, 0, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(9, 'Purchase Delete', 'credit', 'purchase_delete', 0, '', 0, 0, 0, 0, 0, 0, 0, 1, 0, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15'),
(10, 'Expense Delete', 'credit', 'expense_delete', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 'no', 'yes', 1, 1, 0, '2025-07-03 08:43:15', '2025-07-03 08:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `installment_orders`
--

CREATE TABLE `installment_orders` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `purchase_invoice_id` varchar(100) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `interval_count` int(11) NOT NULL,
  `installment_count` int(11) NOT NULL,
  `interest_percentage` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `interest_amount` decimal(25,2) NOT NULL DEFAULT 0.00,
  `initial_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payment_status` enum('paid','due') NOT NULL DEFAULT 'due',
  `last_installment_date` datetime DEFAULT NULL,
  `installment_end_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `installment_payments`
--

CREATE TABLE `installment_payments` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `pmethod_id` int(11) NOT NULL DEFAULT 1,
  `created_by` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `capital` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `interest` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payable` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `paid` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `due` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payment_status` enum('paid','due','pending','cancel') NOT NULL DEFAULT 'due'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `slug`, `code`) VALUES
(1, 'English', 'english', 'en'),
(2, 'Arabic', 'arabic', 'ar'),
(3, 'Bangla', 'bangla', 'bn'),
(4, 'Hindi', 'hindi', 'hi'),
(5, 'French', 'french', 'fr'),
(6, 'Germany', 'Germany', 'de'),
(7, 'Spanish', 'spanish', 'es');

-- --------------------------------------------------------

--
-- Table structure for table `language_translations`
--

CREATE TABLE `language_translations` (
  `id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `lang_key` varchar(100) NOT NULL,
  `key_type` enum('specific','default') NOT NULL DEFAULT 'specific',
  `lang_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `language_translations`
--

INSERT INTO `language_translations` (`id`, `lang_id`, `lang_key`, `key_type`, `lang_value`) VALUES
(1, 1, 'title_dashboard', 'specific', 'Dashboard'),
(2, 1, 'text_arabic', 'specific', 'Arabic'),
(3, 1, 'text_french', 'specific', 'French'),
(4, 1, 'text_germany', 'specific', 'Germany'),
(5, 1, 'text_spanish', 'specific', 'Spanish'),
(6, 1, 'text_pos', 'specific', 'POS'),
(7, 1, 'menu_pos', 'specific', 'POS'),
(8, 1, 'text_cashbook_report', 'specific', 'Cashbook Report'),
(9, 1, 'menu_cashbook', 'specific', 'CASHBOOK'),
(10, 1, 'text_invoice', 'specific', 'Invoice'),
(11, 1, 'menu_invoice', 'specific', 'INVOICE'),
(12, 1, 'text_user_preference', 'specific', 'User Preference'),
(13, 1, 'text_settings', 'specific', 'Settings'),
(14, 1, 'text_stock_alert', 'specific', 'Stock Alert'),
(15, 1, 'text_expired', 'specific', 'Expired'),
(16, 1, 'text_itsolution24', 'specific', 'ITsolution24'),
(17, 1, 'text_reports', 'specific', 'Reports'),
(18, 1, 'text_lockscreen', 'specific', 'Lockscreen'),
(19, 1, 'text_logout', 'specific', 'Logout'),
(20, 1, 'menu_dashboard', 'specific', 'DASHBOARD'),
(21, 1, 'menu_point_of_sell', 'specific', 'POINT OF SELL'),
(22, 1, 'menu_sell', 'specific', 'SELL'),
(23, 1, 'menu_sale_list', 'specific', 'SELL LIST'),
(24, 1, 'menu_return_list', 'specific', 'RETURN LIST'),
(25, 1, 'menu_giftcard', 'specific', 'GIFTCARD'),
(26, 1, 'menu_add_giftcard', 'specific', 'ADD GIFTCARD'),
(27, 1, 'menu_giftcard_list', 'specific', 'GIFTCARD LIST'),
(28, 1, 'menu_giftcard_topup', 'specific', 'GIFTCARD TOPUP'),
(29, 1, 'menu_quotation', 'specific', 'QUOTATION'),
(30, 1, 'menu_add_quotation', 'specific', 'ADD QUOTATION'),
(31, 1, 'menu_quotation_list', 'specific', 'QUOTATION LIST'),
(32, 1, 'menu_installment', 'specific', 'INSTALLMENT'),
(33, 1, 'menu_installment_list', 'specific', 'INSTALLMENT LIST'),
(34, 1, 'menu_payment_list', 'specific', 'PAYMENT LIST'),
(35, 1, 'menu_payment_due_today', 'specific', 'PAYMENT DUE TODAY'),
(36, 1, 'menu_payment_due_all', 'specific', 'PAYMENT DUE ALL'),
(37, 1, 'menu_payment_due_expired', 'specific', 'PAYMENT DUE EXP.'),
(38, 1, 'menu_overview_report', 'specific', 'OVERVIEW REPORT'),
(39, 1, 'menu_purchase', 'specific', 'PURCHASE'),
(40, 1, 'menu_add_purchase', 'specific', 'ADD PURCHASE'),
(41, 1, 'menu_purchase_list', 'specific', 'PURCHASE LIST'),
(42, 1, 'menu_due_invoice', 'specific', 'DUE INVOICE'),
(43, 1, 'menu_transfer', 'specific', 'STOCK TRANSFER'),
(44, 1, 'menu_add_transfer', 'specific', 'ADD TRANSFER'),
(45, 1, 'menu_transfer_list', 'specific', 'TRANSFER LIST'),
(46, 1, 'menu_product', 'specific', 'PRODUCT'),
(47, 1, 'menu_product_list', 'specific', 'PRODUCT LIST'),
(48, 1, 'menu_add_product', 'specific', 'ADD PRODUCT'),
(49, 1, 'menu_barcode_print', 'specific', 'BARCODE PRINT'),
(50, 1, 'menu_category', 'specific', 'CATEGORY LIST'),
(51, 1, 'menu_add_category', 'specific', 'ADD CATEGORY'),
(52, 1, 'menu_product_import', 'specific', 'IMPORT'),
(53, 1, 'menu_stock_alert', 'specific', 'STOCK ALERT'),
(54, 1, 'menu_expired', 'specific', 'EXPIRED'),
(55, 1, 'menu_customer', 'specific', 'CUSTOMER'),
(56, 1, 'menu_add_customer', 'specific', 'ADD CUSTOMER'),
(57, 1, 'menu_customer_list', 'specific', 'CUSTOMER LIST'),
(58, 1, 'menu_transaction_list', 'specific', 'TRANSACTION LIST'),
(59, 1, 'menu_supplier', 'specific', 'SUPPLIER'),
(60, 1, 'menu_add_supplier', 'specific', 'ADD SUPPLIER'),
(61, 1, 'menu_supplier_list', 'specific', 'SUPPLIER LIST'),
(62, 1, 'menu_accounting', 'specific', 'ACCOUNTING'),
(63, 1, 'menu_new_deposit', 'specific', 'DEPOSIT'),
(64, 1, 'menu_new_withdraw', 'specific', 'WIDTHDRAW'),
(65, 1, 'menu_new_transfer', 'specific', 'ADD TRANSFER '),
(66, 1, 'menu_list_transfer', 'specific', 'TRANSFER LIST'),
(67, 1, 'menu_add_bank_account', 'specific', 'ADD BANK ACCOUNT'),
(68, 1, 'menu_bank_accounts', 'specific', 'BANK ACCOUNT LIST'),
(69, 1, 'menu_income_source', 'specific', 'INCOME SOURCE'),
(70, 1, 'menu_list_transactions', 'specific', 'TRANSACTION LIST'),
(71, 1, 'menu_balance_sheet', 'specific', 'BALANCE SHEET'),
(72, 1, 'menu_income_monthwise', 'specific', 'INCOME MONTHWISE'),
(73, 1, 'menu_income_and_expense', 'specific', 'INCOME VS EXPENSE'),
(74, 1, 'menu_profit_and_loss', 'specific', 'PROFIT VS LOSS'),
(75, 1, 'menu_expenditure', 'specific', 'EXPANDITURE'),
(76, 1, 'menu_create_expense', 'specific', 'ADD EXPENSE'),
(77, 1, 'menu_expense_list', 'specific', 'EXPENSE LIST'),
(78, 1, 'menu_expense_monthwise', 'specific', 'EXPENSE MONTHWISE'),
(79, 1, 'menu_summary', 'specific', 'SUMMARY'),
(80, 1, 'menu_loan_manager', 'specific', 'LOAN MANAGER'),
(81, 1, 'menu_take_loan', 'specific', 'TAKE LOAN'),
(82, 1, 'menu_loan_list', 'specific', 'LOAN LIST'),
(83, 1, 'menu_loan_summary', 'specific', 'SUMMARY'),
(84, 1, 'menu_reports', 'specific', 'REPORTS'),
(85, 1, 'menu_report_overview', 'specific', 'OVERVIEW REPORT'),
(86, 1, 'menu_report_collection', 'specific', 'COLLECTION REPORT'),
(87, 1, 'menu_report_due_collection', 'specific', 'DUE COLLECTION RPT'),
(88, 1, 'menu_report_due_paid', 'specific', 'DUE PAID RPT'),
(89, 1, 'menu_sell_report', 'specific', 'SELL REPORT'),
(90, 1, 'menu_purchase_report', 'specific', 'PURCHASE REPORT'),
(91, 1, 'menu_sell_payment_report', 'specific', 'SELL PAYMENT REPORT'),
(92, 1, 'menu_purchase_payment_report', 'specific', 'PUR. PAYMENT RPT.'),
(93, 1, 'menu_tax_report', 'specific', 'SELL TAX REPORT'),
(94, 1, 'menu_purchase_tax_report', 'specific', 'PURCHASE TAX RPT.'),
(95, 1, 'menu_tax_overview_report', 'specific', 'TAX OVERVIEW RPT.'),
(96, 1, 'menu_report_stock', 'specific', 'STOCK REPORT'),
(97, 1, 'menu_analytics', 'specific', 'ANALYTICS'),
(98, 1, 'menu_sms', 'specific', 'SMS'),
(99, 1, 'menu_send_sms', 'specific', 'SEND SMS'),
(100, 1, 'menu_sms_report', 'specific', 'SMS REPORT'),
(101, 1, 'menu_sms_setting', 'specific', 'SMS SETTING'),
(102, 1, 'menu_user', 'specific', 'USER'),
(103, 1, 'menu_add_user', 'specific', 'ADD USER'),
(104, 1, 'menu_user_list', 'specific', 'USER LIST'),
(105, 1, 'menu_add_usergroup', 'specific', 'ADD USERGROUP'),
(106, 1, 'menu_usergroup_list', 'specific', 'USERGROUP LIST'),
(107, 1, 'menu_password', 'specific', 'PASSWORD'),
(108, 1, 'menu_filemanager', 'specific', 'FILEMANAGER'),
(109, 1, 'menu_system', 'specific', 'SYSTEM'),
(110, 1, 'menu_store', 'specific', 'STORE'),
(111, 1, 'menu_create_store', 'specific', 'STORE CREATE'),
(112, 1, 'menu_store_list', 'specific', 'STORE LIST'),
(113, 1, 'menu_store_setting', 'specific', 'STORE SETTING'),
(114, 1, 'menu_receipt_template', 'specific', 'RECEIPT TEMPLATE'),
(115, 1, 'menu_user_preference', 'specific', 'USER PREFERENCE'),
(116, 1, 'menu_brand', 'specific', 'BRAND'),
(117, 1, 'menu_add_brand', 'specific', 'ADD BRAND'),
(118, 1, 'menu_brand_list', 'specific', 'BRAND LIST'),
(119, 1, 'menu_currency', 'specific', 'CURRENCY'),
(120, 1, 'menu_pmethod', 'specific', 'PAYMENT METHOD'),
(121, 1, 'menu_unit', 'specific', 'UNIT'),
(122, 1, 'menu_taxrate', 'specific', 'TAXRATE'),
(123, 1, 'menu_box', 'specific', 'BOX'),
(124, 1, 'menu_printer', 'specific', 'PRINTER'),
(125, 1, 'menu_backup_restore', 'specific', 'BACKUP/RESTORE'),
(126, 1, 'menu_store_change', 'specific', 'STORE CHANGE'),
(127, 1, 'text_dashboard', 'specific', 'Dashboard'),
(128, 1, 'text_old_dashboard', 'specific', 'Old Dashboard'),
(129, 1, 'button_pos', 'specific', 'POS'),
(130, 1, 'button_invoice', 'specific', 'Invoice'),
(131, 1, 'button_overview_report', 'specific', 'Overview Report'),
(132, 1, 'button_sell_report', 'specific', 'Sell Report'),
(133, 1, 'button_purchase_report', 'specific', 'Purchase Report'),
(134, 1, 'button_stock_alert', 'specific', 'Stock Alert'),
(135, 1, 'button_expired_alert', 'specific', 'Expired'),
(136, 1, 'button_backup_restore', 'specific', 'Backup/Restore'),
(137, 1, 'button_stores', 'specific', 'Stores'),
(138, 1, 'text_total_invoice', 'specific', 'TOTAL INVOICE'),
(139, 1, 'text_total_invoice_today', 'specific', 'TOTAL INVOICE TODAY'),
(140, 1, 'text_details', 'specific', 'Details'),
(141, 1, 'text_total_customer', 'specific', 'TOTAL CUSTOMER'),
(142, 1, 'text_total_customer_today', 'specific', 'TOTAL CUSTOMER TODAY'),
(143, 1, 'text_total_supplier', 'specific', 'TOTAL SUPPLIER'),
(144, 1, 'text_total_supplier_today', 'specific', 'TOTAL SUPPLIER TODAY'),
(145, 1, 'text_total_product', 'specific', 'TOTAL PRODUCT'),
(146, 1, 'text_total_product_today', 'specific', 'TOTAL PRODUCT TODAY'),
(147, 1, 'text_deposit_today', 'specific', 'Deposit Today'),
(148, 1, 'text_withdraw_today', 'specific', 'Widthdraw Today'),
(149, 1, 'text_total_deposit', 'specific', 'Total Deposit'),
(150, 1, 'text_total_withdraw', 'specific', 'Total Widthdraw'),
(151, 1, 'text_recent_deposit', 'specific', 'Recent Deposit'),
(152, 1, 'label_date', 'specific', 'Date'),
(153, 1, 'label_description', 'specific', 'Description'),
(154, 1, 'label_amount', 'specific', 'Amount'),
(155, 1, 'button_view_all', 'specific', 'View All'),
(156, 1, 'text_recent_withdraw', 'specific', 'Recent Withdraw'),
(157, 1, 'text_collection_report', 'specific', 'Collection Report'),
(158, 1, 'label_serial_no', 'specific', 'SL'),
(159, 1, 'label_username', 'specific', 'Username'),
(160, 1, 'label_total_inv', 'specific', 'Total Inv'),
(161, 1, 'label_net_amount', 'specific', 'Net Amount'),
(162, 1, 'label_prev_due_collection', 'specific', 'Prev. Due Col.'),
(163, 1, 'label_due_collection', 'specific', 'Due Collection'),
(164, 1, 'label_due_given', 'specific', 'Due GIven'),
(165, 1, 'label_received', 'specific', 'Received'),
(166, 1, 'text_sells_analytics', 'specific', 'Sell Analytics'),
(167, 1, 'text_version', 'specific', 'Version'),
(168, 1, 'button_today', 'specific', 'Today'),
(169, 1, 'button_last_7_days', 'specific', 'Last 7 Days'),
(170, 1, 'button_last_30_days', 'specific', 'Last 30 Days'),
(171, 1, 'button_last_365_days', 'specific', 'Last 365 Days'),
(172, 1, 'button_filter', 'specific', 'Filter'),
(173, 1, 'title_language', 'specific', 'Language'),
(174, 1, 'text_language_title', 'specific', 'Language'),
(175, 1, 'text_language_list_title', 'specific', 'Language Translate'),
(176, 1, 'label_key', 'specific', 'Key'),
(177, 1, 'label_value', 'specific', 'Value'),
(178, 1, 'label_translate', 'specific', 'Translate'),
(179, 1, 'button_translate', 'specific', 'Translate'),
(180, 1, 'title_quotation', 'specific', 'Quotation'),
(181, 1, 'text_quotation_title', 'specific', 'Quotation'),
(182, 1, 'text_add', 'specific', 'Add'),
(183, 1, 'text_new_quotation_title', 'specific', 'Add New Quotation'),
(184, 1, 'label_reference_no', 'specific', 'Ref. No.'),
(185, 1, 'label_note', 'specific', 'Notes'),
(186, 1, 'label_status', 'specific', 'Status'),
(187, 1, 'text_sent', 'specific', 'Sent'),
(188, 1, 'text_pending', 'specific', 'Pending'),
(189, 1, 'text_complete', 'specific', 'Complete'),
(190, 1, 'label_customer', 'specific', 'Customer'),
(191, 1, 'text_select', 'specific', '--- Please Select ---'),
(192, 1, 'label_supplier', 'specific', 'Supplier'),
(193, 1, 'text_all_suppliers', 'specific', 'All Supplier'),
(194, 1, 'label_add_product', 'specific', 'Add Product'),
(195, 1, 'placeholder_search_product', 'specific', 'Search Product'),
(196, 1, 'label_product', 'specific', 'Product'),
(197, 1, 'label_available', 'specific', 'Available'),
(198, 1, 'label_quantity', 'specific', 'Quantity'),
(199, 1, 'label_sell_price', 'specific', 'Sell Price'),
(200, 1, 'label_item_tax', 'specific', 'Item Tax'),
(201, 1, 'label_subtotal', 'specific', 'Subtotal'),
(202, 1, 'label_order_tax', 'specific', 'Order Tax'),
(203, 1, 'label_shipping_charge', 'specific', 'Shipping Charge'),
(204, 1, 'label_others_charge', 'specific', 'Other Charge'),
(205, 1, 'label_discount_amount', 'specific', 'Discount'),
(206, 1, 'label_payable_amount', 'specific', 'Payable Amount'),
(207, 1, 'button_save', 'specific', 'Save'),
(208, 1, 'button_reset', 'specific', 'Reset'),
(209, 1, 'text_quotation_list_title', 'specific', 'Quotation List'),
(210, 1, 'button_all', 'specific', 'All'),
(211, 1, 'button_sent', 'specific', 'Sent'),
(212, 1, 'button_pending', 'specific', 'Pending'),
(213, 1, 'button_complete', 'specific', 'Complete'),
(214, 1, 'label_biller', 'specific', 'Biller'),
(215, 1, 'label_total', 'specific', 'Total'),
(216, 1, 'label_action', 'specific', 'Action'),
(217, 1, 'text_translation_success', 'specific', 'Translation Successfull'),
(218, 1, 'title_purchase', 'specific', 'Purchase'),
(219, 1, 'text_purchase_title', 'specific', 'Purchase'),
(220, 1, 'text_new_purchase_title', 'specific', 'Add New Purchase'),
(221, 1, 'text_received', 'specific', 'Received'),
(222, 1, 'text_ordered', 'specific', 'Ordered'),
(223, 1, 'label_attachment', 'specific', 'Attachment'),
(224, 1, 'label_cost', 'specific', 'Cost'),
(225, 1, 'label_item_total', 'specific', 'Item Total'),
(226, 1, 'label_payment_method', 'specific', 'Payment Method'),
(227, 1, 'label_paid_amount', 'specific', 'Paid Amount'),
(228, 1, 'label_due_amount', 'specific', 'Due Amount'),
(229, 1, 'label_change_amount', 'specific', 'Change Amount'),
(230, 1, 'button_submit', 'specific', 'Submit'),
(231, 1, 'text_purchase_list_title', 'specific', 'Purchase List'),
(232, 1, 'button_today_invoice', 'specific', 'Today Invoice'),
(233, 1, 'button_all_invoice', 'specific', 'All Invoice'),
(234, 1, 'button_due_invoice', 'specific', 'Due Invoice'),
(235, 1, 'button_all_due_invoice', 'specific', 'All Due Invoice'),
(236, 1, 'button_paid_invoice', 'specific', 'Paid Invoice'),
(237, 1, 'button_inactive_invoice', 'specific', 'Inactive Invoice'),
(238, 1, 'label_datetime', 'specific', 'Date Time'),
(239, 1, 'label_invoice_id', 'specific', 'Invoice Id'),
(240, 1, 'label_creator', 'specific', 'Creator'),
(241, 1, 'label_invoice_paid', 'specific', 'Paid Amount'),
(242, 1, 'label_due', 'specific', 'Due'),
(243, 1, 'label_pay', 'specific', 'Pay'),
(244, 1, 'label_return', 'specific', 'Return'),
(245, 1, 'label_view', 'specific', 'View'),
(246, 1, 'label_edit', 'specific', 'Edit'),
(247, 1, 'title_language_translation', 'specific', 'Language Translate'),
(248, 1, 'title_invoice', 'specific', 'Invoice'),
(249, 1, 'text_invoice_title', 'specific', 'Invoice'),
(250, 1, 'text_invoice_sub_title', 'specific', 'Invoice List'),
(251, 1, 'label_customer_name', 'specific', 'Customer Name'),
(252, 1, 'label_invoice_amount', 'specific', 'Inv. Amount'),
(253, 1, 'label_invoice_due', 'specific', 'Invoice Due'),
(254, 1, 'title_transfer', 'specific', 'Transfer'),
(255, 1, 'text_transfer_title', 'specific', 'Transfer'),
(256, 1, 'text_add_transfer_title', 'specific', 'Add New Transfer'),
(257, 1, 'label_ref_no', 'specific', 'Ref. No.'),
(258, 1, 'label_from', 'specific', 'From'),
(259, 1, 'label_to', 'specific', 'To'),
(260, 1, 'text_stock_list', 'specific', 'Stock List'),
(261, 1, 'search', 'specific', 'Search'),
(262, 1, 'text_invoice_id', 'specific', 'Invoice Id'),
(263, 1, 'text_stock', 'specific', 'Stock'),
(264, 1, 'text_transfer_list', 'specific', 'Transfer List'),
(265, 1, 'label_item_name', 'specific', 'Item Name'),
(266, 1, 'label_transfer_qty', 'specific', 'Transfer Qty.'),
(267, 1, 'button_transfer_now', 'specific', 'Transfer Now'),
(268, 1, 'text_list_transfer_title', 'specific', 'Transfer List'),
(269, 1, 'label_from_store', 'specific', 'From Store'),
(270, 1, 'label_to_store', 'specific', 'To Store'),
(271, 1, 'label_total_item', 'specific', 'Total Item'),
(272, 1, 'label_total_quantity', 'specific', 'Total Quantity'),
(273, 1, 'text_success', 'specific', 'Successfully Created'),
(274, 1, 'title_product', 'specific', 'Product'),
(275, 1, 'text_products', 'specific', 'Products'),
(276, 1, 'text_add_new', 'specific', 'Add New Product'),
(277, 1, 'text_product', 'specific', 'Product'),
(278, 1, 'text_general', 'specific', 'General'),
(279, 1, 'text_image', 'specific', 'Image'),
(280, 1, 'label_image', 'specific', 'Image'),
(281, 1, 'label_url', 'specific', 'Url'),
(282, 1, 'label_sort_order', 'specific', 'Order'),
(283, 1, 'label_thumbnail', 'specific', 'Thumbnail'),
(284, 1, 'label_product_type', 'specific', 'Product Type'),
(285, 1, 'text_standard', 'specific', 'Standard'),
(286, 1, 'text_service', 'specific', 'Service'),
(287, 1, 'label_name', 'specific', 'Name'),
(288, 1, 'label_pcode', 'specific', 'P. Code'),
(289, 1, 'label_category', 'specific', 'Category'),
(290, 1, 'label_brand', 'specific', 'Brand'),
(291, 1, 'label_barcode_symbology', 'specific', 'Barcode Symbiology'),
(292, 1, 'label_box', 'specific', 'Box'),
(293, 1, 'label_expired_date', 'specific', 'Expired Date'),
(294, 1, 'label_unit', 'specific', 'Unit'),
(295, 1, 'label_product_cost', 'specific', 'Product Cost'),
(296, 1, 'label_product_price', 'specific', 'Product Price'),
(297, 1, 'label_product_tax', 'specific', 'Product Tax'),
(298, 1, 'label_tax_method', 'specific', 'Tax Method'),
(299, 1, 'text_inclusive', 'specific', 'Inclusive'),
(300, 1, 'text_exclusive', 'specific', 'Exclusive'),
(301, 1, 'label_store', 'specific', 'Store'),
(302, 1, 'label_alert_quantity', 'specific', 'Alert Quantity'),
(303, 1, 'text_active', 'specific', 'Active'),
(304, 1, 'text_inactive', 'specific', 'Inactive'),
(305, 1, 'text_view_all', 'specific', 'View All'),
(306, 1, 'label_all_product', 'specific', 'All Product'),
(307, 1, 'button_trash', 'specific', 'Trash'),
(308, 1, 'button_bulk', 'specific', 'Bulk Action'),
(309, 1, 'button_delete_all', 'specific', 'Delete All'),
(310, 1, 'label_stock', 'specific', 'Stock'),
(311, 1, 'label_purchase_price', 'specific', 'Purchase Price'),
(312, 1, 'label_selling_price', 'specific', 'Selling Price'),
(313, 1, 'label_purchase', 'specific', 'Purchase'),
(314, 1, 'label_print_barcode', 'specific', 'Print Barcode'),
(315, 1, 'button_view', 'specific', 'View'),
(316, 1, 'button_edit', 'specific', 'Edit'),
(317, 1, 'button_purchase_product', 'specific', 'Purchase Product'),
(318, 1, 'button_barcode', 'specific', 'Barcode'),
(319, 1, 'button_delete', 'specific', 'Delete'),
(320, 1, 'error_no_selected', 'specific', 'Not Selected'),
(321, 1, 'success_delete_all', 'specific', 'Successfully Deleted'),
(322, 1, 'text_language_translation_title', 'specific', 'Language Translate'),
(323, 1, 'title_user_preference', 'specific', 'User Preference'),
(324, 1, 'text_user_preference_title', 'specific', 'User Preference'),
(325, 1, 'text_language_preference_title', 'specific', 'Language Translate'),
(326, 1, 'label_select_language', 'specific', 'Select Language'),
(327, 1, 'text_english', 'specific', 'English'),
(328, 1, 'text_color_preference_title', 'specific', 'Color Preference'),
(329, 1, 'label_base_color', 'specific', 'Base color'),
(330, 1, 'text_color_black', 'specific', 'Black'),
(331, 1, 'text_color_blue', 'specific', 'Blue'),
(332, 1, 'text_color_green', 'specific', 'Green'),
(333, 1, 'text_color_red', 'specific', 'Red'),
(334, 1, 'text_color_yellow', 'specific', 'Yellow'),
(335, 1, 'text_pos_side_panel_position_title', 'specific', 'POS Side Panel Position'),
(336, 1, 'label_pos_side_panel_position', 'specific', 'Pos Side Panel Position'),
(337, 1, 'text_right', 'specific', 'Right'),
(338, 1, 'text_left', 'specific', 'Left'),
(339, 1, 'text_pos_pattern_title', 'specific', 'POS Pattern'),
(340, 1, 'label_select_pos_pattern', 'specific', 'Select POS Pattern'),
(341, 1, 'button_update', 'specific', 'Update'),
(342, 1, 'text_login_title', 'specific', 'Login'),
(343, 1, 'text_login', 'specific', 'Login'),
(344, 1, 'button_sign_in', 'specific', 'Sign In'),
(345, 1, 'text_forgot_password', 'specific', 'Forgot Password?'),
(346, 1, 'title_forgot_password', 'specific', 'Forgot Password'),
(347, 1, 'text_forgot_password_instruction', 'specific', 'Please type your email.  We will send you a link just follow the steps.'),
(348, 1, 'button_close', 'specific', 'Close'),
(349, 1, 'title_receipt_template', 'specific', 'Receipt Template'),
(350, 1, 'text_receipt_tempalte_title', 'specific', 'Receipt Template'),
(351, 1, 'title_pos_setting', 'specific', 'POS Settings'),
(352, 1, 'text_receipt_template', 'specific', 'Receipt Template'),
(353, 1, 'text_receipt_tempalte_sub_title', 'specific', 'Receipt Template'),
(354, 1, 'button_preview', 'specific', 'Preview'),
(355, 1, 'text_tempalte_content_title', 'specific', 'Template Content'),
(356, 1, 'text_tempalte_css_title', 'specific', 'Template CSS'),
(357, 1, 'text_template_tags', 'specific', 'Template Tags'),
(358, 1, 'text_translations', 'specific', 'Translations'),
(359, 1, 'text_bangla', 'specific', 'Bangla'),
(360, 1, 'menu_language', 'specific', 'LANGUAGE'),
(361, 1, 'button_default', 'specific', 'Default'),
(362, 1, 'text_paid', 'specific', 'Paid'),
(363, 1, 'button_return', 'specific', 'Return'),
(364, 1, 'button_view_receipt', 'specific', 'View Receipt'),
(365, 1, 'label_delete', 'default', 'Delete'),
(366, 1, 'button_dublicate_entry', 'specific', 'Dublicate Entry'),
(367, 1, 'text_delete_success', 'specific', 'Successfully Deleted'),
(368, 1, 'label_delete', 'specific', 'Delete'),
(369, 1, 'text_customer_list_title', 'specific', 'Customer List'),
(370, 1, 'text_customer_title', 'specific', 'Customer'),
(371, 1, 'text_new_customer_title', 'specific', 'Add New Customer'),
(372, 1, 'label_phone', 'specific', 'Phone'),
(373, 1, 'label_date_of_birth', 'specific', 'Date of Birth'),
(374, 1, 'label_email', 'specific', 'Email'),
(375, 1, 'label_sex', 'specific', 'Sex'),
(376, 1, 'label_male', 'specific', 'Male'),
(377, 1, 'label_female', 'specific', 'Female'),
(378, 1, 'label_others', 'specific', 'Others'),
(379, 1, 'label_age', 'specific', 'Age'),
(380, 1, 'label_address', 'specific', 'Address'),
(381, 1, 'label_city', 'specific', 'City'),
(382, 1, 'label_state', 'specific', 'State'),
(383, 1, 'label_country', 'specific', 'Country'),
(384, 1, 'label_id', 'specific', 'Id'),
(385, 1, 'label_balance', 'specific', 'Balance'),
(386, 1, 'label_sell', 'specific', 'Sell'),
(387, 1, 'button_sell', 'specific', 'Sell'),
(388, 1, 'button_view_profile', 'specific', 'View Profile'),
(389, 1, 'login_success', 'specific', 'Login Successfull'),
(390, 1, 'title_installment_payment', 'specific', 'Installment Payment'),
(391, 1, 'text_installment_payment_title', 'specific', 'Installment Payment'),
(392, 1, 'text_installment', 'specific', 'Installment'),
(393, 1, 'text_installment_payment_list_title', 'specific', 'Installment Payment List'),
(394, 1, 'text_all_payment', 'specific', 'All Payment'),
(395, 1, 'button_all_payment', 'specific', 'All Payment'),
(396, 1, 'button_todays_due_payment', 'specific', 'Todays Due Payment'),
(397, 1, 'button_all_due_payment', 'specific', 'All Due Payment'),
(398, 1, 'button_expired_due_payment', 'specific', 'Expired Due Payment'),
(399, 1, 'label_payment_date', 'specific', 'Payment Date'),
(400, 1, 'label_payable', 'specific', 'Payable'),
(401, 1, 'label_paid', 'specific', 'Paid'),
(402, 1, 'button_payment', 'specific', 'Payment'),
(403, 1, 'title_backup_restore', 'specific', 'Backup/Restore'),
(404, 1, 'text_backup_restore_title', 'specific', 'Backup/Restore'),
(405, 1, 'text_backup', 'specific', 'Backup'),
(406, 1, 'text_restore', 'specific', 'Restore'),
(407, 1, 'label_databases', 'specific', 'Databases'),
(408, 1, 'label_select_all', 'specific', 'Select All'),
(409, 1, 'label_unselect_all', 'specific', 'Unselect All'),
(410, 1, 'button_export', 'specific', 'Export'),
(411, 1, 'label_progress', 'specific', 'Progress'),
(412, 1, 'button_select_sql_file', 'specific', 'Select .sql File'),
(413, 1, 'title_printer', 'specific', 'Printer'),
(414, 1, 'text_printer_title', 'specific', 'Printer'),
(415, 1, 'text_new_printer_title', 'specific', 'Add New Printer'),
(416, 1, 'label_title', 'specific', 'Title'),
(417, 1, 'label_type', 'specific', 'Type'),
(418, 1, 'label_char_per_line', 'specific', 'Char Per Line'),
(419, 1, 'label_path', 'specific', 'Path'),
(420, 1, 'label_ip_address', 'specific', 'Ip Address'),
(421, 1, 'label_port', 'specific', 'Port'),
(422, 1, 'text_printer_list_title', 'specific', 'Printer List'),
(423, 1, 'title_box', 'specific', 'Box'),
(424, 1, 'text_box_title', 'specific', 'Box'),
(425, 1, 'text_box_box_title', 'specific', 'Box '),
(426, 1, 'label_box_name', 'specific', 'Box Name'),
(427, 1, 'label_code_name', 'specific', 'Code Name'),
(428, 1, 'label_box_details', 'specific', 'Box Details'),
(429, 1, 'text_in_active', 'specific', 'Inactive'),
(430, 1, 'text_box_list_title', 'specific', 'Box List'),
(431, 1, 'title_taxrate', 'specific', 'Taxrate'),
(432, 1, 'text_taxrate_title', 'specific', 'Taxrate'),
(433, 1, 'text_new_taxrate_title', 'specific', 'Add New Taxrate'),
(434, 1, 'label_taxrate_name', 'specific', 'Taxrate Name'),
(435, 1, 'label_taxrate', 'specific', 'Taxrate'),
(436, 1, 'text_taxrate_list_title', 'specific', 'Taxrate List'),
(437, 1, 'title_unit', 'specific', 'Unit'),
(438, 1, 'text_unit_title', 'specific', 'Unit'),
(439, 1, 'text_new_unit_title', 'specific', 'Add New Unit'),
(440, 1, 'label_unit_name', 'specific', 'Unit Name'),
(441, 1, 'label_unit_details', 'specific', 'Unit Details'),
(442, 1, 'text_unit_list_title', 'specific', 'Unit List'),
(443, 1, 'title_pmethod', 'specific', 'Payment Mehtod'),
(444, 1, 'text_pmethod_title', 'specific', 'Payment Method'),
(445, 1, 'text_new_pmethod_title', 'specific', 'Add New Payment Method'),
(446, 1, 'label_details', 'specific', 'Details'),
(447, 1, 'text_pmethod_list_title', 'specific', 'Payment Method List'),
(448, 1, 'title_currency', 'specific', 'Currency'),
(449, 1, 'text_currency_title', 'specific', 'Currency'),
(450, 1, 'text_new_currency_title', 'specific', 'Add New Currency'),
(451, 1, 'label_code', 'specific', 'Code'),
(452, 1, 'hint_code', 'specific', 'Code name here'),
(453, 1, 'label_symbol_left', 'specific', 'Symbol Left'),
(454, 1, 'hint_symbol_left', 'specific', 'It will display in Left side'),
(455, 1, 'label_symbol_right', 'specific', 'Symbol Right'),
(456, 1, 'hint_symbol_right', 'specific', 'It will display in right  side'),
(457, 1, 'label_decimal_place', 'specific', 'Decimal  Place'),
(458, 1, 'hint_decimal_place', 'specific', 'It indicates number of digit after ponts. I.E.  100.00'),
(459, 1, 'text_currency_list_title', 'specific', 'Currency List'),
(460, 1, 'text_enabled', 'specific', 'Enabled'),
(461, 1, 'button_activate', 'specific', 'Active'),
(462, 1, 'button_activated', 'specific', 'Activated'),
(463, 1, 'text_brand_list_title', 'specific', 'Brand List'),
(464, 1, 'text_brand_title', 'specific', 'Brand'),
(465, 1, 'text_new_brand_title', 'specific', 'Brand'),
(466, 1, 'label_total_product', 'specific', 'Total Product'),
(467, 1, 'title_create_store', 'specific', 'Create Store'),
(468, 1, 'text_create_store_title', 'specific', 'Create Store'),
(469, 1, 'text_stores', 'specific', 'Stores'),
(470, 1, 'text_currency', 'specific', 'Currency'),
(471, 1, 'text_payment_method', 'specific', 'Paymen Method'),
(472, 1, 'text_printer', 'specific', 'Printer'),
(473, 1, 'text_email_setting', 'specific', 'Email Setting'),
(474, 1, 'text_ftp_setting', 'specific', 'FTP Setting'),
(475, 1, 'label_mobile', 'specific', 'Mobile'),
(476, 1, 'label_zip_code', 'specific', 'Zip Code'),
(477, 1, 'label_vat_reg_no', 'specific', 'VAT Reg. No.'),
(478, 1, 'label_cashier_name', 'specific', 'Cashier Name'),
(479, 1, 'label_timezone', 'specific', 'Timezone'),
(480, 1, 'label_invoice_edit_lifespan', 'specific', 'Invoice Edit Lifespan'),
(481, 1, 'hint_invoice_edit_lifespan', 'specific', 'After this time you won\'t be able to edit invoice.'),
(482, 1, 'text_minute', 'specific', 'Minute'),
(483, 1, 'text_second', 'specific', 'Second'),
(484, 1, 'label_invoice_delete_lifespan', 'specific', 'Invoice Delete Lifespan'),
(485, 1, 'hint_invoice_delete_lifespan', 'specific', 'After this time you won\'t be able to delete invoice.'),
(486, 1, 'label_after_sell_page', 'specific', 'After Sell Page'),
(487, 1, 'hint_after_sell_page', 'specific', 'After Sell Page'),
(488, 1, 'label_pos_printing', 'specific', 'POS Printing'),
(489, 1, 'label_receipt_printer', 'specific', 'Receipt Printer'),
(490, 1, 'label_auto_print_receipt', 'specific', 'Auto Print Receipt'),
(491, 1, 'label_deposit_account', 'specific', 'Deposit Account'),
(492, 1, 'label_tax', 'specific', 'TAX'),
(493, 1, 'hint_tax', 'specific', 'Tax'),
(494, 1, 'label_stock_alert_quantity', 'specific', 'Stock Alert Quantity'),
(495, 1, 'hint_stock_alert_quantity', 'specific', 'If quantity reach this value so it will be alert as stock low alert'),
(496, 1, 'label_datatable_item_limit', 'specific', 'Datatable Item Limit'),
(497, 1, 'hint_datatable_item_limit', 'specific', 'It indicates how many row you will show in any table'),
(498, 1, 'label_invoice_footer_text', 'specific', 'Invoice Footer Text'),
(499, 1, 'hint_invoice_footer_text', 'specific', 'This will display in footer of invoice'),
(500, 1, 'label_sound_effect', 'specific', 'Sound Effect'),
(501, 1, 'label_email_from', 'specific', 'Email From'),
(502, 1, 'hint_email_from', 'specific', 'Email From'),
(503, 1, 'label_email_address', 'specific', 'Email Address'),
(504, 1, 'hint_email_address', 'specific', 'Email Addrress'),
(505, 1, 'label_email_driver', 'specific', 'Email Driver'),
(506, 1, 'hint_email_driver', 'specific', 'Email Driver'),
(507, 1, 'label_smtp_host', 'specific', 'SMTP Host'),
(508, 1, 'hint_smtp_host', 'specific', 'SMTP Host'),
(509, 1, 'label_smtp_username', 'specific', 'SMTP Username'),
(510, 1, 'hint_smtp_username', 'specific', 'SMTP Username'),
(511, 1, 'label_smtp_password', 'specific', 'SMTP Password'),
(512, 1, 'hint_smtp_password', 'specific', 'SMTP Password'),
(513, 1, 'label_smtp_port', 'specific', 'SMTP Port'),
(514, 1, 'hint_smtp_port', 'specific', 'SMTP Port'),
(515, 1, 'label_ssl_tls', 'specific', 'SSL/TLS'),
(516, 1, 'hint_ssl_tls', 'specific', 'SSL/TLS'),
(517, 1, 'label_ftp_hostname', 'specific', 'FTP Hostname'),
(518, 1, 'label_ftp_username', 'specific', 'FTP Username'),
(519, 1, 'label_ftp_password', 'specific', 'FTP Password'),
(520, 1, 'button_back', 'specific', 'Back'),
(521, 1, 'title_store', 'specific', 'Store'),
(522, 1, 'text_store_title', 'specific', 'Store'),
(523, 1, 'text_store_list_title', 'specific', 'Store List'),
(524, 1, 'label_created_at', 'specific', 'Created At'),
(525, 1, 'title_edit_store', 'specific', 'Edit Store'),
(526, 1, 'text_title', 'specific', 'Title'),
(527, 1, 'text_pos_setting', 'specific', 'POS Setting'),
(528, 1, 'label_gst_reg_no', 'specific', 'GST Reg. No.'),
(529, 1, 'label_sms_gateway', 'specific', 'SMS Gateway'),
(530, 1, 'hint_sms_gateway', 'specific', 'SMS Gateway like clickatell, 91sms'),
(531, 1, 'label_sms_alert', 'specific', 'SMS Alert'),
(532, 1, 'hint_sms_alert', 'specific', 'SMS Alert'),
(533, 1, 'text_yes', 'specific', 'Yes'),
(534, 1, 'text_no', 'specific', 'No.'),
(535, 1, 'label_auto_sms', 'specific', 'Auto SMS'),
(536, 1, 'text_sms_after_creating_invoice', 'specific', 'SMS After Create Invoice'),
(537, 1, 'label_expiration_system', 'specific', 'Expiration System'),
(538, 1, 'label_invoice_prefix', 'specific', 'Invoive Prefix'),
(539, 1, 'label_receipt_template', 'specific', 'Receipt Template'),
(540, 1, 'label_invoice_view', 'specific', 'Invoice View'),
(541, 1, 'hint_invoice_view', 'specific', 'Invoice View'),
(542, 1, 'text_tax_invoice', 'specific', 'Tax Invoice'),
(543, 1, 'text_indian_gst', 'specific', 'Indian GST'),
(544, 1, 'label_change_item_price_while_billing', 'specific', 'Change Price when Billing'),
(545, 1, 'hint_change_item_price_while_billing', 'specific', 'You will be able to edit sell price when you will create a invoice.'),
(546, 1, 'label_pos_product_display_limit', 'specific', 'POS Product Display Limit'),
(547, 1, 'hint_pos_product_display_limit', 'specific', 'Number of product that will display in POS'),
(548, 1, 'label_send_mail_path', 'specific', 'Send Mail Path'),
(549, 1, 'hint_send_mail_path', 'specific', 'Type send mail path here'),
(550, 1, 'text_logo', 'specific', 'Logo'),
(551, 1, 'label_logo_size', 'specific', 'Logo Size'),
(552, 1, 'button_upload', 'specific', 'Upload'),
(553, 1, 'text_favicon', 'specific', 'Favicon'),
(554, 1, 'label_favicon_size', 'specific', 'Favicon Size'),
(555, 1, 'title_user', 'specific', 'User'),
(556, 1, 'text_user_title', 'specific', 'User'),
(557, 1, 'text_new_user_title', 'specific', 'Add New User'),
(558, 1, 'label_password', 'specific', 'Password'),
(559, 1, 'label_password_retype', 'specific', 'Retype Password'),
(560, 1, 'label_group', 'specific', 'Group'),
(561, 1, 'hint_group', 'specific', 'Group name here'),
(562, 1, 'text_user_list_title', 'specific', 'User List'),
(563, 1, 'label_profile', 'specific', 'Profile'),
(564, 1, 'title_user_group', 'specific', 'Usergroup'),
(565, 1, 'text_group_title', 'specific', 'User Group'),
(566, 1, 'text_new_group_title', 'specific', 'Add New Usergroup'),
(567, 1, 'label_slug', 'specific', 'Slug'),
(568, 1, 'text_group_list_title', 'specific', 'User Group List'),
(569, 1, 'label_total_user', 'specific', 'Total User'),
(570, 1, 'title_password', 'specific', 'Password'),
(571, 1, 'text_password_title', 'specific', 'Password'),
(572, 1, 'text_password_box_title', 'specific', 'Password'),
(573, 1, 'label_password_user', 'specific', 'Password'),
(574, 1, 'label_password_new', 'specific', 'New Password'),
(575, 1, 'label_password_confirm', 'specific', 'Password Confirm'),
(576, 1, 'title_send_sms', 'specific', 'Send SMS'),
(577, 1, 'text_sms_title', 'specific', 'SMS'),
(578, 1, 'text_send_sms', 'specific', 'Send SMS'),
(579, 1, 'text_send_sms_title', 'specific', 'Send SMS'),
(580, 1, 'text_event_sms', 'specific', 'Event SMS'),
(581, 1, 'text_single', 'specific', 'Single'),
(582, 1, 'text_group', 'specific', 'User Group'),
(583, 1, 'label_sms_for', 'specific', 'SMS For'),
(584, 1, 'text_birthday', 'specific', 'Birthday'),
(585, 1, 'label_people_type', 'specific', 'People Type'),
(586, 1, 'text_all_customer', 'specific', 'All Customer'),
(587, 1, 'text_all_user', 'specific', 'All User'),
(588, 1, 'label_people', 'specific', 'People'),
(589, 1, 'label_message', 'specific', 'Messeage'),
(590, 1, 'button_send', 'specific', 'Send'),
(591, 1, 'label_phone_number', 'specific', 'Phone Number'),
(592, 1, 'title_sms_report', 'specific', 'SMS Report'),
(593, 1, 'text_sms_report_title', 'specific', 'SMS Report'),
(594, 1, 'text_sms_list_title', 'specific', 'SMS List'),
(595, 1, 'text_all', 'specific', 'All'),
(596, 1, 'button_delivered', 'specific', 'Delivered'),
(597, 1, 'button_failed', 'specific', 'Failed'),
(598, 1, 'label_schedule_at', 'specific', 'Schedule At'),
(599, 1, 'label_campaign_name', 'specific', 'Campaign Name'),
(600, 1, 'label_people_name', 'specific', 'People Name'),
(601, 1, 'label_mobile_number', 'specific', 'Mobile Number'),
(602, 1, 'label_process_status', 'specific', 'Process Status'),
(603, 1, 'label_response_text', 'specific', 'Response Text'),
(604, 1, 'label_delivered', 'specific', 'Delivered'),
(605, 1, 'label_resend', 'specific', 'Resend'),
(606, 1, 'title_sms_setting', 'specific', 'SMS Setting'),
(607, 1, 'text_sms_setting_title', 'specific', 'SMS Setting'),
(608, 1, 'text_sms_setting', 'specific', 'SMS Setting'),
(609, 1, 'text_clickatell', 'specific', 'clickatell'),
(610, 1, 'text_twilio', 'specific', 'twilio'),
(611, 1, 'text_msg91', 'specific', 'msg91'),
(612, 1, 'label_api_key', 'specific', 'API Key'),
(613, 1, 'label_sender_id', 'specific', 'Sender Id'),
(614, 1, 'label_auth_key', 'specific', 'Auth Key'),
(615, 1, 'label_contact', 'specific', 'Contact'),
(616, 1, 'label_country_code', 'specific', 'Country Code'),
(617, 1, 'label_maskname', 'specific', 'Maskname'),
(618, 1, 'label_optional', 'specific', 'Optional'),
(619, 1, 'label_campaignname', 'specific', 'Campaign Name'),
(620, 1, 'title_analytics', 'specific', 'Analytics'),
(621, 1, 'text_analytics_title', 'specific', 'Analytics'),
(622, 1, 'text_report_title', 'specific', 'Report'),
(623, 1, 'text_best_customer', 'specific', 'Best Customer'),
(624, 1, 'text_purchase_amount', 'specific', 'Purchase Amount'),
(625, 1, 'text_top_product', 'specific', 'Top Product'),
(626, 1, 'title_overview', 'specific', 'Overview Report'),
(627, 1, 'text_overview_title', 'specific', 'Overview Report'),
(628, 1, 'text_sell_overview', 'specific', 'Sell Overview'),
(629, 1, 'text_purchase_overview', 'specific', 'Purchase Overview'),
(630, 1, 'text_title_sells_overview', 'specific', 'Sell Overview'),
(631, 1, 'text_invoice_amount', 'specific', 'Invoice Amount'),
(632, 1, 'button_details', 'specific', 'Details'),
(633, 1, 'text_discount_amount', 'specific', 'Discount'),
(634, 1, 'text_due_given', 'specific', 'Due Given'),
(635, 1, 'text_due_collection', 'specific', 'Due Collection'),
(636, 1, 'text_others', 'specific', 'Others'),
(637, 1, 'text_shipping_charge', 'specific', 'Shipping Charge'),
(638, 1, 'text_others_charge', 'specific', 'Others Charge'),
(639, 1, 'text_profit_or_loss', 'specific', 'Profit or Loss'),
(640, 1, 'text_order_tax', 'specific', 'Order Tax'),
(641, 1, 'text_item_tax', 'specific', 'Item Tax'),
(642, 1, 'text_total_tax', 'specific', 'Total Tax'),
(643, 1, 'text_title_purchase_overview', 'specific', 'Purchase Overview'),
(644, 1, 'text_due_taken', 'specific', 'Due Taken'),
(645, 1, 'text_due_paid', 'specific', 'Due Paid'),
(646, 1, 'text_total_paid', 'specific', 'Total Paid'),
(647, 1, 'title_collection_report', 'specific', 'Collection Report'),
(648, 1, 'text_collection_report_title', 'specific', 'Collection Report'),
(649, 1, 'title_due_collection', 'specific', 'Due Collection'),
(650, 1, 'text_due_collection_title', 'specific', 'Due Collection'),
(651, 1, 'text_due_collection_sub_title', 'specific', 'Due Collection List'),
(652, 1, 'label_pmethod_name', 'specific', 'Payment Mehtod'),
(653, 1, 'label_created_by', 'specific', 'Created By'),
(654, 1, 'title_supplier_due_paid', 'specific', 'Supplier Due Paid'),
(655, 1, 'text_supplier_due_paid_title', 'specific', 'Supplier Due Paid'),
(656, 1, 'text_supplier_due_paid_sub_title', 'specific', 'Supplier Due Paid'),
(657, 1, 'title_sell_report', 'specific', 'Sell Report'),
(658, 1, 'text_selling_report_title', 'specific', 'Selling Report'),
(659, 1, 'text_selling_report_sub_title', 'specific', 'Selling Report'),
(660, 1, 'button_itemwise', 'specific', 'Itemwise'),
(661, 1, 'button_categorywise', 'specific', 'Categorywise'),
(662, 1, 'button_supplierwise', 'specific', 'Supplierwise'),
(663, 1, 'label_product_name', 'specific', 'Product Name'),
(664, 1, 'label_selling_price_tax', 'specific', 'Selling Price Tax'),
(665, 1, 'label_profit', 'specific', 'Profit'),
(666, 1, 'title_purchase_report', 'specific', 'Purchase Report'),
(667, 1, 'text_purchase_report_title', 'specific', 'Purchase Report'),
(668, 1, 'text_purchase_report_sub_title', 'specific', 'Purchase Report'),
(669, 1, 'label_sup_name', 'specific', 'Sup Name'),
(670, 1, 'title_sell_payment_report', 'specific', 'Sell Payment Report'),
(671, 1, 'text_sell_payment_report_title', 'specific', 'Sell Payment Report'),
(672, 1, 'title_purchase_payment_report', 'specific', 'Purchase Payment Report'),
(673, 1, 'text_purchase_payment_report_title', 'specific', 'Purchase Payment Report'),
(674, 1, 'title_sell_tax_report', 'specific', 'Sell Tax Report'),
(675, 1, 'text_sell_tax_report_title', 'specific', 'Sell Tax Report '),
(676, 1, 'text_sell_amount', 'specific', 'Sell Amount'),
(677, 1, 'text_product_tax_amount', 'specific', 'Product Tax'),
(678, 1, 'text_order_tax_amount', 'specific', 'Order Tax'),
(679, 1, 'text_tax_report_sub_title', 'specific', 'Tax Report '),
(680, 1, 'label_total_amount', 'specific', 'Total Amount'),
(681, 1, 'title_purchase_tax_report', 'specific', 'Purchase Tax Report'),
(682, 1, 'text_purchase_tax_report_title', 'specific', 'Purchase Tax Report'),
(683, 1, 'text_total_tax_amount', 'specific', 'Total Tax'),
(684, 1, 'text_purchase_tax_report_sub_title', 'specific', 'Purcahse Tax Report'),
(685, 1, 'label_tax_amount', 'specific', 'Tax Amount'),
(686, 1, 'title_tax_overview_report', 'specific', 'Tax Overview Report'),
(687, 1, 'text_tax_overview_report_title', 'specific', 'Tax Overview Report'),
(688, 1, 'text_sell_tax', 'specific', 'Sell Tax'),
(689, 1, 'text_purchase_tax', 'specific', 'Purchase Tax'),
(690, 1, 'label_tax_percent', 'specific', 'Tax Percent'),
(691, 1, 'label_count', 'specific', 'Count'),
(692, 1, 'title_stock_report', 'specific', 'Stock Report'),
(693, 1, 'text_stock_report_title', 'specific', 'Stock Report'),
(694, 1, 'text_stock_report', 'specific', 'Stock Report'),
(695, 1, 'supplier_name', 'specific', 'Supplier Name'),
(696, 1, 'title_filemanager', 'specific', 'Filemanager'),
(697, 1, 'title_loan', 'specific', 'Loan'),
(698, 1, 'text_loan_title', 'specific', 'Loan'),
(699, 1, 'text_take_loan_title', 'specific', 'Take Loan'),
(700, 1, 'label_loan_from', 'specific', 'Loan From'),
(701, 1, 'label_interest', 'specific', 'Interest'),
(702, 1, 'label_loan_for', 'specific', 'Loan For'),
(703, 1, 'text_loan_list_title', 'specific', 'Loan List'),
(704, 1, 'button_paid', 'specific', 'Paid'),
(705, 1, 'button_due', 'specific', 'Due'),
(706, 1, 'button_disabled', 'specific', 'Disabled'),
(707, 1, 'label_basic_amount', 'specific', 'Basic Amount'),
(708, 1, 'title_loan_summary', 'specific', 'Loan Summary'),
(709, 1, 'text_loan_summary_title', 'specific', 'Loan Summary'),
(710, 1, 'text_summary_title', 'specific', 'Summary'),
(711, 1, 'text_total_loan', 'specific', 'Total Loan'),
(712, 1, 'text_total_due', 'specific', 'Total Due'),
(713, 1, 'text_recent_payments', 'specific', 'Recent Payments'),
(714, 1, 'title_expense', 'specific', 'Expense'),
(715, 1, 'text_expense_title', 'specific', 'Expense'),
(716, 1, 'text_new_expense_title', 'specific', 'Add New Expense'),
(717, 1, 'label_returnable', 'specific', 'Returnable?'),
(718, 1, 'label_notes', 'specific', 'Notes'),
(719, 1, 'text_expense_list_title', 'specific', 'Expense Category List'),
(720, 1, 'label_category_name', 'specific', 'Category Name'),
(721, 1, 'title_expense_category', 'specific', 'Expense Category'),
(722, 1, 'text_expense_category_title', 'specific', 'Expense Category'),
(723, 1, 'text_new_expense_category_title', 'specific', 'Add New Expense Category'),
(724, 1, 'label_category_slug', 'specific', 'Category Slug'),
(725, 1, 'label_parent', 'specific', 'Parent'),
(726, 1, 'label_category_details', 'specific', 'Category Details'),
(727, 1, 'text_category_list_title', 'specific', 'Category List'),
(728, 1, 'title_expense_monthwise', 'specific', 'Expense Monthwise'),
(729, 1, 'text_expense_monthwise_title', 'specific', 'Expense Monthwise'),
(730, 1, 'text_print', 'specific', 'Print'),
(731, 1, 'text_supplier_list_title', 'specific', 'Supplier List'),
(732, 1, 'text_supplier_title', 'specific', 'Supplier '),
(733, 1, 'text_new_supplier_title', 'specific', 'Add New Supplier'),
(734, 1, 'title_purchase_transaction', 'specific', 'Purchase Transaction'),
(735, 1, 'text_purchase_transaction_title', 'specific', 'Purchase Transaction'),
(736, 1, 'text_transaction_title', 'specific', 'Transaction'),
(737, 1, 'text_transaction_list_title', 'specific', 'Transaction List'),
(738, 1, 'label_pmethod', 'specific', 'Payment Method'),
(739, 1, 'title_sell_transaction', 'specific', 'Sell Transaction'),
(740, 1, 'text_sell_transaction_title', 'specific', 'Sell Transaction'),
(741, 1, 'text_sell_transaction_list_title', 'specific', 'Sell Transaction List'),
(742, 1, 'title_barcode', 'specific', 'Barcode'),
(743, 1, 'text_barcode_title', 'specific', 'Barcode'),
(744, 1, 'text_barcode_generate_title', 'specific', 'Barcode Generate'),
(745, 1, 'label_product_name_with_code', 'specific', 'Product Name with Code'),
(746, 1, 'text_no_product', 'specific', 'No. Proudct'),
(747, 1, 'label_page_layout', 'specific', 'Page Layout'),
(748, 1, 'label_fields', 'specific', 'Fileds'),
(749, 1, 'button_generate', 'specific', 'Generate'),
(750, 1, 'title_category', 'specific', 'Category'),
(751, 1, 'text_category_title', 'specific', 'Category'),
(752, 1, 'text_new_category_title', 'specific', 'Add New Category'),
(753, 1, 'text_product_import_alert', 'specific', 'Product Import Alert'),
(754, 1, 'title_import_product', 'specific', 'Import Product'),
(755, 1, 'text_import_title', 'specific', 'Import'),
(756, 1, 'text_download', 'specific', 'Download'),
(757, 1, 'button_download', 'specific', 'Download'),
(758, 1, 'text_select_xls_file', 'specific', 'Select .xls File'),
(759, 1, 'button_import', 'specific', 'Import'),
(760, 1, 'title_stock_alert', 'specific', 'Stock Alert'),
(761, 1, 'text_stock_alert_title', 'specific', 'Stock Alert'),
(762, 1, 'text_stock_alert_box_title', 'specific', 'Stock Alert'),
(763, 1, 'title_expired', 'specific', 'Expired'),
(764, 1, 'text_expired_title', 'specific', 'Expired'),
(765, 1, 'text_expired_box_title', 'specific', 'Expired'),
(766, 1, 'button_expired', 'specific', 'Expired'),
(767, 1, 'button_expiring_soon', 'specific', 'Comming Soon'),
(768, 1, 'text_due', 'specific', 'Due'),
(769, 1, 'title_purchase_return', 'specific', 'Purchase Return'),
(770, 1, 'text_purchase_return_title', 'specific', 'Purchase Return'),
(771, 1, 'text_return_list_title', 'specific', 'Return List'),
(772, 1, 'text_purchase_return_list_title', 'specific', 'Purchase Return List'),
(773, 1, 'title_sell_return', 'specific', 'Sell Return'),
(774, 1, 'text_sell_return_title', 'specific', 'Sell Return'),
(775, 1, 'text_sell_return_list_title', 'specific', 'Sell Return List'),
(776, 1, 'title_giftcard', 'specific', 'Giftcard'),
(777, 1, 'text_giftcard_title', 'specific', 'Giftcard'),
(778, 1, 'text_new_giftcard_title', 'specific', 'Add New Giftcard'),
(779, 1, 'label_card_no', 'specific', 'Card No.'),
(780, 1, 'label_giftcard_value', 'specific', 'GIftcard Value'),
(781, 1, 'label_expiry_date', 'specific', 'Expiry Date'),
(782, 1, 'button_create_giftcard', 'specific', 'Create GIftcard'),
(783, 1, 'text_giftcard_list_title', 'specific', 'Giftcard List'),
(784, 1, 'label_expiry', 'specific', 'Expiry'),
(785, 1, 'label_topup', 'specific', 'Topup'),
(786, 1, 'title_giftcard_topup', 'specific', 'Giftcard Topup'),
(787, 1, 'text_giftcard_topup_title', 'specific', 'Giftcard Topup'),
(788, 1, 'text_topup_title', 'specific', 'Topup'),
(789, 1, 'text_giftcard_topup_list_title', 'specific', 'Giftcard Popup List'),
(790, 1, 'title_pos', 'specific', 'POS'),
(791, 1, 'text_gift_card', 'specific', 'Giftcard'),
(792, 1, 'button_sell_gift_card', 'specific', 'Giftcard'),
(793, 1, 'text_keyboard_shortcut', 'specific', 'Keyboard Shortcut '),
(794, 1, 'text_holding_order', 'specific', 'Holding Order'),
(795, 1, 'text_search_product', 'specific', 'Search/Barcode Scan'),
(796, 1, 'button_add_product', 'specific', 'Add Product'),
(797, 1, 'button_purchase_now', 'specific', 'Purchase Now'),
(798, 1, 'label_add_to_cart', 'specific', 'Add To Cart'),
(799, 1, 'text_add_note', 'specific', 'Add Note'),
(800, 1, 'label_price', 'specific', 'Price'),
(801, 1, 'label_total_items', 'specific', 'Total Item'),
(802, 1, 'label_discount', 'specific', 'Discount'),
(803, 1, 'label_total_payable', 'specific', 'Total Payable'),
(804, 1, 'button_pay', 'specific', 'Pay Now'),
(805, 1, 'button_hold', 'specific', 'Hold'),
(806, 1, 'text_update_title', 'specific', 'Update '),
(807, 1, 'text_male', 'specific', 'Male'),
(808, 1, 'text_female', 'specific', 'Female'),
(809, 1, 'text_thumbnail', 'specific', 'Thumbnail'),
(810, 1, 'text_update_success', 'specific', 'Successfully Updated'),
(811, 1, 'title_user_profile', 'specific', 'User Profile'),
(812, 1, 'text_profile_title', 'specific', 'Profile'),
(813, 1, 'text_users', 'specific', 'Users'),
(814, 1, 'text_since', 'specific', 'Since'),
(815, 1, 'text_contact_information', 'specific', 'Contact Information'),
(816, 1, 'label_collection', 'specific', 'Collection'),
(817, 1, 'text_sell_report', 'specific', 'Sell Report'),
(818, 1, 'text_purchase_report', 'specific', 'Purchase Report'),
(819, 1, 'text_payment_report', 'specific', 'Payment Report'),
(820, 1, 'text_login_log', 'specific', 'Login History'),
(821, 1, 'button_collection_report', 'specific', 'Collection Report'),
(822, 1, 'button_log', 'specific', 'Log'),
(823, 1, 'text_invoice_list', 'specific', 'Invoice List'),
(824, 1, 'label_items', 'specific', 'Items'),
(825, 1, 'label_time', 'specific', 'Time'),
(826, 1, 'title_bank_transactions', 'specific', 'Bank Transactions'),
(827, 1, 'text_bank_transaction_title', 'specific', 'Bank Transaction'),
(828, 1, 'text_bank_account_title', 'specific', 'Bank Account'),
(829, 1, 'text_bank_transaction_list_title', 'specific', 'Bank Transaction List'),
(830, 1, 'button_filtering', 'specific', 'Filtering'),
(831, 1, 'text_view_all_transactions', 'specific', 'View All Transactions'),
(832, 1, 'label_account', 'specific', 'Account'),
(833, 1, 'label_credit', 'specific', 'Credit'),
(834, 1, 'label_debit', 'specific', 'Debit'),
(835, 1, 'text_unpaid', 'specific', 'Unpaid'),
(836, 1, 'title_income_source', 'specific', 'Income Source'),
(837, 1, 'text_income_source_title', 'specific', 'Income Source'),
(838, 1, 'text_new_income_source_title', 'specific', 'Add New Income Source'),
(839, 1, 'label_source_name', 'specific', 'Source Name'),
(840, 1, 'label_source_slug', 'specific', 'Source Slug'),
(841, 1, 'label_source_details', 'specific', 'Source Details'),
(842, 1, 'text_income_source_sub_title', 'specific', 'Income Source List'),
(843, 1, 'title_income_monthwise', 'specific', 'Income Monthwise'),
(844, 1, 'text_income_monthwise_title', 'specific', 'Income Monthwise'),
(845, 1, 'label_capital', 'specific', 'Capital'),
(846, 1, 'title_bank_transfer', 'specific', 'Bank Transfer'),
(847, 1, 'text_bank_transfer_title', 'specific', 'Bank Transfer'),
(848, 1, 'text_banking_title', 'specific', 'Banking'),
(849, 1, 'text_list_bank_transfer_title', 'specific', 'Bank Transfer List'),
(850, 1, 'label_from_account', 'specific', 'From Account'),
(851, 1, 'label_to_account', 'specific', 'To Account'),
(852, 1, 'title_income_and_expense', 'specific', 'Income '),
(853, 1, 'text_income_and_expense_title', 'specific', 'Income vs Expense'),
(854, 1, 'text_date', 'specific', 'Date'),
(855, 1, 'title_income', 'specific', 'Income'),
(856, 1, 'label_this_month', 'specific', 'This Month'),
(857, 1, 'label_this_year', 'specific', 'This Year'),
(858, 1, 'label_till_now', 'specific', 'Till Now'),
(859, 1, 'error_currency_title', 'specific', 'Currency Tittle is not valid'),
(860, 1, 'text_pmethod', 'specific', 'Payment Method'),
(861, 1, 'button_full_payment', 'specific', 'FULL PAYMENT'),
(862, 1, 'button_full_due', 'specific', 'FULL DUE'),
(863, 1, 'button_sell_with_installment', 'specific', 'Sell With Installment'),
(864, 1, 'text_pay_amount', 'specific', 'Pay Amount'),
(865, 1, 'placeholder_input_an_amount', 'specific', 'Input Amount'),
(866, 1, 'placeholder_note_here', 'specific', 'Note Here'),
(867, 1, 'title_installment_details', 'specific', 'Installment Details'),
(868, 1, 'label_duration', 'specific', 'Duration'),
(869, 1, 'text_days', 'specific', 'Days'),
(870, 1, 'label_interval', 'specific', 'Interval'),
(871, 1, 'label_total_installment', 'specific', 'Total Installment'),
(872, 1, 'label_interest_percentage', 'specific', 'Interest Percentage'),
(873, 1, 'label_interest_amount', 'specific', 'Interest Amount'),
(874, 1, 'text_order_details', 'specific', 'Order Details'),
(875, 1, 'error_reference_no', 'specific', 'Reference no. is not valid'),
(876, 1, 'error_date', 'specific', 'Date is not valid'),
(877, 1, 'error_total_amount', 'specific', 'Total amount is not valid'),
(878, 1, 'error_customer', 'specific', 'Customer is not valid'),
(879, 1, 'text_quotation_create_success', 'specific', 'Successfully Created'),
(880, 1, 'button_action', 'specific', 'Action'),
(881, 1, 'button_create_sell', 'specific', 'Create Sell'),
(882, 1, 'title_installment_overview', 'specific', 'Installment Overview'),
(883, 1, 'text_installment_overview_title', 'specific', 'Installment Overview Report');
INSERT INTO `language_translations` (`id`, `lang_id`, `lang_key`, `key_type`, `lang_value`) VALUES
(884, 1, 'text_installment_overview', 'specific', 'Installment Overview'),
(885, 1, 'text_invoice_count', 'specific', 'Invoice Count'),
(886, 1, 'text_interest_amount', 'specific', 'Interest Amount'),
(887, 1, 'text_amount_received', 'specific', 'Amount Received'),
(888, 1, 'text_amount_due', 'specific', 'Amount Due'),
(889, 1, 'text_expired_due_payment', 'specific', 'Expired Due Payment'),
(890, 1, 'text_all_due_payment', 'specific', 'All Due Payment'),
(891, 1, 'text_todays_due_payment', 'specific', 'Todays Due Payment'),
(892, 1, 'title_installment', 'specific', 'Installment'),
(893, 1, 'text_installment_title', 'specific', 'Installment'),
(894, 1, 'text_installment_sub_title', 'specific', 'Installment List'),
(895, 1, 'button_all_installment', 'specific', 'All Installment'),
(896, 1, 'button_due_installment', 'specific', 'Due Installment'),
(897, 1, 'button_paid_installment', 'specific', 'Paid Installment'),
(898, 1, 'label_total_ins', 'specific', 'Total Ins.'),
(899, 1, 'text_order_summary', 'specific', 'Order Summary'),
(900, 1, 'label_previous_due', 'specific', 'Previous Due'),
(901, 1, 'text_return_item', 'specific', 'Return Item'),
(902, 1, 'label_return_quantity', 'specific', 'Return Quantity'),
(903, 1, 'placeholder_type_any_note', 'specific', 'Type Note'),
(904, 1, 'error_quantity_exceed', 'specific', 'Quantity Exceed'),
(905, 1, 'text_return_success', 'specific', 'Return Successfull'),
(906, 1, 'label_purchase_note', 'specific', 'Purchase Note'),
(907, 1, 'text_purchase_update_success', 'specific', 'Successfully Updated'),
(908, 1, 'error_items', 'specific', 'Items is not valid'),
(909, 1, 'error_store_id', 'specific', 'Store is not valid'),
(910, 1, 'text_transfer_success', 'specific', 'Successfully Transfered'),
(911, 1, 'button_transfer_edit', 'specific', 'Transfer Edit'),
(912, 1, 'text_update_transfer_status_success', 'specific', 'Successfully Updated'),
(913, 1, 'label_transferred_to', 'specific', 'Transfered To'),
(914, 1, 'text_product_list', 'specific', 'Product List'),
(915, 1, 'error_category_name', 'specific', 'Category name is not valid'),
(916, 1, 'error_sup_name', 'specific', 'Suppllier name is not valid'),
(917, 1, 'error_supplier_email_or_mobile', 'specific', 'Supplier email or mobile is not valid'),
(918, 1, 'error_sup_address', 'specific', 'Supplier Address is not valid'),
(919, 1, 'error_unit_name', 'specific', 'Unit name is not valid'),
(920, 1, 'error_product_name', 'specific', 'Product name is not valid'),
(921, 1, 'error_sup_id', 'specific', 'Supplier is not valid'),
(922, 1, 'text_product_name', 'specific', 'Product Name'),
(923, 1, 'text_quantity', 'specific', 'Quantity'),
(924, 1, 'button_print', 'specific', 'Print'),
(925, 1, 'error_walking_customer_can_not_craete_due', 'specific', 'Walking Customer Can\'t to Create a Due'),
(926, 1, 'error_stock', 'specific', 'Stock amount is not valid'),
(927, 1, 'error_installment_count', 'specific', 'Installment count is not valid'),
(928, 1, 'title_bank_account', 'specific', 'Bank Account'),
(929, 1, 'text_new_bank_account_title', 'specific', 'Add New Bank Account'),
(930, 1, 'label_account_name', 'specific', 'Account Name'),
(931, 1, 'label_account_details', 'specific', 'Account Details'),
(932, 1, 'label_account_no', 'specific', 'Account No.'),
(933, 1, 'label_contact_person', 'specific', 'Contact Person'),
(934, 1, 'label_internal_banking_url', 'specific', 'Internal Banking Url'),
(935, 1, 'text_bank_account_list_title', 'specific', 'Bank Account List'),
(936, 1, 'label_account_description', 'specific', 'Account Description'),
(937, 1, 'title_bank_account_sheet', 'specific', 'Balance Sheet'),
(938, 1, 'text_bank_account_sheet_title', 'specific', 'Balance Sheet'),
(939, 1, 'text_bank_account_sheet_list_title', 'specific', 'Balance Sheet Details'),
(940, 1, 'label_account_id', 'specific', 'Account Id'),
(941, 1, 'label_transfer_to_other', 'specific', 'Transfer To Other'),
(942, 1, 'label_transfer_from_other', 'specific', 'Transfer From Other'),
(943, 1, 'label_deposit', 'specific', 'Deposit'),
(944, 1, 'label_withdraw', 'specific', 'Widthdraw'),
(945, 1, 'text_select_store', 'specific', 'Select Store'),
(946, 1, 'text_activate_success', 'specific', 'Successfully Activated'),
(947, 1, 'text_template_content_update_success', 'specific', 'Successfully updated'),
(948, 1, 'text_template_css_update_success', 'specific', 'Successfully updated'),
(949, 1, 'title_cashbook', 'specific', 'Cashbook'),
(950, 1, 'text_cashbook_title', 'specific', 'Cashbook'),
(951, 1, 'text_cashbook_details_title', 'specific', 'Cashbook Details'),
(952, 1, 'label_opening_balance', 'specific', 'Opening Balance'),
(953, 1, 'label_today_income', 'specific', 'Today Income'),
(954, 1, 'label_total_income', 'specific', 'Total Income'),
(955, 1, 'label_today_expense', 'specific', 'Today Expense'),
(956, 1, 'label_cash_in_hand', 'specific', 'Cash In Hand'),
(957, 1, 'label_today_closing_balance', 'specific', 'Today Closing Balance'),
(958, 1, 'text_balance_update_success', 'specific', 'Successfully Updated'),
(959, 1, 'title_profit_and_loss', 'specific', 'Profit vs Loss'),
(960, 1, 'text_profit_and_loss_title', 'specific', 'Profit vs Loss'),
(961, 1, 'text_profit_and_loss_details_title', 'specific', 'Profit vs Loss Details'),
(962, 1, 'text_loss_title', 'specific', 'Loss'),
(963, 1, 'text_profit_title', 'specific', 'Profit'),
(964, 1, 'label_total_profit', 'specific', 'Total Profit'),
(965, 1, 'label_total_loss', 'specific', 'Total Loss'),
(966, 1, 'label_net_profit', 'specific', 'Net Profit'),
(967, 1, 'label_source', 'specific', 'Source'),
(968, 1, 'label_slip_no', 'specific', 'Slip No.'),
(969, 1, 'label_by', 'specific', 'By'),
(970, 1, 'label_exp_category', 'specific', 'Expense Category'),
(971, 1, 'label_about', 'specific', 'About'),
(972, 1, 'button_withdraw_now', 'specific', 'Widthdraw Now'),
(973, 1, 'label_income_source', 'specific', 'Income Source'),
(974, 1, 'button_deposit_now', 'specific', 'Deposit Now'),
(975, 1, 'text_deposit_success', 'specific', 'Deposit Successfull'),
(976, 1, 'text_delete_title', 'specific', 'Delete'),
(977, 1, 'text_delete_instruction', 'specific', 'What should be done belong to this content ?'),
(978, 1, 'label_insert_content_to', 'specific', 'Insert Content To'),
(979, 1, 'button_add_language', 'specific', 'Add Language'),
(980, 1, 'code', 'specific', 'code'),
(981, 1, 'error_code', 'specific', 'Code is not valid'),
(982, 1, 'text_uppdate_success', 'specific', 'Successfully Updated'),
(983, 1, 'error_name', 'specific', 'Name is not valid'),
(984, 1, 'text_hindi', 'specific', 'Hindi'),
(985, 1, 'text_create_success', 'specific', 'Successfully Created'),
(986, 1, 'text_gremany', 'specific', 'Germany'),
(987, 1, 'button_add_new_language', 'specific', 'Add New Language'),
(988, 1, 'text_fullscreen', 'specific', 'Fullscreen'),
(989, 1, 'text_sales', 'specific', 'Sells'),
(990, 1, 'text_quotations', 'specific', 'Quotations'),
(991, 1, 'text_purchases', 'specific', 'Purchases'),
(992, 1, 'text_transfers', 'specific', 'Transfers'),
(993, 1, 'text_customers', 'specific', 'Customers'),
(994, 1, 'text_suppliers', 'specific', 'Suppliers'),
(995, 1, 'label_payment_status', 'specific', 'Payment Status'),
(996, 1, 'button_add_sales', 'specific', 'Add Sell'),
(997, 1, 'button_list_sales', 'specific', 'SELL LIST'),
(998, 1, 'text_sales_amount', 'specific', 'Sell Amount'),
(999, 1, 'text_discount_given', 'specific', 'Discount Given'),
(1000, 1, 'text_received_amount', 'specific', 'Received Amount'),
(1001, 1, 'button_add_quotations', 'specific', 'Add Quotation'),
(1002, 1, 'button_list_quotations', 'specific', 'Quotation List'),
(1003, 1, 'label_supplier_name', 'specific', 'Supplier Name'),
(1004, 1, 'button_add_purchases', 'specific', 'Add Purchase'),
(1005, 1, 'button_list_purchases', 'specific', 'Purchase List'),
(1006, 1, 'button_add_transfers', 'specific', 'Add Transfer'),
(1007, 1, 'button_list_transfers', 'specific', 'Transfer List'),
(1008, 1, 'button_add_customer', 'specific', 'Add Customer'),
(1009, 1, 'button_list_customers', 'specific', 'Customer List'),
(1010, 1, 'button_add_supplier', 'specific', 'Add Supplier'),
(1011, 1, 'button_list_suppliers', 'specific', 'Supplier List'),
(1012, 1, 'text_permission', 'specific', 'Permission'),
(1013, 1, 'text_recent_activities', 'specific', 'Recent Activities'),
(1014, 1, 'text_top_products', 'specific', 'Top Products'),
(1015, 1, 'text_top_customers', 'specific', 'Top Customers'),
(1016, 1, 'text_top_suppliers', 'specific', 'Top Suppliers'),
(1017, 1, 'text_top_brands', 'specific', 'Top Brands'),
(1018, 1, 'text_amount', 'specific', 'Amount'),
(1019, 1, 'text_purchase', 'specific', 'Purchase'),
(1020, 1, 'title_login_logs', 'specific', 'Login Logs'),
(1021, 1, 'title_activity_logs', 'specific', 'Activity Logs'),
(1022, 1, 'text_birthday_today', 'specific', 'Birthday Today'),
(1023, 1, 'text_birthday_coming', 'specific', 'Birthday Coming'),
(1024, 1, 'title_income_vs_expense', 'specific', 'Income vs Expense'),
(1025, 1, 'text_download_as_jpg', 'specific', 'Download as PNG'),
(1026, 1, 'error_disabled_by_default', 'specific', 'Disabled By Default'),
(1027, 1, 'button_empty_value', 'specific', 'Empty Value'),
(1028, 1, 'text_invoice_create_success', 'specific', 'Successfully Created'),
(1029, 1, 'button_send_sms', 'specific', 'Send SMS'),
(1030, 1, 'button_email', 'specific', 'Email'),
(1031, 1, 'button_back_to_pos', 'specific', 'Back to POS'),
(1032, 1, 'error_status', 'specific', 'Status is not valid'),
(1033, 1, 'error_reference_no_exist', 'specific', 'Ref. no. is not valid'),
(1034, 1, 'text_view_invoice_title', 'specific', 'View Invoice Title'),
(1035, 1, 'text_new_dashboard', 'specific', 'New Dashboard'),
(1036, 1, 'text_recent_customer_box_title', 'specific', 'Recent Customers'),
(1037, 1, 'label_customer_mobile', 'specific', 'Customer Mobile'),
(1038, 1, 'label_invoice_note', 'specific', 'Invoice Note'),
(1039, 1, 'text_sell_update_success', 'specific', 'Successfully Updated'),
(1040, 1, 'label_customer_id', 'specific', 'Customer Id'),
(1041, 1, 'label_returened_by', 'specific', 'Returned By'),
(1042, 1, 'text_return_products', 'specific', 'Return Products'),
(1043, 1, 'button_topup', 'specific', 'Topup'),
(1044, 1, 'button_topup_now', 'specific', 'Topup Now'),
(1045, 1, 'error_amount', 'specific', 'Amount is not Valid'),
(1046, 1, 'error_expiry_date', 'specific', 'Expiry Date'),
(1047, 1, 'text_topup_success', 'specific', 'Topup Successfull'),
(1048, 1, 'label_vat_number', 'specific', 'VAT Number'),
(1049, 1, 'label_unit_price', 'specific', 'Unit Price'),
(1050, 1, 'label_shipping', 'specific', 'Shipping'),
(1051, 1, 'label_stamp_and_signature', 'specific', 'Stamp and Signature'),
(1052, 1, 'title_quotation_edit', 'specific', 'Quotation Edit'),
(1053, 1, 'text_quotation_edit_title', 'specific', 'Quotation Edit'),
(1054, 1, 'text_quotation_update_success', 'specific', 'Successfully Updated'),
(1055, 1, 'error_product_not_found', 'specific', 'Product Not Found'),
(1056, 1, 'error_invoice_product_type', 'specific', 'Invoice product type is not valid'),
(1057, 1, 'label_checkout_status', 'specific', 'Checkout Status'),
(1058, 1, 'label_sub_total', 'specific', 'Sub Total'),
(1059, 1, 'text_payments', 'specific', 'Payments'),
(1060, 1, 'error_select_at_least_one_item', 'specific', 'Select at least one product'),
(1061, 1, 'button_pay_now', 'specific', 'Pay Now'),
(1062, 1, 'text_billing_details', 'specific', 'Billing Details'),
(1063, 1, 'Print Barcode', 'specific', 'undefined'),
(1064, 1, 'error_new_category_name', 'specific', 'Please select a category'),
(1065, 1, 'error_customer_name', 'specific', 'Customer name is not valid'),
(1066, 1, 'error_expired_date_below', 'specific', 'Expired date is not valid'),
(1067, 1, 'label_insert_invoice_to', 'specific', 'Insert Invoice To'),
(1068, 1, 'error_new_customer_name', 'specific', 'Please select a customer'),
(1069, 1, 'title_customer_profile', 'specific', 'Customer Profile'),
(1070, 1, 'text_total_purchase', 'specific', 'Total Purchase'),
(1071, 1, 'label_mobile_phone', 'specific', 'Mobile Phone'),
(1072, 1, 'button_transaction_list', 'specific', 'Transaction List'),
(1073, 1, 'label_ref_invoice_Id', 'specific', 'Ref. Invoice Id'),
(1074, 1, 'error_code_name', 'specific', 'Code name is not valid'),
(1075, 1, 'title_supplier_profile', 'specific', 'Supplier Profile'),
(1076, 1, 'text_supplier_profile_title', 'specific', 'Supplier Profile'),
(1077, 1, 'text_supplier_products', 'specific', 'Supplier Products'),
(1078, 1, 'button_products', 'specific', 'Products'),
(1079, 1, 'text_balance_amount', 'specific', 'Balance Amount'),
(1080, 1, 'text_sells', 'specific', 'Sells'),
(1081, 1, 'text_chart', 'specific', 'Chart'),
(1082, 1, 'text_purchase_invoice_list', 'specific', 'Purchase Invoice List'),
(1083, 1, 'button_all_purchase', 'specific', 'All Purchase'),
(1084, 1, 'button_due_purchase', 'specific', 'Due Purchase'),
(1085, 1, 'button_paid_purchase', 'specific', 'Paid Purchase'),
(1086, 1, 'button_stock_transfer', 'specific', 'Stock Transfer'),
(1087, 1, 'text_selling_invoice_list', 'specific', 'Selling Invoice List'),
(1088, 1, 'error_account', 'specific', 'Account is not valid'),
(1089, 1, 'error_ref_no', 'specific', 'Ref. no. is not valid'),
(1090, 1, 'error_about', 'specific', 'About is not valid'),
(1091, 1, 'error_title', 'specific', 'Title is not valid'),
(1092, 1, 'text_withdraw_success', 'specific', 'successfully created'),
(1093, 1, 'error_from_account', 'specific', 'From account is not valid'),
(1094, 1, 'error_to_account', 'specific', 'To account is not valid'),
(1095, 1, 'error_same_account', 'specific', 'Receiver and sender can\'t be same'),
(1096, 1, 'error_insufficient_balance', 'specific', 'Insufficient balance'),
(1097, 1, 'error_ref_no_exist', 'specific', 'Ref. no. already exists'),
(1098, 1, 'error_account_name', 'specific', 'Account name is not valid'),
(1099, 1, 'error_account_no', 'specific', 'Account no. is not valid'),
(1100, 1, 'error_contact_person', 'specific', 'Contact person is not valid'),
(1101, 1, 'error_phone_number', 'specific', 'Phone number is not valid'),
(1102, 1, 'text_income', 'specific', 'Income'),
(1103, 1, 'text_expense', 'specific', 'Expense'),
(1104, 1, 'text_update_income_source_success', 'specific', 'Successfully updated'),
(1105, 1, 'error_new_source_name', 'specific', 'Please select a source'),
(1106, 1, 'text_delete_income_source_success', 'specific', 'Successfully deleted'),
(1107, 1, 'label_day', 'specific', 'Day'),
(1108, 1, 'error_category_id', 'specific', 'Category id is not valid'),
(1109, 1, 'button_viefw', 'specific', 'View'),
(1110, 1, 'label_summary', 'specific', 'Summary'),
(1111, 1, 'label_grand_total', 'specific', 'Grand Total'),
(1112, 1, 'label_this_week', 'specific', 'This Week'),
(1113, 1, 'error_loan_from', 'specific', 'Loan from is not valid'),
(1114, 1, 'error_loan_headline', 'specific', 'Loan headline is not valid'),
(1115, 1, 'error_loan_amount', 'specific', 'Loan amount is not valid'),
(1116, 1, 'text_take_loan_success', 'specific', 'Successfully created'),
(1117, 1, 'error_paid_amount', 'specific', 'Paid amount is not valid'),
(1118, 1, 'error_pay_amount_greater_than_due_amount', 'specific', 'Pay amount can\'t be greater than due amount'),
(1119, 1, 'text_loan_paid_success', 'specific', 'Successfully paid'),
(1120, 1, 'error_sms_text', 'specific', 'SMS text is not valid'),
(1121, 1, 'text_success_sms_sent', 'specific', 'SMS successfully sent'),
(1122, 1, 'error_user_name', 'specific', 'user name is not valid'),
(1123, 1, 'error_user_email_or_mobile', 'specific', 'Email or mobile is not valid'),
(1124, 1, 'error_user_group', 'specific', 'User Group is not valid'),
(1125, 1, 'error_user_password_match', 'specific', 'Retype password didn\'t matched'),
(1126, 1, 'error_user_password_length', 'specific', 'User password length is not valid'),
(1127, 1, 'text_income_vs_expense', 'specific', 'Income vs Expense'),
(1128, 1, 'error_mobile', 'specific', 'Mobile number is not valid'),
(1129, 1, 'error_email', 'specific', 'Email is not valid'),
(1130, 1, 'error_zip_code', 'specific', 'Zip code is not valid'),
(1131, 1, 'error_addreess', 'specific', 'Address is not valid'),
(1132, 1, 'error_preference_receipt_template', 'specific', 'Receipt template is not valid'),
(1133, 1, 'error_currency', 'specific', 'Currency is not valid'),
(1134, 1, 'error_brand_name', 'specific', 'Please select a brand name'),
(1135, 1, 'title_brand_profile', 'specific', 'Brand Profile'),
(1136, 1, 'text_brand_profile_title', 'specific', 'Brand Profile'),
(1137, 1, 'text_brands', 'specific', 'Brands'),
(1138, 1, 'text_brand_products', 'specific', 'Brand Products'),
(1139, 1, 'button_all_products', 'specific', 'All Products'),
(1140, 1, 'text_total_sell', 'specific', 'Total Sell'),
(1141, 1, 'label_brand_name', 'specific', 'Brand Name'),
(1142, 1, 'label_insert_product_to', 'specific', 'Insert Product To'),
(1143, 1, 'error_currency_code', 'specific', 'Currency code is not valid'),
(1144, 1, 'error_currency_symbol', 'specific', 'Currency symbol is not valid'),
(1145, 1, 'error_currency_decimal_place', 'specific', 'Decimal number is not valid'),
(1146, 1, 'error_pmethod_name', 'specific', 'Payment method is not valid'),
(1147, 1, 'label_invoice_to', 'specific', 'Invoice To'),
(1148, 1, 'error_delete_unit_name', 'specific', 'Please select a unit'),
(1149, 1, 'label_ip', 'specific', 'Ip'),
(1150, 1, 'error_taxrate_name', 'specific', 'Taxrate name is not valid'),
(1151, 1, 'error_taxrate', 'specific', 'Taxrate is not valid'),
(1152, 1, 'error_delete_taxrate_name', 'specific', 'Please select a taxrate'),
(1153, 1, 'error_box_name', 'specific', 'Box name is not valid'),
(1154, 1, 'error_delete_box_name', 'specific', 'Please select a box'),
(1155, 1, 'label_success', 'specific', 'Success'),
(1156, 1, 'title_customer_analysis', 'specific', 'Customer Analysis'),
(1157, 1, 'title_customer_analytics', 'specific', 'Customer Analytics'),
(1158, 1, 'error_not_found', 'specific', 'Not Found'),
(1159, 1, 'menu_sell_list', 'specific', 'SELL LIST'),
(1160, 1, 'menu_sell_log', 'specific', 'SELL LOG'),
(1161, 1, 'menu_purchase_logs', 'specific', 'PURCHASE LOG'),
(1162, 1, 'menu_receive_list', 'specific', 'RECEIVE LIST'),
(1163, 1, 'menu_statements', 'specific', 'STATEMENTS'),
(1164, 1, 'menu_data_reset', 'specific', 'DATA RESET'),
(1165, 1, 'placeholder_search_here', 'specific', 'Search Here...'),
(1166, 1, 'text_sell_list_title', 'specific', 'Sell List'),
(1167, 1, 'text_invoices', 'specific', 'Invoices'),
(1168, 1, 'placeholder_input_discount_amount', 'specific', 'Input Discount Amount'),
(1169, 1, 'label_previous_due_paid', 'specific', 'Prev. Due Paid'),
(1170, 1, 'button_add_purchase', 'specific', 'Add Purchase'),
(1171, 1, 'text_selling_tax', 'specific', 'Selling Tax'),
(1172, 1, 'text_igst', 'specific', 'IGST'),
(1173, 1, 'text_cgst', 'specific', 'CGST'),
(1174, 1, 'text_sgst', 'specific', 'SGST'),
(1175, 1, 'text_return_amount', 'specific', 'Return Amount'),
(1176, 1, 'text_sell_due_paid_success', 'specific', 'Due successfully paid'),
(1177, 1, 'text_images', 'specific', 'Images'),
(1178, 1, 'label_hsn_code', 'specific', 'HSN Code'),
(1179, 1, 'label_select', 'specific', '-- Please Select --'),
(1180, 1, 'label_sold', 'specific', 'Sold'),
(1181, 1, 'button_view_details', 'specific', 'View'),
(1182, 1, 'text_installment_details', 'specific', 'Installment Details'),
(1183, 1, 'label_initial_payment', 'specific', 'Initial Payment'),
(1184, 1, 'label_interval_count', 'specific', 'Internal Count'),
(1185, 1, 'label_installment_count', 'specific', 'Installment Count'),
(1186, 1, 'label_last_installment_date', 'specific', 'Last Installment Date'),
(1187, 1, 'label_installment_end_date', 'specific', 'Installment End Date'),
(1188, 1, 'label_sl', 'specific', 'SL'),
(1189, 1, 'text_update_installment_payment_success', 'specific', 'Installment payment successfull'),
(1190, 1, 'error_amount_exceed', 'specific', 'Amount Exceed'),
(1191, 1, 'text_expiry', 'specific', 'Expiry'),
(1192, 1, 'text_opening_balance_update_success', 'specific', 'Opening balance successfully updated'),
(1193, 1, 'title_reset_your_system', 'specific', 'Reset your system'),
(1194, 1, 'title_sell_log', 'specific', 'Sell Log'),
(1195, 1, 'text_sell_log_title', 'specific', 'Sell Log'),
(1196, 1, 'text_sell_title', 'specific', 'Sell'),
(1197, 1, 'label_gtin', 'specific', ''),
(1198, 1, 'button_add_balance', 'specific', 'Add Balance'),
(1199, 1, 'button_statement', 'specific', 'Statement'),
(1200, 1, 'text_all_invoice', 'specific', 'All Invoice'),
(1201, 1, 'label_prev_due', 'specific', 'Prev. Due'),
(1202, 1, 'error_invoice_id', 'specific', 'Invoice id is not valid'),
(1203, 1, 'title_settings', 'specific', ''),
(1204, 1, 'text_cronjob', 'specific', ''),
(1205, 1, 'button_due_invoice_list', 'specific', ''),
(1206, 1, 'text_substract_amount', 'specific', ''),
(1207, 1, 'text_balance_added', 'specific', ''),
(1208, 1, 'button_substract_balance', 'specific', ''),
(1209, 1, 'title_purchase_log', 'specific', 'Purchase log'),
(1210, 1, 'text_purchase_log_title', 'specific', 'Purchase Log'),
(1211, 1, 'title_log_in', 'specific', ''),
(1212, 1, 'text_demo', 'specific', 'This is a demo version. Data will be reset in every 6 hours interval. &lt;a style=&quot;font-weight:bold&quot; href=&quot;http://docs.itsolution24.com/pos/&quot;&gt;Online Documentation&lt;/a&gt;  |  &lt;a style=&quot;color:#aafff0;font-weight:bold&quot; href=&quot;https://nighan2.com&quot;&gt;Visit nighan2labs pvt ltd&lt;/a&gt;'),
(1213, 1, 'error_disabled_in_demo', 'specific', 'This feature is disable in error!'),
(1214, 1, 'text_order_title', 'specific', ''),
(1215, 1, 'error_purchase_price', 'specific', ''),
(1216, 1, 'text_list__transfer__title', 'specific', ''),
(1217, 1, 'text_download_sample_format_file', 'specific', ''),
(1218, 1, 'text_barcode_print', 'specific', ''),
(1219, 1, 'button_semd_email', 'specific', ''),
(1220, 1, 'button_send_email', 'specific', 'Send Email'),
(1221, 1, 'error_email_not_sent', 'specific', ''),
(1222, 1, 'text_success_email_sent', 'specific', ''),
(1223, 1, 'button_installment_payment', 'specific', ''),
(1224, 1, 'text_sell_log_list_title', 'specific', 'Sell Log Details'),
(1225, 1, 'text_purchase_log_list_title', 'specific', 'Purchase Log Details'),
(1226, 1, 'text_stock_transfer_title', 'specific', ''),
(1227, 1, 'title_receive', 'specific', 'Receive'),
(1228, 1, 'text_stock_receive_title', 'specific', 'Stock Receive'),
(1229, 1, 'text_receive_title', 'specific', 'Receive'),
(1230, 1, 'text_list__receive__title', 'specific', 'Receive Details'),
(1231, 1, 'label_what_for', 'specific', ''),
(1232, 1, 'error_out_of_stock', 'specific', ''),
(1233, 1, 'xxx', 'specific', ''),
(1234, 1, 'error_login', 'specific', ''),
(1235, 1, 'text_purchase_due_paid_success', 'specific', ''),
(1236, 1, 'text_trash', 'specific', ''),
(1237, 1, 'button_restore_all', 'specific', ''),
(1238, 1, 'success_restore_all', 'specific', ''),
(1239, 1, 'title_customer_statement', 'specific', ''),
(1240, 1, 'text_statement_title', 'specific', ''),
(1241, 1, 'title_profit', 'specific', ''),
(1242, 1, 'error_return_quantity_exceed', 'specific', ''),
(1243, 1, 'label_transferred_from', 'specific', ''),
(1244, 1, 'label_member_since', 'specific', ''),
(1245, 1, 'text_not_found', 'specific', ''),
(1246, 1, 'label_logged_in', 'specific', ''),
(1247, 1, 'text_disabled', 'specific', ''),
(1248, 1, 'text_gtin', 'specific', ''),
(1249, 1, 'text_balance', 'specific', ''),
(1250, 1, 'error_invalid_username_password', 'specific', ''),
(1251, 1, 'error_installment_interest_percentage', 'specific', ''),
(1252, 1, 'error_installment_interest_amount', 'specific', ''),
(1253, 1, 'button_resend', 'specific', ''),
(1254, 1, 'error_sms_not_sent', 'specific', ''),
(1255, 1, 'text_sms_logs_title', 'specific', ''),
(1256, 1, 'text_sms_history_title', 'specific', ''),
(1257, 1, 'error_mobile_exist', 'specific', ''),
(1258, 1, 'text_success_sms_schedule', 'specific', ''),
(1259, 1, 'text_success_sms_added_to_schedule', 'specific', ''),
(1260, 1, 'text_mimsms', 'specific', ''),
(1261, 1, 'label_api_token', 'specific', ''),
(1262, 1, 'error_gateway', 'specific', ''),
(1263, 1, 'error_sms_not_send', 'specific', ''),
(1264, 1, 'invoice_sms_text', 'specific', 'Dear [customer_name],  Invoice ID: [invoice_id],  Payable: [payable_amount],  Paid: [paid_amount] ,  Due: [due]. Purchase at- [date_time]. Regards, [store_name],  [address]'),
(1265, 1, 'text_stock_register', 'specific', ''),
(1266, 1, 'text_urdu', 'specific', ''),
(1267, 1, 'error_default_language', 'specific', ''),
(1268, 1, 'error_active_or_sold', 'specific', ''),
(1269, 1, 'title_home', 'specific', 'Home'),
(1270, 1, 'error_supplier_name', 'specific', ''),
(1271, 1, 'error_expired_date_belowx', 'specific', ''),
(1272, 1, 'title_categories', 'specific', ''),
(1273, 1, 'title_products', 'specific', 'Products'),
(1274, 1, 'title_shop_on_sale', 'specific', ''),
(1275, 1, 'title_cart', 'specific', 'Cart'),
(1276, 1, 'title_wishlist', 'specific', ''),
(1277, 1, 'title_account', 'specific', ''),
(1278, 1, 'title_contact', 'specific', ''),
(1279, 1, 'title_contact_us', 'specific', ''),
(1280, 1, 'title_return_refund', 'specific', ''),
(1281, 1, 'title_faq', 'specific', ''),
(1282, 1, 'title_terms_condition', 'specific', ''),
(1283, 1, 'title_support', 'specific', ''),
(1284, 1, 'title_login', 'specific', ''),
(1285, 1, 'title_about', 'specific', ''),
(1286, 1, 'text_restore_completed', 'specific', 'Restored successfully completed'),
(1287, 1, 'error_receipt_printer', 'specific', 'Receipt printer is not valid'),
(1288, 1, 'title_checkout', 'specific', 'Checkout'),
(1289, 1, 'label_credit_balance', 'specific', 'Credit Balance'),
(1290, 1, 'label_giftcard_taken', 'specific', 'Gift Card taken'),
(1291, 1, 'text_are_you_sure', 'specific', 'Are you sure?'),
(1292, 1, 'text_information', 'specific', 'Information'),
(1293, 1, 'text_store_access_success', 'specific', 'Store  successfully activated'),
(1294, 1, 'title_cart_empty', 'specific', 'Cart is empty'),
(1295, 1, 'title_payment', 'specific', 'Payment'),
(1296, 1, 'error_installment_duration', 'specific', 'Installment duration is not valid'),
(1297, 1, 'error_password_mismatch', 'specific', 'Confirm password did\'t match'),
(1298, 1, 'error_email_exist', 'specific', 'Email already exists!'),
(1299, 1, 'error_invalid_purchase_code', 'specific', 'Invalid Purchase Code'),
(1300, 1, 'label_member_since', 'specific', 'Member Since'),
(1301, 1, 'error_printer_ip_address_or_port', 'specific', 'IP address or Port'),
(1302, 1, 'error_printer_path', 'specific', 'Printer Path'),
(1303, 1, 'text_barcode_print', 'specific', 'Barcode Print'),
(1304, 1, 'label_select', 'specific', 'Select'),
(1305, 1, 'label_sold', 'specific', 'Sold'),
(1306, 1, 'error_invalid_username_password', 'specific', 'Username or Password is invalid'),
(1307, 1, 'text_order_title', 'specific', 'Order'),
(1308, 1, 'placeholder_search_here', 'specific', 'Search here...'),
(1309, 1, 'text_order', 'specific', 'Order'),
(1310, 1, 'menu_order', 'specific', 'ORDER'),
(1311, 1, 'menu_hold_order', 'specific', 'Hold Order'),
(1312, 1, 'menu_stock_transfer', 'specific', 'Stock Transfer'),
(1313, 1, 'button_gift_card', 'specific', 'Gift Card'),
(1314, 1, 'title_settings', 'specific', 'Settings'),
(1315, 1, 'placeholder_input_discount_amount', 'specific', 'Discount Amount'),
(1316, 1, 'text_sell_due_paid_success', 'specific', 'Successfully Paid'),
(1317, 1, 'button_due_invoice_list', 'specific', 'Due Invoice List'),
(1318, 1, 'button_add_balance', 'specific', 'Add Balance'),
(1319, 1, 'error_pmethod_id', 'specific', 'Payment method is not valid'),
(1320, 1, 'text_balance_added', 'specific', 'Balance successfully added'),
(1321, 1, 'button_sell_product', 'specific', 'Sell Product'),
(1322, 1, 'error_pmethod_code', 'specific', 'Payment method code is not valid'),
(1323, 1, 'invoice_sms_text', 'specific', 'SMS'),
(1324, 1, 'error_installment_duration', 'specific', 'Installment duration is not valid'),
(1325, 1, 'button_view_details', 'specific', 'View Details'),
(1326, 1, 'text_installment_details', 'specific', 'Installment Details'),
(1327, 1, 'label_initial_payment', 'specific', 'Initial Payment'),
(1328, 1, 'label_interval_count', 'specific', 'Interval Count'),
(1329, 1, 'label_installment_count', 'specific', 'Installment Count'),
(1330, 1, 'label_last_installment_date', 'specific', 'Last Installment Date'),
(1331, 1, 'label_installment_end_date', 'specific', 'Intallment End Date'),
(1332, 1, 'text_all_invoice', 'specific', 'All Invoice'),
(1333, 1, 'text_all_due', 'specific', 'All Due'),
(1334, 1, 'button_purchase', 'specific', 'Purchase'),
(1335, 1, 'error_login_attempt', 'specific', 'Error Login Attempt'),
(1336, 1, 'error_login_attempt_exceed', 'specific', 'Login Attempt Exceed'),
(1337, 1, 'error_login_attempts_exceeded', 'specific', 'Login attempt exceeded'),
(1338, 1, 'label_logged_in', 'specific', 'Logged In'),
(1339, 1, 'error_mobile_exist', 'specific', 'Mobile number already exist.'),
(1340, 1, 'error_login', 'specific', 'Login Error.'),
(1341, 1, 'button_product_purchase', 'specific', 'Product purchase'),
(1342, 1, 'button_add_purchase', 'specific', 'Add Purchase'),
(1343, 1, 'label_change', 'specific', 'Change'),
(1344, 1, 'text_demo', 'specific', 'This is a demo version. Data will be reset in every 6 hours interval. &lt;a style=&quot;color:#aafff0;font-weight:bold&quot; href=&quot;https://nighan2.com&quot;&gt;Visit nighan2labs pvt ltd&lt;/a&gt;'),
(1345, 1, 'error_disabled_in_demo', 'specific', 'This feature disabled in demo.'),
(1346, 1, 'button_substract_balance', 'specific', 'Substract Balance'),
(1347, 1, 'error_amount_exceed', 'specific', 'Amount is exceed.'),
(1348, 1, 'text_balance_substracted', 'specific', 'Balance successfully substracted.'),
(1349, 1, 'title_customer_transaction', 'specific', 'Customer Transaction'),
(1350, 1, 'text_customer_transaction_title', 'specific', 'Customer Transaction'),
(1351, 1, 'text_customer_transaction_list_title', 'specific', 'Customer Transaction List'),
(1352, 1, 'title_supplier_transaction', 'specific', 'Supplier Transaction'),
(1353, 1, 'text_supplier_transaction_title', 'specific', 'Supplier Transaction'),
(1354, 1, 'error_card_no', 'specific', 'Card no. is not valid'),
(1355, 1, 'error_activate_permission', 'specific', 'Activate permission is not valid.'),
(1356, 1, 'error_discount_amount_exceed', 'specific', 'Discount amount exceed'),
(1357, 1, 'error_unexpected', 'specific', 'Unexpected error.'),
(1358, 1, 'text_returns', 'specific', 'Returns'),
(1359, 1, 'label_sl', 'specific', 'Sl'),
(1360, 1, 'label_sup_id', 'specific', 'Sup Id'),
(1361, 1, 'label_delete_all', 'specific', 'Delete All'),
(1362, 1, 'label_insert_store_to', 'specific', 'Insert Store To'),
(1363, 1, 'label_insert_store_content_into', 'specific', 'Insert Content To'),
(1364, 1, 'error_store_name', 'specific', 'Store name is not valid'),
(1365, 1, 'error_email_exist', 'specific', 'Email already exist'),
(1366, 1, 'error_customer_gift_card_exist', 'specific', 'Customer giftcard already exist'),
(1367, 1, 'text_expiry', 'specific', 'Expiry'),
(1368, 1, 'label_transferred_from', 'specific', 'Transfered From'),
(1369, 1, 'text_download_samdple_format_file', 'specific', 'Download Sample Format'),
(1370, 1, 'store_code 1 is not valid!', 'specific', 'Store code is not valid'),
(1371, 1, 'text_purchase_due_paid_success', 'specific', 'Successfully Paid'),
(1372, 1, 'error_invalid_balance', 'specific', 'Invalid Balance'),
(1373, 1, 'text_opening_balance_update_success', 'specific', 'Opening balance successfully updated'),
(1374, 1, 'button_installment_payment', 'specific', 'Installment Payment'),
(1375, 1, 'text_update_installment_payment_success', 'specific', 'Installment payment successfully updated'),
(1376, 1, 'error_email_address', 'specific', 'Email address is not valid'),
(1377, 1, 'email_sent_successful', 'specific', 'Email successfully sent'),
(1378, 1, 'error_id', 'specific', 'Id is not valid'),
(1379, 1, 'button_sell_list', 'specific', NULL),
(1380, 1, 'text_add_product', 'specific', NULL),
(1381, 1, 'text_redirecting_to_dashbaord', 'specific', NULL),
(1382, 1, 'label_old_invoice_id', 'specific', NULL),
(1383, 1, 'label_purchase_invoice_id', 'specific', NULL),
(1384, 1, 'label_return_note', 'specific', NULL),
(1385, 1, 'label_return_items', 'specific', NULL),
(1386, 1, 'label_returned_by', 'specific', NULL),
(1387, 1, 'error_product_price', 'specific', NULL),
(1388, 1, 'error_product_code_exist', 'specific', NULL),
(1389, 1, 'error_product_exist', 'specific', NULL),
(1390, 1, 'text_product_created', 'specific', NULL),
(1391, 1, 'label_reference_format', 'specific', NULL),
(1392, 1, 'label_sales_reference_prefix', 'specific', NULL),
(1393, 1, 'error_quantity', 'specific', NULL),
(1394, 1, 'text_product_updated', 'specific', NULL),
(1395, 1, 'label_insert_all_user_to', 'specific', NULL),
(1396, 1, 'text_banner_title', 'specific', NULL),
(1397, 1, 'text_new_banner_title', 'specific', NULL),
(1398, 1, 'label_link', 'specific', NULL),
(1399, 1, 'text_banner_list_title', 'specific', NULL),
(1400, 1, 'title_order', 'specific', NULL),
(1401, 1, 'text_order_list_title', 'specific', NULL),
(1402, 1, 'label_cancel', 'specific', NULL),
(1403, 1, 'menu_stock_import', 'specific', NULL),
(1404, 1, 'button_pay_all', 'specific', NULL),
(1405, 1, 'title_import_stock', 'specific', NULL),
(1406, 1, 'text_stock_import', 'specific', NULL),
(1407, 1, 'text_stock_import_title', 'specific', NULL),
(1408, 1, 'text_export_product_of', 'specific', NULL),
(1409, 1, 'text_select_csv_file', 'specific', NULL),
(1410, 1, 'text_due_incoice', 'specific', NULL),
(1411, 1, 'error_invalid_username_or_password', 'specific', NULL),
(1412, 1, 'button_cancel', 'specific', NULL),
(1413, 1, 'error_user_group_name', 'specific', NULL),
(1414, 1, 'label_insert_content_into', 'specific', NULL),
(1415, 1, 'error_email_address_not_found', 'specific', NULL),
(1416, 1, 'text_summary_of_purchase', 'specific', 'Here\'s the summary of your purchase.'),
(1417, 1, 'text_thank_you_for_choosing', 'specific', 'Thank you for choosing '),
(1418, 1, 'text_thanks_regards', 'specific', 'Thanks with Best Regards,'),
(1419, 1, 'text_database_conf', 'specific', 'Database Configuration'),
(1420, 1, 'text_step_3_of_6', 'specific', 'Running step 3 of 6'),
(1421, 1, 'text_checklist', 'specific', 'Checklist'),
(1422, 1, 'text_verification', 'specific', 'Verification'),
(1423, 1, 'text_database', 'specific', 'Database'),
(1424, 1, 'text_timezone', 'specific', 'Timezone'),
(1425, 1, 'text_site_config', 'specific', 'Site Config'),
(1426, 1, 'text_done', 'specific', 'Done!'),
(1427, 1, 'text_hostname', 'specific', 'Hostname'),
(1428, 1, 'text_database', 'specific', 'Database'),
(1429, 1, 'text_username', 'specific', 'Username'),
(1430, 1, 'text_password', 'specific', 'Password'),
(1431, 1, 'text_port_3306', 'specific', 'Port (3306)'),
(1432, 1, 'text_install_instruction', 'specific', '*** This action may take several minutes. Please keep patience while processing this action and never close the browser. Otherwise system will not work properly. Enjoy a cup of coffee while you are waiting... :)'),
(1433, 1, 'text_prev_step', 'specific', 'Previous Step'),
(1434, 1, 'text_next_step', 'specific', 'Next Step'),
(1435, 1, 'text_footer_link', 'specific', 'https://nighan2.com'),
(1436, 1, 'text_footer_link_text', 'specific', 'nighan2labs pvt ltd'),
(1437, 1, 'text_all_right_reserved', 'specific', 'All right reserved.'),
(1438, 1, 'text_congrats_almost_done', 'specific', 'Congratulations! Almost Done... :)'),
(1439, 1, 'text_login_credentials', 'specific', 'Login Credentials'),
(1440, 1, 'text_role', 'specific', 'Role'),
(1441, 1, 'text_username', 'specific', 'Username'),
(1442, 1, 'text_password', 'specific', 'Password'),
(1443, 1, 'text_admin', 'specific', 'Admin'),
(1444, 1, 'text_cashier', 'specific', 'Cashier'),
(1445, 1, 'text_salesman', 'specific', 'Salesman'),
(1446, 1, 'text_login_now', 'specific', 'Login Now'),
(1447, 1, 'text_pre_installation_checklist', 'specific', 'Pre-Installation Checklist'),
(1448, 1, 'text_running_step_1_of_6', 'specific', 'Running step 1 of 6'),
(1449, 1, 'text_installation_instruction', 'specific', 'Please, Resolve all the warning showings in check list to proceed to next step.'),
(1450, 1, 'text_verify_purchase_code', 'specific', 'Verify Purchase Code'),
(1451, 1, 'text_running_step_2_of_6', 'specific', 'Running step 2 of 6'),
(1452, 1, 'text_envato_username', 'specific', 'Envato Username'),
(1453, 1, 'text_purchase_code', 'specific', 'Purchase Code'),
(1454, 1, 'text_select_timezone', 'specific', '-- Select Timezone --'),
(1455, 1, 'text_trx_id', 'specific', 'Trx ID'),
(1456, 1, 'text_mobile_number', 'specific', 'Mobile Number'),
(1457, 1, 'text_card_no', 'specific', 'Card No.'),
(1458, 1, 'text_expiration_date', 'specific', 'Expiration Date'),
(1459, 1, 'text_holder_name', 'specific', 'Card Holder Name'),
(1460, 1, 'text_security_code', 'specific', 'Card Security Code'),
(1461, 1, 'text_shortcut', 'specific', 'Shortcut'),
(1462, 1, 'text_description', 'specific', 'Description'),
(1463, 1, 'text_focus_product_searchbox', 'specific', 'Focus Product Searchbox'),
(1464, 1, 'text_focus_customer_searchbox', 'specific', 'Focus Customer Searchbox'),
(1465, 1, 'text_customer_add', 'specific', 'Customer Add'),
(1466, 1, 'text_focus_discount_input_field', 'specific', 'Focus Discount Input Field'),
(1467, 1, 'text_focus_tax_input_field', 'specific', 'Focus Tax Input Field'),
(1468, 1, 'text_focus_shipping_charge_field', 'specific', 'Focus Shipping Charge Field'),
(1469, 1, 'text_focus_others_charge_field', 'specific', 'Focus Others Charge Field'),
(1470, 1, 'text_holding_order', 'specific', 'Holding Order'),
(1471, 1, 'text_pay_now', 'specific', 'Pay Now'),
(1472, 1, 'text_toggle_dropdown', 'specific', 'Toggle Dropdown'),
(1473, 1, 'text_for_sell_return', 'specific', 'for sell return'),
(1474, 1, 'text_support_comment_box', 'specific', 'For any query just knock us via nighan2labs pvt ltd contact form'),
(1475, 1, 'text_email_us', 'specific', 'Email Us'),
(1476, 1, 'text_follow_us', 'specific', 'Follow Us'),
(1477, 1, 'text_contact_us', 'specific', 'Contact Us'),
(1478, 1, 'text_contact_link', 'specific', 'https://itsolution24.com/contact.php'),
(1479, 1, 'text_email_address', 'specific', 'itsolution24bd@gmail.com'),
(1480, 1, 'text_nighan2_follow_link', 'specific', 'https://nighan2.com/contact'),
(1481, 1, 'text_thank_you_for_choose', 'specific', 'Thank you for choosing us!'),
(1482, 1, 'text_quotation', 'specific', 'Quotation'),
(1483, 1, 'text_windows_instruction', 'specific', '(Local USB, Serial or Parallel Printer): Share the printer and enter the share name for your printer here or for Server Message Block (SMB): enter as a smb:// url format such as '),
(1484, 1, 'text_printer_port', 'specific', 'Most printers are open on port 9100'),
(1485, 1, 'label_cash_exchange', 'specific', 'cash/exchange'),
(1486, 1, 'label_select_deselect', 'specific', 'Select / Deselect'),
(1487, 1, 'button_delete', 'specific', 'DELETE'),
(1488, 1, 'text_restore_instruction', 'specific', 'Restoring process may take several minute to complete. Never close your browser before the process, otherwise system may break and not work properly.'),
(1489, 1, 'text_only_sql_file_accepted', 'specific', 'Only .sql file is accepted'),
(1490, 1, 'text_disabled_in_demo', 'specific', 'This feature disabled in demo.'),
(1491, 1, 'text_product_import_instruction', 'specific', 'The first line in downloaded .xls file should remain as it is. Please do not change the order of columns. Please make sure the (*.xls) file is UTF-8 encoded. The files should be uploaded in storage/products/ (or where you pointed) folder. The System will check that if a row exists then update, if not exist then insert.'),
(1492, 1, 'text_product_stock_instruction', 'specific', 'The first line in explored .csv file should remain as it is. Please do not change the order of columns. Please make sure the (*.csv) file is UTF-8 encoded. The files should be uploaded in storage/products/ (or where you pointed) folder.'),
(1493, 1, 'text_reset_done', 'specific', 'Reset Successfully done!'),
(1494, 1, 'text_back_to_dashboard', 'specific', 'Back to Dashboard'),
(1495, 1, 'text_data_reset', 'specific', 'DATA RESET'),
(1496, 1, 'text_reset_instruction', 'specific', 'You are going to reset your Modern POS. This action will delete all data that can not be restored again. If you still proceed this action then click on \'Yes\' otherwise click on \'No\' button.'),
(1497, 1, 'text_select_store', 'specific', 'SELECT STORE'),
(1498, 1, 'text_sms_info', 'specific', 'SMS sending is a time-consuming task. It may take few seconds to few minutes event several minutes to accomplished. So, It is highly recommended to configure Cronjob in Linux or Schedule a task in Windows to smooth this task.'),
(1499, 1, 'text_installation_info', 'specific', 'For local single machine installation: PHP Server will be the best choice and for live server or local server setup (LAN): you can install PHP Pos Print Server locally on each machine (recommended) or use web browser printing feature.'),
(1500, 1, 'text_retrieve_session', 'specific', 'Enter your password to retrieve your session'),
(1501, 1, 'text_sign_as_different', 'specific', 'Sign in as a different user'),
(1502, 1, 'text_resetting', 'specific', 'Resetting, Please wait...'),
(1503, 1, 'text_resetting_info', 'specific', 'System will reset modern pos data to default. Please, keep patience a bit. We are coming back in live soon!'),
(1504, 1, 'text_site_maintainance', 'specific', 'Site Maintenance'),
(1505, 1, 'error_payment_code_or_title_exist', 'specific', 'Payment code not exist'),
(1506, 1, 'menu_stock_import', 'specific', 'STOCK IMPORT'),
(1507, 1, 'error_source_name', 'specific', 'Source name not valid'),
(1508, 1, 'text_loan_details', 'specific', 'Loan details'),
(1509, 1, 'label_paid_by', 'specific', 'Paid by'),
(1510, 1, 'button_add_stock', 'specific', 'Add Stock'),
(1511, 1, 'button_stock_adjustment', 'specific', 'Stock Adjustment'),
(1512, 1, 'label_qty', 'specific', 'Qty'),
(1513, 1, 'label_returned_at', 'specific', 'Requrned At'),
(1514, 1, 'text_gst', 'specific', 'GST'),
(1515, 1, 'text_unavailable_now', 'specific', 'Unavailable now'),
(1516, 1, 'text_select_deselect', 'specific', 'select/deselect'),
(1517, 1, 'button_yes', 'specific', 'Yes'),
(1518, 1, 'button_no', 'specific', 'No'),
(1519, 1, 'label_delete_the_product', 'specific', 'Delete the product'),
(1520, 1, 'label_soft_delete_the_product', 'specific', 'Soft Delete'),
(1521, 1, 'text_delete', 'specific', 'Delete'),
(1522, 1, 'error_reference_number_exists', 'specific', 'Reference already exist'),
(1523, 1, 'error_supplier_name_exist', 'specific', 'Supplier name exist'),
(1524, 1, 'error_username', 'specific', 'Username'),
(1525, 1, 'text_invalid_purchase_code', 'specific', 'Invalid Purchase Code'),
(1526, 1, 'text_invalid_info', 'specific', 'Invalid Info'),
(1527, 1, 'text_purchase_code_revalidate_instruction', 'specific', 'Your purchase code is not valid. If you have a valid purchase code then  to revalide that or Claim a valid purchase code here:'),
(1528, 1, 'text_invalid_info', 'specific', 'Your purchase code is not valid. If you have a valid purchase code then claim a valid purchase code to itsolution24bd@gmail.com'),
(1529, 1, 'text_to_revalidate_ext', 'specific', 'to revalidate that or Claim a valid purchase code here:'),
(1530, 1, 'text_invalid_purchase_code', 'specific', 'Invalid Purchase Code!'),
(1531, 1, 'text_app_blocked', 'specific', 'App Blocked!'),
(1532, 1, 'text_max_160_ch', 'specific', 'Max character: 160'),
(1533, 1, 'text_total_people', 'specific', 'Total People'),
(1534, 4, 'title_receipt_template', 'specific', NULL),
(1535, 4, 'text_english', 'specific', NULL),
(1536, 4, 'text_arabic', 'specific', NULL),
(1537, 4, 'text_bangla', 'specific', NULL),
(1538, 4, 'text_hindi', 'specific', NULL),
(1539, 4, 'text_french', 'specific', NULL),
(1540, 4, 'text_Germany', 'specific', NULL),
(1541, 4, 'text_spanish', 'specific', NULL),
(1542, 4, 'text_pos', 'specific', NULL),
(1543, 4, 'menu_pos', 'specific', NULL),
(1544, 4, 'text_cashbook_report', 'specific', NULL),
(1545, 4, 'menu_cashbook', 'specific', NULL),
(1546, 4, 'text_invoice', 'specific', NULL),
(1547, 4, 'menu_invoice', 'specific', NULL),
(1548, 4, 'text_user_preference', 'specific', NULL),
(1549, 4, 'text_settings', 'specific', NULL),
(1550, 4, 'text_stock_alert', 'specific', NULL),
(1551, 4, 'text_itsolution24', 'specific', NULL),
(1552, 4, 'text_fullscreen', 'specific', NULL),
(1553, 4, 'text_reports', 'specific', NULL),
(1554, 4, 'text_lockscreen', 'specific', NULL),
(1555, 4, 'text_logout', 'specific', NULL),
(1556, 4, 'menu_dashboard', 'specific', NULL),
(1557, 4, 'menu_point_of_sell', 'specific', NULL),
(1558, 4, 'menu_sell', 'specific', NULL),
(1559, 4, 'menu_sell_list', 'specific', NULL),
(1560, 4, 'menu_return_list', 'specific', NULL),
(1561, 4, 'menu_sell_log', 'specific', NULL),
(1562, 4, 'menu_giftcard', 'specific', NULL),
(1563, 4, 'menu_add_giftcard', 'specific', NULL),
(1564, 4, 'menu_giftcard_list', 'specific', NULL),
(1565, 4, 'menu_giftcard_topup', 'specific', NULL),
(1566, 4, 'menu_quotation', 'specific', NULL),
(1567, 4, 'menu_add_quotation', 'specific', NULL),
(1568, 4, 'menu_quotation_list', 'specific', NULL),
(1569, 4, 'menu_installment', 'specific', NULL),
(1570, 4, 'menu_installment_list', 'specific', NULL),
(1571, 4, 'menu_payment_list', 'specific', NULL),
(1572, 4, 'menu_payment_due_today', 'specific', NULL),
(1573, 4, 'menu_payment_due_all', 'specific', NULL),
(1574, 4, 'menu_payment_due_expired', 'specific', NULL),
(1575, 4, 'menu_overview_report', 'specific', NULL),
(1576, 4, 'menu_purchase', 'specific', NULL),
(1577, 4, 'menu_add_purchase', 'specific', NULL),
(1578, 4, 'menu_purchase_list', 'specific', NULL),
(1579, 4, 'menu_due_invoice', 'specific', NULL),
(1580, 4, 'menu_purchase_logs', 'specific', NULL),
(1581, 4, 'menu_stock_import', 'specific', NULL),
(1582, 4, 'menu_transfer', 'specific', NULL),
(1583, 4, 'menu_add_transfer', 'specific', NULL),
(1584, 4, 'menu_transfer_list', 'specific', NULL),
(1585, 4, 'menu_receive_list', 'specific', NULL),
(1586, 4, 'menu_product', 'specific', NULL),
(1587, 4, 'menu_product_list', 'specific', NULL),
(1588, 4, 'menu_add_product', 'specific', NULL),
(1589, 4, 'menu_barcode_print', 'specific', NULL),
(1590, 4, 'menu_category', 'specific', NULL),
(1591, 4, 'menu_add_category', 'specific', NULL),
(1592, 4, 'menu_product_import', 'specific', NULL),
(1593, 4, 'menu_stock_alert', 'specific', NULL),
(1594, 4, 'menu_customer', 'specific', NULL),
(1595, 4, 'menu_add_customer', 'specific', NULL),
(1596, 4, 'menu_customer_list', 'specific', NULL),
(1597, 4, 'menu_supplier', 'specific', NULL),
(1598, 4, 'menu_add_supplier', 'specific', NULL),
(1599, 4, 'menu_supplier_list', 'specific', NULL),
(1600, 4, 'menu_accounting', 'specific', NULL),
(1601, 4, 'menu_new_deposit', 'specific', NULL),
(1602, 4, 'menu_new_withdraw', 'specific', NULL),
(1603, 4, 'menu_list_transactions', 'specific', NULL),
(1604, 4, 'menu_new_transfer', 'specific', NULL),
(1605, 4, 'menu_list_transfer', 'specific', NULL),
(1606, 4, 'menu_add_bank_account', 'specific', NULL),
(1607, 4, 'menu_bank_accounts', 'specific', NULL),
(1608, 4, 'menu_income_source', 'specific', NULL),
(1609, 4, 'menu_balance_sheet', 'specific', NULL),
(1610, 4, 'menu_income_monthwise', 'specific', NULL),
(1611, 4, 'menu_expense_monthwise', 'specific', NULL),
(1612, 4, 'menu_income_and_expense', 'specific', NULL),
(1613, 4, 'menu_profit_and_loss', 'specific', NULL),
(1614, 4, 'menu_expenditure', 'specific', NULL),
(1615, 4, 'menu_create_expense', 'specific', NULL),
(1616, 4, 'menu_expense_list', 'specific', NULL),
(1617, 4, 'menu_summary', 'specific', NULL),
(1618, 4, 'menu_loan_manager', 'specific', NULL),
(1619, 4, 'menu_loan_list', 'specific', NULL),
(1620, 4, 'menu_take_loan', 'specific', NULL),
(1621, 4, 'menu_loan_summary', 'specific', NULL),
(1622, 4, 'menu_reports', 'specific', NULL),
(1623, 4, 'menu_report_overview', 'specific', NULL),
(1624, 4, 'menu_report_collection', 'specific', NULL),
(1625, 4, 'menu_report_due_collection', 'specific', NULL),
(1626, 4, 'menu_report_due_paid', 'specific', NULL),
(1627, 4, 'menu_sell_report', 'specific', NULL),
(1628, 4, 'menu_purchase_report', 'specific', NULL),
(1629, 4, 'menu_sell_payment_report', 'specific', NULL),
(1630, 4, 'menu_purchase_payment_report', 'specific', NULL),
(1631, 4, 'menu_tax_report', 'specific', NULL),
(1632, 4, 'menu_purchase_tax_report', 'specific', NULL),
(1633, 4, 'menu_tax_overview_report', 'specific', NULL),
(1634, 4, 'menu_report_stock', 'specific', NULL),
(1635, 4, 'menu_analytics', 'specific', NULL),
(1636, 4, 'menu_sms', 'specific', NULL),
(1637, 4, 'menu_send_sms', 'specific', NULL),
(1638, 4, 'menu_sms_report', 'specific', NULL),
(1639, 4, 'menu_sms_setting', 'specific', NULL),
(1640, 4, 'menu_user', 'specific', NULL),
(1641, 4, 'menu_add_user', 'specific', NULL),
(1642, 4, 'menu_user_list', 'specific', NULL),
(1643, 4, 'menu_add_usergroup', 'specific', NULL),
(1644, 4, 'menu_usergroup_list', 'specific', NULL),
(1645, 4, 'menu_password', 'specific', NULL),
(1646, 4, 'menu_filemanager', 'specific', NULL),
(1647, 4, 'menu_system', 'specific', NULL),
(1648, 4, 'menu_store', 'specific', NULL),
(1649, 4, 'menu_create_store', 'specific', NULL),
(1650, 4, 'menu_store_list', 'specific', NULL),
(1651, 4, 'menu_store_setting', 'specific', NULL),
(1652, 4, 'menu_receipt_template', 'specific', NULL),
(1653, 4, 'menu_user_preference', 'specific', NULL),
(1654, 4, 'menu_brand', 'specific', NULL),
(1655, 4, 'menu_add_brand', 'specific', NULL),
(1656, 4, 'menu_brand_list', 'specific', NULL),
(1657, 4, 'menu_currency', 'specific', NULL),
(1658, 4, 'menu_pmethod', 'specific', NULL),
(1659, 4, 'menu_unit', 'specific', NULL),
(1660, 4, 'menu_taxrate', 'specific', NULL),
(1661, 4, 'menu_box', 'specific', NULL),
(1662, 4, 'menu_printer', 'specific', NULL),
(1663, 4, 'menu_language', 'specific', NULL),
(1664, 4, 'menu_backup_restore', 'specific', NULL),
(1665, 4, 'menu_data_reset', 'specific', NULL),
(1666, 4, 'menu_store_change', 'specific', NULL),
(1667, 4, 'text_receipt_tempalte_title', 'specific', NULL),
(1668, 4, 'text_dashboard', 'specific', NULL),
(1669, 4, 'title_pos_setting', 'specific', NULL),
(1670, 4, 'text_receipt_template', 'specific', NULL),
(1671, 4, 'text_receipt_tempalte_sub_title', 'specific', NULL),
(1672, 4, 'button_preview', 'specific', NULL),
(1673, 4, 'text_tempalte_content_title', 'specific', NULL),
(1674, 4, 'text_tempalte_css_title', 'specific', NULL),
(1675, 4, 'text_template_tags', 'specific', NULL),
(1676, 4, 'placeholder_search_here', 'specific', NULL),
(1677, 4, 'text_version', 'specific', NULL),
(1678, 4, 'button_today', 'specific', NULL),
(1679, 4, 'button_last_7_days', 'specific', NULL),
(1680, 4, 'button_last_30_days', 'specific', NULL),
(1681, 4, 'button_last_365_days', 'specific', NULL),
(1682, 4, 'button_filter', 'specific', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `loan_id` int(10) UNSIGNED NOT NULL,
  `ref_no` varchar(50) NOT NULL,
  `loan_from` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` decimal(25,4) UNSIGNED NOT NULL,
  `interest` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payable` decimal(25,4) UNSIGNED NOT NULL,
  `paid` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `due` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `details` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_payments`
--

CREATE TABLE `loan_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `lloan_id` int(10) UNSIGNED NOT NULL,
  `ref_no` varchar(50) DEFAULT NULL,
  `paid` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `status` enum('success','error') NOT NULL DEFAULT 'success',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `username`, `ip`, `status`, `created_at`) VALUES
(1, 1, 'mokashihanama@gmail.com', '::1', 'success', '2025-07-03 08:46:41');

-- --------------------------------------------------------

--
-- Table structure for table `mail_sms_tag`
--

CREATE TABLE `mail_sms_tag` (
  `tag_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `tagname` varchar(128) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `mail_sms_tag`
--

INSERT INTO `mail_sms_tag` (`tag_id`, `type`, `tagname`, `created_at`) VALUES
(1, 'invoice', '[customer_name]', '2025-07-03 08:43:17'),
(2, 'invoice', '[payable_amount]', '2025-07-03 08:43:17'),
(3, 'invoice', '[paid_amount]', '2025-07-03 08:43:17'),
(4, 'invoice', '[due]', '2025-07-03 08:43:17'),
(5, 'invoice', '[store_name]', '2025-07-03 08:43:17'),
(6, 'invoice', '[payment_status]', '2025-07-03 08:43:17'),
(7, 'invoice', '[customer_mobile]', '2025-07-03 08:43:17'),
(8, 'invoice', '[payment_method]', '2025-07-03 08:43:17'),
(9, 'invoice', '[date_time]', '2025-07-03 08:43:17'),
(10, 'invoice', '[date]', '2025-07-03 08:43:17'),
(11, 'invoice', '[tax]', '2025-07-03 08:43:17'),
(12, 'invoice', '[discount]', '2025-07-03 08:43:17'),
(13, 'invoice', '[address]', '2025-07-03 08:43:17'),
(14, 'invoice', '[invoice_id]', '2025-07-03 08:43:17'),
(15, 'invoice', '[invoice_id]', '2025-07-03 08:43:17');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'sell',
  `is_profit` tinyint(1) NOT NULL DEFAULT 1,
  `is_hide` tinyint(1) NOT NULL DEFAULT 0,
  `store_id` int(10) UNSIGNED NOT NULL,
  `invoice_id` varchar(100) DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `pmethod_id` int(10) UNSIGNED DEFAULT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `capital` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `details` text DEFAULT NULL,
  `attachment` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `total_paid` decimal(25,4) DEFAULT 0.0000,
  `pos_balance` decimal(25,4) DEFAULT 0.0000,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pmethods`
--

CREATE TABLE `pmethods` (
  `pmethod_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `code_name` varchar(50) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pmethods`
--

INSERT INTO `pmethods` (`pmethod_id`, `name`, `code_name`, `details`, `created_at`, `updated_at`) VALUES
(1, 'Cash on Delivery', 'cod', 'Payment method details goes here...', '2025-07-03 08:43:17', '2025-07-03 08:43:17'),
(2, 'Bkash', 'bkash', 'Bkash a Brack Bank Service', '2025-07-03 08:43:17', '2025-07-03 08:43:17'),
(3, 'Gift card', 'gift_card', 'Details of giftcard payment method', '2025-07-03 08:43:17', '2025-07-03 08:43:17'),
(4, 'Credit', 'credit', 'Payment by customer credited balance', '2025-07-03 08:43:17', '2025-07-03 08:43:17'),
(5, 'UPI Payment', 'upi', 'Payment through UPI (Unified Payments Interface) with dynamic QR code', '2025-07-03 08:43:17', '2025-07-03 08:43:17');

-- --------------------------------------------------------

--
-- Table structure for table `pmethod_to_store`
--

CREATE TABLE `pmethod_to_store` (
  `p2s_id` int(11) NOT NULL,
  `ppmethod_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pmethod_to_store`
--

INSERT INTO `pmethod_to_store` (`p2s_id`, `ppmethod_id`, `store_id`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 1, 1, 2),
(4, 4, 1, 1, 4),
(5, 3, 1, 1, 3),
(9, 5, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pos_register`
--

CREATE TABLE `pos_register` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `opening_balance` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `closing_balance` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `note` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pos_templates`
--

CREATE TABLE `pos_templates` (
  `template_id` int(11) NOT NULL,
  `template_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `template_content` longtext CHARACTER SET ucs2 COLLATE ucs2_general_ci NOT NULL,
  `template_css` longtext CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pos_templates`
--

INSERT INTO `pos_templates` (`template_id`, `template_name`, `template_content`, `template_css`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'Default', '&lt;section class=&quot;receipt-template&quot;&gt;\n\n        &lt;header class=&quot;receipt-header&quot;&gt;\n            &lt;div class=&quot;logo-area&quot;&gt;\n                &lt;img class=&quot;logo&quot; src=&quot;{{ logo_url }}&quot;&gt;\n            &lt;/div&gt;\n            &lt;h2 class=&quot;store-name&quot;&gt;{{ store_name }}&lt;/h2&gt;\n            &lt;div class=&quot;address-area&quot;&gt;\n                &lt;span class=&quot;info address&quot;&gt;{{ store_address }}&lt;/span&gt;\n                &lt;div class=&quot;block&quot;&gt;\n                    &lt;span class=&quot;info phone&quot;&gt;Mobile: {{ store_phone }}&lt;/span&gt;, &lt;span class=&quot;info email&quot;&gt;Email: {{ store_email }}&lt;/span&gt;\n                &lt;/div&gt;\n            &lt;/div&gt;\n        &lt;/header&gt;\n        \n        &lt;section class=&quot;info-area&quot;&gt;\n            &lt;table&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;&lt;span&gt;Invoice ID:&lt;/td&gt;\n                    &lt;td&gt;{{ invoice_id }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;VAT-Reg:&lt;/td&gt;\n                    &lt;td&gt;{{ vat_reg }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;&lt;span&gt;Date:&lt;/td&gt;\n                    &lt;td&gt;{{ date_time }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;&lt;span&gt;GST Reg:&lt;/td&gt;\n                    &lt;td&gt;{{ gst_reg }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;Customer Name:&lt;/td&gt;\n                    &lt;td&gt;{{ customer_name }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;Phone:&lt;/td&gt;\n                    &lt;td&gt;{{ customer_phone }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;Address:&lt;/td&gt;\n                    &lt;td&gt;{{ customer_address }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-30&quot;&gt;GTIN:&lt;/td&gt;\n                    &lt;td&gt;{{ gtin }}&lt;/td&gt;\n                &lt;/tr&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        \n        &lt;h4 class=&quot;main-title&quot;&gt;INVOICE&lt;/h4&gt;\n        \n        {{ if items }}\n        &lt;section class=&quot;listing-area item-list&quot;&gt;\n            &lt;table&gt;\n                &lt;thead&gt;\n                    &lt;tr&gt;\n                        &lt;td class=&quot;w-10 text-center&quot;&gt;Sl.&lt;/td&gt;\n                        &lt;td class=&quot;w-40 text-center&quot;&gt;Name&lt;/td&gt;\n                        &lt;td class=&quot;w-15 text-center&quot;&gt;Qty&lt;/td&gt;\n                        &lt;td class=&quot;w-15 text-right&quot;&gt;Price&lt;/td&gt;\n                        &lt;td class=&quot;w-20 text-right&quot;&gt;Amount&lt;/td&gt;\n                    &lt;/tr&gt;\n                &lt;/thead&gt;\n                &lt;tbody&gt;\n                    {{ items }}\n                        &lt;tr&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ sl }}&lt;/td&gt;\n                            &lt;td&gt;{{ item_name }} \n                                {{ if invoice_view == indian_gst }} \n                                    &lt;small&gt;[HSN-{{ hsn_code }}]&lt;/small&gt;\n                                {{ endif }}\n                            &lt;/td&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ item_quantity }} {{ unitName }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_price }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_total }}&lt;/td&gt;   \n                        &lt;/tr&gt;\n                    {{ /items }}\n                &lt;/tbody&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        {{ endif }}\n        \n        &lt;section class=&quot;info-area calculation-area&quot;&gt;\n            &lt;table&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Total Amt:&lt;/td&gt;\n                    &lt;td&gt;{{ subtotal }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Order Tax:&lt;/td&gt;\n                    &lt;td&gt;{{ order_tax }}&lt;/td&gt;\n                &lt;/tr&gt;\n                {{ if invoice_view == \'indian_gst\' }}\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;CGST:&lt;/td&gt;\n                    &lt;td&gt;{{ cgst }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;SGST:&lt;/td&gt;\n                    &lt;td&gt;{{ sgst }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;IGST:&lt;/td&gt;\n                    &lt;td&gt;{{ igst }}&lt;/td&gt;\n                &lt;/tr&gt;\n                {{ endif }}\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Discount:&lt;/td&gt;\n                    &lt;td&gt;{{ discount_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Shipping Chrg:&lt;/td&gt;\n                    &lt;td&gt;{{ shipping_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Others Chrg:&lt;/td&gt;\n                    &lt;td&gt;{{ others_charge }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Previous Due:&lt;/td&gt;\n                    &lt;td&gt;{{ previous_due }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Total Due:&lt;/td&gt;\n                    &lt;td&gt;{{ payable_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Amount Paid:&lt;/td&gt;\n                    &lt;td&gt;{{ paid_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Prev. Due Paid:&lt;/td&gt;\n                    &lt;td&gt;{{ prev_due_paid }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Change:&lt;/td&gt;\n                    &lt;td&gt;{{ change }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Due:&lt;/td&gt;\n                    &lt;td&gt;{{ due }}&lt;/td&gt;\n                &lt;/tr&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        \n        &lt;section class=&quot;info-area italic&quot;&gt;\n            &lt;span class=&quot;text-small&quot;&gt;&lt;b&gt;In Text:&lt;/b&gt; {{ amount_in_text }}&lt;/span&gt;&lt;br&gt;\n            {{ if invoice_note }}\n                &lt;span class=&quot;text-small&quot;&gt;&lt;b&gt;Note:&lt;/b&gt; {{ invoice_note }}&lt;/span&gt;\n            {{ endif }}\n        &lt;/section&gt;\n\n        {{ if return_items }}\n        &lt;section class=&quot;listing-area payment-list&quot;&gt;\n            &lt;div class=&quot;heading&quot;&gt;\n                &lt;h2 class=&quot;sub-title&quot;&gt;Returns&lt;/h2&gt;\n            &lt;/div&gt;\n            &lt;table&gt;\n                &lt;thead&gt;\n                    &lt;td class=&quot;w-5 text-center&quot;&gt;Sl.&lt;/td&gt;\n                    &lt;td class=&quot;w-25 text-center&quot;&gt;Returned at&lt;/td&gt;\n                    &lt;td class=&quot;w-30 text-center&quot;&gt;Item Name&lt;/td&gt;\n                    &lt;td class=&quot;w-20 text-right&quot;&gt;Qty&lt;/td&gt;\n                    &lt;td class=&quot;w-20 text-right&quot;&gt;Amt&lt;/td&gt;\n                &lt;/thead&gt;\n                &lt;tbody&gt;\n                    {{return_items}}\n                        &lt;tr&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ sl }}&lt;/td&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ created_at }}&lt;/td&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ item_name }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_quantity }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_total }}&lt;/td&gt; \n                        &lt;/tr&gt;\n                    {{/return_items}}\n                &lt;/tbody&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        {{ endif }}\n        \n        {{ if payments }}\n        &lt;section class=&quot;listing-area payment-list&quot;&gt;\n            &lt;div class=&quot;heading&quot;&gt;\n                &lt;h2 class=&quot;sub-title&quot;&gt;Payments&lt;/h2&gt;\n            &lt;/div&gt;\n            &lt;table&gt;\n                &lt;thead&gt;\n                    &lt;td class=&quot;w-10 text-center&quot;&gt;Sl.&lt;/td&gt;\n                    &lt;td class=&quot;w-50 text-center&quot;&gt;Payment Method&lt;/td&gt;\n                    &lt;td class=&quot;w-20 text-right&quot;&gt;Amount&lt;/td&gt;\n                    &lt;td class=&quot;w-20 text-right&quot;&gt;Balance&lt;/td&gt;\n                &lt;/thead&gt;\n                &lt;tbody&gt;\n                    {{ payments }}\n                        &lt;tr&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ sl }}&lt;/td&gt;\n                            &lt;td&gt;{{ name }} by {{ by }} on {{ created_at }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ amount }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ pos_balance }}&lt;/td&gt; \n                        &lt;/tr&gt;\n                    {{ /payments }}\n                &lt;/tbody&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        {{ endif }}\n           \n        {{ if invoice_view != \'standard\' }}\n        {{ if taxes }}\n        &lt;section class=&quot;listing-area payment-list&quot;&gt;\n            &lt;div class=&quot;heading&quot;&gt;\n                &lt;h2 class=&quot;sub-title&quot;&gt;Tax Information&lt;/h2&gt;\n            &lt;/div&gt;\n            &lt;table&gt;\n                &lt;thead&gt;\n                    &lt;td class=&quot;w-25&quot;&gt;Name&lt;/td&gt;\n                    &lt;td class=&quot;w-25 text-center&quot;&gt;Code&lt;/td&gt;\n                    &lt;td class=&quot;w-25 text-right&quot;&gt;Qty&lt;/td&gt;\n                    &lt;td class=&quot;w-25 text-right&quot;&gt;Tax Amt.&lt;/td&gt;\n                &lt;/thead&gt;\n                &lt;tbody&gt;\n                    {{ taxes }}\n                        &lt;tr&gt;\n                            &lt;td&gt;{{ taxrate_name }}&lt;/td&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ code_name }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ qty }}&lt;/td&gt; \n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_tax }}&lt;/td&gt; \n                        &lt;/tr&gt;\n                    {{ /taxes }}\n                    {{ if invoice_view == \'indian_gst\' }}\n                        &lt;tr class=&quot;bg-gray&quot;&gt;\n                            &lt;td&gt;Order Tax: {{ order_tax }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;CGST: {{ cgst }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;SGST: {{ sgst }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;IGST: {{ igst }}&lt;/td&gt;\n                        &lt;/tr&gt;\n                     {{ endif }}\n                &lt;/tbody&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        {{ endif }}\n        {{ endif }}\n        \n        {{ if barcode }}\n        &lt;section class=&quot;info-area barcode-area&quot;&gt;\n            {{ barcode }}\n        &lt;/section&gt;\n        {{ endif }}\n        \n        &lt;section class=&quot;info-area align-center footer-area&quot;&gt;\n            &lt;span class=&quot;block&quot;&gt;Sold product No Claim. No Change, New product One Month Warranty.&lt;/span&gt;\n            &lt;span class=&quot;block bold&quot;&gt;{{ footer_text }}&lt;/span&gt;\n        &lt;/section&gt;\n        \n &lt;/section&gt;', '/*Common CSS*/\n        .receipt-template {\n            width:302px;\n            margin:0 auto;\n        }\n        .receipt-template .text-small {\n            font-size: 10px;\n        }\n        .receipt-template .block {\n            display: block;\n        }\n        .receipt-template .inline-block {\n            display: inline-block;\n        }\n        .receipt-template .bold {\n            font-weight: 700;\n        }\n        .receipt-template .italic {\n            font-style: italic;\n        }\n        .receipt-template .align-right {\n            text-align: right;\n        }\n        .receipt-template .align-center {\n            text-align: center;\n        }\n        .receipt-template .main-title {\n            font-size: 14px;\n            font-weight: 700;\n            text-align: center;\n            margin: 10px 0 5px 0;\n            padding: 0;\n        }\n        .receipt-template .heading {\n            position: relation;\n        }\n        .receipt-template .title {\n            font-size: 16px;\n            font-weight: 700;\n            margin: 10px 0 5px 0;\n        }\n        .receipt-template .sub-title {\n            font-size: 12px;\n            font-weight: 700;\n            margin: 10px 0 5px 0;\n        }\n        .receipt-template table {\n            width: 100%;\n        }\n        .receipt-template td,\n        .receipt-template th {\n            font-size:12px;\n        }\n        .receipt-template .info-area {\n            font-size: 12px;      \n            line-height: 1.222;  \n        }\n        .receipt-template .listing-area {\n            line-height: 1.222;\n        }\n        .receipt-template .listing-area table {}\n        .receipt-template .listing-area table thead tr {\n            border-top: 1px solid #000;\n            border-bottom: 1px solid #000;\n            font-weight: 700;\n        }\n        .receipt-template .listing-area table tbody tr {\n            border-top: 1px dashed #000;\n            border-bottom: 1px dashed #000;\n        }\n        .receipt-template .listing-area table tbody tr:last-child {\n            border-bottom: none;\n        }\n        .receipt-template .listing-area table td {\n            vertical-align: top;\n        }\n        .receipt-template .info-area table {}\n        .receipt-template .info-area table thead tr {\n            border-top: 1px solid #000;\n            border-bottom: 1px solid #000;\n        }\n    \n /*Receipt Heading*/\n        .receipt-template .receipt-header {\n            text-align: center;\n        }\n        .receipt-template .receipt-header .logo-area {\n            width: 80px;\n            height: 80px;\n            margin: 0 auto;\n        }\n        .receipt-template .receipt-header .logo-area img.logo {\n            display: inline-block;\n            max-width: 100%;\n            max-height: 100%;\n        }\n        .receipt-template .receipt-header .address-area {\n            margin-bottom: 5px;\n            line-height: 1;\n        }\n        .receipt-template .receipt-header .info {\n            font-size: 12px;\n        }\n        .receipt-template .receipt-header .store-name {\n            font-size: 24px;\n            font-weight: 700;\n            margin: 0;\n            padding: 0;\n        }\n        \n        \n/*Invoice Info Area*/ \n    .receipt-template .invoice-info-area {}\n    \n/*Customer Customer Area*/\n    .receipt-template .customer-area {\n        margin-top:10px;\n    }\n\n/*Calculation Area*/\n    .receipt-template .calculation-area {\n        border-top: 2px solid #000;\n        font-weight: bold;\n    }\n    .receipt-template .calculation-area table td {\n        text-align: right;\n    }\n    .receipt-template .calculation-area table td:nth-child(2) {\n        border-bottom: 1px dashed #000;\n    }\n\n/*Item Listing*/\n    .receipt-template .item-list table tr {\n    }\n    \n/*Barcode Area*/\n    .receipt-template .barcode-area {\n        margin-top: 10px;\n        text-align: center;\n    }\n    .receipt-template .barcode-area img {\n        max-width: 100%;\n        display: inline-block;\n    }\n    \n/*Footer Area*/\n    .receipt-template .footer-area {\n        line-height: 1.222;\n        font-size: 10px;\n    }\n \n/*Media Query*/\n    @media print {\n        .receipt-template {\n            width: 100%;\n        }\n    }\n    @media all and (max-width: 215px) {}', '2025-07-03 08:43:17', '2025-07-03 08:43:17', 1),
(2, 'Minimal', '&lt;section class=&quot;receipt-template&quot;&gt;\n\n        &lt;header class=&quot;receipt-header&quot;&gt;\n            &lt;div class=&quot;logo-area&quot;&gt;\n                &lt;img class=&quot;logo&quot; src=&quot;{{  logo_url  }}&quot;&gt;\n            &lt;/div&gt;\n            &lt;h2 class=&quot;store-name&quot;&gt;{{ store_name }}&lt;/h2&gt;\n            &lt;div class=&quot;address-area&quot;&gt;\n                &lt;span class=&quot;info address&quot;&gt;{{ store_address }}&lt;/span&gt;\n                &lt;div class=&quot;block&quot;&gt;\n                    &lt;span class=&quot;info phone&quot;&gt;Mobile: {{ store_phone }}&lt;/span&gt;, &lt;span class=&quot;info email&quot;&gt;Email: {{ store_email }}&lt;/span&gt;\n                &lt;/div&gt;\n            &lt;/div&gt;\n        &lt;/header&gt;\n        \n        &lt;div class=&quot;heading&quot;&gt;\n            &lt;h2 class=&quot;title text-center zero-around title-lg&quot;&gt;INVOICE&lt;/h2&gt;\n        &lt;/div&gt;\n        \n        &lt;section class=&quot;info-area&quot;&gt;\n            &lt;table&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-10&quot;&gt;&lt;span&gt;Bill #:&lt;/td&gt;\n                    &lt;td class=&quot;w-40 text-center sinfo billno&quot;&gt;&lt;span&gt;{{ invoice_id }}&lt;/span&gt;&lt;/td&gt;\n                    &lt;td class=&quot;w-10 text-right&quot;&gt;&lt;span&gt;Date:&lt;/td&gt;\n                    &lt;td class=&quot;w-40 text-center sinfo date&quot;&gt;&lt;span&gt;{{ date_time }}&lt;/span&gt;&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-10&quot;&gt;M/S:&lt;/td&gt;\n                    &lt;td class=&quot;w-90&quot; colspan=&quot;3&quot;&gt;&lt;span class=&quot;text-lg&quot;&gt;{{ customer_name }}&lt;/span&gt;&lt;/td&gt;\n                &lt;/tr&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        \n        &lt;section class=&quot;listing-area item-list&quot;&gt;\n            &lt;table&gt;\n                &lt;thead&gt;\n                    &lt;tr&gt;\n                        &lt;td class=&quot;w-40 text-center&quot;&gt;DESC.&lt;/td&gt;\n                        &lt;td class=&quot;w-15 text-center&quot;&gt;Qty&lt;/td&gt;\n                        &lt;td class=&quot;w-15 text-right&quot;&gt;Price&lt;/td&gt;\n                        &lt;td class=&quot;w-20 text-right&quot;&gt;AMT&lt;/td&gt;\n                    &lt;/tr&gt;\n                &lt;/thead&gt;\n                &lt;tbody&gt;\n                    {{ items }}\n                        &lt;tr&gt;\n                            &lt;td&gt;{{ item_name }}&lt;/td&gt;\n                            &lt;td class=&quot;text-center&quot;&gt;{{ item_quantity }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_price }}&lt;/td&gt;\n                            &lt;td class=&quot;text-right&quot;&gt;{{ item_total }}&lt;/td&gt;   \n                        &lt;/tr&gt;\n                    {{ /items }}\n                &lt;/tbody&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        \n        &lt;section class=&quot;info-area calculation-area&quot;&gt;\n            &lt;table&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Subtotal:&lt;/td&gt;\n                    &lt;td&gt;{{ subtotal }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Order Tax:&lt;/td&gt;\n                    &lt;td&gt;{{ order_tax }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Discount:&lt;/td&gt;\n                    &lt;td&gt;{{ discount_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Shipping Chrg:&lt;/td&gt;\n                    &lt;td&gt;{{ shipping_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Others Chrg:&lt;/td&gt;\n                    &lt;td&gt;{{ others_charge }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Previous Due:&lt;/td&gt;\n                    &lt;td&gt;{{ previous_due }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Amount Total:&lt;/td&gt;\n                    &lt;td&gt;{{ payable_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Amount Paid:&lt;/td&gt;\n                    &lt;td&gt;{{ paid_amount }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Due:&lt;/td&gt;\n                    &lt;td&gt;{{ due }}&lt;/td&gt;\n                &lt;/tr&gt;\n                &lt;tr&gt;\n                    &lt;td class=&quot;w-70&quot;&gt;Change:&lt;/td&gt;\n                    &lt;td&gt;{{ change }}&lt;/td&gt;\n                &lt;/tr&gt;\n            &lt;/table&gt;\n        &lt;/section&gt;\n        \n        &lt;section class=&quot;stylish-footer text-center&quot;&gt;\n            &lt;span&gt;Printed On: {{ printed_on }}&lt;/span&gt;\n        &lt;/section&gt;\n        \n        &lt;section class=&quot;info-area align-center footer-area&quot;&gt;\n            &lt;span class=&quot;block&quot;&gt;Sold product No Claim. No Change, New product One Month Warranty.&lt;/span&gt;\n            &lt;span class=&quot;block bold&quot;&gt;Thank You for Choosing Us.&lt;/span&gt;\n        &lt;/section&gt;\n        \n &lt;/section&gt;', '/*Common CSS*/\n        .receipt-template {\n            width:302px;\n            margin:0 auto;\n        }\n        .receipt-template .text-small {\n            font-size: 10px;\n        }\n        .receipt-template .block {\n            display: block;\n        }\n        .receipt-template .inline-block {\n            display: inline-block;\n        }\n        .receipt-template .bold {\n            font-weight: 700;\n        }\n        .receipt-template .italic {\n            font-style: italic;\n        }\n        .receipt-template .align-right {\n            text-align: right;\n        }\n        .receipt-template .align-center {\n            text-align: center;\n        }\n        .receipt-template .heading {\n            position: relation;\n        }\n        .receipt-template .title {\n            font-size: 16px;\n            font-weight: 700;\n            margin: 10px 0 5px 0;\n        }\n        .receipt-template .sub-title {\n            font-size: 12px;\n            font-weight: 700;\n            margin: 10px 0 5px 0;\n        }\n        .receipt-template table {\n            width: 100%;\n        }\n        .receipt-template td,\n        .receipt-template th {\n            font-size:10px;\n        }\n        .receipt-template .info-area {\n            font-size: 12px;      \n            line-height: 1.222;  \n        }\n        .receipt-template .listing-area {\n            line-height: 1.222;\n        }\n        .receipt-template .listing-area table {}\n        .receipt-template .listing-area table thead tr {\n            border-top: 1px solid #000;\n            border-bottom: 1px solid #000;\n            font-weight: 700;\n        }\n        .receipt-template .listing-area table tbody tr {\n            border-top: 1px dashed #000;\n            border-bottom: 1px dashed #000;\n        }\n        .receipt-template .listing-area table tbody tr:last-child {\n            border-bottom: none;\n        }\n        .receipt-template .listing-area table td {\n            vertical-align: top;\n        }\n        .receipt-template .info-area table {}\n        .receipt-template .info-area table thead tr {\n            border-top: 1px solid #000;\n            border-bottom: 1px solid #000;\n        }\n\n /*Receipt Heading*/\n        .receipt-template .receipt-header {\n            text-align: center;\n        }\n        .receipt-template .receipt-header .logo-area {\n            width: 80px;\n            height: 80px;\n            margin: 0 auto;\n        }\n        .receipt-template .receipt-header .logo-area img.logo {\n            display: inline-block;\n            max-width: 100%;\n            max-height: 100%;\n        }\n        .receipt-template .receipt-header .address-area {\n            margin-bottom: 5px;\n            line-height: 1;\n        }\n        .receipt-template .receipt-header .info {\n            font-size: 12px;\n        }\n        .receipt-template .receipt-header .store-name {\n            font-size: 28px;\n            font-weight: 700;\n            margin: 0;\n            padding: 0;\n        }\n        \n        \n/*Invoice Info Area*/ \n    .receipt-template .invoice-info-area {}\n    \n/*Customer Info Area*/\n    .receipt-template .customer-area {\n        margin-top:10px;\n    }\n\n/*Calculation Area*/\n    .receipt-template .calculation-area {\n        border-top: 2px solid #000;\n    }\n    .receipt-template .calculation-area table td {\n        text-align: right;\n    }\n    .receipt-template .calculation-area table td:nth-child(2) {\n        border-bottom: 1px dashed #000;\n    }\n\n/*Item Listing*/\n    .receipt-template .item-list table tr {\n    }\n    \n/*Barcode Area*/\n    .receipt-template .barcode-area {\n        margin-top: 10px;\n        text-align: center;\n    }\n    .receipt-template .barcode-area img {\n        max-width: 100%;\n        display: inline-block;\n    }\n    \n/*Footer Area*/\n    .receipt-template .footer-area {\n        line-height: 1.222;\n        font-size: 10px;\n    }\n \n/*Media Query*/\n    @media print {\n        .receipt-template {\n            width: 100%;\n        }\n    }\n    @media all and (max-width: 215px) {}\n    \n    \n/* Additional */\n        .receipt-template .zero-around {\n            margin:0;\n            padding: 0;\n        }\n        .receipt-template .title-lg {\n            font-size: 18px!important;\n            margin-bottom: 5px;\n         }\n         .receipt-template .text-lg {\n             font-size: 18px;\n             font-weight: 700;\n         }\n         .receipt-template .info-area td {\n             vertical-align: center;\n         }\n         .receipt-template .info-area td.sinfo {\n             padding: 1px!important;\n         }\n         .receipt-template .info-area td.sinfo span {\n             display: block;\n             font-weight: 700;\n             border: 1px solid #000;\n             padding: 2px;\n         }\n         .receipt-template .listing-area td, .receipt-template .listing-area th, .receipt-template .calculation-area table td {\n             font-size: 13px;\n             font-weight: 700;\n         }\n         .receipt-template .item-list table thead td {\n             text-align: center;\n             padding: 3px;\n             border: 2px solid #000;\n          }\n          .receipt-template .stylish-footer {\n              margin: 10px 0 5px 0;\n          }\n          .receipt-template .stylish-footer span {\n              display: inline-block;\n              font-size: 12px;\n              border-top: 1px dashed #000;\n              border-bottom: 1px dashed #000; \n          }\n', '2025-07-03 08:43:17', '2025-07-03 08:43:17', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pos_template_to_store`
--

CREATE TABLE `pos_template_to_store` (
  `pt2s` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `ttemplate_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pos_template_to_store`
--

INSERT INTO `pos_template_to_store` (`pt2s`, `store_id`, `ttemplate_id`, `is_active`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 1, 1),
(2, 1, 2, 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `printers`
--

CREATE TABLE `printers` (
  `printer_id` int(11) NOT NULL,
  `title` varchar(55) NOT NULL,
  `type` varchar(25) NOT NULL,
  `profile` varchar(25) DEFAULT NULL,
  `char_per_line` tinyint(3) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `printers`
--

INSERT INTO `printers` (`printer_id`, `title`, `type`, `profile`, `char_per_line`, `created_at`) VALUES
(1, 'Common Printer', 'network', '', 200, '2025-07-03 08:43:17');

-- --------------------------------------------------------

--
-- Table structure for table `printer_to_store`
--

CREATE TABLE `printer_to_store` (
  `p2s_id` int(11) NOT NULL,
  `pprinter_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `path` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `port` varchar(10) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `printer_to_store`
--

INSERT INTO `printer_to_store` (`p2s_id`, `pprinter_id`, `store_id`, `path`, `ip_address`, `port`, `status`, `sort_order`) VALUES
(1, 1, 1, '', NULL, '9100', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `p_id` int(10) UNSIGNED NOT NULL,
  `p_type` enum('standard','service') NOT NULL DEFAULT 'standard',
  `p_code` varchar(50) DEFAULT NULL,
  `hsn_code` varchar(100) DEFAULT NULL,
  `barcode_symbology` varchar(50) DEFAULT NULL,
  `p_name` varchar(100) NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `p_image` varchar(250) DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_to_store`
--

CREATE TABLE `product_to_store` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `purchase_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `sell_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `quantity_in_stock` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `alert_quantity` decimal(25,4) NOT NULL DEFAULT 10.0000,
  `sup_id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(11) DEFAULT 0,
  `box_id` int(10) UNSIGNED DEFAULT 0,
  `taxrate_id` int(10) UNSIGNED DEFAULT NULL,
  `tax_method` varchar(55) NOT NULL DEFAULT 'inclusive',
  `preference` longtext DEFAULT NULL,
  `e_date` date DEFAULT NULL,
  `p_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_info`
--

CREATE TABLE `purchase_info` (
  `info_id` int(10) UNSIGNED NOT NULL,
  `invoice_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `inv_type` enum('purchase','transfer') NOT NULL DEFAULT 'purchase',
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `sup_id` int(10) UNSIGNED DEFAULT NULL,
  `total_item` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `status` enum('stock','active','sold') NOT NULL DEFAULT 'stock',
  `total_sell` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `purchase_note` text DEFAULT NULL,
  `attachment` text DEFAULT NULL,
  `is_visible` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `payment_status` varchar(20) NOT NULL DEFAULT 'due',
  `checkout_status` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_status` enum('received','pending','ordered') NOT NULL DEFAULT 'received',
  `created_by` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_item`
--

CREATE TABLE `purchase_item` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `item_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `brand_id` int(11) DEFAULT 0,
  `item_name` varchar(100) NOT NULL,
  `item_purchase_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_selling_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_sell` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `status` enum('stock','active','sold') NOT NULL DEFAULT 'stock',
  `item_total` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `tax_method` enum('exclusive','inclusive') DEFAULT 'exclusive',
  `tax` varchar(20) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `return_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `installment_quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_logs`
--

CREATE TABLE `purchase_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `sup_id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(55) DEFAULT NULL,
  `ref_invoice_id` varchar(55) DEFAULT NULL,
  `type` varchar(55) NOT NULL,
  `pmethod_id` int(11) DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `store_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_payments`
--

CREATE TABLE `purchase_payments` (
  `id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'purchase',
  `is_hide` tinyint(1) NOT NULL DEFAULT 0,
  `store_id` int(10) UNSIGNED NOT NULL,
  `invoice_id` varchar(100) DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `pmethod_id` int(10) UNSIGNED DEFAULT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `attachment` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_paid` decimal(25,4) DEFAULT 0.0000,
  `balance` decimal(25,4) DEFAULT 0.0000,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_price`
--

CREATE TABLE `purchase_price` (
  `price_id` int(11) NOT NULL,
  `invoice_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `discount_type` enum('percentage','plain') NOT NULL DEFAULT 'plain',
  `discount_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `shipping_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `shipping_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `others_charge` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `order_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `payable_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `paid_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `due_paid` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `due` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `return_amount` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `balance` decimal(25,4) NOT NULL DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `sup_id` int(11) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total_item` int(11) DEFAULT NULL,
  `total_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `subtotal` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_items`
--

CREATE TABLE `purchase_return_items` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_quantity` decimal(15,4) NOT NULL,
  `item_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `item_total` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotation_info`
--

CREATE TABLE `quotation_info` (
  `info_id` int(11) NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `invoice_id` varchar(100) DEFAULT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `customer_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `customer_mobile` varchar(20) DEFAULT NULL,
  `status` enum('sent','pending','complete','canceled') NOT NULL DEFAULT 'sent',
  `payment_status` varchar(50) DEFAULT NULL,
  `quotation_note` text DEFAULT NULL,
  `is_installment` tinyint(1) NOT NULL DEFAULT 0,
  `is_order` tinyint(1) NOT NULL DEFAULT 0,
  `total_items` int(11) NOT NULL DEFAULT 0,
  `address` text DEFAULT NULL,
  `pmethod_details` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotation_item`
--

CREATE TABLE `quotation_item` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(100) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `sup_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(11) DEFAULT 0,
  `item_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_discount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `tax_method` enum('exclusive','inclusive') NOT NULL DEFAULT 'exclusive',
  `taxrate_id` int(10) UNSIGNED DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `item_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_purchase_price` decimal(25,4) DEFAULT NULL,
  `item_total` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `purchase_invoice_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotation_price`
--

CREATE TABLE `quotation_price` (
  `price_id` int(11) NOT NULL,
  `reference_no` varchar(100) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `discount_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `discount_amount` decimal(25,4) DEFAULT 0.0000,
  `interest_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `interest_percentage` int(11) NOT NULL DEFAULT 0,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `order_tax` decimal(25,4) DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `total_purchase_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `shipping_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `shipping_amount` decimal(25,4) DEFAULT 0.0000,
  `others_charge` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payable_amount` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `purchase_invoice_id` varchar(100) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total_item` decimal(25,4) DEFAULT NULL,
  `total_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `subtotal` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `total_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `total_purchase_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `profit` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `attachment` varchar(55) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `return_items`
--

CREATE TABLE `return_items` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `reference_no` varchar(100) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_purchase_price` decimal(25,4) DEFAULT NULL,
  `item_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `item_total` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `selling_info`
--

CREATE TABLE `selling_info` (
  `info_id` int(11) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `edit_counter` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `inv_type` enum('sell') NOT NULL DEFAULT 'sell',
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `customer_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `customer_mobile` varchar(20) DEFAULT NULL,
  `gst_number` varchar(50) DEFAULT NULL,
  `ref_invoice_id` varchar(100) DEFAULT NULL,
  `ref_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `invoice_note` text DEFAULT NULL,
  `total_items` smallint(6) DEFAULT NULL,
  `is_installment` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `pmethod_id` int(11) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `checkout_status` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `selling_item`
--

CREATE TABLE `selling_item` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(11) DEFAULT 0,
  `sup_id` int(10) UNSIGNED NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `item_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_discount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `tax_method` enum('inclusive','exclusive') DEFAULT 'exclusive',
  `taxrate_id` int(10) UNSIGNED DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `item_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `item_purchase_price` decimal(25,4) DEFAULT NULL,
  `item_total` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `purchase_invoice_id` varchar(100) DEFAULT NULL,
  `print_counter` int(10) UNSIGNED DEFAULT 0,
  `print_counter_time` datetime DEFAULT NULL,
  `printed_by` int(11) DEFAULT NULL,
  `return_quantity` decimal(25,4) DEFAULT 0.0000,
  `installment_quantity` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `selling_price`
--

CREATE TABLE `selling_price` (
  `price_id` int(11) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `discount_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `discount_amount` decimal(25,4) DEFAULT 0.0000,
  `interest_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `interest_percentage` int(11) NOT NULL DEFAULT 0,
  `item_tax` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `order_tax` decimal(25,4) DEFAULT 0.0000,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `total_purchase_price` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `shipping_type` enum('plain','percentage') NOT NULL DEFAULT 'plain',
  `shipping_amount` decimal(25,4) DEFAULT 0.0000,
  `others_charge` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `payable_amount` decimal(25,4) DEFAULT NULL,
  `paid_amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `due` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `due_paid` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `return_amount` decimal(25,4) UNSIGNED NOT NULL DEFAULT 0.0000,
  `balance` decimal(25,4) DEFAULT 0.0000,
  `profit` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `previous_due` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `prev_due_paid` decimal(25,4) NOT NULL DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sell_logs`
--

CREATE TABLE `sell_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(55) DEFAULT NULL,
  `ref_invoice_id` varchar(55) DEFAULT NULL,
  `type` varchar(55) NOT NULL,
  `pmethod_id` int(11) DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `store_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `version` varchar(10) NOT NULL,
  `is_update_available` tinyint(1) NOT NULL DEFAULT 0,
  `update_version` varchar(100) DEFAULT NULL,
  `update_link` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `version`, `is_update_available`, `update_version`, `update_link`, `created_at`, `updated_at`) VALUES
(1, '3.4', 0, '', '', '2025-07-03 08:43:18', '2025-07-03 08:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `shortcut_links`
--

CREATE TABLE `shortcut_links` (
  `id` int(11) NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `href` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `target` varchar(100) NOT NULL DEFAULT '_self',
  `title` varchar(255) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `thumbnail` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `permission_slug` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `shortcut_links`
--

INSERT INTO `shortcut_links` (`id`, `type`, `href`, `target`, `title`, `icon`, `thumbnail`, `permission_slug`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'report', '/admin/report_overview.php', '', 'Overview Report', 'fa-angle-right', '', 'read_overview_report', 1, 1, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(2, 'report', '/admin/report_collection.php', '', 'Collection Report', 'fa-angle-right', '', 'read_collection_report', 1, 2, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(3, 'report', '/admin/report_customer_due_collection.php', '', 'Due Collection Report', 'fa-angle-right', '', 'read_customer_due_collection_report', 1, 3, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(4, 'report', '/admin/report_supplier_due_paid.php', '', 'Supplier Due Paid Report', 'fa-angle-right', '', 'read_supplier_due_paid_report', 1, 4, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(5, 'report', '/admin/report_sell_itemwise.php', '', 'Sell Report', 'fa-angle-right', '', 'read_sell_report', 1, 5, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(6, 'report', '/admin/report_purchase_supplierwise.php', '', 'Purchase Report', 'fa-angle-right', '', 'read_purchase_report', 1, 6, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(7, 'report', '/admin/report_sell_payment.php', '', 'Sell Payment Report', 'fa-angle-right', '', 'read_sell_payment_report', 1, 7, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(8, 'report', '/admin/report_purchase_payment.php', '', 'Purchase Payment Report', 'fa-angle-right', '', 'read_purchase_payment_report', 1, 8, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(9, 'report', '/admin/report_sell_tax.php', '', 'Sell Tax Report', 'fa-angle-right', '', 'read_sell_tax_report', 1, 9, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(10, 'report', '/admin/report_purchase_tax.php', '', 'Purchase Tax Report', 'fa-angle-right', '', 'read_purchase_tax_report', 1, 10, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(11, 'report', '/admin/report_tax_overview.php', '', 'Tax Overview Report', 'fa-angle-right', '', 'read_tax_overview_report', 1, 11, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(12, 'report', '/admin/report_stock.php', '', 'Stock Report', 'fa-angle-right', '', 'read_stock_report', 1, 12, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(13, 'report', '/admin/bank_transactions.php', '', 'Bank Transaction', 'fa-angle-right', '', 'read_bank_transactions', 1, 13, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(14, 'report', '/admin/bank_account_sheet.php', '', 'Balance Sheet', 'fa-angle-right', '', 'read_bank_account_sheet', 1, 14, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(15, 'report', '/admin/income_monthwise.php', '', 'Income Monthwise Report', 'fa-angle-right', '', 'read_income_monthwise', 1, 15, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(16, 'report', '/admin/report_income_and_expense.php', '', 'Income vs Expense Report', 'fa-angle-right', '', 'read_income_and_expense_report', 1, 16, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(17, 'report', '/admin/report_profit_and_loss.php', '', 'Profit vs Loss Report', 'fa-angle-right', '', 'read_profit_and_loss_report', 1, 17, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(18, 'report', '/admin/report_cashbook.php', '', 'Cashbook', 'fa-angle-right', '', 'read_cashbook_report', 1, 18, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(19, 'report', '/admin/expense_monthwise.php', '', 'Expense Monthwise Report', 'fa-angle-right', '', 'read_income_monthwise', 1, 15, '2025-07-03 08:43:18', '2025-07-03 08:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `sms_schedule`
--

CREATE TABLE `sms_schedule` (
  `id` int(10) UNSIGNED NOT NULL,
  `schedule_datetime` datetime DEFAULT NULL,
  `store_id` int(10) UNSIGNED NOT NULL,
  `people_type` varchar(100) DEFAULT NULL,
  `people_sms_type` varchar(50) DEFAULT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `people_name` varchar(100) NOT NULL,
  `sms_text` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sms_type` varchar(50) NOT NULL DEFAULT 'TEXT',
  `campaign_name` varchar(100) DEFAULT NULL,
  `process_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `total_try` int(11) NOT NULL DEFAULT 0,
  `response_text` varchar(250) DEFAULT NULL,
  `delivery_status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_setting`
--

CREATE TABLE `sms_setting` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `api_id` varchar(100) DEFAULT NULL,
  `auth_key` varchar(100) DEFAULT NULL,
  `sender_id` varchar(100) NOT NULL,
  `contact` text DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `maskname` varchar(100) DEFAULT NULL,
  `campaignname` varchar(100) DEFAULT NULL,
  `unicode` varchar(20) DEFAULT NULL,
  `country_code` varchar(20) DEFAULT NULL,
  `url` varchar(150) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sms_setting`
--

INSERT INTO `sms_setting` (`id`, `type`, `api_id`, `auth_key`, `sender_id`, `contact`, `username`, `password`, `maskname`, `campaignname`, `unicode`, `country_code`, `url`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'Twilio', '', '', '', '', '', '', '', '', '', '', '', 1, 0, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(2, 'Msg91', '', '', '', '', '', '', '', '', '', '', 'http://api.msg91.com/api/v2/', 1, 0, '2025-07-03 08:43:18', '2025-07-03 08:43:18'),
(3, 'Mimsms', '', '', '', '', '', '', '', '', '', '', 'https://www.mimsms.com.bd/smsAPI?', 1, 0, '2025-07-03 08:43:18', '2025-07-03 08:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code_name` varchar(55) DEFAULT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `zip_code` varchar(50) NOT NULL,
  `currency` varchar(100) NOT NULL DEFAULT 'USD',
  `vat_reg_no` varchar(250) DEFAULT NULL,
  `cashier_id` int(10) UNSIGNED NOT NULL,
  `address` longtext DEFAULT NULL,
  `receipt_printer` varchar(100) DEFAULT NULL,
  `cash_drawer_codes` varchar(100) DEFAULT NULL,
  `char_per_line` tinyint(4) NOT NULL DEFAULT 42,
  `remote_printing` tinyint(1) NOT NULL DEFAULT 1,
  `printer` int(11) DEFAULT NULL,
  `order_printers` varchar(100) DEFAULT NULL,
  `auto_print` tinyint(1) NOT NULL DEFAULT 0,
  `show_upi_qr` tinyint(1) NOT NULL DEFAULT 0,
  `local_printers` tinyint(1) DEFAULT NULL,
  `logo` text DEFAULT NULL,
  `favicon` varchar(250) DEFAULT NULL,
  `preference` longtext DEFAULT NULL,
  `sound_effect` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `feedback_status` varchar(100) NOT NULL DEFAULT 'ready',
  `feedback_at` datetime DEFAULT NULL,
  `deposit_account_id` int(11) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`store_id`, `name`, `code_name`, `mobile`, `email`, `country`, `zip_code`, `currency`, `vat_reg_no`, `cashier_id`, `address`, `receipt_printer`, `cash_drawer_codes`, `char_per_line`, `remote_printing`, `printer`, `order_printers`, `auto_print`, `show_upi_qr`, `local_printers`, `logo`, `favicon`, `preference`, `sound_effect`, `sort_order`, `feedback_status`, `feedback_at`, `deposit_account_id`, `thumbnail`, `status`, `created_at`) VALUES
(1, 'Shreshta Collections', 'shreshta_collections', '9739381943', 'info@store1.com', 'US', '1200', 'INR', '654321', 2, 'Darur', '1', NULL, 42, 0, 1, '[\"1\"]', 0, 0, 1, '1_logo.jpg', '1_favicon.png', 'a:18:{s:8:\"timezone\";s:12:\"Asia/Kolkata\";s:21:\"invoice_edit_lifespan\";i:1440;s:26:\"invoice_edit_lifespan_unit\";s:6:\"minute\";s:23:\"invoice_delete_lifespan\";i:1440;s:28:\"invoice_delete_lifespan_unit\";s:6:\"minute\";s:3:\"tax\";i:0;s:20:\"stock_alert_quantity\";i:10;s:20:\"datatable_item_limit\";i:25;s:15:\"after_sell_page\";s:3:\"pos\";s:19:\"invoice_footer_text\";s:26:\"Thank you for choosing us!\";s:10:\"email_from\";s:20:\"Shreshta Collections\";s:13:\"email_address\";s:2:\"US\";s:12:\"email_driver\";s:11:\"smtp_server\";s:9:\"smtp_host\";s:15:\"smtp.google.com\";s:13:\"smtp_username\";s:0:\"\";s:13:\"smtp_password\";s:0:\"\";s:9:\"smtp_port\";i:465;s:7:\"ssl_tls\";s:3:\"ssl\";}', 0, 0, 'ready', '2019-03-01 14:29:18', 1, NULL, 1, '2025-07-03 08:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `sup_id` int(10) UNSIGNED NOT NULL,
  `sup_name` varchar(100) NOT NULL,
  `code_name` varchar(55) DEFAULT NULL,
  `sup_mobile` varchar(14) DEFAULT NULL,
  `sup_email` varchar(100) DEFAULT NULL,
  `gtin` varchar(100) DEFAULT NULL,
  `sup_address` text DEFAULT NULL,
  `sup_city` varchar(100) DEFAULT NULL,
  `sup_state` varchar(55) DEFAULT NULL,
  `sup_country` varchar(100) DEFAULT NULL,
  `sup_details` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`sup_id`, `sup_name`, `code_name`, `sup_mobile`, `sup_email`, `gtin`, `sup_address`, `sup_city`, `sup_state`, `sup_country`, `sup_details`, `created_at`) VALUES
(1, 'No Supplier', 'no_supplier', '016000000', 'supplier@itsolution24.com', '', 'USA', '', '', 'AD', '', '2025-07-03 08:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_to_store`
--

CREATE TABLE `supplier_to_store` (
  `s2s_id` int(11) NOT NULL,
  `sup_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `balance` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `supplier_to_store`
--

INSERT INTO `supplier_to_store` (`s2s_id`, `sup_id`, `store_id`, `balance`, `status`, `sort_order`) VALUES
(1, 1, 1, 0.0000, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `taxrates`
--

CREATE TABLE `taxrates` (
  `taxrate_id` int(11) NOT NULL,
  `taxrate_name` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code_name` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `taxrate` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `taxrates`
--

INSERT INTO `taxrates` (`taxrate_id`, `taxrate_name`, `code_name`, `taxrate`, `status`, `sort_order`) VALUES
(1, 'GST @0%', 'GG0', 0.0000, 1, 4),
(2, 'GST @18%', 'GGX', 18.0000, 1, 5),
(3, 'No Tax', 'no_tax', 0.0000, 1, 1),
(4, 'VAT @10%', 'VVX', 10.0000, 1, 2),
(5, 'Tax @20%', 'TTX', 20.0000, 1, 3),
(6, 'Tax@5%', 'tax@5%', 5.0000, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(11) NOT NULL,
  `ref_no` varchar(55) NOT NULL,
  `invoice_id` varchar(100) DEFAULT NULL,
  `ref_invoice_id` varchar(100) DEFAULT NULL,
  `from_store_id` int(11) NOT NULL,
  `to_store_id` int(11) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total_item` decimal(25,4) DEFAULT NULL,
  `total_quantity` decimal(25,4) NOT NULL DEFAULT 0.0000,
  `created_by` varchar(255) DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `cancelled_by` int(11) DEFAULT NULL,
  `status` varchar(55) NOT NULL DEFAULT 'pending',
  `attachment` varchar(55) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfer_items`
--

CREATE TABLE `transfer_items` (
  `id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` decimal(25,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `unit_details` text CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_id`, `unit_name`, `code_name`, `unit_details`) VALUES
(1, 'Pieces', 'pieces', '');

-- --------------------------------------------------------

--
-- Table structure for table `unit_to_store`
--

CREATE TABLE `unit_to_store` (
  `unit2s_id` int(10) UNSIGNED NOT NULL,
  `uunit_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `store_id` int(10) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `unit_to_store`
--

INSERT INTO `unit_to_store` (`unit2s_id`, `uunit_id`, `store_id`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(10) NOT NULL DEFAULT 'M',
  `password` varchar(100) NOT NULL,
  `pass_reset_code` varchar(32) DEFAULT NULL,
  `reset_code_time` datetime DEFAULT NULL,
  `login_try` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `last_login` datetime DEFAULT NULL,
  `ip` varchar(40) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `preference` longtext DEFAULT NULL,
  `user_image` varchar(250) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `group_id`, `username`, `email`, `mobile`, `dob`, `sex`, `password`, `pass_reset_code`, `reset_code_time`, `login_try`, `last_login`, `ip`, `address`, `preference`, `user_image`, `created_at`, `updated_at`) VALUES
(1, 1, 'Your Name', 'mokashihanama@gmail.com', '9739381943', '1990-01-01', 'M', '$2y$10$OYNAqNt5KVeAKRGXPG.K1uWbv0gCVsH2KWgzb6Xfzccy5.Fq1uOJa', '', NULL, 0, '2025-07-03 14:16:41', '::1', NULL, 'a:4:{s:10:\"base_color\";s:5:\"green\";s:14:\"pos_side_panel\";s:5:\"right\";s:11:\"pos_pattern\";s:13:\"brickwall.jpg\";s:8:\"language\";s:2:\"hi\";}', '/solution24-logo.jpg', '2025-07-03 05:15:47', '2025-07-03 08:48:04'),
(2, 2, 'Cashier', 'cashier@gmail.com', '01521504597', '1990-01-01', 'M', '$2y$10$OYNAqNt5KVeAKRGXPG.K1uWbv0gCVsH2KWgzb6Xfzccy5.Fq1uOJa', '', NULL, 0, '2019-06-22 14:01:20', '::1', NULL, 'a:4:{s:8:\"language\";s:7:\"english\";s:10:\"base_color\";s:5:\"green\";s:14:\"pos_side_panel\";s:5:\"right\";s:11:\"pos_pattern\";s:31:\"abstract-attractive-backdro.jpg\";}', '', '2025-07-03 05:15:47', '2025-07-03 08:45:47'),
(3, 3, 'Salesman', 'salesman@gmail.com', '0113743700', '1990-01-01', 'M', '$2y$10$OYNAqNt5KVeAKRGXPG.K1uWbv0gCVsH2KWgzb6Xfzccy5.Fq1uOJa', '', NULL, 0, '2020-08-29 10:12:31', '::1', NULL, 'a:4:{s:10:\"base_color\";s:5:\"black\";s:14:\"pos_side_panel\";s:4:\"left\";s:11:\"pos_pattern\";s:13:\"brickwall.jpg\";s:8:\"language\";s:2:\"en\";}', '', '2025-07-03 05:15:47', '2025-07-03 08:45:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `group_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `permission` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`group_id`, `name`, `slug`, `sort_order`, `status`, `permission`) VALUES
(1, 'Admin', 'admin', 1, 1, 'a:1:{s:6:\"access\";a:122:{s:16:\"read_sell_report\";s:4:\"true\";s:20:\"read_overview_report\";s:4:\"true\";s:22:\"read_collection_report\";s:4:\"true\";s:27:\"read_full_collection_report\";s:4:\"true\";s:35:\"read_customer_due_collection_report\";s:4:\"true\";s:29:\"read_supplier_due_paid_report\";s:4:\"true\";s:14:\"read_analytics\";s:4:\"true\";s:24:\"read_sell_payment_report\";s:4:\"true\";s:20:\"read_sell_tax_report\";s:4:\"true\";s:24:\"read_tax_overview_report\";s:4:\"true\";s:17:\"read_stock_report\";s:4:\"true\";s:21:\"send_report_via_email\";s:4:\"true\";s:8:\"withdraw\";s:4:\"true\";s:7:\"deposit\";s:4:\"true\";s:8:\"transfer\";s:4:\"true\";s:17:\"read_bank_account\";s:4:\"true\";s:23:\"read_bank_account_sheet\";s:4:\"true\";s:18:\"read_bank_transfer\";s:4:\"true\";s:22:\"read_bank_transactions\";s:4:\"true\";s:19:\"create_bank_account\";s:4:\"true\";s:19:\"update_bank_account\";s:4:\"true\";s:19:\"delete_bank_account\";s:4:\"true\";s:12:\"read_expense\";s:4:\"true\";s:14:\"create_expense\";s:4:\"true\";s:14:\"update_expense\";s:4:\"true\";s:14:\"delete_expense\";s:4:\"true\";s:21:\"read_sell_transaction\";s:4:\"true\";s:23:\"create_purchase_invoice\";s:4:\"true\";s:18:\"read_purchase_list\";s:4:\"true\";s:28:\"update_purchase_invoice_info\";s:4:\"true\";s:23:\"delete_purchase_invoice\";s:4:\"true\";s:16:\"purchase_payment\";s:4:\"true\";s:13:\"read_transfer\";s:4:\"true\";s:12:\"add_transfer\";s:4:\"true\";s:15:\"update_transfer\";s:4:\"true\";s:13:\"read_giftcard\";s:4:\"true\";s:12:\"add_giftcard\";s:4:\"true\";s:15:\"update_giftcard\";s:4:\"true\";s:15:\"delete_giftcard\";s:4:\"true\";s:14:\"giftcard_topup\";s:4:\"true\";s:19:\"read_giftcard_topup\";s:4:\"true\";s:21:\"delete_giftcard_topup\";s:4:\"true\";s:12:\"read_product\";s:4:\"true\";s:14:\"create_product\";s:4:\"true\";s:14:\"update_product\";s:4:\"true\";s:14:\"delete_product\";s:4:\"true\";s:14:\"import_product\";s:4:\"true\";s:19:\"product_bulk_action\";s:4:\"true\";s:18:\"delete_all_product\";s:4:\"true\";s:13:\"read_category\";s:4:\"true\";s:15:\"create_category\";s:4:\"true\";s:15:\"update_category\";s:4:\"true\";s:15:\"delete_category\";s:4:\"true\";s:16:\"read_stock_alert\";s:4:\"true\";s:20:\"read_expired_product\";s:4:\"true\";s:19:\"restore_all_product\";s:4:\"true\";s:13:\"read_supplier\";s:4:\"true\";s:15:\"create_supplier\";s:4:\"true\";s:15:\"update_supplier\";s:4:\"true\";s:15:\"delete_supplier\";s:4:\"true\";s:21:\"read_supplier_profile\";s:4:\"true\";s:8:\"read_box\";s:4:\"true\";s:10:\"create_box\";s:4:\"true\";s:10:\"update_box\";s:4:\"true\";s:10:\"delete_box\";s:4:\"true\";s:9:\"read_unit\";s:4:\"true\";s:11:\"create_unit\";s:4:\"true\";s:11:\"update_unit\";s:4:\"true\";s:11:\"delete_unit\";s:4:\"true\";s:12:\"read_taxrate\";s:4:\"true\";s:14:\"create_taxrate\";s:4:\"true\";s:14:\"update_taxrate\";s:4:\"true\";s:14:\"delete_taxrate\";s:4:\"true\";s:9:\"read_loan\";s:4:\"true\";s:17:\"read_loan_summary\";s:4:\"true\";s:9:\"take_loan\";s:4:\"true\";s:11:\"update_loan\";s:4:\"true\";s:11:\"delete_loan\";s:4:\"true\";s:8:\"loan_pay\";s:4:\"true\";s:13:\"read_customer\";s:4:\"true\";s:21:\"read_customer_profile\";s:4:\"true\";s:15:\"create_customer\";s:4:\"true\";s:15:\"update_customer\";s:4:\"true\";s:15:\"delete_customer\";s:4:\"true\";s:9:\"read_user\";s:4:\"true\";s:11:\"create_user\";s:4:\"true\";s:11:\"update_user\";s:4:\"true\";s:11:\"delete_user\";s:4:\"true\";s:15:\"change_password\";s:4:\"true\";s:14:\"read_usergroup\";s:4:\"true\";s:16:\"create_usergroup\";s:4:\"true\";s:16:\"update_usergroup\";s:4:\"true\";s:16:\"delete_usergroup\";s:4:\"true\";s:13:\"read_currency\";s:4:\"true\";s:15:\"create_currency\";s:4:\"true\";s:15:\"update_currency\";s:4:\"true\";s:15:\"change_currency\";s:4:\"true\";s:15:\"delete_currency\";s:4:\"true\";s:16:\"read_filemanager\";s:4:\"true\";s:12:\"read_pmethod\";s:4:\"true\";s:14:\"create_pmethod\";s:4:\"true\";s:14:\"update_pmethod\";s:4:\"true\";s:14:\"delete_pmethod\";s:4:\"true\";s:10:\"read_store\";s:4:\"true\";s:12:\"create_store\";s:4:\"true\";s:12:\"update_store\";s:4:\"true\";s:12:\"delete_store\";s:4:\"true\";s:14:\"activate_store\";s:4:\"true\";s:14:\"upload_favicon\";s:4:\"true\";s:11:\"upload_logo\";s:4:\"true\";s:12:\"read_printer\";s:4:\"true\";s:14:\"create_printer\";s:4:\"true\";s:14:\"update_printer\";s:4:\"true\";s:14:\"delete_printer\";s:4:\"true\";s:20:\"read_user_preference\";s:4:\"true\";s:22:\"update_user_preference\";s:4:\"true\";s:9:\"filtering\";s:4:\"true\";s:13:\"language_sync\";s:4:\"true\";s:6:\"backup\";s:4:\"true\";s:7:\"restore\";s:4:\"true\";s:11:\"show_profit\";s:4:\"true\";s:10:\"show_graph\";s:4:\"true\";}}'),
(2, 'Cashier', 'cashier', 2, 1, 'a:1:{s:6:\"access\";a:2:{s:9:\"read_user\";s:4:\"true\";s:11:\"update_user\";s:4:\"true\";}}'),
(3, 'Salesman', 'salesman', 3, 1, 'a:1:{s:6:\"access\";a:191:{s:22:\"read_recent_activities\";s:4:\"true\";s:32:\"read_dashboard_accounting_report\";s:4:\"true\";s:16:\"read_sell_report\";s:4:\"true\";s:20:\"read_overview_report\";s:4:\"true\";s:22:\"read_collection_report\";s:4:\"true\";s:27:\"read_full_collection_report\";s:4:\"true\";s:35:\"read_customer_due_collection_report\";s:4:\"true\";s:29:\"read_supplier_due_paid_report\";s:4:\"true\";s:14:\"read_analytics\";s:4:\"true\";s:20:\"read_purchase_report\";s:4:\"true\";s:28:\"read_purchase_payment_report\";s:4:\"true\";s:24:\"read_purchase_tax_report\";s:4:\"true\";s:24:\"read_sell_payment_report\";s:4:\"true\";s:20:\"read_sell_tax_report\";s:4:\"true\";s:24:\"read_tax_overview_report\";s:4:\"true\";s:17:\"read_stock_report\";s:4:\"true\";s:21:\"send_report_via_email\";s:4:\"true\";s:8:\"withdraw\";s:4:\"true\";s:7:\"deposit\";s:4:\"true\";s:8:\"transfer\";s:4:\"true\";s:17:\"read_bank_account\";s:4:\"true\";s:23:\"read_bank_account_sheet\";s:4:\"true\";s:18:\"read_bank_transfer\";s:4:\"true\";s:22:\"read_bank_transactions\";s:4:\"true\";s:18:\"read_income_source\";s:4:\"true\";s:19:\"create_bank_account\";s:4:\"true\";s:19:\"update_bank_account\";s:4:\"true\";s:19:\"delete_bank_account\";s:4:\"true\";s:20:\"create_income_source\";s:4:\"true\";s:20:\"update_income_source\";s:4:\"true\";s:20:\"delete_income_source\";s:4:\"true\";s:21:\"read_income_monthwise\";s:4:\"true\";s:30:\"read_income_and_expense_report\";s:4:\"true\";s:27:\"read_profit_and_loss_report\";s:4:\"true\";s:20:\"read_cashbook_report\";s:4:\"true\";s:14:\"read_quotation\";s:4:\"true\";s:16:\"create_quotation\";s:4:\"true\";s:16:\"update_quotation\";s:4:\"true\";s:16:\"delete_quotation\";s:4:\"true\";s:16:\"read_installment\";s:4:\"true\";s:18:\"create_installment\";s:4:\"true\";s:18:\"update_installment\";s:4:\"true\";s:18:\"delete_installment\";s:4:\"true\";s:19:\"installment_payment\";s:4:\"true\";s:20:\"installment_overview\";s:4:\"true\";s:12:\"read_expense\";s:4:\"true\";s:14:\"create_expense\";s:4:\"true\";s:14:\"update_expense\";s:4:\"true\";s:14:\"delete_expense\";s:4:\"true\";s:21:\"read_expense_category\";s:4:\"true\";s:23:\"create_expense_category\";s:4:\"true\";s:23:\"update_expense_category\";s:4:\"true\";s:23:\"delete_expense_category\";s:4:\"true\";s:22:\"read_expense_monthwise\";s:4:\"true\";s:20:\"read_expense_summary\";s:4:\"true\";s:17:\"read_sell_invoice\";s:4:\"true\";s:14:\"read_sell_list\";s:4:\"true\";s:19:\"create_sell_invoice\";s:4:\"true\";s:24:\"update_sell_invoice_info\";s:4:\"true\";s:19:\"delete_sell_invoice\";s:4:\"true\";s:12:\"sell_payment\";s:4:\"true\";s:15:\"create_sell_due\";s:4:\"true\";s:18:\"create_sell_return\";s:4:\"true\";s:16:\"read_sell_return\";s:4:\"true\";s:18:\"update_sell_return\";s:4:\"true\";s:18:\"delete_sell_return\";s:4:\"true\";s:16:\"sms_sell_invoice\";s:4:\"true\";s:18:\"email_sell_invoice\";s:4:\"true\";s:13:\"read_sell_log\";s:4:\"true\";s:23:\"create_purchase_invoice\";s:4:\"true\";s:18:\"read_purchase_list\";s:4:\"true\";s:28:\"update_purchase_invoice_info\";s:4:\"true\";s:23:\"delete_purchase_invoice\";s:4:\"true\";s:16:\"purchase_payment\";s:4:\"true\";s:19:\"create_purchase_due\";s:4:\"true\";s:22:\"create_purchase_return\";s:4:\"true\";s:20:\"read_purchase_return\";s:4:\"true\";s:22:\"update_purchase_return\";s:4:\"true\";s:22:\"delete_purchase_return\";s:4:\"true\";s:17:\"read_purchase_log\";s:4:\"true\";s:13:\"read_transfer\";s:4:\"true\";s:12:\"add_transfer\";s:4:\"true\";s:15:\"update_transfer\";s:4:\"true\";s:15:\"delete_transfer\";s:4:\"true\";s:13:\"read_giftcard\";s:4:\"true\";s:12:\"add_giftcard\";s:4:\"true\";s:15:\"update_giftcard\";s:4:\"true\";s:15:\"delete_giftcard\";s:4:\"true\";s:14:\"giftcard_topup\";s:4:\"true\";s:19:\"read_giftcard_topup\";s:4:\"true\";s:21:\"delete_giftcard_topup\";s:4:\"true\";s:12:\"read_product\";s:4:\"true\";s:14:\"create_product\";s:4:\"true\";s:14:\"update_product\";s:4:\"true\";s:14:\"delete_product\";s:4:\"true\";s:14:\"import_product\";s:4:\"true\";s:19:\"product_bulk_action\";s:4:\"true\";s:18:\"delete_all_product\";s:4:\"true\";s:13:\"read_category\";s:4:\"true\";s:15:\"create_category\";s:4:\"true\";s:15:\"update_category\";s:4:\"true\";s:15:\"delete_category\";s:4:\"true\";s:16:\"read_stock_alert\";s:4:\"true\";s:20:\"read_expired_product\";s:4:\"true\";s:13:\"barcode_print\";s:4:\"true\";s:19:\"restore_all_product\";s:4:\"true\";s:13:\"read_supplier\";s:4:\"true\";s:15:\"create_supplier\";s:4:\"true\";s:15:\"update_supplier\";s:4:\"true\";s:15:\"delete_supplier\";s:4:\"true\";s:21:\"read_supplier_profile\";s:4:\"true\";s:10:\"read_brand\";s:4:\"true\";s:12:\"create_brand\";s:4:\"true\";s:12:\"update_brand\";s:4:\"true\";s:12:\"delete_brand\";s:4:\"true\";s:18:\"read_brand_profile\";s:4:\"true\";s:8:\"read_box\";s:4:\"true\";s:10:\"create_box\";s:4:\"true\";s:10:\"update_box\";s:4:\"true\";s:10:\"delete_box\";s:4:\"true\";s:9:\"read_unit\";s:4:\"true\";s:11:\"create_unit\";s:4:\"true\";s:11:\"update_unit\";s:4:\"true\";s:11:\"delete_unit\";s:4:\"true\";s:12:\"read_taxrate\";s:4:\"true\";s:14:\"create_taxrate\";s:4:\"true\";s:14:\"update_taxrate\";s:4:\"true\";s:14:\"delete_taxrate\";s:4:\"true\";s:9:\"read_loan\";s:4:\"true\";s:17:\"read_loan_summary\";s:4:\"true\";s:9:\"take_loan\";s:4:\"true\";s:11:\"update_loan\";s:4:\"true\";s:11:\"delete_loan\";s:4:\"true\";s:8:\"loan_pay\";s:4:\"true\";s:13:\"read_customer\";s:4:\"true\";s:21:\"read_customer_profile\";s:4:\"true\";s:15:\"create_customer\";s:4:\"true\";s:15:\"update_customer\";s:4:\"true\";s:15:\"delete_customer\";s:4:\"true\";s:20:\"add_customer_balance\";s:4:\"true\";s:26:\"substract_customer_balance\";s:4:\"true\";s:25:\"read_customer_transaction\";s:4:\"true\";s:9:\"read_user\";s:4:\"true\";s:11:\"create_user\";s:4:\"true\";s:11:\"update_user\";s:4:\"true\";s:11:\"delete_user\";s:4:\"true\";s:15:\"change_password\";s:4:\"true\";s:14:\"read_usergroup\";s:4:\"true\";s:16:\"create_usergroup\";s:4:\"true\";s:16:\"update_usergroup\";s:4:\"true\";s:16:\"delete_usergroup\";s:4:\"true\";s:13:\"read_currency\";s:4:\"true\";s:15:\"create_currency\";s:4:\"true\";s:15:\"update_currency\";s:4:\"true\";s:15:\"change_currency\";s:4:\"true\";s:15:\"delete_currency\";s:4:\"true\";s:16:\"read_filemanager\";s:4:\"true\";s:12:\"read_pmethod\";s:4:\"true\";s:14:\"create_pmethod\";s:4:\"true\";s:14:\"update_pmethod\";s:4:\"true\";s:14:\"delete_pmethod\";s:4:\"true\";s:22:\"updadte_pmethod_status\";s:4:\"true\";s:10:\"read_store\";s:4:\"true\";s:12:\"create_store\";s:4:\"true\";s:12:\"update_store\";s:4:\"true\";s:12:\"delete_store\";s:4:\"true\";s:14:\"activate_store\";s:4:\"true\";s:14:\"upload_favicon\";s:4:\"true\";s:11:\"upload_logo\";s:4:\"true\";s:12:\"read_printer\";s:4:\"true\";s:14:\"create_printer\";s:4:\"true\";s:14:\"update_printer\";s:4:\"true\";s:14:\"delete_printer\";s:4:\"true\";s:10:\"send_email\";s:4:\"true\";s:13:\"read_language\";s:4:\"true\";s:15:\"create_language\";s:4:\"true\";s:15:\"update_language\";s:4:\"true\";s:15:\"delete_language\";s:4:\"true\";s:20:\"language_translation\";s:4:\"true\";s:19:\"delete_language_key\";s:4:\"true\";s:16:\"receipt_template\";s:4:\"true\";s:20:\"read_user_preference\";s:4:\"true\";s:22:\"update_user_preference\";s:4:\"true\";s:9:\"filtering\";s:4:\"true\";s:13:\"language_sync\";s:4:\"true\";s:6:\"backup\";s:4:\"true\";s:7:\"restore\";s:4:\"true\";s:5:\"reset\";s:4:\"true\";s:19:\"show_purchase_price\";s:4:\"true\";s:11:\"show_profit\";s:4:\"true\";s:10:\"show_graph\";s:4:\"true\";}}');

-- --------------------------------------------------------

--
-- Table structure for table `user_to_store`
--

CREATE TABLE `user_to_store` (
  `u2s_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_to_store`
--

INSERT INTO `user_to_store` (`u2s_id`, `user_id`, `store_id`, `status`, `sort_order`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 1, 1, 2),
(3, 3, 1, 1, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_account_to_store`
--
ALTER TABLE `bank_account_to_store`
  ADD PRIMARY KEY (`ba2s`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `bank_transaction_info`
--
ALTER TABLE `bank_transaction_info`
  ADD PRIMARY KEY (`info_id`),
  ADD KEY `ref_no` (`ref_no`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `bank_transaction_price`
--
ALTER TABLE `bank_transaction_price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `ref_no` (`ref_no`);

--
-- Indexes for table `boxes`
--
ALTER TABLE `boxes`
  ADD PRIMARY KEY (`box_id`);

--
-- Indexes for table `box_to_store`
--
ALTER TABLE `box_to_store`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `brand_to_store`
--
ALTER TABLE `brand_to_store`
  ADD PRIMARY KEY (`b2s_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `categorys`
--
ALTER TABLE `categorys`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `category_to_store`
--
ALTER TABLE `category_to_store`
  ADD PRIMARY KEY (`c2s_id`),
  ADD KEY `ccategory_id` (`ccategory_id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currency_id`);

--
-- Indexes for table `currency_to_store`
--
ALTER TABLE `currency_to_store`
  ADD PRIMARY KEY (`ca2s_id`),
  ADD KEY `currency_id` (`currency_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_to_store`
--
ALTER TABLE `customer_to_store`
  ADD PRIMARY KEY (`c2s_id`);

--
-- Indexes for table `customer_transactions`
--
ALTER TABLE `customer_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categorys`
--
ALTER TABLE `expense_categorys`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_no` (`card_no`);

--
-- Indexes for table `gift_card_topups`
--
ALTER TABLE `gift_card_topups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `card_id` (`card_id`);

--
-- Indexes for table `holding_info`
--
ALTER TABLE `holding_info`
  ADD PRIMARY KEY (`info_id`);

--
-- Indexes for table `holding_item`
--
ALTER TABLE `holding_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ref_no` (`ref_no`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `holding_price`
--
ALTER TABLE `holding_price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `ref_no` (`ref_no`);

--
-- Indexes for table `income_sources`
--
ALTER TABLE `income_sources`
  ADD PRIMARY KEY (`source_id`);

--
-- Indexes for table `installment_orders`
--
ALTER TABLE `installment_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `installment_payments`
--
ALTER TABLE `installment_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `language_translations`
--
ALTER TABLE `language_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`loan_id`);

--
-- Indexes for table `loan_payments`
--
ALTER TABLE `loan_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lloan_id` (`lloan_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `mail_sms_tag`
--
ALTER TABLE `mail_sms_tag`
  ADD PRIMARY KEY (`tag_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `pmethods`
--
ALTER TABLE `pmethods`
  ADD PRIMARY KEY (`pmethod_id`);

--
-- Indexes for table `pmethod_to_store`
--
ALTER TABLE `pmethod_to_store`
  ADD PRIMARY KEY (`p2s_id`),
  ADD KEY `ppmethod_id` (`ppmethod_id`);

--
-- Indexes for table `pos_register`
--
ALTER TABLE `pos_register`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_templates`
--
ALTER TABLE `pos_templates`
  ADD PRIMARY KEY (`template_id`);

--
-- Indexes for table `pos_template_to_store`
--
ALTER TABLE `pos_template_to_store`
  ADD PRIMARY KEY (`pt2s`),
  ADD KEY `ttemplate_id` (`ttemplate_id`);

--
-- Indexes for table `printers`
--
ALTER TABLE `printers`
  ADD PRIMARY KEY (`printer_id`);

--
-- Indexes for table `printer_to_store`
--
ALTER TABLE `printer_to_store`
  ADD PRIMARY KEY (`p2s_id`),
  ADD KEY `pprinter_id` (`pprinter_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`p_id`),
  ADD UNIQUE KEY `p_code` (`p_code`) USING BTREE;

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_to_store`
--
ALTER TABLE `product_to_store`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `p_date` (`p_date`);

--
-- Indexes for table `purchase_info`
--
ALTER TABLE `purchase_info`
  ADD PRIMARY KEY (`info_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `purchase_item`
--
ALTER TABLE `purchase_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `purchase_logs`
--
ALTER TABLE `purchase_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sup_id` (`sup_id`),
  ADD KEY `reference_no` (`reference_no`),
  ADD KEY `ref_invoice_id` (`ref_invoice_id`);

--
-- Indexes for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `purchase_price`
--
ALTER TABLE `purchase_price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `purchase_return_items`
--
ALTER TABLE `purchase_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `quotation_info`
--
ALTER TABLE `quotation_info`
  ADD PRIMARY KEY (`info_id`);

--
-- Indexes for table `quotation_item`
--
ALTER TABLE `quotation_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reference_no` (`reference_no`);

--
-- Indexes for table `quotation_price`
--
ALTER TABLE `quotation_price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `reference_no` (`reference_no`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `return_items`
--
ALTER TABLE `return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`reference_no`),
  ADD KEY `product_id` (`item_id`);

--
-- Indexes for table `selling_info`
--
ALTER TABLE `selling_info`
  ADD PRIMARY KEY (`info_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `selling_item`
--
ALTER TABLE `selling_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `selling_price`
--
ALTER TABLE `selling_price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `sell_logs`
--
ALTER TABLE `sell_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shortcut_links`
--
ALTER TABLE `shortcut_links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms_schedule`
--
ALTER TABLE `sms_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `people_type` (`people_type`);

--
-- Indexes for table `sms_setting`
--
ALTER TABLE `sms_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`sup_id`);

--
-- Indexes for table `supplier_to_store`
--
ALTER TABLE `supplier_to_store`
  ADD PRIMARY KEY (`s2s_id`),
  ADD KEY `sup_id` (`sup_id`);

--
-- Indexes for table `taxrates`
--
ALTER TABLE `taxrates`
  ADD PRIMARY KEY (`taxrate_id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer_items`
--
ALTER TABLE `transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`transfer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `unit_to_store`
--
ALTER TABLE `unit_to_store`
  ADD PRIMARY KEY (`unit2s_id`),
  ADD KEY `uunit_id` (`uunit_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`group_id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `user_to_store`
--
ALTER TABLE `user_to_store`
  ADD PRIMARY KEY (`u2s_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `bank_account_to_store`
--
ALTER TABLE `bank_account_to_store`
  MODIFY `ba2s` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_transaction_info`
--
ALTER TABLE `bank_transaction_info`
  MODIFY `info_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank_transaction_price`
--
ALTER TABLE `bank_transaction_price`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `boxes`
--
ALTER TABLE `boxes`
  MODIFY `box_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `box_to_store`
--
ALTER TABLE `box_to_store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brand_to_store`
--
ALTER TABLE `brand_to_store`
  MODIFY `b2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categorys`
--
ALTER TABLE `categorys`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category_to_store`
--
ALTER TABLE `category_to_store`
  MODIFY `c2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `currency_to_store`
--
ALTER TABLE `currency_to_store`
  MODIFY `ca2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_to_store`
--
ALTER TABLE `customer_to_store`
  MODIFY `c2s_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_transactions`
--
ALTER TABLE `customer_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categorys`
--
ALTER TABLE `expense_categorys`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_topups`
--
ALTER TABLE `gift_card_topups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holding_info`
--
ALTER TABLE `holding_info`
  MODIFY `info_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holding_item`
--
ALTER TABLE `holding_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holding_price`
--
ALTER TABLE `holding_price`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_sources`
--
ALTER TABLE `income_sources`
  MODIFY `source_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `installment_orders`
--
ALTER TABLE `installment_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `installment_payments`
--
ALTER TABLE `installment_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `language_translations`
--
ALTER TABLE `language_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1683;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `loan_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_payments`
--
ALTER TABLE `loan_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mail_sms_tag`
--
ALTER TABLE `mail_sms_tag`
  MODIFY `tag_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pmethods`
--
ALTER TABLE `pmethods`
  MODIFY `pmethod_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pmethod_to_store`
--
ALTER TABLE `pmethod_to_store`
  MODIFY `p2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pos_register`
--
ALTER TABLE `pos_register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_templates`
--
ALTER TABLE `pos_templates`
  MODIFY `template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pos_template_to_store`
--
ALTER TABLE `pos_template_to_store`
  MODIFY `pt2s` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `printers`
--
ALTER TABLE `printers`
  MODIFY `printer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `printer_to_store`
--
ALTER TABLE `printer_to_store`
  MODIFY `p2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `p_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_to_store`
--
ALTER TABLE `product_to_store`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_info`
--
ALTER TABLE `purchase_info`
  MODIFY `info_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_item`
--
ALTER TABLE `purchase_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_logs`
--
ALTER TABLE `purchase_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_payments`
--
ALTER TABLE `purchase_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_price`
--
ALTER TABLE `purchase_price`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_return_items`
--
ALTER TABLE `purchase_return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotation_info`
--
ALTER TABLE `quotation_info`
  MODIFY `info_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotation_item`
--
ALTER TABLE `quotation_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotation_price`
--
ALTER TABLE `quotation_price`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `return_items`
--
ALTER TABLE `return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `selling_info`
--
ALTER TABLE `selling_info`
  MODIFY `info_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `selling_item`
--
ALTER TABLE `selling_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `selling_price`
--
ALTER TABLE `selling_price`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sell_logs`
--
ALTER TABLE `sell_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shortcut_links`
--
ALTER TABLE `shortcut_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `sms_schedule`
--
ALTER TABLE `sms_schedule`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms_setting`
--
ALTER TABLE `sms_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `sup_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supplier_to_store`
--
ALTER TABLE `supplier_to_store`
  MODIFY `s2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `taxrates`
--
ALTER TABLE `taxrates`
  MODIFY `taxrate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfer_items`
--
ALTER TABLE `transfer_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `unit_to_store`
--
ALTER TABLE `unit_to_store`
  MODIFY `unit2s_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_to_store`
--
ALTER TABLE `user_to_store`
  MODIFY `u2s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
