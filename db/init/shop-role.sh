#!/bin/sh
# Runs once, when the database volume is first created. The app logs in as
# "shop", which owns the orders database but isn't a superuser.
set -e
psql -v ON_ERROR_STOP=1 -v pw="$DB_PASSWORD" --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<'EOSQL'
CREATE ROLE shop LOGIN PASSWORD :'pw';
-- A safety net for connections a page forgets to close (Postgres allows 100).
ALTER ROLE shop SET idle_session_timeout = '5min';
ALTER DATABASE orders OWNER TO shop;
-- The superuser is then only reachable with docker exec.
ALTER ROLE postgres PASSWORD NULL;
EOSQL
