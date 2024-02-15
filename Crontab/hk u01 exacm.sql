[root@cc011adm01vm01 ~]# crontab -l
#0 1 */5 * 0 find /var/opt/oracle/log/* -name "*.log" -mtime +1 -exec rm {} \; >/dev/null 2>&1
30 22 * * * /home/oracle/hk_trc_file.sh
0 1,13 * * * /home/oracle/hk_listener01.sh
[root@cc011adm01vm01 ~]# cat /home/oracle/hk_trc_file.sh
find /u02/app/oracle/diag/rdbms/od*/OD*/trace -name "*.trc" -mtime +1 -print -delete
find /u02/app/oracle/product/12.1.0/db*/rdbms/audit -name "*.aud" -mtime +1 -print -delete
find /u02/app/oracle/product/11.2.0/db*/rdbms/audit -name "*.aud" -mtime +1 -print -delete
find /u02/app/oracle/product/12.2.0/db*/rdbms/audit -name "*.aud" -mtime +1 -print -delete
find /u02/app/oracle/product/18.0.0.0/db*/rdbms/audit -name "*.aud" -mtime +1 -print -delete
[root@cc011adm01vm01 ~]# cat /home/oracle/hk_listener01.sh
cd /u01/app/grid/diag/tnslsnr/cc011adm01vm01/listener_scan1/trace
cat /dev/null > listener_scan1.log
rm -fr listener_scan1_*.log.gz
