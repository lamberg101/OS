wa#Check IP SCAN
srvctl config scan

------------------------------------------------------------------------------------------------------------------------------

#MONITORING USING WATCH.
watch -n15 "echo exit | sqlplus -s / as sysdba @/home/oracle/longops.sql"


------------------------------------------------------------------------------------------------------------------------------

#RESET PASS

run> passwd
Masuk mtegarc trus sudo su --> masuk ke user root
Baru reset
run> Passwd oracle

ganti pass bisa pake habibrk > sudo su - > passwd oracle > exit

------------------------------------------------------------------------------------------------------------------------------


#Check SIZE ALL FILE
--find /temp/*.tmp -mtime +90 -print | du -skh

------------------------------------------------------------------------------------------------------------------------------

#Check NUMBER OF FILE
--find /temp/*.tmp -mtime +90 -print | wc -l 
--du -sh /tmp/*.tmp -mtime +90 -print | wc -l

------------------------------------------------------------------------------------------------------------------------------

#Check BACKUP CONTROL FILE
--ls -lrth /zfssa/exapdb/backup*/prod/* | grep control
--ls -lrth /zfssa/exapdb/backup*/prod/db/*.ctl 

------------------------------------------------------------------------------------------------------------------------------

#GREP TOTAL
--du -ch /tmp/*.tmp -mtime +90 -print | grep total
--du -ch /public_html/images/*.jpg | grep total


=============================================================================================================================

--to check alert
grep "Bad TTC Packet Detected: DB Logon User" alert_DBNAME1.log | awk -F ":" '{print $4","$5","$7"}' | awk -F "," '{print $1"|"$3"|"$5}' | sort | uniq -c 


-to check alert first appear
grep -b2 "ORA-03137: malformed TTC packet from client rejected:" alert_DBNAME1.log | Head

--to count similar alert
grep -b2 "ORA-03137: malformed TTC packet from client rejected:" alert_DBNAME1.log | wc -l


=============================================================================================================================



grep "Fri Dec 24 05:56" /u01/app/oracle/diag/rdbms/oprfsev/OPRFSEV1/trace/alert_OPRFSEV1.log

grep -i "shutdown" /u01/app/oracle/diag/rdbms/oprfsev/OPRFSEV1/trace/alert_OPRFSEV1.log


grep -i -b2 "shutdown" /u01/app/oracle/diag/rdbms/opdgpos19/OPDGPOS191/trace/alert_OPDGPOS191.log | tail
grep -i -b2 "shutdown" /u01/app/oracle/diag/rdbms/opdgpos19/OPDGPOS192/trace/alert_OPDGPOS192.log | tail



sed -n '4571848,4572114 p' /u01/app/oracle/diag/rdbms/oprfsev/OPRFSEV1/trace/alert_OPRFSEV1.log


grep -n "2021-05-08T17" alert_BLACKREZIM.log 
sed -n '2088656,2097258 p' alert_OPSCVTBS1.log
ps -ef | grep pmon | awk -F "_" '{print "exaimcpdb01 "$3}'  |sort




ps -ef | grep pmon | awk -F " " '{print $8}' | awk -F "_" '{print $3}'



--Check LOG
tail -10000 /u01/app/oracle/diag/rdbms/oppreprg/OPPREPRG1/trace/alert_OPPREPRG1.log | grep -B 10 -A 5 "corrupt"
tail -2000 /u01/app/oracle/diag/rdbms/oppomtbs/OPPOMTBS2/trace/alert_OPPOMTBS2.log | grep -A3 -B3 "extend"
tail -500000 /u01/app/oracle/diag/rdbms/oppomtbs/OPPOMTBS2/trace/alert_OPPOMTBS2.log | grep -A3 -B3 "ORA-"

#Check log
tail -3000 /u01/app/oracle/diag/rdbms/oppom/OPPOM1/trace/alert_OPPOM1.log | grep ADDRESS=
tail -4000 alert.log | grep -B 10 "TNS: dan seterusnya" | wc -l


tail -3000 listener.log | grep -B 10 "TNS-12518"
tail -3000 listener.log | grep -B 10 "TNS-12505"

--------------------------------------------------------------------------------------------------------------

--Check jumlah file
find core.* -mtime +90 | wc -l

--------------------------------------------------------------------------------------------------------------
--Check PID
ps -ef | egrep "pid|pid"
ps -ef | grep "1234|1234|2121"

--------------------------------------------------------------------------------------------------------------
--TNSPING
tnsping service_name 10

--------------------------------------------------------------------------------------------------------------







