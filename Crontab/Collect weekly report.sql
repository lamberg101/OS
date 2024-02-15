[oracle@oem13cpdb1 Oracle_Alert]$ more report_weekly.sh
set -x
DBALIST="dba@telkomsel.co.id,itsam-l@telkomsel.co.id"
sh /home/oracle/Oracle_Alert/jajal.sh
sh  /home/oracle/Oracle_Alert/asm_size.sh 
#sh  /home/oracle/Oracle_Alert/dbsize_weekly.sh 
sh  /home/oracle/Oracle_Alert/segment_size.sh 
sh  /home/oracle/Oracle_Alert/os_utils2.sh
rm /home/oracle/Oracle_Alert/report_weekly.html
sh /home/oracle/Oracle_Alert/jajal2.sh
echo "weekly report" | mailx -s "weekly report" -a "/home/oracle/Oracle_Alert/report_weekly.html" DBA@telkomsel.co.id ssi_dba_core@sigma.co.id
[oracle@oem13cpdb1 Oracle_Alert]$ 




***************** DETAIL ***************************

[oracle@oem13cpdb1 Oracle_Alert]$ more /home/oracle/Oracle_Alert/jajal.sh

export ORACLE_HOME=/data/OEM12C/product/12.2.0/db1
export ORACLE_SID=CAPTURE
export OMS_HOME=/data/OEM12C/middleware
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/data/OEM12C/product/12.2.0/db1/bin:/data/OEM12C/product/12.2.0/db1/jdk/jre/bin
sqlplus -s << !
system/OR4cl35y5#2015
@/home/oracle/Oracle_Alert/truncate.sql
exit
!
[oracle@oem13cpdb1 Oracle_Alert]$ 


--------------------------------------------------------------------------------------------------------------------------------------------------

[oracle@oem13cpdb1 Oracle_Alert]$ more /home/oracle/Oracle_Alert/asm_size.sh 
export ORACLE_HOME=/data/OEM12C/product/12.2.0/db1
export ORACLE_SID=CAPTURE
export OMS_HOME=/data/OEM12C/middleware
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/data/OEM12C/product/12.2.0/db1/bin:/data/OEM12C/product/12.2.0/db1/jdk/jre/bin

DBALIST="dede.sulaeman@sigma.co.id"
TARGET="OPCRMBE OPIRIS OPGIS OPPOMNEW OPOTTWBS PROD OPCCM OPSCM OPHPOINT OPDGPOS19 OPCITTBS  ZDLRA rabsdp OPPRN"

cd /home/oracle/Oracle_Alert

for i in $TARGET
do
sqlplus -x system/OR4cl35y5#2015<<EOF
alter session set nls_date_format = 'HH24:MI:SS';
set serveroutput on
declare
 DB_DATE varchar2(20);
 HOST_NAME VARCHAR2(64);
 DISK_FILE_NAME varchar2(20);
 TOTAL number(20,5);
 USED number(20,5);
 FREE number(20,5);
 USABLE number(20,5);
 PCT_USED number(20,5);
 REQUIRED_MIRROR_FREE_MB number(20,5);
 no_listner_except   EXCEPTION;
 PRAGMA EXCEPTION_INIT (no_listner_except, -12541);
cursor asm is
select to_char(SYSDATE,'DD-MON-YYYY') "DB_DATE", (SELECT HOST_NAME FROM V\$INSTANCE@$i) "HOST_NAME",
DISK_FILE_NAME,TOTAL,USED,FREE,USABLE,PCT_USED,REQUIRED_MIRROR_FREE_MB from (SELECT b.name  disk_file_name,b.total_mb total,
b.total_mb - b.free_mb used,B.free_mb free,
b.USABLE_FILE_MB USABLE,
decode(b.total_mb,0,0,(ROUND((1- (b.free_mb / b.total_mb))*100, 2))) pct_used,REQUIRED_MIRROR_FREE_MB FROM v\$asm_diskgroup@$i b);
begin
for asm_size in asm loop
DB_DATE := asm_size.DB_DATE;
HOST_NAME := asm_size.HOST_NAME;
DISK_FILE_NAME := asm_size.DISK_FILE_NAME;
TOTAL := asm_size.TOTAL;
USED := asm_size.USED;
FREE := asm_size.FREE;
USABLE := asm_size.USABLE;
PCT_USED := asm_size.PCT_USED;
REQUIRED_MIRROR_FREE_MB := asm_size.REQUIRED_MIRROR_FREE_MB;
begin
      INSERT INTO ASMSIZE VALUES (to_date(DB_DATE,'DD-MON-YYYY'),HOST_NAME,DISK_FILE_NAME,TOTAL,USED,FREE,USABLE,PCT_USED,REQUIRED_MIRROR_FREE_MB);
      EXCEPTION
      WHEN no_listner_except THEN
         insert into ASMSIZE values(to_date(DB_DATE,'DD-MON-YYYY'),HOST_NAME,DISK_FILE_NAME,0,0,0,0,0,0);
         commit;
      WHEN others THEN
         insert into ASMSIZE values(to_date(DB_DATE,'DD-MON-YYYY'),HOST_NAME,DISK_FILE_NAME,0,0,0,0,0,0);
         commit;
