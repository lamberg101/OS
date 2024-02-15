start stop cluster

node 2
stop service:
-------------
srvctl status service -d OPB2BOP
srvctl stop service -d OPB2BOP -i OPB2BOP2 -s HAOPB2BOP

srvctl status service -d OPC2PODD
srvctl stop service -d OPC2PODD -i OPC2PODD2 -s C2PODD

stop home:
----------
. .OPDMSNEW_profile
srvctl stop home -o /u01/app/oracle/product/11.2.0.4/dbhome_1 -s /home/oracle/statefile/state_file_11 -n exa62bsdpdb2-mgt -t immediate

. .OPPRN_profile
srvctl stop home -o /u01/app/oracle/product/12.1.0.2/dbhome_1 -s /home/oracle/statefile/state_file_12 -n exa62bsdpdb2-mgt -t immediate

. .OPC2PODD1_18_profile
srvctl stop home -o /u01/app/oracle/product/18.0.0.0/dbhome_1 -s /home/oracle/statefile/state_file_18 -n exa62bsdpdb2-mgt -t immediate

. .OPRAFM19_profile
srvctl stop home -o /u01/app/oracle/product/19.0.0.0/dbhome_1 -s /home/oracle/statefile/state_file_19 -n exa62bsdpdb2-mgt -t immediate

stop cluster
-----------
# cd /u01/app/19.0.0.0/grid/bin
# ./crsctl stop crs



start home:
----------
. .OPDMSNEW_profile
srvctl start home -o /u01/app/oracle/product/11.2.0.4/dbhome_1 -s /home/oracle/statefile/state_file_11 -n exa62bsdpdb2-mgt

. .OPPRN_profile
srvctl start home -o /u01/app/oracle/product/12.1.0.2/dbhome_1 -s /home/oracle/statefile/state_file_12 -n exa62bsdpdb2-mgt

. .OPC2PODD1_18_profile
srvctl start home -o /u01/app/oracle/product/18.0.0.0/dbhome_1 -s /home/oracle/statefile/state_file_18 -n exa62bsdpdb2-mgt

. .OPRAFM19_profile
srvctl start home -o /u01/app/oracle/product/19.0.0.0/dbhome_1 -s /home/oracle/statefile/state_file_19 -n exa62bsdpdb2-mgt
