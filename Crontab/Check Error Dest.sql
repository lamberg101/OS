[oracle@oem13cpdb1 ~]$ cat /home/oracle/Oracle_Alert/error_dest.sh
DBALIST="dba@telkomsel.co.id"

TARGET="OPRFSODNEW OPC2PODD OPC2PEVN  OPRFSEV OPUIMTBS OPDGPOS19 OPCRMSB19 OPNBP OPSCVTBS OPPOMTBS OPESBTBS OPPRN OPCEOTBS"

. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f dest_error.* namaDB_dest.txt

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> dest_error.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> dest_error.tmp
echo " " >> dest_error.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_dbname.sh oracle $i`
echo " " > namaDB_dest.txt
echo " " >> namaDB_dest.txt
echo "DB Name : $namaDB, waktu : $waktu" >> namaDB_dest.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 100
set pagesize 200
spool dest_error.alert
select inst_id, dest_id,status, error from gv\$archive_dest_status where dest_id in (1,2,3,4,5) and status = 'ERROR' ;
spool off
exit
!
if [ `cat dest_error.alert|wc -l` -gt 0 ]
then
          cat namaDB_dest.txt >> dest_error.tmp
          cat dest_error.alert >> dest_error.tmp
fi
fi
done
mailx -s "DEST_ERROR" $DBALIST < dest_error.tmp

[oracle@oem13cpdb1 ~]$ 