end;
end loop;
commit;
end;
/
EOF
done
exit
You have new mail in /var/spool/mail/oracle
[oracle@oem13cpdb1 Oracle_Alert]$ 


--------------------------------------------------------------------------------------------------------------------------------------------------



[oracle@oem13cpdb1 Oracle_Alert]$ more /home/oracle/Oracle_Alert/os_utils2.sh
export ORACLE_HOME=/data/OEM12C/product/12.2.0/db1
export ORACLE_SID=CAPTURE
export OMS_HOME=/data/OEM12C/middleware
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/data/OEM12C/product/12.2.0/db1/bin:/data/OEM12C/product/12.2.0/db1/jdk/jre/bin

TARGET="exa82bsdpdbadm01.telkomsel.co.id exa82bsdpdbadm02.telkomsel.co.id  exa82tbspdbadm01.telkomsel.co.id exa82tbspdbadm02.telkomsel.co.id exa82absdpdbadm01.telkomsel.co.id exa82absdpdbadm02.tel
komsel.co.id exapdb01-mgt.telkomsel.co.id exapdb02-mgt.telkomsel.co.id zdlra62db2-mgt.telkomsel.co.id zdlra62db1-mgt.telkomsel.co.id exa62bsdpdb1-mgt.telkomsel.co.id exa62bsdpdb2-mgt.telkomsel.co.
id exa62pdb1-mgt.telkomsel.co.id exa62pdb2-mgt.telkomsel.co.id exa62pdb3-mgt.telkomsel.co.id exa62pdb4-mgt.telkomsel.co.id exa62tbspdb1-mgt.telkomsel.co.id exa62tbspdb2-mgt.telkomsel.co.id exaimcp
db01-mgt.telkomsel.co.id exaimcpdb02-mgt.telkomsel.co.id "
for i in $TARGET
do
sqlplus -x system/OR4cl35y5#2015<<EOF
set serveroutput on
declare
 HOSTNAME varchar2(50);
 AVG_CPU number(20,5);
 MAX_CPU number(20,5);
 MAX_CPU_DATE varchar2(50);
 AVG_MEM number(20,5);
 MAX_MEM number(20,5);
 MAX_MEM_DATE varchar2(50);
 no_listner_except   EXCEPTION;
 PRAGMA EXCEPTION_INIT (no_listner_except, -12541);
