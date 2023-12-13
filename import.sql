-- start mysql with "mysql --local-infile=1 -u root -p"
-- show databasea;
-- use db_name'

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT(5),
    customer_city VARCHAR(30),
    customer_state VARCHAR(30)
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_customers_dataset.csv"
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "order_id","customer_id","order_status","order_purchase_timestamp","order_approved_at","order_delivered_carrier_date","order_delivered_customer_date","order_estimated_delivery_date"
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(15),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_orders_dataset.csv"
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "order_id","order_item_id","product_id","seller_id","shipping_limit_date","price","freight_value"

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_order_items_dataset.csv"
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "order_id","payment_sequential","payment_type","payment_installments","payment_value"
CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER(2),
    payment_type VARCHAR(15),
    payment_installments INTEGER(2),
    payment_value FLOAT
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_order_payments_dataset.csv"
INTO TABLE order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "geolocation_zip_code_prefix","geolocation_lat","geolocation_lng","geolocation_city","geolocation_state"
CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(6),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(15),
    geolocation_state VARCHAR(2)
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_geolocation_dataset.csv"
INTO TABLE geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "review_id","order_id","review_score","review_comment_title","review_comment_message","review_creation_date","review_answer_timestamp"
CREATE TABLE order_reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INTEGER(1),
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_order_reviews_dataset.csv"
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "product_id","product_category_name","product_name_lenght","product_description_lenght","product_photos_qty","product_weight_g","product_length_cm","product_height_cm","product_width_cm"
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(30),
    product_name_lenght INTEGER(5),
    product_description_lenght INTEGER(5),
    product_photos_qty INTEGER(5),
    product_weight_g INTEGER(5),
    product_length_cm INTEGER(5),
    product_height_cm INTEGER(5),
    product_width_cm INTEGER(5)
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_products_dataset.csv"
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- "seller_id","seller_zip_code_prefix","seller_city","seller_state"
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(6),
    seller_city VARCHAR(30),
    seller_state VARCHAR(3)
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/olist_sellers_dataset.csv"
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- product_category_name,product_category_name_english
CREATE TABLE product_category (
    product_category_name VARCHAR(30) PRIMARY KEY,
    product_category_name_english VARCHAR(30)
);

LOAD DATA LOCAL INFILE "C:/Users/user/Documents/SQL/Uploads/product_category_name_translation.csv"
INTO TABLE product_category
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

show TABLES;

SELECT *
FROM order_reviews;

-- TRUNCATE TABLE order_payments;

-- ALTER TABLE customers MODIFY customer_zip_code_prefix VARCHAR(6);
-- ALTER TABLE order_items DROP PRIMARY KEY;