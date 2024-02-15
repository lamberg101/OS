[oracle@exa82absdpdbadm01 ~]$ crontab -l
9 * * * * /home/oracle/script/clean_arch.sh > /home/oracle/script/clean_arch.log

############# mount point alert
*/10 * * * * sh /home/oracle/script/alert_mp.sh
*/10 * * * * sh /home/oracle/script/alert_mp_root.sh

[oracle@exa82absdpdbadm01 ~]$ cat /home/oracle/script/alert_mp.sh
#!/bin/bash
FILE1=mp_temp_result.txt
FILE2=mp_temp_mail.txt

df -Pk | awk -v hostname="$(hostname)" '{if (NR != 1) print  $5 $6"%"hostname}' > ${FILE1}
#cat $FILE1
awk -F"%" '{if ($1 >55 && $2 != "/mnt") print $3 " " $2 " over 55% threshold (" $1 "%)"}' ${FILE1} >> ${FILE2}
if [ -s ${FILE2} ]; then
        echo "Last update:" `hostname` " at "`date` >> ${FILE2}
        mail -s "WARNING: Mountpoint alert over threshold" "dba@telkomsel.co.id" < ${FILE2}
        #echo "mail sent"
        #cat ${FILE2}
fi --buka
rm ${FILE1}
rm ${FILE2}

ssh oracle@exa82absdpdbadm02 'df -Pk' | awk -v hostname="exa82absdpdbadm02" '{if (NR != 1) print  $5 $6"%"hostname}' > ${FILE1}
awk -F"%" '{if ($1 >55 && $2 != "/mnt") print $3 " " $2 " over 55% threshold (" $1 "%)"}' ${FILE1} >> ${FILE2}
if [ -s ${FILE2} ]; then
        echo "Last update: exa82absdpdbadm02 at "`date` >> ${FILE2}
        mail -s "WARNING: Mountpoint alert over threshold" "dba@telkomsel.co.id" < ${FILE2}
        #echo "mail sent"
        #cat ${FILE2}
fi --tutup

rm ${FILE1}
rm ${FILE2}

[oracle@exa82absdpdbadm01 ~]$ cat /home/oracle/script/alert_mp_root.sh
#!/bin/bash
FILE1=mp_temp_result.txt
FILE2=mp_temp_mail.txt

df -Pk / | awk -v hostname="$(hostname)" '{if (NR != 1) print  $5 $6"%"hostname}' > ${FILE1}
#cat $FILE1
awk -F"%" '{if ($1 >55 && $2 != "/mnt") print $3 " " $2 " over 55% threshold (" $1 "%)"}' ${FILE1} >> ${FILE2}
if [ -s ${FILE2} ]; then
        echo "Last update:" `hostname` " at "`date` >> ${FILE2}
        mail -s "WARNING: Mountpoint alert over threshold" "dba@telkomsel.co.id;mo_sigma@telkomsel.co.id;" < ${FILE2}
        #echo "mail sent"
        #cat ${FILE2}
fi
rm ${FILE1}
rm ${FILE2}

ssh oracle@exa82absdpdbadm02 'df -Pk /' | awk -v hostname="exa82absdpdbadm02" '{if (NR != 1) print  $5 $6"%"hostname}' > ${FILE1}
awk -F"%" '{if ($1 >55 && $2 != "/mnt") print $3 " " $2 " over 55% threshold (" $1 "%)"}' ${FILE1} >> ${FILE2}
if [ -s ${FILE2} ]; then
        echo "Last update: exa82absdpdbadm02 at "`date` >> ${FILE2}
        mail -s "WARNING: Mountpoint alert over threshold" "dba@telkomsel.co.id;mo_sigma@telkomsel.co.id" < ${FILE2}
        #echo "mail sent"
        #cat ${FILE2}
fi
rm ${FILE1}
rm ${FILE2}

[oracle@exa82absdpdbadm01 ~]$ 
[oracle@exa82absdpdbadm01 ~]$ 
[oracle@exa82absdpdbadm01 ~]$ cat /home/oracle/script/clean_arch.sh
#!/usr/bin/bash
. /home/oracle/.bash_profile

border="================================================================================================================"
date=`date +"%c"`

echo $border
echo $date
echo $border

echo "clean up SCV"

. /home/oracle/.OPSCVBSD_profile

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/12.1.0.2/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PHYSICAL STANDBY" ]] && { echo "ERROR: database not a physical standby"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-10) from v\$archived_log where applied='YES' and thread#=$THREAD;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

echo "clean up OPPOM"

. /home/oracle/.OPPOMNEW_profile

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/12.1.0.2/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PHYSICAL STANDBY" ]] && { echo "ERROR: database not a physical standby"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-10) from v\$archived_log where applied='YES' and thread#=$THREAD;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

echo "clean up OPRMD"

. /home/oracle/.OPRMD12NEW_profile

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/12.1.0.2/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PRIMARY" ]] && { echo "ERROR: database not PRIMARY"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-3) from v\$archived_log where applied='YES' and dest_id=2 and thread#=$THREAD and NEXT_TIME < sysdate-1;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

echo "clean up OPSELREP"

. /home/oracle/.OPSELREPNEW_profile

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/12.1.0.2/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PRIMARY" ]] && { echo "ERROR: database not PRIMARY"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-3) from v\$archived_log where applied='YES' and dest_id=2 and thread#=$THREAD and NEXT_TIME < sysdate-1;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

echo "clean up OPRFSODBSD"

. /home/oracle/.OPRFSODBSD_profile

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/12.1.0.2/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PHYSICAL STANDBY" ]] && { echo "ERROR: database not a physical standby"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-10) from v\$archived_log where applied='YES' and thread#=$THREAD;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

echo "clean up OPDGPOS"

. /home/oracle/.OPDGPOSBSD_profile

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/19.0.0.0/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PHYSICAL STANDBY" ]] && { echo "ERROR: database not a physical standby"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-10) from v\$archived_log where applied='YES' and thread#=$THREAD;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

echo "clean up OPPOIN"

. /home/oracle/.OPPOINBSD_profile

#PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/19.0.0.0/dbhome_1/bin/sqlplus -L -S / as sysdba"
#ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
#[[ "$ROLE" != "PHYSICAL STANDBY" ]] && { echo "ERROR: database not a physical standby"; exit 1; }
#THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
#for THREAD in $THREADS; do
#  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-10) from v\$archived_log where applied='YES' and thread#=$THREAD;" | $SS)
#  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
#done

PRE="set pagesize 0 \n set feedback off \n"; SS="/u01/app/oracle/product/19.0.0.0/dbhome_1/bin/sqlplus -L -S / as sysdba"
ROLE=$(echo -e "$PRE select database_role from v\$database;" | $SS)
[[ "$ROLE" != "PRIMARY" ]] && { echo "ERROR: database not PRIMARY"; exit 1; }
THREADS=$(echo -e "$PRE select distinct thread# from v\$archived_log;" | $SS)
for THREAD in $THREADS; do
  MAX_APPLIED=$(echo -e "$PRE select max(sequence#-3) from v\$archived_log where applied='YES' and dest_id=2 and thread#=$THREAD and NEXT_TIME < sysdate-1;" | $SS)
  echo "delete noprompt archivelog until sequence $MAX_APPLIED thread $THREAD;"|rman target /
done

[oracle@exa82absdpdbadm01 ~]$ 
