-- FUNCTION: public.ensure_manager_exists()

-- DROP FUNCTION IF EXISTS public.ensure_manager_exists();

CREATE OR REPLACE FUNCTION public.ensure_manager_exists()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
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
$BODY$;

ALTER FUNCTION public.ensure_manager_exists()
    OWNER TO postgres;
