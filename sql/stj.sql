-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 31, 2019 at 11:31 PM
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

DROP DATABASE stj;
CREATE DATABASE stj;

USE stj;

CREATE TABLE `cart` (
  `id` int(10) NOT NULL,
  `id_invoice` int(11) NOT NULL,
  `id_client` int(11) NOT NULL,
  `is_in_progress` tinyint NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cart_product`
--

CREATE TABLE `cart_product` (
  `id_cart` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `quantity` int(10) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categories_subcategories`
--

CREATE TABLE `categories_subcategories` (
  `CategoryId` int(10) NOT NULL,
  `SubCategoryId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories_subcategories`
--

INSERT INTO `categories_subcategories` (`CategoryId`, `SubCategoryId`) VALUES
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
  `Id` int(10) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `Level` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`Id`, `Description`, `Level`) VALUES
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
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `salt` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address1` varchar(250) DEFAULT NULL,
  `address2` varchar(250) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gravura`
--

CREATE TABLE `gravura` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `vat_price` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `id_client` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Table structure for table `model`
--

CREATE TABLE `model` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `id_measure` int (10) NULL,
  `id_gravura` int (10) NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `model`
--

INSERT INTO `model` (`id`, `name`, `description`, `price`) VALUES
(1, 'S-Clase', 'Jmecherie', 2000000);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Id` int(10) NOT NULL,
  `Name` varchar(250) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `id_material` int(10) DEFAULT NULL,
  `id_model` int(10) DEFAULT NULL,
  `PicturePath` varchar(500) DEFAULT NULL,
  `CategoryId` int(10) DEFAULT NULL,
  `SubCategoryId` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Name`, `Description`, `id_material`, `id_model`, `PicturePath`, `CategoryId`, `SubCategoryId`) VALUES
(1, 'Bratara 1', '', NULL, NULL, 'Lant1', 1, 5),
(2, 'Bratara 2', '', NULL, NULL, 'Lant1', 1, 6),
(3, 'Bratara 3', '', NULL, NULL, 'Lant1', 1, 6),
(4, 'Colier 1', '', NULL, NULL, 'Lant1', 1, 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`Id`);


ALTER TABLE `categories_subcategories`
  ADD KEY `category_category` (`CategoryId`),
  ADD KEY `category_subcategory` (`SubCategoryId`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gravura`
--
ALTER TABLE `gravura`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_client` (`id_client`);

--
-- Indexes for table `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `measure`
--
ALTER TABLE `measure`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`id`),
  ADD KEY `model_gravura` (`id_gravura`),
  ADD KEY `model_measure` (`id_measure`);

--
-- Indexes for table `model`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_invoice` (`id_invoice`),
  ADD KEY `cart_client` (`id_client`);

--
-- Indexes for table `model`
--
ALTER TABLE `cart_product`
  ADD KEY `cart_cart` (`id_cart`),
  ADD KEY `cart_product` (`id_product`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `product_material` (`id_material`),
  ADD KEY `product_model` (`id_model`),
  ADD KEY `product_category` (`CategoryId`),
  ADD KEY `product_sub_category` (`SubCategoryId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gravura`
--
ALTER TABLE `gravura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `model`
--
ALTER TABLE `model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--

ALTER TABLE `cart`
  ADD CONSTRAINT `cart_invoice` FOREIGN KEY (`id_invoice`) REFERENCES `invoice` (`id`),
  ADD CONSTRAINT `cart_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`Id`);

ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_cart` FOREIGN KEY (`id_cart`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `cart_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`Id`);

ALTER TABLE `categories_subcategories`
  ADD CONSTRAINT `category_category` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `category_subcategory` FOREIGN KEY (`SubCategoryId`) REFERENCES `category` (`id`);

ALTER TABLE `model`
  ADD CONSTRAINT `model_gravura` FOREIGN KEY (`id_gravura`) REFERENCES `gravura` (`id`),
  ADD CONSTRAINT `model_measure` FOREIGN KEY (`id_measure`) REFERENCES `measure` (`id`);

ALTER TABLE `product`
  ADD CONSTRAINT `product_category` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`Id`),
  ADD CONSTRAINT `product_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`),
  ADD CONSTRAINT `product_model` FOREIGN KEY (`id_model`) REFERENCES `model` (`id`),
  ADD CONSTRAINT `product_sub_category` FOREIGN KEY (`SubCategoryId`) REFERENCES `category` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
