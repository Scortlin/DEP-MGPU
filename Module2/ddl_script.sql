--
-- PostgreSQL database dump
--
-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1) 
-- Dumped by pg_dump version 16.6
-- Started on 2025-09-20 07:19:41 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning; 
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 24857)
-- Name: dw; Type: SCHEMA; Schema: -; Owner: admin
--
CREATE SCHEMA dw;

ALTER SCHEMA dw OWNER TO admin;
--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA Public OWNER TO pg_database_owner;
--
-- TOC entry 3418 (class OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner

COMMENT ON SCHEMA public IS 'standard public schema';
--
-- TOC entry 6 (class 2615 OID 16647)
-- Name: stg; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA stg;

ALTER SCHEMA stg OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 24890)
-- Name: calendar_dim; Type: TABLE; Schema: dw; Owner: admin
--


CREATE TABLE dw.calendar_dim ( 
dateid integer NOT NULL, 
year integer NOT NULL, 
quarter integer NOT NULL, 
month integer NOT NULL, 
week integer NOT NULL, 
date date NOT NULL,
week_day character varying (20) NOT NULL, 
leap character varying (20) NOT NULL
);

ALTER TABLE dw.calendar_dim OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 24889)
--Name: calendar_dim_dateid_seq; Type: SEQUENCE; Schema: dw; Owner: admin
--

CREATE SEQUENCE dw.calendar_dim_dateid_seq
AS integer
START WITH 1 INCREMENT BY 1
NO MINVALUE 
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE dw.calendar_dim_dateid_seq OWNER TO admin;
--
-- TOC entry 3420 (class 0 OID 0) 
-- Dependencies: 229
-- Name: calendar_dim_dateid_seq; Type: SEQUENCE OWNED BY; Schema: dw; Owner: admin
--

ALTER SEQUENCE dw.calendar_dim_dateid_seq OWNED BY dw.calendar_dim.dateid;

--
-- TOC entry 224 (class 1259 OID 24866)
-- Name: customer_dim; Type: TABLE; Schema: dw; Owner: admin
--

CREATE TABLE dw.customer_dim (
cust_id integer NOT NULL,
customer_id character varying (8) NOT NULL, 
customer_name character varying (22) NOT NULL
);

ALTER TABLE dw.customer_dim OWNER TO admin;

--
-- TOC entry 223 (class 1259 OID 24865)
-- Name: customer_dim_cust_id_seq; Type: SEQUENCE; Schema: dw; Owner: admin
--

CREATE SEQUENCE dw.customer_dim_cust_id_seq
AS integer
START WITH 1 
INCREMENT BY 1 
NO MINVALUE 
NO MAXVALUE 
CACHE 1;

ALTER SEQUENCE dw.customer_dim_cust_id_seq OWNER TO admin;

--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 223
-- Name: customer_dim_cust_id_seq; Type: SEQUENCE OWNED BY; Schema: dw; Owner: admin

ALTER SEQUENCE dw.customer_dim_cust_id_seq OWNED BY dw.customer_dim.cust_id;


--
-- TOC entry 226 (class 1259 OID 24873)
-- Name: geo_dim; Type: TABLE; Schema: dw; Owner: admin
--

CREATE TABLE dw.geo_dim (
geo_id integer NOT NULL,
country character varying (13) NOT NULL,
city character varying (17) NOT NULL,
state character varying (20) NOT NULL,
postal code character varying(20)
);

ALTER TABLE dw.geo_dim OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 24872)
-- Name: geo_dim_geo_id_seq; Type: SEQUENCE; Schema: dw; Owner: admin
--

CREATE SEQUENCE dw.geo_dim_geo_id_seq
AS integer
START WITH 1 
INCREMENT BY 1 
NO MINVALUE 
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE dw.geo_dim_geo_id_seq OWNER TO admin;

--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 225
-- Name: geo_dim_geo_id_seq; Type: SEQUENCE OWNED BY; Schema: dw; Owner: admin
--

ALTER SEQUENCE dw.geo_dim_geo_id_seq OWNED BY dw.geo_dim.geo_id;

--
-- TOC entry 228 (class 1259 OID 24881)
-- Name: product_dim; Type: TABLE; Schema: dw; Owner: admin
--

CREATE TABLE dw.product_dim (
prod_id integer NOT NULL,
product_id character varying(50) NOT NULL,
product_name character varying(127) NOT NULL,
category character varying(15) NOT NULL,
sub_category character varying(11) NOT NULL,
segment character varying(11) NOT NULL
);

