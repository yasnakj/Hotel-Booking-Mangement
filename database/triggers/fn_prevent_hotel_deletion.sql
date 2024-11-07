-- FUNCTION: public.fn_prevent_hotel_deletion()

-- DROP FUNCTION IF EXISTS public.fn_prevent_hotel_deletion();

CREATE OR REPLACE FUNCTION public.fn_prevent_hotel_deletion()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  -- Check for active bookings
  IF EXISTS (SELECT 1 FROM Bookings WHERE ID_Hotel = OLD.ID_Hotel) THEN
    RAISE EXCEPTION 'Cannot delete hotel with active bookings.';
  END IF;

  RETURN OLD;
END;
$BODY$;

ALTER FUNCTION public.fn_prevent_hotel_deletion()
    OWNER TO postgres;
