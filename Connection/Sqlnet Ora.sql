Ip ini (x.x.x.x) sudah di tambahkan ke di listener x42 belum ya?
- Check ip nya di /u01/app/11.2.0.4/grid/network/admin/sqlnet.ora


NAMES.DIRECTORY_PATH= (TNSNAMES, EZCONNECT)

SQLNET.ALLOWED_LOGON_VERSION_SERVER=8
SQLNET.ALLOWED_LOGON_VERSION_CLIENT=8

up.. yg odpoint, sqlnet.ora nya tambahin ini cmiiw



<br /> <b>Warning</b>:  oci_connect(): OCIEnvNlsCreate() failed. There is something wrong with your system - please check that ORACLE_HOME and LD_LIBRARY_PATH are set and point to the right directories in <b>/apps/www/api/Check.php</b> on line <b>59</b><br /> <br /> <b>Warning</b>:  oci_connect(): Error while trying to retrieve text for error ORA-01804  in <b>/apps/www/api/Check.php</b> on line <b>59</b><br /> Array (     [status] =>     [message] => DB Connection failed     [oci_connect_exists] => 1     [ora_error_msg] =>     [user] => lolyta     [password] => lolyta#2019     [host] => exaimcpdb-scan.telkomsel.co.id     [port] => 1521     [service] => OPHPOINTIMC     [ORACLE_HOME] => /home/oracle/app/client12c/client_1     [LD_LIBRARY_PATH] => /home/oracle/app/client12c/client_1/lib     [_ENV] => Array         (         )     [connection_string] => (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = exaimcpdb-scan.telkomsel.co.id)(PORT = 1521))(CONNECT_DATA =(SERVICE_NAME = OPHPOINTIMC)))