ALTER TABLE dw.product_dim OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 24880)
-- Name: product_dim_prod_id_seq; Type: SEQUENCE; Schema: dw; Owner: admin

CREATE SEQUENCE dw.product_dim_prod_id_seq
AS integer
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;

ALTER SEQUENCE dw.product_dim_prod_id_seq OWNER TO admin;

--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 227
-- Name: product_dim_prod_id_seq; Type: SEQUENCE OWNED BY; Schema: dw; Owner: admin
--

ALTER SEQUENCE dw.product_dim_prod_id_seq OWNED BY dw.product_dim.prod_id;

--
-- TOC entry 232 (class 1259 OID 24897)
-- Name: sales_fact; Type: TABLE; Schema: dw; Owner: admin
--

CREATE TABLE dw.sales_fact (
    sales_id integer NOT NULL,
    cust_id integer NOT NULL,
    order_date_id integer NOT NULL,
    ship_date_id integer NOT NULL,
    prod_id integer NOT NULL,
    ship_id integer NOT NULL,
    geo_id integer NOT NULL,
    order_id character varying(25) NOT NULL,
    sales numeric(9,4) NOT NULL,
    profit numeric(21,16) NOT NULL,
    quantity integer NOT NULL,
    discount numeric(4,2) NOT NULL
);

ALTER TABLE dw.sales_fact OWNER TO admin;

--
-- TOC entry 231 (class 1259 OID 24896)
-- Name: sales_fact_sales_id_seq; Type: SEQUENCE; Schema: dw; Owner: admin
--

CREATE SEQUENCE dw.sales_fact_sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE dw.sales_fact_sales_id_seq OWNER TO admin;

--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 231
-- Name: sales_fact_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: dw; Owner: admin
--

ALTER SEQUENCE dw.sales_fact_sales_id_seq OWNED BY dw.sales_fact.sales_id;

--
-- TOC entry 222 (class 1259 OID 24859)
-- Name: shipping_dim; Type: TABLE; Schema: dw; Owner: admin
--

CREATE TABLE dw.shipping_dim (
    ship_id integer NOT NULL,
    shipping_mode character varying(14) NOT NULL
);

ALTER TABLE dw.shipping_dim OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 24858)
-- Name: shipping_dim_ship_id_seq; Type: SEQUENCE; Schema: dw; Owner: admin
--

CREATE SEQUENCE dw.shipping_dim_ship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE dw.shipping_dim_ship_id_seq OWNER TO admin;

--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 221
-- Name: shipping_dim_ship_id_seq; Type: SEQUENCE OWNED BY; Schema: dw; Owner: admin
--

ALTER SEQUENCE dw.shipping_dim_ship_id_seq OWNED BY dw.shipping_dim.ship_id;

--
-- TOC entry 218 (class 1259 OID 24839)
-- Name: orders; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders (
    row_id integer NOT NULL,
    order_id character varying(14) NOT NULL,
    order_date date NOT NULL,
    ship_date date NOT NULL,
    ship_mode character varying(14) NOT NULL,
    customer_id character varying(8) NOT NULL,
    customer_name character varying(22) NOT NULL,
    segment character varying(11) NOT NULL,
    country character varying(13) NOT NULL,
    city character varying(17) NOT NULL,
    state character varying(20) NOT NULL,
    postal_code integer,
    region character varying(7) NOT NULL,
    product_id character varying(15) NOT NULL,
    category character varying(15) NOT NULL,
    subcategory character varying(11) NOT NULL,
    product_name character varying(127) NOT NULL,
    sales numeric(9,4) NOT NULL
    quantity integer NOT NULL,
    discount numeric(4,2) NOT NULL,
    profit numeric(21,16) NOT NULL
);

ALTER TABLE public.orders OWNER TO admin;

--
-- TOC entry 219 (class 1259 OID 24849)
-- Name: people; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.people (
    person character varying(17) NOT NULL,
    region character varying(7) NOT NULL
);

ALTER TABLE public.people OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 24854)
-- Name: returns; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.returns (
    returned character varying(17) NOT NULL,
    order_id character varying(20) NOT NULL
);

ALTER TABLE public.returns OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 16648)
-- Name: orders; Type: TABLE; Schema: stg; Owner: admin
--

