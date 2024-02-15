[oracle@oem13cpdb1 Alert]$ cat Check_Listener_exarflex_n2.sh 

DBALIST="dba@telkomsel.co.id,i_npw_dharmawan@telkomsel.co.id,Taufik_S_Hidayat@telkomsel.co.id,wahyu_setiawan@telkomsel.co.id,ssi_dba_core@sigma.co.id"

TARGET="OBIEETBS2 OPCBDLTBS2 OPCEOTBS2 OPESBTBS2 OPGIS2 OPICASMSTBS2 OPNBP2 OPREMNOTBS2 OPREVASSTBS2 OPRMD9IT2 OPTUNAITBS2 OPC2PM2 OPCITTBS2"

. /home/oracle/.profileCapture
cd /home/oracle/Oracle_Alert
rm -f Check_List_reflex1.* namaDB_Check_List_reflex1.txt 

for i in $TARGET
do
waktu=`date`
hsl=`tnsping $i`
if [ $? -ne 0 ]
then
echo " " >> Check_List_reflex1.tmp
echo "Koneksi ke $i GAGAL, waktu : $waktu" >> Check_List_62B.tmp
echo " " >> Check_List_62B.tmp
else
namaDB=`sh /home/oracle/Oracle_Alert/Check_inst_name.sh oracle $i`
echo " " > namaDB_Check_List_reflex1.txt
echo " " >> namaDB_Check_List_reflex1.txt
echo "DB Name : $namaDB, waktu : $waktu" >> namaDB_Check_List_reflex1.txt
sqlplus -s <<!
system/OR4cl35y5#2015@$i
set linesize 200
spool Check_List_reflex1.alert
show parameter listener;
spool off
exit
!
if [ `cat Check_List_reflex1.alert|wc -l` -gt 0 ]
then
          cat namaDB_Check_List_reflex1.txt >> Check_List_reflex1.tmp
          cat Check_List_reflex1.alert >> Check_List_reflex1.tmp
fi
fi
done
mailx -s "Check_List_reflex1 LIST PARAMETER" $DBALIST < Check_List_reflex1.tmp
[oracle@oem13cpdb1 Alert]$ 