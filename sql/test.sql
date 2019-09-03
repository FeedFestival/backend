
--
-- Dumping data for table `category`
--

DELETE FROM category;
ALTER TABLE category AUTO_INCREMENT = 0;

INSERT INTO `category` (`id`, `description`, `level`) VALUES
(1, 'Pentru ea', 1),
(2, 'Pentru el', 1),
(3, 'Pentru cuplu', 1),
(4, 'Pentru copii', 1),
(5, 'Bratari', 2),
(6, 'Lanturi', 2),
(7, 'Coliere cu nume', 2),
(8, 'Banuti mot', 2);

--
-- Dumping data for table `categories_subcategories`
--

DELETE FROM categories_subcategories;
ALTER TABLE categories_subcategories AUTO_INCREMENT = 0;

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

--
-- Dumping data for table `measure`
--

DELETE FROM measure;
ALTER TABLE measure AUTO_INCREMENT = 0;

INSERT INTO measure (id, height, width, thickness, diameter) VALUES 
( 1, null, null, 0.75, 16.5),
( 2, null, null, 0.75, 18.5);

--
-- Dumping data for table `model`
--

DELETE FROM model;
ALTER TABLE model AUTO_INCREMENT = 0;

INSERT INTO model (id, name, id_measure, price) VALUES
( 1, 'Banut 16.6', 1, null ),
( 2, 'Banut 18.5', 2, null );

--
-- Dumping data for table `material`
--

DELETE FROM material;
ALTER TABLE material AUTO_INCREMENT = 0;

INSERT INTO material (id, name, gramprice, handicraftprice) VALUES
( 1, 'argint', 20, 20),
( 2, 'inox', null, 5),
( 3, 'aur', 140, 50);

--
-- Dumping data for table `gravura`
--

DELETE FROM gravura;
ALTER TABLE gravura AUTO_INCREMENT = 0;

INSERT INTO gravura (id, type, category) VALUES
(1, 'Fata', null),
(2, 'Spate', null),
(3, 'Fata Verso', null);

--
-- Dumping data for table `product`
--

DELETE FROM product;
ALTER TABLE product AUTO_INCREMENT = 0;

INSERT INTO `product` (`id`, `name`, `description`, `id_material`, `id_model`, `picture_path`, `id_category`, `id_subcategory`) VALUES
(1, 'Bratara 1', '', NULL, NULL, 'Lant1', 1, 5),
(2, 'Lant 2', '', NULL, NULL, 'Lant1', 1, 6),
(3, 'Bratara 3', '', NULL, NULL, 'Lant1', 1, 5),
(4, 'Colier 1', '', NULL, NULL, 'Lant1', 1, 7),
(5, 'Bratara cu banut, 16.5', '', 2, 1, 'Banut1', 1, 5),
(6, 'Bratara cu banut, 18.5', '', 2, 2, 'Banut2', 2, 5);

--
-- Dumping data for table `client`
--

DELETE FROM client;
ALTER TABLE client AUTO_INCREMENT = 0;

INSERT INTO client (id, id_device) VALUES
(1, '2848b212cd593c31b3628b17d21d0fdcd5a8b2e9');

--
-- Dumping data for table `product_options`
--

DELETE FROM product_options;
ALTER TABLE product_options AUTO_INCREMENT = 0;

INSERT INTO product_options (id, id_product,	file, text, nume, id_gravura) VALUES
(1, 6, null, 'Dani + Lavi', NULL, 1),
(2, 5, null, 'Lavi + Dani', NULL, 3);

--
-- Dumping data for table `invoice`
--

DELETE FROM invoice;
ALTER TABLE invoice AUTO_INCREMENT = 0;

INSERT INTO invoice (id, quantity, price, vat_price, total_price) VALUES
(1, null, null, null, null);

--
-- Dumping data for table `cart`
--

DELETE FROM cart;
ALTER TABLE cart AUTO_INCREMENT = 0;

INSERT INTO cart (id, id_invoice, id_client, is_in_progress) VALUES
(1, 1, 1, 1);

--
-- Dumping data for table `cart_product`
--

DELETE FROM cart_product;
ALTER TABLE cart_product AUTO_INCREMENT = 0;

INSERT INTO cart_product (id_cart, id_product_options, quantity) VALUES
(1, 1, 1),
(1, 2, 1);
