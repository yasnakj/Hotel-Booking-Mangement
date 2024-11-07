--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-03-30 23:19:49 EDT

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
-- TOC entry 233 (class 1255 OID 33041)
-- Name: ensure_manager_exists(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ensure_manager_exists() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW.Role = 'Manager' AND NOT EXISTS (
        SELECT 1 FROM Employees WHERE HotelID = NEW.HotelID AND Role = 'Manager' AND EmployeeID != NEW.EmployeeID
    )) THEN
        RETURN NEW;
    ELSEIF (NEW.Role != 'Manager' AND NOT EXISTS (
        SELECT 1 FROM Employees WHERE HotelID = NEW.HotelID AND Role = 'Manager'
    )) THEN
        RAISE EXCEPTION 'Each hotel must have at least one manager.';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ensure_manager_exists() OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 40963)
-- Name: fn_prevent_hotel_deletion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_prevent_hotel_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Check for active bookings
  IF EXISTS (SELECT 1 FROM Bookings WHERE ID_Hotel = OLD.ID_Hotel) THEN
    RAISE EXCEPTION 'Cannot delete hotel with active bookings.';
  END IF;

  RETURN OLD;
END;
$$;


ALTER FUNCTION public.fn_prevent_hotel_deletion() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 40960)
-- Name: fn_update_room_availability(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_update_room_availability() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Assuming there's a column 'is_available' in the 'Room' table to update
  UPDATE Room
  SET is_available = FALSE
  WHERE Room_Number = NEW.Room_Number AND ID_Hotel = NEW.ID_Hotel;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.fn_update_room_availability() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 33206)
-- Name: archive; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.archive (
    id_archive integer NOT NULL,
    number_bookings integer NOT NULL,
    number_rentings integer NOT NULL
);


ALTER TABLE public.archive OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 33205)
-- Name: archive_id_archive_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.archive_id_archive_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.archive_id_archive_seq OWNER TO postgres;

--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 229
-- Name: archive_id_archive_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.archive_id_archive_seq OWNED BY public.archive.id_archive;


--
-- TOC entry 220 (class 1259 OID 33133)
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel (
    id_hotel integer NOT NULL,
    chain_id integer,
    contact_emails character varying(255) NOT NULL,
    phone_number character varying(20),
    address character varying(255) NOT NULL,
    name character varying(255)
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33167)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    room_number integer NOT NULL,
    id_hotel integer NOT NULL,
    room_price numeric(10,2) NOT NULL,
    amenities text,
    capacity character varying(50),
    problems text,
    extendable boolean NOT NULL,
    view character varying(50),
    is_available boolean DEFAULT true
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 40970)
-- Name: availableroomsperarea; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.availableroomsperarea AS
 SELECT SUBSTRING(h.address SIMILAR '%[^0-9,]%'::text ESCAPE ' '::text) AS area,
    count(*) AS available_rooms
   FROM (public.hotel h
     JOIN public.room r ON ((h.id_hotel = r.id_hotel)))
  WHERE (r.is_available = true)
  GROUP BY (SUBSTRING(h.address SIMILAR '%[^0-9,]%'::text ESCAPE ' '::text));


ALTER VIEW public.availableroomsperarea OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 33192)
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id_booking integer NOT NULL,
    id_hotel integer,
    room_number integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    special_request text
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 33191)
-- Name: bookings_id_booking_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_id_booking_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_booking_seq OWNER TO postgres;

--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 227
-- Name: bookings_id_booking_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_id_booking_seq OWNED BY public.bookings.id_booking;


--
-- TOC entry 218 (class 1259 OID 33121)
-- Name: central_office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.central_office (
    id_centoffice integer NOT NULL,
    address character varying(255) NOT NULL,
    chain_id integer
);


ALTER TABLE public.central_office OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 33120)
-- Name: central_office_id_centoffice_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.central_office_id_centoffice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.central_office_id_centoffice_seq OWNER TO postgres;

--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 217
-- Name: central_office_id_centoffice_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.central_office_id_centoffice_seq OWNED BY public.central_office.id_centoffice;


--
-- TOC entry 223 (class 1259 OID 33159)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id_customer integer NOT NULL,
    name character varying(255) NOT NULL,
    registration_date date NOT NULL,
    address character varying(255) NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 33158)
-- Name: customer_id_customer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_customer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_id_customer_seq OWNER TO postgres;

--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 222
-- Name: customer_id_customer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_id_customer_seq OWNED BY public.customer.id_customer;


--
-- TOC entry 221 (class 1259 OID 33146)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    ssn_sin character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    salary numeric(10,2) NOT NULL,
    address character varying(255) NOT NULL,
    id_hotel integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33112)
