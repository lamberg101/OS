tnsping service_name 10

--------------------------------------------------------------------------------


[oracle@oem13cpdb1 ~]$ vi tnsping_oppomtbs.sh 

#!/bin/bash

TARGET="OPPOMTBS OPPOMTBS1 OPPOMTBS2"

echo "--start-- " `date`
for db in $TARGET
do
        for i in {1..10}
        do
        echo "$db = " `tnsping $db | grep  OK`
        done
done
echo "--Finish-- " `date`



--------------------------------------------------------------------------------

[oracle@hcismonpapp1 script]$ cat tnsping-loop.sh
lmt=30 --set detik nya

i=1
while [ ${i} -ne ${lmt} ]; do
date
TARGET="OTOPEC_OLD OTOPEC_VIP1 OTOPEC_VIP2"
echo "-----"
sleep 1
let i=${i}+1
done

