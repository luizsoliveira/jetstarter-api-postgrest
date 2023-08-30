CREATE SCHEMA api;

-- Creates the role api_anon_user
CREATE ROLE api_anon_user nologin;

-- Allow app_user switch to api_anon_user
GRANT api_anon_user TO app_user;

-- Allow api_anon_user to use the api schema
GRANT usage on schema api to api_anon_user;

CREATE OR REPLACE VIEW api.countries AS
  SELECT id, iso, name, nicename, iso3, numcode, phonecode
  FROM common.countries;

GRANT SELECT ON TABLE api.countries TO api_anon_user

