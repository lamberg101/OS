[oracle@oem13cpdb1 ~]$ cat Check_parameter_limits_IMC_node1.sh
DBALIST="dba@telkomsel.co.id,i_npw_dharmawan@telkomsel.co.id,Taufik_S_Hidayat@telkomsel.co.id,wahyu_setiawan@telkomsel.co.id,ssi_dba_core@sigma.co.id"

TARGET="OPGTWFIMC1 OPVERONAIMC1 OPPRCISE1 OPRECISEIMC1 OPCRON1 OPDGPOS1 OPCRMSBIMC1 OPHPOINTIMC1 OPTOIPIMC1 OPVCICA1 OPCTC1 OPHVC1 OBIEERCU1 OPOPE1"

. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f Check_Limit_IMC1.* namaDB_Check_Limit_IMC1.txt

for i in $TARGET 
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> Check_Limit_IMC1.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> Check_Limit_IMC1.tmp
echo " " >> Check_Limit_IMC1.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_inst_name.sh oracle $i`
echo " " > namaDB_Check_Limit_IMC1.txt
echo " " >> namaDB_Check_Limit_IMC1.txt
echo "DB Name : $namaDB, waktu : $waktu" >> namaDB_Check_Limit_IMC1.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i

set linesize 300
col resource_name for a30
spool Check_Limit_IMC1.alert

select INST_ID,resource_name, current_utilization, max_utilization, limit_value 
from gv\$resource_limit 
where resource_name in ('sessions', 'processes');

col username for a30
col machine for a30
col osuser for a30
set pages 500
select distinct username,machine, osuser,inst_id, count(*) 
from gv\$session  
where osuser != 'oracle' 
group by username,machine, osuser, inst_id 
order by count(*) desc;

show parameter listener;

spool off
exit
!
if [ `cat Check_Limit_IMC1.alert|wc -l` -gt 0 ]
then
          cat namaDB_Check_Limit_IMC1.txt >> Check_Limit_IMC1.tmp
	  cat Check_Limit_IMC1.alert >> Check_Limit_IMC1.tmp
fi
fi
done
mailx -s "Check Limit IMC node 1" $DBALIST < Check_Limit_IMC1.tmp
[oracle@oem13cpdb1 ~]$ 
