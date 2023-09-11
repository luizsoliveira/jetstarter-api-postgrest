-- SQL statements based on PostgREST documentation
-- aivailable at: https://postgrest.org/en/stable/how-tos/sql-user-management.html#sql-user-management

-- JWT from SQL

--select * from current_setting('app.settings.jwt_secret') limit 1;
ALTER DATABASE app_db SET "app.jwt_secret" TO 'reallyreallyreallyreallyverysafe';


-- add type
CREATE TYPE basic_auth.jwt_token AS (
  token text
);

-- login should be on your exposed schema
create or replace function
login(email text, pass text) returns basic_auth.jwt_token as $$
declare
  _role name;
  result basic_auth.jwt_token;
begin
  -- check email and password
  select basic_auth.user_role(email, pass) into _role;
  if _role is null then
    raise invalid_password using message = 'invalid user or password';
  end if;

  select jwt.sign(
      row_to_json(r), current_setting('APP.JWT_SECRET')
    ) as token
    from (
      select _role as role, login.email as email,
         extract(epoch from now())::integer + 60*60 as exp
    ) r
    into result;
  return result;
end;
$$ language plpgsql security definer;

grant execute on function login(text,text) to api_anon_user;

