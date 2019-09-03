--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--

ALTER TABLE `cart`
  ADD CONSTRAINT `cart_invoice` FOREIGN KEY (`id_invoice`) REFERENCES `invoice` (`id`),
  ADD CONSTRAINT `cart_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`);

ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_cart` FOREIGN KEY (`id_cart`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `cart_product_options` FOREIGN KEY (`id_product_options`) REFERENCES `product_options` (`id`);

ALTER TABLE `categories_subcategories`
  ADD CONSTRAINT `category_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `category_subcategory` FOREIGN KEY (`id_subcategory`) REFERENCES `category` (`id`);

ALTER TABLE `model`
  ADD CONSTRAINT `model_measure` FOREIGN KEY (`id_measure`) REFERENCES `measure` (`id`);

ALTER TABLE `product_options`
  ADD CONSTRAINT `product_options_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `product_options_gravura` FOREIGN KEY (`id_gravura`) REFERENCES `gravura` (`id`);

ALTER TABLE `product`
  ADD CONSTRAINT `product_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `product_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id`),
  ADD CONSTRAINT `product_model` FOREIGN KEY (`id_model`) REFERENCES `model` (`id`),
  ADD CONSTRAINT `product_sub_category` FOREIGN KEY (`id_subcategory`) REFERENCES `category` (`id`);