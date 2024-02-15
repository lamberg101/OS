[oracle@oem13cpdb1 ~]$ cat Check_dbname.sh
sqlplus -s system/OR4cl35y5#2015@$2 <<EOF
set pagesize 0
set feedback off
set echo off
set verify off
set heading off
set serveroutput off
set termout off
SELECT name from v\$database;
exit
EOF
exit
