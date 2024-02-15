Add and remove from cluster

1. ADD TO CLUSTER
$> srvctl add database -d TESTPOIN -o /u01/app/oracle/product/19.0.0.0/dbhome_1
$> srvctl add instance -d TESTPOIN -i TESTPOIN1 -n exa82absdpdbadm01
$> srvctl add instance -d TESTPOIN -i TESTPOIN2 -n exa82absdpdbadm02
$> srvctl modify database -d TESTPOIN -p '+DATA1/TESTPOIN/PARAMETER/spfileTESTPOIN1.ora' ---ambil path nya dari hasil path create spfile 


2. REMOVE FROM CLUSTER
$> srvctl status database -d OPTUNAI
$> srvctl remove database -d OPTUNAI

