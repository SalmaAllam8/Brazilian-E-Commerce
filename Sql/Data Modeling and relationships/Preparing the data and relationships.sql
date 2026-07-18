CREATE TABLE IF NOT EXISTS `Customers` (
	`customer_id` VARCHAR(32) NOT NULL,
	`customer_unique` VARCHAR(32) UNIQUE,
	`customer_zip_code` VARCHAR(5),
	`customer_city` VARCHAR(32),
	`customer_state` VARCHAR(32),
	PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS `Products` (
	`product_id` VARCHAR(32) NOT NULL,
	`product_category_name` VARCHAR(32),
	`product_name_length` MEDIUMINT,
	`product_description_length` INTEGER,
	`product_photos_qty` SMALLINT,
	`product_weight_g` DECIMAL(8,2),
	`product_length_cm` DECIMAL(8,2),
	`product_height_cm` DECIMAL(8,2),
	`product_width_cm` DECIMAL(8,2),
	PRIMARY KEY (`product_id`),
	CHECK (product_weight_g >= 0),
	CHECK (product_length_cm >= 0),
	CHECK (product_height_cm >= 0),
	CHECK (product_width_cm >= 0),
	CHECK (product_photos_qty >= 0),
	CHECK (product_name_length >= 0),
	CHECK (product_description_length >= 0)
);

CREATE TABLE IF NOT EXISTS `Seller` (
	`seller_id` VARCHAR(32) NOT NULL,
	`seller_zip_code_prefix` VARCHAR(5),
	`seller_city` VARCHAR(32),
	`seller_state` VARCHAR(32),
	PRIMARY KEY (`seller_id`)
);

CREATE TABLE IF NOT EXISTS `Orders` (
	`order_id` VARCHAR(32) NOT NULL,
	`customer_id` VARCHAR(32),
	`order_purchase_timestamp` DATETIME,
	`order_approved_at` DATETIME,
	`order_delivered_carrier_date` DATETIME,
	`order_delivered_customer_date` DATETIME,
	`order_estimated_delivery_date` DATETIME,
	PRIMARY KEY (order_id),
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE INDEX `Orders_index_customer_id`
ON `Orders` (`customer_id`);

CREATE TABLE IF NOT EXISTS `Order_items` (
	`order_id` VARCHAR(32) NOT NULL,
	`order_item_id` INTEGER NOT NULL,
	`product_id` VARCHAR(32) NOT NULL,
	`seller_id` VARCHAR(32) NOT NULL,
	`price` DECIMAL(10,2),
	`freight_value` DECIMAL(10,2),
	PRIMARY KEY (`order_id`, `order_item_id`),
	CHECK (price >= 0),
	CHECK (freight_value >= 0),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

CREATE INDEX `Order_items_index_product_id`
ON `Order_items` (`product_id`);

CREATE INDEX `Order_items_index_seller_id`
ON `Order_items` (`seller_id`);

CREATE TABLE IF NOT EXISTS `order_payment` (
	`order_id` VARCHAR(32) NOT NULL,
	`payment_sequence` INTEGER NOT NULL,
	`payment_type` VARCHAR(32),
	`payment_installment` INTEGER,
	`payment_value` DECIMAL(10,2),
	PRIMARY KEY (`order_id`, `payment_sequence`),
	CHECK (payment_installment >= 1),
	CHECK (payment_value >= 0),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE INDEX `order_payment_index_order_id`
ON `order_payment` (`order_id`);

CREATE TABLE IF NOT EXISTS `Order_Reviews` (
	`review_id` VARCHAR(32) NOT NULL,
	`order_id` VARCHAR(32) NOT NULL,
	`review_score` SMALLINT,
	`review_comment` TEXT,
	`review_creation_date` DATETIME,
	`review_answer_timestamp` DATETIME,
	PRIMARY KEY (review_id),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id),
	CHECK (review_score BETWEEN 1 AND 5)
);

CREATE INDEX `Order_Reviews_index_order_id`
ON `Order_Reviews` (`order_id`);

CREATE TABLE IF NOT EXISTS `Geolocation` (
	`geolocation_zip_code` VARCHAR(5) NOT NULL,
	`geolocation_lat` FLOAT,
	`geolocation_lng` FLOAT,
	`geolocation_city` VARCHAR(32),
	`geolocation_state` VARCHAR(32)
);

CREATE INDEX `Geolocation_index_zip_code`
ON `Geolocation` (`geolocation_zip_code`);



