-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: database:3306
-- Generation Time: Jun 26, 2021 at 05:40 AM
-- Server version: 8.0.25
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `docker`
--
CREATE DATABASE IF NOT EXISTS `docker` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `docker`;
--
-- Database: `tita`
--
CREATE DATABASE IF NOT EXISTS `tita` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `tita`;

-- --------------------------------------------------------

--
-- Table structure for table `chitietdathang`
--

CREATE TABLE `chitietdathang` (
  `id` bigint UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `soluong` int NOT NULL,
  `tongtien` decimal(18,0) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chitietkho`
--

CREATE TABLE `chitietkho` (
  `id` bigint UNSIGNED NOT NULL,
  `soluong` int NOT NULL,
  `gianhap` decimal(18,0) NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `khohang_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chitietkho`
--

INSERT INTO `chitietkho` (`id`, `soluong`, `gianhap`, `menu_id`, `khohang_id`, `created_at`, `updated_at`) VALUES
(13, 11, '5000', 1, 8, '2021-06-18 15:55:44', '2021-06-18 15:55:44'),
(14, 11, '5000', 2, 9, '2021-06-22 17:44:57', '2021-06-22 17:44:57'),
(15, 10, '80000', 3, 8, '2021-06-23 03:48:15', '2021-06-23 03:48:15');

--
-- Triggers `chitietkho`
--
DELIMITER $$
CREATE TRIGGER `GiatienAndSL_DELETE` BEFORE DELETE ON `chitietkho` FOR EACH ROW BEGIN
    UPDATE menu SET menu.giaold = menu.giaold - OLD.gianhap WHERE menu.id = OLD.menu_id;
    UPDATE menu SET menu.gianew = menu.gianew - OLD.gianhap WHERE menu.id = OLD.menu_id;
    UPDATE menu SET menu.soluong = menu.soluong - OLD.soluong WHERE menu.id = OLD.menu_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `GiatienAndSL_INSERT` BEFORE INSERT ON `chitietkho` FOR EACH ROW BEGIN
    UPDATE menu SET menu.giaold = menu.giaold+ NEW.gianhap WHERE menu.id = NEW.menu_id;
    UPDATE menu SET menu.gianew = menu.gianew +NEW.gianhap WHERE menu.id = NEW.menu_id;
    UPDATE menu SET menu.soluong = menu.soluong+ NEW.soluong WHERE menu.id = NEW.menu_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `GiatienAndSL_UPDATE` BEFORE UPDATE ON `chitietkho` FOR EACH ROW BEGIN
    UPDATE menu SET menu.giaold = menu.giaold - OLD.gianhap + NEW.gianhap WHERE	 menu.id = NEW.menu_id;
    UPDATE menu SET menu.gianew = menu.gianew -  OLD.gianhap + NEW.gianhap WHERE menu.id = NEW.menu_id;
    UPDATE menu SET menu.soluong = menu.soluong - OLD.soluong +  NEW.soluong WHERE menu.id = NEW.menu_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `XuatKho_DELETE` BEFORE DELETE ON `chitietkho` FOR EACH ROW BEGIN
    UPDATE khohang
    SET khohang.soluong = khohang.soluong + OLD.soluong
    WHERE khohang.id = OLD.khohang_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `XuatKho_INSERT` BEFORE INSERT ON `chitietkho` FOR EACH ROW BEGIN
    UPDATE khohang
    SET khohang.soluong = khohang.soluong - NEW.soluong
    WHERE khohang.id = NEW.khohang_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `XuatKho_UPDATE` BEFORE UPDATE ON `chitietkho` FOR EACH ROW BEGIN
    UPDATE khohang
    SET khohang.soluong = khohang.soluong + OLD.soluong - NEW.soluong
    WHERE khohang.id = NEW.khohang_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `chitietluachon`
--

CREATE TABLE `chitietluachon` (
  `id` bigint UNSIGNED NOT NULL,
  `tuychon_id` bigint UNSIGNED NOT NULL,
  `luachon_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `danhmuc`
--

CREATE TABLE `danhmuc` (
  `id` bigint UNSIGNED NOT NULL,
  `tendanhmuc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `danhmuccha_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `danhmuc`
--

INSERT INTO `danhmuc` (`id`, `tendanhmuc`, `danhmuccha_id`, `created_at`, `updated_at`) VALUES
(1, 'smartphone', 0, '2021-06-17 09:34:18', '2021-06-17 09:34:18'),
(2, 'Apple', 0, '2021-06-17 09:34:23', '2021-06-17 09:34:23'),
(3, 'Combo 1 nguoi', 0, '2021-06-17 09:34:29', '2021-06-17 09:34:29');

-- --------------------------------------------------------

--
-- Table structure for table `diachikhachhang`
--

CREATE TABLE `diachikhachhang` (
  `id` bigint UNSIGNED NOT NULL,
  `hoten` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sdt` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diachi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maps_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `donhang`
--

CREATE TABLE `donhang` (
  `id` bigint UNSIGNED NOT NULL,
  `diachikh_id` bigint UNSIGNED NOT NULL,
  `nhanvien_id` bigint UNSIGNED NOT NULL,
  `tinhtrang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pp_thanhtoan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tongtien` decimal(18,0) NOT NULL,
  `ghichu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `giamgia`
--

CREATE TABLE `giamgia` (
  `id` bigint UNSIGNED NOT NULL,
  `phantram` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `giamgia`
--

INSERT INTO `giamgia` (`id`, `phantram`, `menu_id`, `created_at`, `updated_at`) VALUES
(2, '5', 1, '2021-06-18 16:33:56', '2021-06-18 16:33:56'),
(3, '5', 3, '2021-06-23 03:48:43', '2021-06-23 03:48:43');

--
-- Triggers `giamgia`
--
DELIMITER $$
CREATE TRIGGER `GiamGia_DELETE` BEFORE DELETE ON `giamgia` FOR EACH ROW BEGIN
    UPDATE menu
    SET menu.gianew = menu.gianew/((100-OLD.phantram)*0.01)
    WHERE menu.id = OLD.menu_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `GiamGia_INSERT` BEFORE INSERT ON `giamgia` FOR EACH ROW BEGIN
    UPDATE menu
    SET menu.gianew = menu.gianew*((100-NEW.phantram)*0.01)
    WHERE menu.id = NEW.menu_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `GiamGia_UPDATE` BEFORE UPDATE ON `giamgia` FOR EACH ROW BEGIN
    UPDATE menu
    SET menu.gianew = menu.gianew/((100-OLD.phantram)*0.01)*((100-NEW.phantram)*0.01)
    WHERE menu.id = NEW.menu_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `image`, `menu_id`, `created_at`, `updated_at`) VALUES
(1, '1.jpg', 2, '2021-06-17 09:39:38', '2021-06-17 09:39:38'),
(2, '1.jpg', 1, '2021-06-17 09:41:51', '2021-06-17 09:41:51'),
(3, '1.jpg', 3, '2021-06-23 03:47:48', '2021-06-23 03:47:48');

-- --------------------------------------------------------

--
-- Table structure for table `khohang`
--

CREATE TABLE `khohang` (
  `id` bigint UNSIGNED NOT NULL,
  `sanphamkho` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soluong` int NOT NULL,
  `giasanpham` decimal(18,0) NOT NULL,
  `tongtienkho` decimal(18,0) NOT NULL,
  `nhanvien_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `khohang`
--

INSERT INTO `khohang` (`id`, `sanphamkho`, `soluong`, `giasanpham`, `tongtienkho`, `nhanvien_id`, `created_at`, `updated_at`) VALUES
(8, 'Tomca', 3, '10000', '30000', 1, '2021-06-18 14:29:23', '2021-06-18 14:29:23'),
(9, 'test1', 9, '10000', '90000', 1, '2021-06-18 14:30:43', '2021-06-18 14:30:43');

--
-- Triggers `khohang`
--
DELIMITER $$
CREATE TRIGGER `TinhTien_INSERT1` BEFORE INSERT ON `khohang` FOR EACH ROW BEGIN
    SET NEW.tongtienkho = NEW.soluong * NEW.giasanpham;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TinhTien_UPDATE` BEFORE UPDATE ON `khohang` FOR EACH ROW BEGIN
    SET NEW.tongtienkho = NEW.soluong * NEW.giasanpham;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `luachon`
--

CREATE TABLE `luachon` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maps`
--

CREATE TABLE `maps` (
  `id` bigint UNSIGNED NOT NULL,
  `maps` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` bigint UNSIGNED NOT NULL,
  `tensp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soluong` int NOT NULL,
  `giaold` decimal(18,0) NOT NULL,
  `gianew` decimal(18,0) NOT NULL,
  `mota` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `danhmuc_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `tensp`, `soluong`, `giaold`, `gianew`, `mota`, `danhmuc_id`, `created_at`, `updated_at`) VALUES
(1, 'Chicker', 11, '5000', '4750', '<p>oke111</p>', 3, '2021-06-17 09:35:31', '2021-06-17 09:37:40'),
(2, 'Chicker1', 11, '5000', '5000', '<p>123132</p>', 3, '2021-06-17 09:39:38', '2021-06-17 09:39:38'),
(3, 'fish', 10, '80000', '76000', '<p>ca&nbsp;</p>', 3, '2021-06-23 03:47:48', '2021-06-23 03:47:48');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(18, '2019_08_19_000000_create_failed_jobs_table', 2),
(19, '2021_06_17_080950_create_maps_table', 2),
(20, '2021_06_17_081007_create_danhmuc_table', 2),
(21, '2021_06_17_081027_create_nhanviens_table', 2),
(22, '2021_06_17_081215_create_menu_table', 2),
(23, '2021_06_17_081241_create_diachikhachhang_table', 2),
(24, '2021_06_17_081315_create_khohang_table', 2),
(25, '2021_06_17_081644_create_giamgia_table', 2),
(26, '2021_06_17_081706_create_images_table', 2),
(27, '2021_06_17_081730_create_chitietkho_table', 2),
(28, '2021_06_17_082014_create_donhang_table', 2),
(29, '2021_06_17_082036_create_tuychon_table', 2),
(30, '2021_06_17_082057_create_luachon_table', 2),
(31, '2021_06_17_082351_create_chitietdathang_table', 2),
(32, '2021_06_17_082411_create_chitietluachon_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `nhanviens`
--

CREATE TABLE `nhanviens` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CMND` int NOT NULL,
  `diachi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chucvu` tinyint NOT NULL,
  `sdt` int NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhanviens`
--

INSERT INTO `nhanviens` (`id`, `name`, `email`, `CMND`, `diachi`, `chucvu`, `sdt`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Quan Ly Kho', 'qlkho@gmail.com', 123456781, '1 quan ly kho', 4, 1231231231, '$2y$10$qCfqe06aub4.OFvSTyvtFuZXBe8RnRrjx0ZxOdGviWW66TArL3lA2', NULL, '2021-06-18 08:26:40', '2021-06-18 08:26:40');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tuychon`
--

CREATE TABLE `tuychon` (
  `id` bigint UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `tentuychon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Hồ Thị Thu Thảo', '197vanthien@gmail.com', NULL, '$2y$10$SkA3NqYb2Edkb6oEqtAFxulMfaYZz5J43MPgwK9DSoYD0ALpUQlhu', NULL, '2021-06-17 08:36:31', '2021-06-17 08:36:31'),
(2, 'Hồ Thị Thu Thảo', 'thien.hv.vn@gmail.com', NULL, '$2y$10$WS/AThn0GzwgBMOW5wY0HuB2rWkIBgezgMiAfOBSEOHqEWE8aYl8y', NULL, '2021-06-17 09:06:50', '2021-06-17 09:06:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chitietdathang`
--
ALTER TABLE `chitietdathang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chitietdathang_menu_id_foreign` (`menu_id`),
  ADD KEY `chitietdathang_order_id_foreign` (`order_id`);

--
-- Indexes for table `chitietkho`
--
ALTER TABLE `chitietkho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chitietkho_menu_id_foreign` (`menu_id`),
  ADD KEY `chitietkho_khohang_id_foreign` (`khohang_id`);

--
-- Indexes for table `chitietluachon`
--
ALTER TABLE `chitietluachon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chitietluachon_tuychon_id_foreign` (`tuychon_id`),
  ADD KEY `chitietluachon_luachon_id_foreign` (`luachon_id`);

--
-- Indexes for table `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `danhmuc_tendanhmuc_unique` (`tendanhmuc`);

--
-- Indexes for table `diachikhachhang`
--
ALTER TABLE `diachikhachhang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `diachikhachhang_sdt_unique` (`sdt`),
  ADD KEY `diachikhachhang_maps_id_foreign` (`maps_id`);

--
-- Indexes for table `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `donhang_diachikh_id_foreign` (`diachikh_id`),
  ADD KEY `donhang_nhanvien_id_foreign` (`nhanvien_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `giamgia`
--
ALTER TABLE `giamgia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `giamgia_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `images_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `khohang`
--
ALTER TABLE `khohang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `khohang_nhanvien_id_foreign` (`nhanvien_id`);

--
-- Indexes for table `luachon`
--
ALTER TABLE `luachon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `maps`
--
ALTER TABLE `maps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_tensp_unique` (`tensp`),
  ADD KEY `menu_danhmuc_id_foreign` (`danhmuc_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nhanviens`
--
ALTER TABLE `nhanviens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nhanviens_email_unique` (`email`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `tuychon`
--
ALTER TABLE `tuychon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tuychon_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chitietdathang`
--
ALTER TABLE `chitietdathang`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chitietkho`
--
ALTER TABLE `chitietkho`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `chitietluachon`
--
ALTER TABLE `chitietluachon`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `diachikhachhang`
--
ALTER TABLE `diachikhachhang`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `donhang`
--
ALTER TABLE `donhang`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `giamgia`
--
ALTER TABLE `giamgia`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `khohang`
--
ALTER TABLE `khohang`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `luachon`
--
ALTER TABLE `luachon`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maps`
--
ALTER TABLE `maps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `nhanviens`
--
ALTER TABLE `nhanviens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tuychon`
--
ALTER TABLE `tuychon`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitietdathang`
--
ALTER TABLE `chitietdathang`
  ADD CONSTRAINT `chitietdathang_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietdathang_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `donhang` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chitietkho`
--
ALTER TABLE `chitietkho`
  ADD CONSTRAINT `chitietkho_khohang_id_foreign` FOREIGN KEY (`khohang_id`) REFERENCES `khohang` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietkho_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chitietluachon`
--
ALTER TABLE `chitietluachon`
  ADD CONSTRAINT `chitietluachon_luachon_id_foreign` FOREIGN KEY (`luachon_id`) REFERENCES `luachon` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietluachon_tuychon_id_foreign` FOREIGN KEY (`tuychon_id`) REFERENCES `tuychon` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `diachikhachhang`
--
ALTER TABLE `diachikhachhang`
  ADD CONSTRAINT `diachikhachhang_maps_id_foreign` FOREIGN KEY (`maps_id`) REFERENCES `maps` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_diachikh_id_foreign` FOREIGN KEY (`diachikh_id`) REFERENCES `diachikhachhang` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `donhang_nhanvien_id_foreign` FOREIGN KEY (`nhanvien_id`) REFERENCES `nhanviens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `giamgia`
--
ALTER TABLE `giamgia`
  ADD CONSTRAINT `giamgia_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `khohang`
--
ALTER TABLE `khohang`
  ADD CONSTRAINT `khohang_nhanvien_id_foreign` FOREIGN KEY (`nhanvien_id`) REFERENCES `nhanviens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_danhmuc_id_foreign` FOREIGN KEY (`danhmuc_id`) REFERENCES `danhmuc` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tuychon`
--
ALTER TABLE `tuychon`
  ADD CONSTRAINT `tuychon_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
