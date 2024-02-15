[oracle@oem13cpdb1 ~]$ more parameter_Check_exatbs2.sh
DBALIST="dba@telkomsel.co.id,i_npw_dharmawan@telkomsel.co.id,Taufik_S_Hidayat@telkomsel.co.id,wahyu_setiawan@telkomsel.co.id,ssi_dba_core@sigma.co.id"

TARGET="
OPPOMTBS2
OPTUNAINEW2
OPGIS2
OPSMSICA192
OPCBDL192
OPCEONEW2
OPC2PODDTBS2
OPRMN9IT2
OPSCVTBS2
OPREMNOTBS2
OPNBP2
OPESB2
PRODHR2
OPOPETBS2
"


. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f Check_Limit_TBS1.* namaDB_Check_Limit_TBS1.txt

for i in $TARGET 
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> Check_Limit_TBS1.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> Check_Limit_TBS1.tmp
echo " " >> Check_Limit_TBS1.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_inst_name.sh oracle $i`
echo " " > namaDB_Check_Limit_TBS1.txt
echo " " >> namaDB_Check_Limit_TBS1.txt
echo "DB Name : $namaDB, waktu : $waktu" >> namaDB_Check_Limit_TBS1.txt
sqlplus -L -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 200
set pagesize 200
col machine for a40
col username for a30
col osuser for a15
col NAME for a15
col VALUE for a15
col TYPE for a15
SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF
SET FEED OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES
col RESOURCE_NAME for a18
spool Check_Limit_TBS1.alert
select (select name from v\$database),INST_ID,
RESOURCE_NAME,CURRENT_UTILIZATION,
ROUND(CURRENT_UTILIZATION/(INITIAL_ALLOCATION / 100 ), 2) used_pct,
MAX_UTILIZATION,INITIAL_ALLOCATION,LIMIT_VALUE 
from gv\$resource_limit where RESOURCE_NAME in ('processes','sessions');
	col machine for a50
	col username for a30
	col osuser for a15
	set lines 300 pages 1000
SELECT inst_id,machine,username,osuser,
	NVL(active_count, 0) AS active,
	NVL(inactive_count, 0) AS inactive,
	NVL(killed_count, 0) AS killed 
FROM   ( SELECT inst_id,machine, status,username,osuser, count(*) AS quantity
	FROM   gv\$session
	GROUP BY machine, status,username,osuser,inst_id)
PIVOT  (SUM(quantity) AS count FOR (status) IN ('ACTIVE' AS active, 'INACTIVE' AS inactive, 'KILLED' AS killed))
ORDER BY 6,1,2,3 asc;
col value for a60
col name for a30
select name, value from v\$parameter where name in ('local_listener','remote_listener');
!echo "--------------------------------------------------------------------------------"
spool off
exit
!
if [ `cat Check_Limit_TBS1.alert|wc -l` -gt 0 ]
then
          cat namaDB_Check_Limit_TBS1.txt >> Check_Limit_TBS1.tmp
	  cat Check_Limit_TBS1.alert >> Check_Limit_TBS1.tmp
fi
fi
done
mailx -s "Check Limit tbs node 2" $DBALIST < Check_Limit_TBS1.tmp
You have mail in /var/spool/mail/oracle