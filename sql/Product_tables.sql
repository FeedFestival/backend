DROP TABLE IF EXISTS product;

CREATE TABLE product (
  `Id` int(10) NOT NULL,
  `Name` varchar(250) NOT NULL,
  `Description` varchar(500) NULL,
  `id_material` int (10) NULL,
  `id_measure` int (10) NULL,
  `id_model` int (10) NULL,
  `PicturePath` varchar(500) NULL,
  `SubCategoryId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE product
  ADD PRIMARY KEY (`Id`);

ALTER TABLE product
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Table structure for SUB_CATEGORIES
--

INSERT
INTO `product`(
    `Name`, `Description`, `PicturePath`, `SubCategoryId`
  )
VALUES(
    'Bratara 1', '', 'Lant1', 5
);

INSERT
INTO `product`(
    `Name`, `Description`, `PicturePath`, `SubCategoryId`
  )
VALUES(
    'Bratara 2', '', 'Lant1', 6
);

INSERT
INTO `product`(
    `Name`, `Description`, `PicturePath`, `SubCategoryId`
  )
VALUES(
    'Bratara 3', '', 'Lant1', 6
);

INSERT
INTO `product`(
    `Name`, `Description`, `PicturePath`, `SubCategoryId`
  )
VALUES(
    'Colier 1', '', 'Lant1', 6
);