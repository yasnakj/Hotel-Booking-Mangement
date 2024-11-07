--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-03-30 23:25:02 EDT

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
-- TOC entry 3691 (class 0 OID 33206)
-- Dependencies: 230
-- Data for Name: archive; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3689 (class 0 OID 33192)
-- Dependencies: 228
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3679 (class 0 OID 33121)
-- Dependencies: 218
-- Data for Name: central_office; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3684 (class 0 OID 33159)
-- Dependencies: 223
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3682 (class 0 OID 33146)
-- Dependencies: 221
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3681 (class 0 OID 33133)
-- Dependencies: 220
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hotel VALUES (1, 1, 'globalstayny@globalstay.com', '212-555-0101', '123 Broadway, New York, NY', 'GlobalStay');
INSERT INTO public.hotel VALUES (2, 1, 'globalstayla@globalstay.com', '310-555-0102', '456 Sunset Blvd, Los Angeles, CA', 'GlobalStay');
INSERT INTO public.hotel VALUES (3, 1, 'globalstaychicago@globalstay.com', '312-555-0103', '789 Lake Shore Dr, Chicago, IL', 'GlobalStay');
INSERT INTO public.hotel VALUES (4, 1, 'globalstaymiami@globalstay.com', '305-555-0104', '101 Ocean Ave, Miami, FL', 'GlobalStay');
INSERT INTO public.hotel VALUES (5, 1, 'globalstayorlando@globalstay.com', '407-555-0105', '234 Palm St, Orlando, FL', 'GlobalStay');
INSERT INTO public.hotel VALUES (6, 1, 'globalstayatlanta@globalstay.com', '404-555-0106', '567 Peachtree St, Atlanta, GA', 'GlobalStay');
INSERT INTO public.hotel VALUES (7, 1, 'globalstaydallas@globalstay.com', '214-555-0107', '890 Main St, Dallas, TX', 'GlobalStay');
INSERT INTO public.hotel VALUES (8, 1, 'globalstayseattle@globalstay.com', '206-555-0108', '345 Harbor Dr, Seattle, WA', 'GlobalStay');
INSERT INTO public.hotel VALUES (9, 2, 'info@horizoninns.com', '800-555-0102', '1234 Main St, Houston, TX', 'HorizonInns');
INSERT INTO public.hotel VALUES (10, 2, 'reservations@horizoninns.com', '512-555-0102', '5678 Oak St, Austin, TX', 'HorizonInns');
INSERT INTO public.hotel VALUES (11, 2, 'hello@horizoninns.com', '615-555-0102', '910 Elm St, Nashville, TN', 'HorizonInns');
INSERT INTO public.hotel VALUES (12, 2, 'support@horizoninns.com', '404-555-0102', '1212 Maple Ave, Atlanta, GA', 'HorizonInns');
INSERT INTO public.hotel VALUES (13, 2, 'horizoninnschicago@horizoninns.com', '312-555-0102', '1313 Lake St, Chicago, IL', 'HorizonInns');
INSERT INTO public.hotel VALUES (14, 2, 'horizoninnsdetroit@horizoninns.com', '313-555-0102', '1414 Cherry St, Detroit, MI', 'HorizonInns');
INSERT INTO public.hotel VALUES (15, 2, 'horizoninnsla@horizoninns.com', '213-555-0102', '1515 Vine St, Los Angeles, CA', 'HorizonInns');
INSERT INTO public.hotel VALUES (16, 2, 'horizoninnsnyc@horizoninns.com', '212-555-0102', '1616 Broadway, New York, NY', 'HorizonInns');
INSERT INTO public.hotel VALUES (17, 3, 'support@cityscapehotels.com', '800-555-0103', '1234 Market St, San Francisco, CA', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (18, 3, 'info@cityscapehotels.com', '415-555-0103', '5678 Pine St, Denver, CO', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (19, 3, 'cityscapehotelsmiami@cityscapehotels.com', '305-555-0103', '910 Ocean Dr, Miami, FL', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (20, 3, 'cityscapehotelsorlando@cityscapehotels.com', '407-555-0103', '1212 Palm St, Orlando, FL', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (21, 3, 'cityscapehotelsseattle@cityscapehotels.com', '206-555-0103', '1313 Harbor Dr, Seattle, WA', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (22, 3, 'cityscapehotelschicago@cityscapehotels.com', '312-555-0103', '1414 Lake St, Chicago, IL', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (23, 3, 'cityscapehotelsdallas@cityscapehotels.com', '214-555-0103', '1515 Main St, Dallas, TX', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (24, 3, 'cityscapehotelsatlanta@cityscapehotels.com', '404-555-0103', '1616 Peachtree St, Atlanta, GA', 'CityScape Hotels');
INSERT INTO public.hotel VALUES (25, 4, 'hello@mountainviewresorts.com', '800-555-0104', '1234 Mountain View Dr, Boulder, CO', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (26, 4, 'reservations@mountainviewresorts.com', '303-555-0104', '5678 Valley View Dr, Aspen, CO', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (27, 4, 'mountainviewresortsnyc@mountainviewresorts.com', '212-555-0104', '910 Summit St, New York, NY', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (28, 4, 'mountainviewresortsla@mountainviewresorts.com', '310-555-0104', '1212 Hillside Ave, Los Angeles, CA', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (29, 4, 'mountainviewresortsmiami@mountainviewresorts.com', '305-555-0104', '1313 Ridge Rd, Miami, FL', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (30, 4, 'mountainviewresortsseattle@mountainviewresorts.com', '206-555-0104', '1414 Mountain Rd, Seattle, WA', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (31, 4, 'mountainviewresortsdallas@mountainviewresorts.com', '214-555-0104', '1515 Cliffside Dr, Dallas, TX', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (32, 4, 'mountainviewresortsatlanta@mountainviewresorts.com', '404-555-0104', '1616 Vista St, Atlanta, GA', 'MountainView Resorts');
INSERT INTO public.hotel VALUES (33, 5, 'contact@seasidestays.com', '800-555-0105', '1234 Beach Blvd, Miami, FL', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (34, 5, 'reservations@seasidestays.com', '305-555-0105', '5678 Ocean Dr, Fort Lauderdale, FL', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (35, 5, 'hello@seasidestays.com', '954-555-0105', '910 Shoreline Ave, Daytona Beach, FL', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (36, 5, 'support@seasidestays.com', '386-555-0105', '1212 Sandy St, Panama City Beach, FL', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (37, 5, 'seasidestaysnyc@seasidestays.com', '212-555-0105', '1313 Wave St, New York, NY', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (38, 5, 'seasidestaysla@seasidestays.com', '310-555-0105', '1414 Surf St, Los Angeles, CA', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (39, 5, 'seasidestayschicago@seasidestays.com', '312-555-0105', '1515 Sand St, Chicago, IL', 'SeaSide Stays');
INSERT INTO public.hotel VALUES (40, 5, 'seasidestaysseattle@seasidestays.com', '206-555-0105', '1616 Tide St, Seattle, WA', 'SeaSide Stays');


--
-- TOC entry 3677 (class 0 OID 33112)
-- Dependencies: 216
-- Data for Name: hotel_chain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hotel_chain VALUES (1, 'GlobalStay', 15, '1-800-555-0101', 'contact@globalstay.com');
INSERT INTO public.hotel_chain VALUES (2, 'HorizonInns', 20, '1-800-555-0102', 'info@horizoninns.com');
INSERT INTO public.hotel_chain VALUES (3, 'CityScape Hotels', 18, '1-800-555-0103', 'support@cityscapehotels.com');
INSERT INTO public.hotel_chain VALUES (4, 'MountainView Resorts', 12, '1-800-555-0104', 'hello@mountainviewresorts.com');
INSERT INTO public.hotel_chain VALUES (5, 'SeaSide Stays', 14, '1-800-555-0105', 'contact@seasidestays.com');


--
-- TOC entry 3687 (class 0 OID 33180)
-- Dependencies: 226
-- Data for Name: renting; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3685 (class 0 OID 33167)
-- Dependencies: 224
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.room VALUES (101, 1, 200.00, 'TV, Air Condition, Fridge', 'Single', NULL, false, 'City', true);
INSERT INTO public.room VALUES (102, 1, 300.00, 'TV, Air Condition, Fridge, Coffee Maker', 'Double', NULL, true, 'City', true);
INSERT INTO public.room VALUES (103, 1, 250.00, 'TV, Air Condition', 'Single', 'Minor wear and tear', false, 'Courtyard', true);
INSERT INTO public.room VALUES (104, 1, 400.00, 'TV, Air Condition, Fridge, Spa Tub', 'Suite', NULL, true, 'Skyline', true);
INSERT INTO public.room VALUES (105, 1, 350.00, 'TV, Air Condition, Fridge', 'Double', NULL, false, 'Park', true);
INSERT INTO public.room VALUES (101, 9, 150.00, 'TV, Air Condition', 'Single', 'None', false, 'City', true);
INSERT INTO public.room VALUES (102, 9, 200.00, 'TV, Air Condition, Fridge', 'Double', 'None', true, 'City', true);
INSERT INTO public.room VALUES (103, 9, 250.00, 'TV, Air Condition, Fridge, Coffee Maker', 'Double', 'None', true, 'City', true);
INSERT INTO public.room VALUES (104, 9, 300.00, 'TV, Air Condition, Fridge, Microwave', 'Double', 'None', true, 'City', true);
INSERT INTO public.room VALUES (105, 9, 400.00, 'TV, Air Condition, Fridge, Spa Tub', 'Suite', 'None', true, 'City', true);
INSERT INTO public.room VALUES (101, 17, 250.00, 'TV, Air Condition, Fridge', 'Single', NULL, false, 'City', true);
INSERT INTO public.room VALUES (102, 17, 350.00, 'TV, Air Condition, Fridge, Coffee Maker', 'Double', NULL, true, 'City', true);
INSERT INTO public.room VALUES (103, 17, 300.00, 'TV, Air Condition, Fridge', 'Double', NULL, true, 'City', true);
INSERT INTO public.room VALUES (104, 17, 400.00, 'TV, Air Condition, Fridge, Microwave', 'Double', NULL, true, 'City', true);
INSERT INTO public.room VALUES (105, 17, 500.00, 'TV, Air Condition, Fridge, Spa Tub', 'Suite', NULL, true, 'City', true);
INSERT INTO public.room VALUES (101, 25, 300.00, 'TV, Air Condition, Fridge', 'Single', 'None', false, 'Mountain', true);
INSERT INTO public.room VALUES (102, 25, 400.00, 'TV, Air Condition, Fridge, Coffee Maker', 'Double', 'None', true, 'Mountain', true);
INSERT INTO public.room VALUES (103, 25, 500.00, 'TV, Air Condition, Fridge', 'Double', 'None', true, 'Mountain', true);
INSERT INTO public.room VALUES (104, 25, 600.00, 'TV, Air Condition, Fridge, Microwave', 'Double', 'None', true, 'Mountain', true);
INSERT INTO public.room VALUES (105, 25, 800.00, 'TV, Air Condition, Fridge, Spa Tub', 'Suite', 'None', true, 'Mountain', true);
INSERT INTO public.room VALUES (101, 33, 200.00, 'TV, Air Condition', 'Single', NULL, false, 'Ocean', true);
INSERT INTO public.room VALUES (102, 33, 300.00, 'TV, Air Condition, Fridge', 'Double', NULL, true, 'Ocean', true);
INSERT INTO public.room VALUES (103, 33, 350.00, 'TV, Air Condition, Fridge', 'Double', NULL, true, 'Ocean', true);
INSERT INTO public.room VALUES (104, 33, 400.00, 'TV, Air Condition, Fridge, Microwave', 'Double', NULL, true, 'Ocean', true);
INSERT INTO public.room VALUES (105, 33, 500.00, 'TV, Air Condition, Fridge, Spa Tub', 'Suite', NULL, true, 'Ocean', true);


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


-- Completed on 2024-03-30 23:25:02 EDT

--
-- PostgreSQL database dump complete
--