-- Name: hotel_chain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel_chain (
    chain_id integer NOT NULL,
    name character varying(255) NOT NULL,
    number_hotels integer NOT NULL,
    phone_number character varying(20),
    contact_emails character varying(255) NOT NULL
);


ALTER TABLE public.hotel_chain OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 33111)
-- Name: hotel_chain_chain_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotel_chain_chain_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_chain_chain_id_seq OWNER TO postgres;

--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 215
-- Name: hotel_chain_chain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotel_chain_chain_id_seq OWNED BY public.hotel_chain.chain_id;


--
-- TOC entry 219 (class 1259 OID 33132)
-- Name: hotel_id_hotel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotel_id_hotel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_id_hotel_seq OWNER TO postgres;

--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 219
-- Name: hotel_id_hotel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotel_id_hotel_seq OWNED BY public.hotel.id_hotel;


--
-- TOC entry 226 (class 1259 OID 33180)
-- Name: renting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.renting (
    id_renting integer NOT NULL,
    id_hotel integer,
    room_number integer,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE public.renting OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33179)
-- Name: renting_id_renting_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.renting_id_renting_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.renting_id_renting_seq OWNER TO postgres;

--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 225
-- Name: renting_id_renting_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.renting_id_renting_seq OWNED BY public.renting.id_renting;


--
-- TOC entry 232 (class 1259 OID 40975)
-- Name: totalcapacityperhotel; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.totalcapacityperhotel AS
SELECT
    NULL::integer AS id_hotel,
    NULL::character varying(255) AS hotel_address,
    NULL::bigint AS total_capacity;


ALTER VIEW public.totalcapacityperhotel OWNER TO postgres;

--
-- TOC entry 3499 (class 2604 OID 33209)
-- Name: archive id_archive; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archive ALTER COLUMN id_archive SET DEFAULT nextval('public.archive_id_archive_seq'::regclass);


--
-- TOC entry 3498 (class 2604 OID 33195)
-- Name: bookings id_booking; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id_booking SET DEFAULT nextval('public.bookings_id_booking_seq'::regclass);


--
-- TOC entry 3493 (class 2604 OID 33124)
-- Name: central_office id_centoffice; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.central_office ALTER COLUMN id_centoffice SET DEFAULT nextval('public.central_office_id_centoffice_seq'::regclass);


--
-- TOC entry 3495 (class 2604 OID 33162)
-- Name: customer id_customer; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN id_customer SET DEFAULT nextval('public.customer_id_customer_seq'::regclass);


--
-- TOC entry 3494 (class 2604 OID 33136)
-- Name: hotel id_hotel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel ALTER COLUMN id_hotel SET DEFAULT nextval('public.hotel_id_hotel_seq'::regclass);


--
-- TOC entry 3492 (class 2604 OID 33115)
-- Name: hotel_chain chain_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_chain ALTER COLUMN chain_id SET DEFAULT nextval('public.hotel_chain_chain_id_seq'::regclass);


--
-- TOC entry 3497 (class 2604 OID 33183)
-- Name: renting id_renting; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.renting ALTER COLUMN id_renting SET DEFAULT nextval('public.renting_id_renting_seq'::regclass);


--
-- TOC entry 3691 (class 0 OID 33206)
-- Dependencies: 230
-- Data for Name: archive; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.archive (id_archive, number_bookings, number_rentings) FROM stdin;
\.


--
-- TOC entry 3689 (class 0 OID 33192)
-- Dependencies: 228
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id_booking, id_hotel, room_number, start_date, end_date, special_request) FROM stdin;
\.


--
-- TOC entry 3679 (class 0 OID 33121)
-- Dependencies: 218
-- Data for Name: central_office; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.central_office (id_centoffice, address, chain_id) FROM stdin;
\.


--
-- TOC entry 3684 (class 0 OID 33159)
-- Dependencies: 223
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id_customer, name, registration_date, address) FROM stdin;
\.


--
-- TOC entry 3682 (class 0 OID 33146)
-- Dependencies: 221
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (ssn_sin, name, title, salary, address, id_hotel) FROM stdin;
\.


