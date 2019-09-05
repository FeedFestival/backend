-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2019 at 12:07 AM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stj`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(10) NOT NULL,
  `id_invoice` int(11) NOT NULL,
  `id_client` int(11) NOT NULL,
  `is_in_progress` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `id_invoice`, `id_client`, `is_in_progress`) VALUES
(1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cart_product`
--

CREATE TABLE `cart_product` (
  `id_cart` int(11) NOT NULL,
  `id_product_options` int(11) NOT NULL,
  `quantity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cart_product`
--

INSERT INTO `cart_product` (`id_cart`, `id_product_options`, `quantity`) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `categories_subcategories`
--

CREATE TABLE `categories_subcategories` (
  `id_category` int(10) NOT NULL,
  `id_subcategory` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories_subcategories`
--

INSERT INTO `categories_subcategories` (`id_category`, `id_subcategory`) VALUES
(1, 5),
(1, 6),
(1, 7),
(2, 5),
(2, 6),
(3, 5),
(3, 6),
(4, 5),
(4, 6),
(4, 8);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(10) NOT NULL,
  `description` varchar(250) NOT NULL,
  `level` int(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `description`, `level`) VALUES
(1, 'Pentru ea', 1),
(2, 'Pentru el', 1),
(3, 'Pentru cuplu', 1),
(4, 'Pentru copii', 1),
(5, 'Bratari', 2),
(6, 'Lanturi', 2),
(7, 'Coliere cu nume', 2),
(8, 'Banuti mot', 2);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `id_device` varchar(100) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `salt` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address1` varchar(250) DEFAULT NULL,
  `address2` varchar(250) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `id_device`, `email`, `password`, `salt`, `lastname`, `firstname`, `phone`, `address1`, `address2`, `city`, `county`) VALUES
(1, '2848b212cd593c31b3628b17d21d0fdcd5a8b2e9', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gravura`
--

CREATE TABLE `gravura` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gravura`
--

INSERT INTO `gravura` (`id`, `type`, `category`) VALUES
(1, 'Fata', NULL),
(2, 'Spate', NULL),
(3, 'Fata Verso', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(10) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `vat_price` double DEFAULT NULL,
  `total_price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`id`, `quantity`, `price`, `vat_price`, `total_price`) VALUES
(1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `material`
--

CREATE TABLE `material` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gramprice` double DEFAULT NULL,
  `handicraftprice` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `material`
--

INSERT INTO `material` (`id`, `name`, `gramprice`, `handicraftprice`) VALUES
(1, 'argint', 10, 5),
(2, 'inox', 1, 2),
(3, 'aur', 140, 50);

-- --------------------------------------------------------

--
-- Table structure for table `measure`
--

CREATE TABLE `measure` (
  `id` int(11) NOT NULL,
  `height` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `thickness` double DEFAULT NULL,
  `diameter` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `measure`
--

INSERT INTO `measure` (`id`, `height`, `width`, `thickness`, `diameter`) VALUES
(1, 1, 1, 0.75, 16.5),
(2, 1, 1, 0.7, 18.5),
(3, 30, 17, 1, NULL),
(4, 40, 17, 0.9, NULL),
(5, 20, 20, 0.8, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `model`
--

CREATE TABLE `model` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `grams` double NOT NULL,
  `id_measure` int(10) NOT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `model`
--

INSERT INTO `model` (`id`, `name`, `grams`, `id_measure`, `price`) VALUES
(1, 'Banut 16.6', 3, 1, 30),
(2, 'Banut 18.5', 3.5, 2, 35),
(3, 'Colier 30', 0, 3, 29.9),
(4, 'Colier 40', 0, 4, 39.9),
(5, 'Patrat', 2, 5, 15.9),
(6, 'Inima', 2, 5, 15.9);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(10) NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` varchar(500) NOT NULL,
  `length` double NOT NULL,
  `id_material` int(10) NOT NULL,
  `id_model` int(10) NOT NULL,
  `picture_path` varchar(500) NOT NULL,
  `id_category` int(10) NOT NULL,
  `id_subcategory` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `length`, `id_material`, `id_model`, `picture_path`, `id_category`, `id_subcategory`) VALUES
(1, 'Bratara Inimioara', '', 0, 1, 6, 'Bratara1', 1, 5),
(2, 'Colier Inox 30mm', '', 0, 2, 3, 'colier_inox_30', 1, 7),
(3, 'Bratara Patrata', '', 0, 1, 5, 'Bratara_patrata', 1, 5),
(4, 'Colier Inox 40mm', '', 0, 2, 4, 'colier_inox_30', 2, 6),
(5, 'Bratara cu banut, 16.5', '', 0, 1, 1, 'Bratara_banut_16_5', 1, 5),
(6, 'Bratara cu banut, 18.5', '', 0, 1, 2, 'bratara_banut_18_5', 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `product_options`
--

CREATE TABLE `product_options` (
  `id` int(10) NOT NULL,
  `id_product` int(10) NOT NULL,
  `file` varchar(500) DEFAULT NULL,
  `text` varchar(100) DEFAULT NULL,
  `nume` varchar(50) DEFAULT NULL,
  `id_gravura` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_options`
--

INSERT INTO `product_options` (`id`, `id_product`, `file`, `text`, `nume`, `id_gravura`) VALUES
(1, 6, NULL, 'Dani + Lavi', NULL, 1),
(2, 5, NULL, 'Lavi + Dani', NULL, 3),
(3, 4, NULL, 'Am luat licenta!', NULL, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_invoice` (`id_invoice`),
  ADD KEY `cart_invoice` (`id_invoice`),
  ADD KEY `cart_client` (`id_client`);

--
-- Indexes for table `cart_product`
--
ALTER TABLE `cart_product`
  ADD KEY `cart_cart` (`id_cart`),
  ADD KEY `cart_product_options` (`id_product_options`);

--
-- Indexes for table `categories_subcategories`
--
ALTER TABLE `categories_subcategories`
  ADD KEY `category_category` (`id_category`),
  ADD KEY `category_subcategory` (`id_subcategory`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `description` (`description`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_device` (`id_device`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `gravura`
--
ALTER TABLE `gravura`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `measure`
--
ALTER TABLE `measure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `thickness` (`thickness`);

--
-- Indexes for table `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `model_measure` (`id_measure`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_material` (`id_material`),
  ADD KEY `product_model` (`id_model`),
  ADD KEY `product_category` (`id_category`),
  ADD KEY `product_sub_category` (`id_subcategory`);

--
-- Indexes for table `product_options`
--
ALTER TABLE `product_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_options_product` (`id_product`),
  ADD KEY `product_options_gravura` (`id_gravura`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gravura`
--
ALTER TABLE `gravura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `model`
--
ALTER TABLE `model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_options`
--
ALTER TABLE `product_options`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `cart_invoice` FOREIGN KEY (`id_invoice`) REFERENCES `invoice` (`id`);

--
-- Constraints for table `cart_product`
--
ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_cart` FOREIGN KEY (`id_cart`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `cart_product_options` FOREIGN KEY (`id_product_options`) REFERENCES `product_options` (`id`);

--
-- Constraints for table `categories_subcategories`
--
ALTER TABLE `categories_subcategories`
  ADD CONSTRAINT `category_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `category_subcategory` FOREIGN KEY (`id_subcategory`) REFERENCES `category` (`id`);

--
-- Constraints for table `model`
--
ALTER TABLE `model`
  ADD CONSTRAINT `model_measure` FOREIGN KEY (`id_measure`) REFERENCES `measure` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `product_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`),
  ADD CONSTRAINT `product_model` FOREIGN KEY (`id_model`) REFERENCES `model` (`id`),
  ADD CONSTRAINT `product_sub_category` FOREIGN KEY (`id_subcategory`) REFERENCES `category` (`id`);

--
-- Constraints for table `product_options`
--
ALTER TABLE `product_options`
  ADD CONSTRAINT `product_options_gravura` FOREIGN KEY (`id_gravura`) REFERENCES `gravura` (`id`),
  ADD CONSTRAINT `product_options_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
