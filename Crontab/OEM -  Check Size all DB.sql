[oracle@dbapdb1 ~]$ cat /home/oracle/Oracle_Alert/Check_size_db_all.sh
DBALIST="dba@telkomsel.co.id"

#DISMANTLE : OPREFLEX
TARGET="opirwbs opottwbs OPIDM OBIEE PROD OBIEEEXAP OPEAIDSPEXAP OPOMS OPWITA OPSPTFRE OPTMNTSL OPPGATE OPMRA OPOCSRPT OPOPE62 OPTWIRE OPRMDFMS OPPREPRG OPANGLN OPENVIEW62A OPKNDILU OPEPM OPCRMRPT OPCMC OPCMTRPT OPCCM OPCUG OPIFS OPHRN OPFMS OPEBILL OPCOMMET62A OPAUTODB OPMORISA OPNANIA OPTSELCC62B OPKM OPCUGSME OPIKNOW OPREPORT OPWH OPIFS62B OPLACIMA OPCIS OPSCM OPSELREP OPBDM OPCMDB OPRFWL OPRFSEV OPSIAD OPRFSOD OPSPOTFR62B OPGTWFIMC OTOPE OPVERONA OPRECISEIMC OPCRON OPESB OPDGPOS OPENVIEWIMC OPTOIPIMC OPCRMSBIMC OPHPOINTIMC OPIMC OPSPOTFR OPVCICA OPCTC OPAPMTDR OPHVC OPAPMIMC OBIEERCU OPOPE OPTUNAITBS OPCBDLTBS OPCITTBS OPRMD9IT OBIEETBS OPREMNOTBS OPEAIDSPTBS OPGIS OPREVASSTBS OPICAVC OPICASMSTBS OPNBP OPCEO OPC2PM OPESBTBS OPPOM OPRFSODBSD OPHUMBSD OPBIBSD OPRCS OPIDMBSD OPEA OPRBRICKBSD OPRFSEVBSD OPREMEDYBSD OPWEBCCBSD OPPRN OPREVINA OPDOM OPDMS OPRFWLBSD OPRAFM OPC2P "

. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f sizedb_all.* namaDB.txt

for i in $TARGET 
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> sizedb_all.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> sizedb_all.tmp
echo " " >> sizedb_all.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_dbname.sh oracle $i`
echo " " > namaDB.txt
echo " " >> namaDB.txt
echo "DB Name : $namaDB, waktu : $waktu" >> namaDB.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i

set feed off
set linesize 100
set pagesize 200
set echo        off
set feedback    6
set heading     on
set linesize    180
set pagesize    50000
set termout     on
set timing      off
set trimout     on
set trimspool   on
set verify      off
set feed off
clear columns
clear breaks
clear computes
spool sizedb_all.alert

select sum(bytes/1024/1024/1024) from dba_segments;
select sum(bytes/1024/1024/1024) from dba_data_files;

spool off
exit
!
if [ `cat sizedb_all.alert|wc -l` -gt 0 ]
then
          cat namaDB.txt >> sizedb_all.tmp
	  cat sizedb_all.alert >> sizedb_all.tmp
fi
fi
done
mailx -s "sizedb_all" $DBALIST < sizedb_all.tmp

[oracle@dbapdb1 ~]$ 