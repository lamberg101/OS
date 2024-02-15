[oracle@dbapdb1 Oracle_Alert]$ cat tegar.sh 
DBALIST="dba@telkomsel.co.id"

TARGET="PROD OPIDMEXAP OBIEEEXAP opirwbs opottwbs OPOMS OPSPTFRE OPTMNTSL OPPGATE OPANGLN OPAUTODB OPCCM OPCMC OPCMTRPT OPCOMMET62A OPCRMRPT OPCUG OPEBILL OPENVIEW62A OPEPM OPFMS OPHRN OPIFS OPKNDILU OPMORISA OPMRA OPOPE62 OPPREPRG OPRMDFMS OPTWIRE OPWITA OPTSELCC62B OPKM OPCUGSME OPIKNOW OPREPORT OPWH OPIFS62B OPLACIMA OPCIS OPSCM OPSELREP OPRFWL OPRFSEV OPSIAD OPNANIA OPBDM OPCMDB OPAPMTDR OPGTWFIMC OPVERONAIMC OPRECISEIMC OPCRON OPDGPOS  OPTOIPIMC OPCRMSBIMC OPHPOINTIMC OPVCICA OPCTC OPHVC OPAPMIMC OBIEERCU OPOPE OTOPE OBIEETBS OPCBDLTBS OPCEOTBS OPESBTBS OPGIS OPICASMSTBS OPICAVCTBS OPNBP OPREMNOTBS OPREVASSTBS OPRMD9IT OPTUNAITBS OPC2PM OPCITTBS OPBIBSD OPREMEDYBSD OPRAFM OPHUMBSD OPRBRICKBSD OPIDMBSD OPREVINA OPPRN OPEABSD OPRCSBSD OPDMS OPRFSODBSD OPRFWL OPPOM OPSCV OPC2P OPB2BOP OTBIBSD OPUIMTBS OPPURCS"

. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f Synch.* nama_user_tegar_copy.txt

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> Synch_tegar_copy.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> Synch_tegar_copy.tmp
echo " " >> Synch_tegar_copy.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_dbname.sh oracle $i`
echo " " > nama_user_tegar_copy.txt
echo " " >> nama_user_tegar_copy.txt
echo "DB Name : $namaDB, waktu : $waktu" >> nama_user_tegar_copy.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i

spool Synch_tegar.alert

ALTER PROFILE DEFAULT LIMIT
SESSIONS_PER_USER UNLIMITED
CPU_PER_SESSION UNLIMITED
CPU_PER_CALL UNLIMITED
CONNECT_TIME UNLIMITED
IDLE_TIME UNLIMITED
LOGICAL_READS_PER_SESSION UNLIMITED
LOGICAL_READS_PER_CALL UNLIMITED
COMPOSITE_LIMIT UNLIMITED
PRIVATE_SGA UNLIMITED
FAILED_LOGIN_ATTEMPTS UNLIMITED
PASSWORD_LIFE_TIME UNLIMITED
PASSWORD_REUSE_TIME UNLIMITED
PASSWORD_REUSE_MAX UNLIMITED
PASSWORD_LOCK_TIME UNLIMITED
PASSWORD_GRACE_TIME UNLIMITED
PASSWORD_VERIFY_FUNCTION NULL;

set feed off
set linesize 200
set pages 400
spool synch_tegar.alert
column username format a20
column account_status format a40
select username, account_status, profile 
from DBA_USERS 
where account_status = 'OPEN' order by 1;

spool off
exit



spool off
exit
!
if [ `cat Synch_tegar_copy.alert|wc -l` -gt 0 ]
then
          cat nama_user_tegar_copy.txt >> Synch_tegar_copy.tmp
          cat Synch_tegar_copy.alert >> Synch_tegar_copy.tmp
fi
fi
done
mailx -s "Synch user tegar " $DBALIST < Synch_tegar_copy.tmp

[oracle@dbapdb1 Oracle_Alert]$ 
