[oracle@exa62bsdpdb1-mgt ~]$ cat /home/oracle/script/hk_arch_OPNBPBSD.sh

export ORACLE_SID=OPNBPBSD1
export ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1
$ORACLE_HOME/bin/rman target / trace=/home/oracle/script/backup/log/OPNBPBSD_ARCH.trc << EOF
run {
delete force noprompt archivelog until time 'sysdate-6';}
crosscheck archivelog all;
exit
EOF

[oracle@exa62bsdpdb1-mgt ~]$ 
