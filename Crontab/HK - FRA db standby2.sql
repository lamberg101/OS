#####hk standby arch
10 4,16 * * * /home/oracle/script/hk_arch_ODPOMDG1.sh



[oracle@exa62bsdpdb1-mgt ~]$ cat /home/oracle/script/hk_arch_OPNBPBSD.sh

export ORACLE_SID=ODPOMCDG1
export ORACLE_BASE=/u02/app/oracle
export ORACLE_HOME=/u02/app/oracle/product/12.1.0/dbhome_3
$ORACLE_HOME/bin/rman target / trace=/home/oracle/script/ODPOMCDG_ARCH.trc << EOF
run {
delete force noprompt archivelog until time 'sysdate-7';}
crosscheck archivelog all;
exit
EOF