--
-- TOC entry 3681 (class 0 OID 33133)
-- Dependencies: 220
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel (id_hotel, chain_id, contact_emails, phone_number, address, name) FROM stdin;
1	1	globalstayny@globalstay.com	212-555-0101	123 Broadway, New York, NY	GlobalStay
2	1	globalstayla@globalstay.com	310-555-0102	456 Sunset Blvd, Los Angeles, CA	GlobalStay
3	1	globalstaychicago@globalstay.com	312-555-0103	789 Lake Shore Dr, Chicago, IL	GlobalStay
4	1	globalstaymiami@globalstay.com	305-555-0104	101 Ocean Ave, Miami, FL	GlobalStay
5	1	globalstayorlando@globalstay.com	407-555-0105	234 Palm St, Orlando, FL	GlobalStay
6	1	globalstayatlanta@globalstay.com	404-555-0106	567 Peachtree St, Atlanta, GA	GlobalStay
7	1	globalstaydallas@globalstay.com	214-555-0107	890 Main St, Dallas, TX	GlobalStay
8	1	globalstayseattle@globalstay.com	206-555-0108	345 Harbor Dr, Seattle, WA	GlobalStay
9	2	info@horizoninns.com	800-555-0102	1234 Main St, Houston, TX	HorizonInns
10	2	reservations@horizoninns.com	512-555-0102	5678 Oak St, Austin, TX	HorizonInns
11	2	hello@horizoninns.com	615-555-0102	910 Elm St, Nashville, TN	HorizonInns
12	2	support@horizoninns.com	404-555-0102	1212 Maple Ave, Atlanta, GA	HorizonInns
13	2	horizoninnschicago@horizoninns.com	312-555-0102	1313 Lake St, Chicago, IL	HorizonInns
14	2	horizoninnsdetroit@horizoninns.com	313-555-0102	1414 Cherry St, Detroit, MI	HorizonInns
15	2	horizoninnsla@horizoninns.com	213-555-0102	1515 Vine St, Los Angeles, CA	HorizonInns
16	2	horizoninnsnyc@horizoninns.com	212-555-0102	1616 Broadway, New York, NY	HorizonInns
17	3	support@cityscapehotels.com	800-555-0103	1234 Market St, San Francisco, CA	CityScape Hotels
18	3	info@cityscapehotels.com	415-555-0103	5678 Pine St, Denver, CO	CityScape Hotels
19	3	cityscapehotelsmiami@cityscapehotels.com	305-555-0103	910 Ocean Dr, Miami, FL	CityScape Hotels
20	3	cityscapehotelsorlando@cityscapehotels.com	407-555-0103	1212 Palm St, Orlando, FL	CityScape Hotels
21	3	cityscapehotelsseattle@cityscapehotels.com	206-555-0103	1313 Harbor Dr, Seattle, WA	CityScape Hotels
22	3	cityscapehotelschicago@cityscapehotels.com	312-555-0103	1414 Lake St, Chicago, IL	CityScape Hotels
23	3	cityscapehotelsdallas@cityscapehotels.com	214-555-0103	1515 Main St, Dallas, TX	CityScape Hotels
24	3	cityscapehotelsatlanta@cityscapehotels.com	404-555-0103	1616 Peachtree St, Atlanta, GA	CityScape Hotels
25	4	hello@mountainviewresorts.com	800-555-0104	1234 Mountain View Dr, Boulder, CO	MountainView Resorts
26	4	reservations@mountainviewresorts.com	303-555-0104	5678 Valley View Dr, Aspen, CO	MountainView Resorts
27	4	mountainviewresortsnyc@mountainviewresorts.com	212-555-0104	910 Summit St, New York, NY	MountainView Resorts
28	4	mountainviewresortsla@mountainviewresorts.com	310-555-0104	1212 Hillside Ave, Los Angeles, CA	MountainView Resorts
29	4	mountainviewresortsmiami@mountainviewresorts.com	305-555-0104	1313 Ridge Rd, Miami, FL	MountainView Resorts
30	4	mountainviewresortsseattle@mountainviewresorts.com	206-555-0104	1414 Mountain Rd, Seattle, WA	MountainView Resorts
31	4	mountainviewresortsdallas@mountainviewresorts.com	214-555-0104	1515 Cliffside Dr, Dallas, TX	MountainView Resorts
32	4	mountainviewresortsatlanta@mountainviewresorts.com	404-555-0104	1616 Vista St, Atlanta, GA	MountainView Resorts
33	5	contact@seasidestays.com	800-555-0105	1234 Beach Blvd, Miami, FL	SeaSide Stays
34	5	reservations@seasidestays.com	305-555-0105	5678 Ocean Dr, Fort Lauderdale, FL	SeaSide Stays
35	5	hello@seasidestays.com	954-555-0105	910 Shoreline Ave, Daytona Beach, FL	SeaSide Stays
36	5	support@seasidestays.com	386-555-0105	1212 Sandy St, Panama City Beach, FL	SeaSide Stays
37	5	seasidestaysnyc@seasidestays.com	212-555-0105	1313 Wave St, New York, NY	SeaSide Stays
38	5	seasidestaysla@seasidestays.com	310-555-0105	1414 Surf St, Los Angeles, CA	SeaSide Stays
39	5	seasidestayschicago@seasidestays.com	312-555-0105	1515 Sand St, Chicago, IL	SeaSide Stays
40	5	seasidestaysseattle@seasidestays.com	206-555-0105	1616 Tide St, Seattle, WA	SeaSide Stays
\.


