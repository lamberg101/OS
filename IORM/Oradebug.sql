
sqlplus '/ as sysdba'
oradebug setmypid
oradebug unlimit
oradebug dump systemstate 258
oradebug dump systemstate 258
oradebug tracefile_name
exit

sqlplus -s '/ as sysdba'
oradebug setmypid
oradebug -G all hanganalyze 4
wait for 3 min
oradebug -G all hanganalyze 4
wait for 3 min
oradebug -G all hanganalyze 4