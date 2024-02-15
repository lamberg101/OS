running file sh

1. masukan data2 penting di file.sh
--> profile 
export ORACLE_SID=OPPOM1
export ORACLE_HOME=/u01/..
export PATH=$ORACLE_HOME/bin..
export LD_LIBRARY..

cd /home/oracle --where the location of the sql file.
sqlplus / as sysdba @index_IDX_UPLOADDATE_BTS_UPLOAD_N.sql trace =/home/oracle/index_IDX_UPLOADDATE_BTS_UPLOAD.log

2. masukan script di file script.sql

select ...

3. jalankan file.sh
$nohup bash -x exec_inde.sh &

--------------------------------------------------------------------------------

$ nohup bash -x filename.sh &
$ nohup sh /home/oracle/script/filename.sh &


--------------------------------------------------------------------------------

Kalau ada $ gunakan \
contoh: from v$database --> v\$database

--------------------------------------------------------------------------------
#replace log?
/home/oracle/script/backup/OPSCV_arch.sh > /dev/null 2>&1 >> /home/oracle/script/backup/log/OPSCV_arch.log

#create new log
/home/oracle/file.sh > /home/oracle/file.log

 