/#!/bin/ksh
#############################################
# Alert Script for Tablespace Monitoring    #
# Created by : Deni Kusmayadi 04/07/2013    # 
# Ver : 1.0                                 #
#############################################
#OPRBRICK2 temporary 20190123
#############################################

DBALIST="dba@telkomsel.co.id"


#DECOMM SEMENTARA OPRFSODBSD1

TARGET="OPRFSOD1 OPRFSOD2 OPRFSOD OPSCVTBS1 OPSCVTBS2 OPSCVTBS OPPOMTBS1 OPPOMTBS2 OPPOMTBS OPKMNEW OPKMNEW1 OPKMNEW2 PRODHR1 PRODHR2 OPCRMBE PROD OPIDMEXAP OBIEEEXAP opirwbs opottwbs OPPURCS OPPURCS1 OPPURCS2  OPOMS OPSPTFRE OPTMNTSL OPANGLN OPAUTODB OPCCM OPCMC OPC2PEVN OPCOMMET62A OPCRMRPT OPCUG OPEPM OPFMS OPHRN  OPKNDILU OPMORISA OPMRA OPOPE62 OPPREPRG OPRMDFMS OPTWIRE OPPESCC OPTSELCC62B  OPCUGSME OPIKNOWS OPREPORT  OPIFS62B OPLACIMA OPUIMTBS OPUIMTBS1 OPUIMTBS2 OPSCM OPSELREP OPRFWL OPRFSEV OPSIAD OPBDM OPCMDB  OPGTWFIMC OPVERONAIMC OPPRCISE OPCRON19 OPDGPOS OPTOIPIMC OPCRMSBIMC OPHPOINTIMC OPVCICA OPCTC OPHVC OBIEERCU OPOPE OPESBTBS OBIEETBS OPCBDLTBS OPCEOTBS OPESBTBS OPGIS OPICASMSTBS  OPNBP OPREMNOTBS OPREVASSTBS OPTUNAITBS OPC2PM OPCITTBS OPRAFM OPBIBSD OPREMEDYBSD OPHUMBSD OPRBRICKBSD OPIDMBSD OPPRN OPEABSD OPRCSBSD OPDMS  OPRFWL   OPC2P OPB2BOP OPCRMBE1 PROD1 OPIDMEXAP1 OBIEEEXAP1 OPOMS1 OPSPTFRE1 OPTMNTSL1 OPANGLN1 OPAUTODB1 OPCCM1 OPCMC1 OPC2PEVN1 OPCOMMET62A1 OPCRMRPT1 OPCUG1 OPEPM1 OPFMS1 OPHRN1  OPKNDILU1 OPMORISA1 OPMRA1 OPOPE621 OPPREPRG1 OPRMDFMS1 OPTWIRE1 OPPESCC1  OPTSELCC62B1   OPCUGSME1 OPIKNOWS1 OPREPORT1  OPIFS62B1 OPLACIMA1 OPCIS1 OPSCM1 OPSELREP1 OPRFWL1 OPRFSEV1 OPSIAD1 OPBDM1 OPCMDB1  OPGTWFIMC1 OPVERONAIMC1 OPPRCISE1 OPCRON191 OPDGPOS1 OPTOIPIMC1 OPCRMSBIMC1 OPHPOINTIMC1 OPVCICA1 OPCTC1 OPHVC1 OBIEERCU1 OPOPE1  OPESBTBS1 OBIEETBS1 OPCBDLTBS1 OPCEO1 OPESBTBS1 OPGIS1 OPICASMSTBS1  OPNBP1 OPREMNOTBS1 OPREVASSTBS1 OPTUNAITBS1 OPC2PM1 OPCITTBS1  OPRAFM1 OPBIBSD1 OPREMEDYBSD1 OPHUMBSD1 OPRBRICKBSD1 OPIDMBSD1 OPPRN1 OPEABSD1 OPRCSBSD1 OPDMS1 OPRFWL1   OPC2P1 OPB2BOP1 OPCRMBE2 PROD2 OPIDMEXAP2 OBIEEEXAP2  OPOMS2 OPSPTFRE2 OPTMNTSL2 OPANGLN2 OPAUTODB2 OPCCM2 OPCMC2 OPC2PEVN2 OPCOMMET62A2 OPCRMRPT2 OPCUG2  OPEPM2 OPFMS2 OPHRN2  OPKNDILU2 OPMORISA2 OPMRA2 OPOPE622 OPPREPRG2 OPRMDFMS2 OPTWIRE2 OPPESCC2 OPTSELCC62B2  OPCUGSME2 OPIKNOWS2 OPREPORT2  OPIFS62B2 OPLACIMA2 OPCIS2 OPSCM2 OPSELREP2 OPRFWL2 OPRFSEV2 OPSIAD OPBDM2 OPCMDB2  OPGTWFIMC2 OPVERONAIMC2 OPPRCISE2 OPCRON192 OPDGPOS2  OPTOIPIMC2 OPCRMSBIMC2 OPHPOINTIMC2 OPVCICA2 OPCTC2 OPHVC2 OBIEERCU2 OPOPE2  OPESBTBS2 OBIEETBS2 OPCBDLTBS2 OPCEO2 OPESBTBS2 OPGIS2 OPICASMSTBS2  OPNBP2 OPREMNOTBS2 OPREVASSTBS2 OPTUNAITBS2 OPC2PM2 OPCITTBS2 OPRAFM2  OPBIBSD2 OPREMEDYBSD2 OPHUMBSD2 OPRBRICKBSD2 OPIDMBSD2 OPPRN2 OPEABSD2 OPRCSBSD2 OPDMS2 OPRFWL2 OPC2P2 OPB2BOP2 OPRMD9IT OPRMD9IT1 OPRMD9IT2"


. /home/oracle/.profileCapture
cd /home/oracle/Alert
rm -f db_avail.* 

for i in $TARGET 
do
sqlplus system/OR4cl35y5#2015@$i<<ENDOFSQL
select  sysdate from dual;
exit
ENDOFSQL

ERRORCODE=$?

#Check the return code from SQL Plus
if [ $ERRORCODE -ne 0 ]
then

tanggal=`date`

 echo "------------------------------------------------------------------" >> db_avail.tmp 
 echo "CONNECTION ERROR to : $i date : $tanggal.    ErrorCode: $ERRORCODE" >> db_avail.tmp
 echo "------------------------------------------------------------------" >> db_avail.tmp

else
  echo "SQL Plus Successfully connect to : $i. Code: $ERRORCODE" 
fi
done
if [ `cat db_avail.tmp|wc -l` -gt 1 ]
then
          mailx -s "DB AVAILABLE REPORT" $DBALIST < db_avail.tmp
fi
