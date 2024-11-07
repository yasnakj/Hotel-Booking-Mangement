-- FUNCTION: public.fn_update_room_availability()

-- DROP FUNCTION IF EXISTS public.fn_update_room_availability();

CREATE OR REPLACE FUNCTION public.fn_update_room_availability()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  -- Assuming there's a column 'is_available' in the 'Room' table to update
  UPDATE Room
  SET is_available = FALSE
  WHERE Room_Number = NEW.Room_Number AND ID_Hotel = NEW.ID_Hotel;

  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.fn_update_room_availability()
    OWNER TO postgres;
