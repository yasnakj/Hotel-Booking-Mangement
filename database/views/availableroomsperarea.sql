-- View: public.availableroomsperarea

-- DROP VIEW public.availableroomsperarea;

CREATE OR REPLACE VIEW public.availableroomsperarea
 AS
 SELECT SUBSTRING(h.address SIMILAR '%[^0-9,]%'::text ESCAPE ' '::text) AS area,
    count(*) AS available_rooms
   FROM hotel h
     JOIN room r ON h.id_hotel = r.id_hotel
  WHERE r.is_available = true
  GROUP BY (SUBSTRING(h.address SIMILAR '%[^0-9,]%'::text ESCAPE ' '::text));

ALTER TABLE public.availableroomsperarea
    OWNER TO postgres;

