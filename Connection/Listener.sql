
--Check KONEKSI BY LISTENER 
--(ada ip apa saja yang nge hit ke server)

$ cat $ORACLE_HOME/network/admin/listener.ora
$ cd /u01/app/oracle/diag/tnslsnr/testet01/listener/trace
$ tail -20f listener.log | grep OPIDM

----------------------------------------------------------------------------------------------------------------------------------------------

--Check IP PERNAH KONEK KE DB TERSEBUT.
more /u01/app/oracle/diag/tnslsnr/exa62bsdpdb1-mgt/listener/alert/log.xml | grep 10.2.121.160  ---disesuaikan path nya


----------------------------------------------------------------------------------------------------------------------------------------------

--Check APAKAH IP SUDAH ADA

$ more /u01/app/11.2.0.4/grid/network/admin/sqlnet.ora | grep ip nya --path nya di sesuaikan dengan grid
$ . .grid profile
$ lsnrctl status  ----Check path
Listener Parameter File   /u01/app/12.1.0.2/grid/network/admin/listener.ora --masauk di sini, cari listener or sql ora


*KALAU BELUM ADA DAN MINTA DI TAMBAHKAN*
--add ip whitelist in exadata (acl)
$ . .grid_profile
$ vi /u01/app/11.2.0.4/grid/network/admin/sqlnet.ora --sesuaikan path nya
$ lsnrctl reload LISTENER

----------------------------------------------------------------------------------------------------------------------------------------------

--RESTART
$ srvctl stop scan_listener
$ srvctl start scan_listener
  

--Check STATUS
$ srvctl status scan_listener
$ ps -ef | grep tns

--Check LISTENER/ALERT/LOG
tail -100 /u01/app/11.2.0.4/grid/log/diag/tnslsnr/testet02/listener_scan2/trace/listener.log

Note!
- Apakah sudah ada ip tertentu di exadata? -- check di sqlnet.ora, kalau belum ada di tambahkan
- Setelah add? --jangan lupa reload listener.
- Kalau tanya ip nya sudah di add apa belum? --tanyakan ip berapa ya

----------------------------------------------------------------------------------------------------------------------------------------------

--START LISTENER
$ lsnrctl status
or
$ lsnrctl status nama_listener
or
$ lsnrctl
LSNTRL> status
LSNTRL> start > exit


--RELOAD LISTENER
. .grid_profile 
$ lsnrctl reload LISTENER


--STOP LISTENER
$ ps -ef | grep inherit
$ lsnrctl status
$ lsnrctl stop
or 
$ srvctl status scan_listener
$ srvctl stop LISTENER_SCAN2
$ srvctl stop LISTENER_SCAN3


---------------------------------------------------------------------------------------------------

--KALAU LISTENER LEPAS
alter system local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=10.53.71.163)(PORT=1521))'  scope=both sid='OPHPOINTIMC1'; --di kedua node

alter system set remote_listener='exapdb62a-scan:1521' scope=both sid='*';
alter system set remote_listener='exaimcpdb-scan:1521' scope=both sid='*';
alter system set remote_listener='exa62bsda-scan:1521' scope=both sid='*';