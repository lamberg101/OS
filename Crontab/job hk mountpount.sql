vi /home/oracle/del_core.sh
cd /u02/app/oracle/diag/rdbms/odbiee/ODBIEE2/cdump/
rm -rf core*

*/10 * * * * /home/oracle/del_core.sh
kalo mau di buat job/crontab nya di node 2 nya




/u02/app/oracle/diag/rdbms/

-rw-r----- 1 oracle asmadmin  941 Jan 20 19:03 ODCTC2C1_mmon_293781.trm
-rw-r----- 1 oracle asmadmin 6.6K Jan 20 19:03 ODCTC2C1_mmon_293781.trc
[oracle@cc011adm01vm01 trace]$ pwd
/u02/app/oracle/diag/rdbms/odctc2c/ODCTC2C1/trace


vi /home/oracle/hk_trace.sh
find /u02/app/oracle/diag/rdbms/od*/OD*/trace \( -name "OD*_ora_*.tr*" -a -type f \) -mtime +5 -exec rm -fr {} \;

*/30 * * * * /home/oracle/hk_trc_file.sh



vi /home/oracle/hk_listener01.sh
cd /u01/app/grid/diag/tnslsnr/cc011adm01vm01/listener_scan1/trace
cat /dev/null > listener_scan1.log
rm -fr listener_scan1_*.log.gz


0 1,13 * * * /home/oracle/hk_listener01.sh

