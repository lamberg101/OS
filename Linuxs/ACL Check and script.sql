--ADD IP WHITELIST IN EXADATA (ACL):
1. using user oracle with profile: .grid_profile
2. add IP in nodes /u01/app/11.2.0.4/grid/network/admin/sqlnet.ora

--LSNRCTL RELOAD LISTENER
$srvctl stop scan_listener
$srvctl start scan_listener
  
--SRVCTL STATUS SCAN_LISTENER
$ps -ef | grep tns


------------------------------------------------------------------------------------------------------------------------

-- CREATE ACL
BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'ACL_DASHPOIN.xml', 
    description  => 'A report of the ACL functionality',
    principal    => 'DASHPOIN',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;
END;

-- ASSIGN ACL
BEGIN
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'ACL_DASHPOIN.xml',
    host        => '10.2.248.214', 
    lower_port  => 8000,
    upper_port  => NULL); 
  COMMIT;
END;
/

-- ADD PRIVILEGE ACL
BEGIN
  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => 'ACL_DASHPOIN.xml', 
    principal   => 'DASHPOIN',
    is_grant    => TRUE, 
    privilege   => 'connect', 
    position    => NULL, 
    start_date  => NULL,
    end_date    => NULL);

  COMMIT;
END;
/


-- CHECK ACL
column host format a30
column acl format a30
select host, lower_port, upper_port, acl 
from DBA_NETWORK_ACLS;


column acl format a30
column principal format a30
select acl, principal, privilege, is_grant,
to_char(start_date, 'DD-MON-YYYY') AS start_date,
to_char(end_date, 'DD-MON-YYYY') AS end_date
from DBA_NETWORK_ACL_PRIVILEGES;

