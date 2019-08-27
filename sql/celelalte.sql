DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `id_invoice` int(11) NOT NULL,
  `id_client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `client`;

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

ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

  ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

DROP TABLE IF EXISTS `invoice`;
  CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `vat_price` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `id_client` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_client` (`id_client`);

DROP TABLE IF EXISTS `material`;

CREATE TABLE `material` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gramprice` double DEFAULT NULL,
  `handicraftprice` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE `material`
  ADD PRIMARY KEY (`id`);


DROP TABLE IF EXISTS `measure`;
CREATE TABLE `measure` (
  `id` int(11) NOT NULL,
  `height` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `thickness` double DEFAULT NULL,
  `diameter` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `measure`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `model`
  ADD PRIMARY KEY (`id`);
