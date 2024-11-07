-- View: public.totalcapacityperhotel

-- DROP VIEW public.totalcapacityperhotel;

CREATE OR REPLACE VIEW public.totalcapacityperhotel
 AS
 SELECT h.id_hotel,
    h.address AS hotel_address,
    sum(r.capacity::integer) AS total_capacity
   FROM hotel h
     JOIN room r ON h.id_hotel = r.id_hotel
  GROUP BY h.id_hotel;

ALTER TABLE public.totalcapacityperhotel
    OWNER TO postgres;

