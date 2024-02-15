[ORACLE@OEM13CPDB1 ~]$ CAT STATUS_BACKUP_ZDLRA.SH ==================================================================================================
DBALIST="dba@telkomsel.co.id"
TARGET="OPOMS OPTMNTSL OPCOMMET62A OPPGATE OPCMTRPT OPCUG OPEBILL OPFMS OPHRN OPOPE62 OPPREPRG OPRMDFMS"
batas=85

. /home/oracle/.profileCapture
cd /home/oracle/Alert
find . -type d -ctime +7 | xargs rm -rf
shonum='ps -ef | grep Check_usage_db.sh | grep -v grep | wc -l'
if [ $shonum >= 1 ]; then
    exit 0
fi

tgl=`date +%d%m%Y`
timing=`date +%H%M`
directory=`date +%d-%m-%Y`
if [ ! -d "$directory" ]; then
        mkdir usage_db_$directory
fi
cd usage_db_$directory
rm -f usage_db_* namaDB.txt

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> usage_db.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> tbs_$tgl.tmp
echo " " >> usage_db_$tgl.tmp
else
namaDB=`sh /home/oracle/Alert/Check_dbname.sh oracle $i`
echo " " > namaDB.txt
echo " " >> namaDB.txt
echo "$namaDB, waktu : $waktu" >> namaDB.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 150
spool size_db.alert
set linesize 1000
set pagesize 300
col time_taken_display for a10
select
input_type,
status,
to_char(start_time,'dd/mm/yyyy hh24:mi') start_time,
time_taken_display,
ROUND ((input_bytes/1024/1024/1024),1) input_size_GB,
ROUND ((output_bytes/1024/1024/1024),1) output_size_GB,
output_device_type
from v\$rman_backup_job_details
where start_time > sysdate-8
order by session_key asc;
spool off
exit
!
if [ `cat size_db.alert|wc -l` -gt 0 ]
then
          cat namaDB.txt >> usage_db_$tgl.tmp
          cat size_db.alert >> usage_db_$tgl.tmp
fi
fi
done
mailx -s "STATUS BACKUP ZDLRA" $DBALIST < usage_db_$tgl.tmp
cd /home/oracle/Alert/$directory
mv usage_db_$tgl.tmp usage_db_$tgl-$timing.tmp
[oracle@oem13cpdb1 ~]$ 


[ORACLE@OEM13CPDB1 ~]$ CAT STATUS_BACKUP_ZFS.SH ==================================================================================================
DBALIST="dba@telkomsel.co.id"
TARGET="OPPESCC OPSPOTFR OPSPTFRE OPREMEDYBSD OPREVINA OBIEETBS OPCBDLTBS OPCEOTBS OPESB OPGIS OPICASMSTBS "
batas=85


. /home/oracle/.profileCapture
cd /home/oracle/Alert
find . -type d -ctime +7 | xargs rm -rf
shonum='ps -ef | grep Check_usage_db.sh | grep -v grep | wc -l'
if [ $shonum >= 1 ]; then
    exit 0
fi

tgl=`date +%d%m%Y`
timing=`date +%H%M`
directory=`date +%d-%m-%Y`
if [ ! -d "$directory" ]; then
        mkdir usage_db_$directory
fi
cd usage_db_$directory
rm -f usage_db_* namaDB.txt

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> usage_db.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> tbs_$tgl.tmp
echo " " >> usage_db_$tgl.tmp
else
namaDB=`sh /home/oracle/Alert/Check_dbname.sh oracle $i`
echo " " > namaDB.txt
echo " " >> namaDB.txt
echo "$namaDB, waktu : $waktu" >> namaDB.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 150
spool size_db.alert
set linesize 1000
set pagesize 300
col time_taken_display for a10
select
input_type,
status,
to_char(start_time,'dd/mm/yyyy hh24:mi') start_time,
time_taken_display,
ROUND ((input_bytes/1024/1024/1024),1) input_size_GB,
ROUND ((output_bytes/1024/1024/1024),1) output_size_GB,
output_device_type
from v\$rman_backup_job_details
where start_time > sysdate-8
order by session_key asc;
spool off
exit
!
if [ `cat size_db.alert|wc -l` -gt 0 ]
then
          cat namaDB.txt >> usage_db_$tgl.tmp
          cat size_db.alert >> usage_db_$tgl.tmp
fi
fi
done
mailx -s "STATUS BACKUP DISK" $DBALIST < usage_db_$tgl.tmp
cd /home/oracle/Alert/$directory
mv usage_db_$tgl.tmp usage_db_$tgl-$timing.tmp
[oracle@oem13cpdb1 ~]$ 


[ORACLE@OEM13CPDB1 ~]$ CAT STATUS_BACKUP_NETBACKUP.SH ==================================================================================================
DBALIST="dba@telkomsel.co.id"
TARGET="OPCMC OPANGLN OPAUTODB OPCMC62 OPCRMRPT OPENVIEW OPEPM OPKNDILU OPMORISA OPMRA OPTWIRE OPTSELCC62B OPKM OPIKNOW OPREPORT OPWH OPCIS OPSCM OPSIAD OPNANIA OPBDM OPTOIPIMC OBIEERCU"
batas=85

. /home/oracle/.profileCapture
cd /home/oracle/Alert
find . -type d -ctime +7 | xargs rm -rf
shonum='ps -ef | grep Check_usage_db.sh | grep -v grep | wc -l'
if [ $shonum >= 1 ]; then
    exit 0
fi

tgl=`date +%d%m%Y`
timing=`date +%H%M`
directory=`date +%d-%m-%Y`
if [ ! -d "$directory" ]; then
        mkdir usage_db_$directory
fi
cd usage_db_$directory
rm -f usage_db_* namaDB.txt

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> usage_db.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> tbs_$tgl.tmp
echo " " >> usage_db_$tgl.tmp
else
namaDB=`sh /home/oracle/Alert/Check_dbname.sh oracle $i`
echo " " > namaDB.txt
echo " " >> namaDB.txt
echo "$namaDB, waktu : $waktu" >> namaDB.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 150
spool size_db.alert
set linesize 1000
set pagesize 300
col time_taken_display for a10
elect
input_type,
status,
to_char(start_time,'dd/mm/yyyy hh24:mi') start_time,
time_taken_display,
ROUND ((input_bytes/1024/1024/1024),1) input_size_GB,
ROUND ((output_bytes/1024/1024/1024),1) output_size_GB,
output_device_type
from v\$rman_backup_job_details
where start_time > sysdate-8
order by session_key asc;
spool off
exit
!
if [ `cat size_db.alert|wc -l` -gt 0 ]
then
          cat namaDB.txt >> usage_db_$tgl.tmp
          cat size_db.alert >> usage_db_$tgl.tmp
fi
fi
done
mailx -s "STATUS BACKUP NETBACKUP" $DBALIST < usage_db_$tgl.tmp
cd /home/oracle/Alert/$directory
mv usage_db_$tgl.tmp usage_db_$tgl-$timing.tmp