cursor db is
select z.entity_name as HOSTNAME,Z.avg_values AS AVG_CPU, Z.max_values AS MAX_CPU,Z.max_date as MAX_CPU_DATE,X.avg_values AS AVG_MEM,X.max_values AS MAX_MEM,X.max_date as MAX_MEM_DATE
FROM
(select a.entity_name,b.avg_values,a.max_values,a.max_date from
(SELECT entity_name,round(max_value,2) max_values,collection_time as max_date FROM sysman.gc\$metric_values_DAILY@emrep13 WHERE max_value =
(select MAX(max_value)
from sysman.gc\$metric_values_DAILY@emrep13 
where metric_group_name = 'Load'
and metric_column_name = 'cpuUtil'
and (entity_name = '$i')
AND collection_time BETWEEN (SYSDATE - 7) AND SYSDATE)
AND collection_time BETWEEN (SYSDATE - 7) AND SYSDATE) a,
(SELECT round(AVG(avg_value),2) avg_values,entity_name from sysman.gc\$metric_values_DAILY@emrep13
where metric_group_name = 'Load'
and metric_column_name = 'cpuUtil'
and entity_name = '$i'
AND collection_time BETWEEN (SYSDATE - 7) AND SYSDATE
group by entity_name) b
where a.entity_name=b.entity_name) z,
(select distinct(a.entity_name),b.avg_values,a.max_values,a.max_date from
(SELECT entity_name,round(max_value,2) max_values,collection_time as max_date FROM sysman.gc\$metric_values_DAILY@emrep13 WHERE max_value =
(select MAX(max_value)
from sysman.gc\$metric_values_DAILY@emrep13
where metric_group_name = 'Load'
and metric_column_name = 'memUsedPct'
and (entity_name = '$i')
AND collection_time BETWEEN (SYSDATE - 7) AND SYSDATE)
AND collection_time BETWEEN (SYSDATE - 7) AND SYSDATE) a,
(SELECT round(AVG(avg_value),2) avg_values,entity_name from sysman.gc\$metric_values_DAILY@emrep13
where metric_group_name = 'Load'
and metric_column_name = 'memUsedPct'
and entity_name = '$i'
AND collection_time BETWEEN (SYSDATE - 60) AND SYSDATE
group by entity_name) b
where a.entity_name=b.entity_name) x
WHERE Z.entity_name=X.entity_name;
begin
for db_size in db loop
HOSTNAME := db_size.HOSTNAME;
AVG_CPU := db_size.AVG_CPU;
MAX_CPU := db_size.MAX_CPU;
MAX_CPU_DATE := db_size.MAX_CPU_DATE;
AVG_MEM := db_size.AVG_MEM;
MAX_MEM := db_size.MAX_MEM;
MAX_MEM_DATE := db_size.MAX_MEM_DATE;
begin
INSERT INTO OS_UTILS VALUES (HOSTNAME,AVG_CPU,MAX_CPU,MAX_CPU_DATE,AVG_MEM,MAX_MEM,MAX_MEM_DATE);         
commit;
end;
end loop;
commit;
end;
/
EOF
done
exit
[oracle@oem13cpdb1 Oracle_Alert]$ 


--------------------------------------------------------------------------------------------------------------------------------------------------


[oracle@oem13cpdb1 Oracle_Alert]$ more /home/oracle/Oracle_Alert/jajal2.sh

export ORACLE_HOME=/data/OEM12C/product/12.2.0/db1
export ORACLE_SID=CAPTURE
export OMS_HOME=/data/OEM12C/middleware
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/data/OEM12C/product/12.2.0/db1/bin:/data/OEM12C/product/12.2.0/db1/jdk/jre/bin
sqlplus -s <<!
system/OR4cl35y5#2015
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
set lines 700
set pages 1000
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ', ';
SPOOL report_weekly.html
select * from (select DATABASE_NAME, round(RESERVED_SPACE/1024,2) dbsize_on_TB from dbsize where RESERVED_SPACE > 3000) order by dbsize_on_TB desc;
select DB_DATE,HOST_NAME,DATABASE_NAME,RESERVED_SPACE as SIZE_DB from  dbsize order by 2,4 DESC;
select DATABASE_NAME,owner,segment_name, segment_type, SIZE_ON_GIGA from segmentsize where SIZE_ON_GIGA > 100 order by database_name, SIZE_ON_GIGA desc;
select HOST_NAME,DISK_FILE_NAME,round(TOTAL/1024/1024,2) TOTAL,round(used/1024/1024,2) USED,round(free/1024/1024,2) Free,round(usable/1024/1024,2) Usable,REQUIRED_MIRROR,pct_used from asmsize orde
r by 1;
select DATABASE_NAME, host, status, to_char(start_time,'dd-MON-yyyy hh24:mi') start_time,
       to_char(end_time,'dd-MON-yyyy hh24:mi') end_time, input_type, output_device_type
from sysman.mgmt\$ha_backup@emrep13
where INPUT_TYPE in('DB FULL','DB INCR','ARCHIVELOG') and status='FAILED'
and START_TIME between (sysdate-7) and sysdate
order by host, database_name;
select * from os_utils order by 1;
SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
exit
!
[oracle@oem13cpdb1 Oracle_Alert]$ 
You have mail in /var/spool/mail/oracle
