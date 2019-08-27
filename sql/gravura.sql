DROP TABLE IF EXISTS `gravura`;

CREATE TABLE `gravura` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `gravura`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `gravura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
  