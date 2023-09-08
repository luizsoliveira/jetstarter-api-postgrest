-- Creates the role api_anon_user
CREATE ROLE api_anon_user nologin;

-- Allow app_user switch to api_anon_user
GRANT api_anon_user TO app_user;

-- Allow api_anon_user to use the public schema
GRANT usage on schema public to api_anon_user;

-- Allow api_anon_user to use the public schema
GRANT ALL on schema public to api_anon_user;



