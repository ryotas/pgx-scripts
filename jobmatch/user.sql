-- USER SQL
CREATE USER pgx_user IDENTIFIED BY "oracle"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER pgx_user QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT "CONNECT" TO pgx_user ;
GRANT "RESOURCE" TO pgx_user ;
