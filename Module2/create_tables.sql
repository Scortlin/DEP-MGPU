-- Создание таблицы Orders
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
Row_ID INTEGER NOT NULL PRIMARY KEY
 ,Order_ID VARCHAR(14) NOT NULL
 ,Order_Date DATE NOT NULL
 ,Ship_Date DATE NOT NULL
 ,Ship_Mode VARCHAR(14) NOT NULL
 ,Customer_ID VARCHAR(8) NOT NULL
 ,Customer_Name VARCHAR(22) NOT NULL
 ,Segment VARCHAR(11) NOT NULL
 ,Country VARCHAR(13) NOT NULL
 ,City VARCHAR(17) NOT NULL
 ,State VARCHAR(20) NOT NULL
 ,Postal_Code INTEGER
 ,Region VARCHAR(7) NOT NULL
 ,Product_ID VARCHAR(15) NOT NULL
 ,Category VARCHAR(15) NOT NULL
 ,SubCategory VARCHAR(11) NOT NULL
 ,Product_Name VARCHAR(127) NOT NULL
 ,Sales NUMERIC(9,4) NOT NULL
 ,Quantity INTEGER NOT NULL
 ,Discount NUMERIC(4,2) NOT NULL
 ,Profit NUMERIC(21,16) NOT NULL
);
-- Создание таблицы People
DROP TABLE IF EXISTS people;
CREATE TABLE people(
Person VARCHAR(17) NOT NULL PRIMARY KEY
 ,Region VARCHAR(7) NOT NULL
);
-- Создание таблицы Returns
DROP TABLE IF EXISTS returns;
CREATE TABLE returns(
 Person VARCHAR(17) NOT NULL,
 Region VARCHAR(20) NOT NULL
);
-- Создание таблицы stg.orders
CREATE TABLE stg.orders(
   Row_ID        INTEGER  NOT NULL PRIMARY KEY 
  ,Order_ID      VARCHAR(14) NOT NULL
  ,Order_Date    DATE  NOT NULL
  ,Ship_Date     DATE  NOT NULL
  ,Ship_Mode     VARCHAR(14) NOT NULL
  ,Customer_ID   VARCHAR(8) NOT NULL
  ,Customer_Name VARCHAR(22) NOT NULL
  ,Segment       VARCHAR(11) NOT NULL
  ,Country       VARCHAR(13) NOT NULL
  ,City          VARCHAR(17) NOT NULL
  ,State         VARCHAR(20) NOT NULL
  ,Postal_Code   VARCHAR(50) --varchar because can start from 0
  ,Region        VARCHAR(7) NOT NULL
  ,Product_ID    VARCHAR(15) NOT NULL
  ,Category      VARCHAR(15) NOT NULL
  ,SubCategory   VARCHAR(11) NOT NULL
  ,Product_Name  VARCHAR(127) NOT NULL
  ,Sales         NUMERIC(9,4) NOT NULL
  ,Quantity      INTEGER  NOT NULL
  ,Discount      NUMERIC(4,2) NOT NULL
  ,Profit        NUMERIC(21,16) NOT NULL
);
-- Создание таблицы dw.shipping_dim
CREATE TABLE dw.shipping_dim
(
 ship_id       serial NOT NULL,
 shipping_mode varchar(14) NOT NULL,
 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
);
-- Создание таблицы dw.customer_dim
CREATE TABLE dw.customer_dim
(
cust_id serial NOT NULL,
customer_id   varchar(8) NOT NULL, --id can't be NULL
 customer_name varchar(22) NOT NULL,
 CONSTRAINT PK_customer_dim PRIMARY KEY ( cust_id )
);
-- Создание таблицы dw.geo_dim
CREATE TABLE dw.geo_dim
(
 geo_id      serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(17) NOT NULL,
 state       varchar(20) NOT NULL,
 postal_code varchar(20) NULL,       --can't be integer, we lost first 0
 CONSTRAINT PK_geo_dim PRIMARY KEY ( geo_id )
);
-- Создание таблицы dw.product_dim
CREATE TABLE dw.product_dim
(
 prod_id   serial NOT NULL, --we created surrogated key
 product_id   varchar(50) NOT NULL,  --exist in ORDERS table
 product_name varchar(127) NOT NULL,
 category     varchar(15) NOT NULL,
 sub_category varchar(11) NOT NULL,
 segment      varchar(11) NOT NULL,
 CONSTRAINT PK_product_dim PRIMARY KEY ( prod_id )
);
-- Создание таблицы dw.calendar_dim
CREATE TABLE dw.calendar_dim
(
dateid serial  NOT NULL,
year        int NOT NULL,
quarter     int NOT NULL,
month       int NOT NULL,
week        int NOT NULL,
date        date NOT NULL,
week_day    varchar(20) NOT NULL,
leap  varchar(20) NOT NULL,
CONSTRAINT PK_calendar_dim PRIMARY KEY ( dateid )
);
-- Создание таблицы dw.sales_fact
CREATE TABLE dw.sales_fact
(
 sales_id      serial NOT NULL,
 cust_id integer NOT NULL,
 order_date_id integer NOT NULL,
 ship_date_id integer NOT NULL,
 prod_id  integer NOT NULL,
 ship_id     integer NOT NULL,
 geo_id      integer NOT NULL,
 order_id    varchar(25) NOT NULL,
 sales       numeric(9,4) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 quantity    int4 NOT NULL,
 discount    numeric(4,2) NOT NULL,
 CONSTRAINT PK_sales_fact PRIMARY KEY ( sales_id ));