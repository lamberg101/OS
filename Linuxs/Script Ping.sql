[oracle@oem13cpdb1 ~]$ cat check_ping.sh 

#!/bin/bash

TARGET="OPREMEDYBSD1
OPREMEDYBSD2
OPRFSOD1
OPRFSOD2
OPC2PODD1
OPC2PODD2
OPPOM1
OPPOM2
OPSCV1
OPSCV2"

echo "--start-- " `date`
for db in $TARGET
do
	for i in {1..10}
	do
        echo "$db = " `tnsping $db | grep  OK`                    
	done
done 
echo "--Finish-- " `date`
[oracle@oem13cpdb1 ~]$ vi check_ping.sh 