--
-- TOC entry 3677 (class 0 OID 33112)
-- Dependencies: 216
-- Data for Name: hotel_chain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel_chain (chain_id, name, number_hotels, phone_number, contact_emails) FROM stdin;
1	GlobalStay	15	1-800-555-0101	contact@globalstay.com
2	HorizonInns	20	1-800-555-0102	info@horizoninns.com
3	CityScape Hotels	18	1-800-555-0103	support@cityscapehotels.com
4	MountainView Resorts	12	1-800-555-0104	hello@mountainviewresorts.com
5	SeaSide Stays	14	1-800-555-0105	contact@seasidestays.com
\.


--
-- TOC entry 3687 (class 0 OID 33180)
-- Dependencies: 226
-- Data for Name: renting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.renting (id_renting, id_hotel, room_number, start_date, end_date) FROM stdin;
\.


--
-- TOC entry 3685 (class 0 OID 33167)
-- Dependencies: 224
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (room_number, id_hotel, room_price, amenities, capacity, problems, extendable, view, is_available) FROM stdin;
101	1	200.00	TV, Air Condition, Fridge	Single	\N	f	City	t
102	1	300.00	TV, Air Condition, Fridge, Coffee Maker	Double	\N	t	City	t
103	1	250.00	TV, Air Condition	Single	Minor wear and tear	f	Courtyard	t
104	1	400.00	TV, Air Condition, Fridge, Spa Tub	Suite	\N	t	Skyline	t
105	1	350.00	TV, Air Condition, Fridge	Double	\N	f	Park	t
101	9	150.00	TV, Air Condition	Single	None	f	City	t
102	9	200.00	TV, Air Condition, Fridge	Double	None	t	City	t
103	9	250.00	TV, Air Condition, Fridge, Coffee Maker	Double	None	t	City	t
104	9	300.00	TV, Air Condition, Fridge, Microwave	Double	None	t	City	t
105	9	400.00	TV, Air Condition, Fridge, Spa Tub	Suite	None	t	City	t
101	17	250.00	TV, Air Condition, Fridge	Single	\N	f	City	t
102	17	350.00	TV, Air Condition, Fridge, Coffee Maker	Double	\N	t	City	t
103	17	300.00	TV, Air Condition, Fridge	Double	\N	t	City	t
104	17	400.00	TV, Air Condition, Fridge, Microwave	Double	\N	t	City	t
105	17	500.00	TV, Air Condition, Fridge, Spa Tub	Suite	\N	t	City	t
101	25	300.00	TV, Air Condition, Fridge	Single	None	f	Mountain	t
102	25	400.00	TV, Air Condition, Fridge, Coffee Maker	Double	None	t	Mountain	t
103	25	500.00	TV, Air Condition, Fridge	Double	None	t	Mountain	t
104	25	600.00	TV, Air Condition, Fridge, Microwave	Double	None	t	Mountain	t
105	25	800.00	TV, Air Condition, Fridge, Spa Tub	Suite	None	t	Mountain	t
101	33	200.00	TV, Air Condition	Single	\N	f	Ocean	t
102	33	300.00	TV, Air Condition, Fridge	Double	\N	t	Ocean	t
103	33	350.00	TV, Air Condition, Fridge	Double	\N	t	Ocean	t
104	33	400.00	TV, Air Condition, Fridge, Microwave	Double	\N	t	Ocean	t
105	33	500.00	TV, Air Condition, Fridge, Spa Tub	Suite	\N	t	Ocean	t
\.


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 229
-- Name: archive_id_archive_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.archive_id_archive_seq', 1, false);


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 227
-- Name: bookings_id_booking_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_id_booking_seq', 1, false);


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 217
-- Name: central_office_id_centoffice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.central_office_id_centoffice_seq', 1, false);


--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 222
-- Name: customer_id_customer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_id_customer_seq', 1, false);


--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 215
-- Name: hotel_chain_chain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotel_chain_chain_id_seq', 5, true);


--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 219
-- Name: hotel_id_hotel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotel_id_hotel_seq', 40, true);


--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 225
-- Name: renting_id_renting_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.renting_id_renting_seq', 1, false);


