set echo off
set serveroutput off
set pagesize 0
set trimspool on
set colsep ','
spool friend_table2.csv
SELECT * FROM friend_table;
spool off

