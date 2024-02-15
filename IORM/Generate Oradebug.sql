ORADEBUG 
Example commands
---------------------------
Then generate the 10046 for this OS pid (ex: 9834)


connect / as sysdba
oradebug setospid 9834
oradebug tracefile_name
oradebug unlimit
oradebug event 10046 trace name context forever,level 12
oradebug tracefile_name
--wait for few minutes and upload the trace file after closing the hanging session.
oradebug event 10046 trace name context off
disc
