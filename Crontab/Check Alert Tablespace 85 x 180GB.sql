[oracle@oem13cpdb1 ~]$ cat /home/oracle/Oracle_Alert/tbs_opremedybsd.sh 
DBALIST="dba@telkomsel.co.id"

TARGET="OPREMEDYBSD"

. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f tablespace_opremedy.* namaDB_tbs_remedy.txt

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> tablespace_opremedy.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> tablespace_opremedy.tmp
echo " " >> tablespace_opremedy.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_dbname.sh oracle $i`
echo " " > namaDB_tbs_remedy.txt
echo " " >> namaDB_tbs_remedy.txt
echo "DB Name : $namaDB, waktu : $waktu" >> namaDB_tbs_remedy.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set feed off
set linesize 100
set pagesize 200
col "MAXSIZE (MB)" for 999999999.99
col "USED (MB)" for 999999999.99
col "FREE (MB)" for 999999999.99
col "% USED" for 999.99
spool tablespace_opremedy.alert
Select   ddf.TABLESPACE_NAME "TABLESPACE",
         ddf.MAXBYTES "MAXSIZE (MB)",
         (ddf.BYTES - dfs.bytes) "USED (MB)",
         ddf.MAXBYTES-(ddf.BYTES - dfs.bytes) "FREE (MB)",
         round(((ddf.BYTES - dfs.BYTES)/ddf.MAXBYTES)*100,2) "% USED"
from    (select TABLESPACE_NAME,
         round(sum(BYTES)/1024/1024,2) bytes,
         round(sum(decode(autoextensible,'NO',BYTES,MAXBYTES))/1024/1024,2) maxbytes
         from   dba_data_files
         group  by TABLESPACE_NAME) ddf,
        (select TABLESPACE_NAME,
                round(sum(BYTES)/1024/1024,2) bytes
         from   dba_free_space
         group  by TABLESPACE_NAME) dfs
where    ddf.TABLESPACE_NAME=dfs.TABLESPACE_NAME
and  round(((ddf.BYTES - dfs.BYTES)/ddf.MAXBYTES)*100,2) > 85
and round(ddf.MAXBYTES-(ddf.BYTES - dfs.bytes)) < 180000
order by (((ddf.BYTES - dfs.BYTES))/ddf.MAXBYTES) desc, (ddf.MAXBYTES-(ddf.BYTES - dfs.bytes));
spool off
exit
!
if [ `cat tablespace_opremedy.alert|wc -l` -gt 0 ]
then
          cat namaDB_tbs_remedy.txt >> tablespace_opremedy.tmp
          cat tablespace_opremedy.alert >> tablespace_opremedy.tmp
fi
fi
done
mailx -s "TABLESPACE ALERT opremedy " $DBALIST < tablespace_opremedy.tmp

You have mail in /var/spool/mail/oracle

[END] 12/9/2020 5:39:29 AM
