[oracle@oem13cpdb1 Alert]$ cat /home/oracle/Alert/RUN_locking.sh

#!/bin/bash
#DBALIST="itoc@telkomsel.co.id,oracle@oracle11gddb1.telkomsel.co.id,Perdana_R_Hanafi@telkomsel.co.id,dba@telkomsel.co.id,eko_c_pramulanto_t@telkomsel.co.id"
#DBALIST="dba@telkomsel.co.id"
DBALIST="dba@telkomsel.co.id"

TARGET="OPRFSOD OPSCVTBS OPPOMTBS OPKMNEW PRODHR1 OPCRMBE PROD OPIDMEXAP OBIEEEXAP opirwbs opottwbs OPOMS OPSPTFRE OPTMNTSL "

. /home/oracle/.profileCapture  
cd /home/oracle/Alert
shonum=` ps -ef | grep RUN_locking.sh | grep -v grep | wc -l`
if [ $shonum -gt 1 ]; then
    exit 0
fi

tgl=`date +%d%m%Y`
timing=`date +%H%M`

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> tbs.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> tbs.tmp
echo " " >> tbs.tmp
mailx -s "Koneksi gagal dari lock scrip" $DBALIST < tbs.tmp
else
namaDB=`sh /home/oracle/Alert/Check_dbname.sh oracle $i`
echo " " > namaDB.txt
echo " " >> namaDB.txt
echo "$namaDB, waktu : $waktu" >> namaDB.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 70
set pagesize 90
spool lock.alert
col HOST_NAME format a40
select INSTANCE_NAME, HOST_NAME from v\$instance;
set linesize 140
col BLOCKING_SESSION HEADING 'BLOCKING|SESSION'
col INST_ID HEADING 'INST|ID'
col USERNAME format a15
BREAK ON INST_ID SKIP 1
SELECT INST_ID,BLOCKING_SESSION,USERNAME,SID,SQL_ID  FROM gv\$session
WHERE BLOCKING_SESSION IS NOT NULL;
exit
/

spool off
exit
!
if [ `cat lock.alert|grep SID|wc -l` -gt 0 ]
then
          cat namaDB.txt >> lock.tmp
          cat lock.alert >> lock.tmp
          mailx -s "OPTUNAI: DB LOCKING" $DBALIST < lock.tmp
fi
fi
done
cd /home/oracle/Alert
cat lock.tmp >> lock_log.log
rm lock.alert lock.tmp
[oracle@oem13cpdb1 Alert]$ 
