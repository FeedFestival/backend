--
-- Table structure for CATEGORIES
--

DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS categories_subcategories;

CREATE TABLE category (
  `Id` int(10) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `Level` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE category
  ADD PRIMARY KEY (`Id`);

ALTER TABLE category
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Table structure for SUB_CATEGORIES
--

CREATE TABLE categories_subcategories (
  `CategoryId` int(10) NOT NULL,
  `SubCategoryId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO category( `Description`, `Level` )
VALUES( 'Pentru ea', 1 );

INSERT INTO category( `Description`, `Level` )
VALUES( 'Pentru el', 1 );

INSERT INTO category( `Description`, `Level` )
VALUES( 'Pentru cuplu', 1 );

INSERT INTO category( `Description`, `Level` )
VALUES( 'Pentru copii', 1 );

--

INSERT INTO category( `Description`, `Level` )
VALUES( 'Bratari', 2 );
INSERT INTO category( `Description`, `Level` )
VALUES( 'Lanturi', 2 );
INSERT INTO category( `Description`, `Level` )
VALUES( 'Coliere cu nume', 2 );
INSERT INTO category( `Description`, `Level` )
VALUES( 'Banuti mot', 2 );

INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 1, 5 );
INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 1, 6 );
INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 1, 7 );

INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 2, 5 );
INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 2, 6 );

INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 3, 5 );
INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 3, 6 );

INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 4, 5 );
INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 4, 6 );
INSERT INTO categories_subcategories( `CategoryId`, `SubCategoryId` )
VALUES( 4, 8 );
