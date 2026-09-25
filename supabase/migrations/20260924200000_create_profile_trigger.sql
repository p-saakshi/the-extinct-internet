CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.profiles (
        id,
        username,
        display_name
    )
    VALUES (
        NEW.id,
        NEW.raw_user_meta_data ->> 'username',
        NEW.raw_user_meta_data ->> 'display_name'
    );

    RETURN NEW;
END;
$$;


CREATE OR REPLACE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();