kena err denied ACL
grant execute on sys.utl_http to PRNO;
grant execute on sys.utl_http to USERAPI;


itu mesti di rerun ulang soft link nbu nya bli

BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'acl_prn_new.xml',
                                    description => 'prn acl new',
                                    principal   => 'PRNO',
                                    is_grant    => true,
                                    privilege   => 'connect');
 
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'acl_prn_new.xml',
                                       principal => 'PRNO',
                                       is_grant  => true,
                                       privilege => 'resolve');
 
 DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'acl_prn_new.xml',
                                      principal => 'USERAPI',
                                      is_grant  => true,
                                      privilege => 'resolve');
                    
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl  => 'acl_prn_new.xml',
                                    host => 'uniprov.telkomsel.co.id',
                      lower_port => 5319,
                      upper_port => 5319);
                  
END;


---------------------------------------------------------------------------------------------

BEGIN
  DBMS_NETWORK_ACL_ADMIN.add_privilege (
    acl       => 'NETWORK_ACL_6A2F6C272A8185A4E0535858F90A959F',
    principal => 'CTC_SIT11_USR_OPE',
    is_grant  => true,
    privilege => 'resolve',
    start_date   => NULL,
    end_date   => NULL);
  COMMIT;
END;
/