CREATE TABLE stg.orders (
    row_id integer NOT NULL,
    order_id character varying(14) NOT NULL,
    order_date date NOT NULL,
    ship_date date NOT NULL,
    ship_mode character varying(14) NOT NULL,
    customer_id character varying(8) NOT NULL,
    customer_name character varying(22) NOT NULL,
    segment character varying(11) NOT NULL,
    country character varying(13) NOT NULL,
    city character varying(17) NOT NULL,
    state character varying(20) NOT NULL,
    postal_code character varying(50),
    region character varying(7) NOT NULL,
    product_id character varying(15) NOT NULL,
    category character varying(15) NOT NULL,
    subcategory character varying(11) NOT NULL,
    product_name character varying(127) NOT NULL,
    sales numeric(9,4) NOT NULL,
    quantity integer NOT NULL,
    discount numeric(4,2) NOT NULL,
    profit numeric(21,16) NOT NULL
);

ALTER TABLE stg.orders OWNER TO admin;

--
-- TOC entry 3250 (class 2604 OID 24893)
-- Name: calendar_dim dated; Type: DEFAULT; Schema: dw; Owner: admin
--

ALTER TABLE ONLY dw.calendar_dim ALTER COLUMN dated SET DEFAULT nextval('dw.calendar_dim_dated_seq'::regclass);

--
-- TOC entry 3247 (class 2604 OID 24869)
-- Name: customer_dim cust_id; Type: DEFAULT; Schema: dw; Owner: admin
--

ALTER TABLE ONLY dw.customer_dim ALTER COLUMN cust_id SET DEFAULT nextval('dw.customer_dim_cust_id_seq'::regclass);

-- TOC entry 3248 (class 2604 OID 24876)
-- Name: geo_dim geo_id; Type: DEFAULT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.geo_dim ALTER COLUMN geo_id SET DEFAULT nextval('dw.geo_dim_geo_id_seq'::regclass);

-- TOC entry 3249 (class 2604 OID 24884)
-- Name: product_dim prod_id; Type: DEFAULT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.product_dim ALTER COLUMN prod_id SET DEFAULT nextval('dw.product_dim_prod_id_seq'::regclass);

-- TOC entry 3251 (class 2604 OID 24900)
-- Name: sales_fact sales_id; Type: DEFAULT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.sales_fact ALTER COLUMN sales_id SET DEFAULT nextval('dw.sales_fact_sales_id_seq'::regclass);

-- TOC entry 3246 (class 2604 OID 24862)
-- Name: shipping_dim ship_id; Type: DEFAULT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.shipping_dim ALTER COLUMN ship_id SET DEFAULT nextval('dw.shipping_dim_ship_id_seq'::regclass);

-- TOC entry 3267 (class 2606 OID 24895)
-- Name: calendar_dim pk_calendar_dim; Type: CONSTRAINT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.calendar_dim
    ADD CONSTRAINT pk_calendar_dim PRIMARY KEY (dateid);

-- TOC entry 3261 (class 2606 OID 24871)
-- Name: customer_dim pk_customer_dim; Type: CONSTRAINT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.customer_dim
    ADD CONSTRAINT pk_customer_dim PRIMARY KEY (cust_id);

-- TOC entry 3263 (class 2606 OID 24878)
-- Name: geo_dim pk_geo_dim; Type: CONSTRAINT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.geo_dim
    ADD CONSTRAINT pk_geo_dim PRIMARY KEY (geo_id);

-- TOC entry 3265 (class 2606 OID 24886)
-- Name: product_dim pk_product_dim; Type: CONSTRAINT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.product_dim
    ADD CONSTRAINT pk_product_dim PRIMARY KEY (prod_id);

-- TOC entry 3269 (class 2606 OID 24902)
-- Name: sales_fact pk_sales_fact; Type: CONSTRAINT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.sales_fact
    ADD CONSTRAINT pk_sales_fact PRIMARY KEY (sales_id);

-- TOC entry 3259 (class 2606 OID 24864)
-- Name: shipping_dim pk_shipping_dim; Type: CONSTRAINT; Schema: dw; Owner: admin

ALTER TABLE ONLY dw.shipping_dim
    ADD CONSTRAINT pk_shipping_dim PRIMARY KEY (ship_id);

-- TOC entry 3255 (class 2606 OID 24843)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: admin

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (row_id);

-- TOC entry 3257 (class 2606 OID 24853)
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: admin

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person);

-- TOC entry 3253 (class 2606 OID 16652)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: stg; Owner: admin

ALTER TABLE ONLY stg.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (row_id);

-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner

GRANT ALL ON SCHEMA public TO admin;

-- Completed on 2025-09-20 07:19:41 UTC

-- PostgreSQL database dump complete