--
-- TOC entry 3522 (class 2606 OID 33211)
-- Name: archive archive_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY (id_archive);


--
-- TOC entry 3519 (class 2606 OID 33199)
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id_booking);


--
-- TOC entry 3503 (class 2606 OID 33126)
-- Name: central_office central_office_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.central_office
    ADD CONSTRAINT central_office_pkey PRIMARY KEY (id_centoffice);


--
-- TOC entry 3510 (class 2606 OID 33166)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id_customer);


--
-- TOC entry 3508 (class 2606 OID 33152)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (ssn_sin);


--
-- TOC entry 3501 (class 2606 OID 33119)
-- Name: hotel_chain hotel_chain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel_chain
    ADD CONSTRAINT hotel_chain_pkey PRIMARY KEY (chain_id);


--
-- TOC entry 3505 (class 2606 OID 33140)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id_hotel);


--
-- TOC entry 3517 (class 2606 OID 33185)
-- Name: renting renting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_pkey PRIMARY KEY (id_renting);


--
-- TOC entry 3515 (class 2606 OID 33173)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_number, id_hotel);


--
-- TOC entry 3520 (class 1259 OID 40966)
-- Name: idx_booking_dates; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_dates ON public.bookings USING btree (start_date, end_date);


--
-- TOC entry 3506 (class 1259 OID 40967)
-- Name: idx_hotel_chain_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hotel_chain_id ON public.hotel USING btree (chain_id);


--
-- TOC entry 3511 (class 1259 OID 40965)
-- Name: idx_room_availability; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_room_availability ON public.room USING btree (is_available);


--
-- TOC entry 3512 (class 1259 OID 40968)
-- Name: idx_room_hotel_room_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_room_hotel_room_number ON public.room USING btree (id_hotel, room_number);


--
-- TOC entry 3513 (class 1259 OID 40969)
-- Name: idx_room_price; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_room_price ON public.room USING btree (room_price);


--
-- TOC entry 3675 (class 2618 OID 40978)
-- Name: totalcapacityperhotel _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.totalcapacityperhotel AS
 SELECT h.id_hotel,
    h.address AS hotel_address,
    sum((r.capacity)::integer) AS total_capacity
   FROM (public.hotel h
     JOIN public.room r ON ((h.id_hotel = r.id_hotel)))
  GROUP BY h.id_hotel;


--
-- TOC entry 3530 (class 2620 OID 40961)
-- Name: bookings trg_after_booking; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_after_booking AFTER INSERT ON public.bookings FOR EACH ROW EXECUTE FUNCTION public.fn_update_room_availability();


--
-- TOC entry 3529 (class 2620 OID 40964)
-- Name: hotel trg_before_hotel_deletion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_before_hotel_deletion BEFORE DELETE ON public.hotel FOR EACH ROW EXECUTE FUNCTION public.fn_prevent_hotel_deletion();


--
-- TOC entry 3528 (class 2606 OID 33200)
-- Name: bookings bookings_id_hotel_room_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_id_hotel_room_number_fkey FOREIGN KEY (id_hotel, room_number) REFERENCES public.room(id_hotel, room_number) ON DELETE CASCADE;


--
-- TOC entry 3523 (class 2606 OID 33127)
-- Name: central_office central_office_chain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.central_office
    ADD CONSTRAINT central_office_chain_id_fkey FOREIGN KEY (chain_id) REFERENCES public.hotel_chain(chain_id) ON DELETE SET NULL;


--
-- TOC entry 3525 (class 2606 OID 33153)
-- Name: employee employee_id_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_id_hotel_fkey FOREIGN KEY (id_hotel) REFERENCES public.hotel(id_hotel) ON DELETE SET NULL;


--
-- TOC entry 3524 (class 2606 OID 33141)
-- Name: hotel hotel_chain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_chain_id_fkey FOREIGN KEY (chain_id) REFERENCES public.hotel_chain(chain_id) ON DELETE CASCADE;


--
-- TOC entry 3527 (class 2606 OID 33186)
-- Name: renting renting_id_hotel_room_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_id_hotel_room_number_fkey FOREIGN KEY (id_hotel, room_number) REFERENCES public.room(id_hotel, room_number) ON DELETE CASCADE;


--
-- TOC entry 3526 (class 2606 OID 33174)
-- Name: room room_id_hotel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_id_hotel_fkey FOREIGN KEY (id_hotel) REFERENCES public.hotel(id_hotel) ON DELETE CASCADE;


-- Completed on 2024-03-30 23:19:49 EDT

--
-- PostgreSQL database dump complete
--

