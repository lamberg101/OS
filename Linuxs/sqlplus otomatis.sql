[oracle@oem13cpdb1 dd]$ more sqlplus.sh 
echo "MASUKIN NAMA DB"
read dbname
sqlplus sys/OR4cl35y5#2015@$dbname as sysdba
[oracle@oem13cpdb1 dd]$ 
[oracle@oem13cpdb1 dd]$ date
Tue Jan 18 22:36:23 WIB 2022
[oracle@oem13cpdb1 dd]$ ./sqlplus.sh 
MASUKIN NAMA DB
OPCRMBE

SQL*Plus: Release 12.2.0.1.0 Production on Tue Jan 18 22:36:43 2022

Copyright (c) 1982, 2016, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Partitioning, Real Application Clusters, Automatic Storage Management, OLAP,
Advanced Analytics and Real Application Testing options
