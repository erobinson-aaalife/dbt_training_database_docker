-- SQL statements to load test data to database

-- Create schemas

CREATE SCHEMA IF NOT EXISTS jaffle_shop; 
CREATE SCHEMA IF NOT EXISTS stripe;
CREATE SCHEMA IF NOT EXISTS dbt_test;


-- Load customers table
CREATE TABLE IF NOT EXISTS jaffle_shop.customers
(
	id integer,
    first_name varchar,
    last_name varchar
);

TRUNCATE TABLE jaffle_shop.customers;

COPY jaffle_shop.customers(id, first_name, last_name) from '/home/datafiles/jaffle_shop_customers.csv' DELIMITER ',' CSV HEADER;

-- Load orders table
CREATE TABLE IF NOT EXISTS jaffle_shop.orders
(
  id integer,
  user_id integer,
  order_date date,
  status varchar,
  _etl_loaded_at timestamp default current_timestamp
);

TRUNCATE TABLE jaffle_shop.orders;

COPY jaffle_shop.orders(id, user_id, order_date, status) from '/home/datafiles/jaffle_shop_orders.csv' DELIMITER ',' CSV HEADER;

-- Load stripe payment table
CREATE TABLE IF NOT EXISTS stripe.payment
(
  id integer,
  orderid integer,
  paymentmethod varchar,
  status varchar,
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

TRUNCATE TABLE stripe.payment;

COPY stripe.payment(id, orderid, paymentmethod, status, amount, created) FROM '/home/datafiles/stripe_payments.csv' DELIMITER ',' CSV HEADER;
