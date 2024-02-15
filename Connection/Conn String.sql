--TEST CONNECT
$ sqlplus system@SERVICE_NAME
$ sqlplus system@"(DECRIPTION=(ADRESS=(PROTOCOL=TCP)(HOST=ip)(PORT=1521)(dan seterusnya)))"
$ sqlplus 'FORTUNE@(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = ip)dan seterusnya)))'
sqlplus username@"(DESCRIPTION= (ADDRESS= (PROTOCOL=TCP) (HOST=exacctbsddb-scan) (PORT=1521)) (CONNECT_DATA= (SERVER=DEDICATED) (SERVICE_NAME=ODTMENUPDB.telkomsel.co.id) (FAILOVER_MODE= (TYPE=select) (METHOD=basic))))"

---------------------------------------------------------------------------------------------------------------------------------------

--satu baris
jdbc:oracle:thin:@(DESCRIPTION=(FAILOVER=on)(LOAD_BALANCE=off)(CONNECT_TIMEOUT=2)(RETRY_COUNT=2)
(RETRY_DELAY=2)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=exaimcpdb-scan.telkomsel.co.id)
(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=exapdb62b-scan.telkomsel.co.id)
(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=DGPOSHA)))


sqlplus system@'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST =  exa82absdp-scan1)(PORT = 1521))(CONNECT_DATA = (SERVER = DEDICATED)(SERVICE_NAME = OPRFSODBSD)))'
sqlplus user@'(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = exapdb62b-scan)(PORT = 1521))) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = OPSCM) (UR=A)))'
sqlplus user@'(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = exapdb62b-scan)(PORT = 1521))) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = OPSCM) (UR=A)))'
sqlplus 'namauser/pass@(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = exapdb62a-scan.telkomsel.co.id)(PORT = 1521))) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = OPCCM) (UR=A)))'
sqlplus system@'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = cc011-scan1.id1.ocm.s7065770.oraclecloudatcustomer.com)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ODTDIRECT.id1.ocm.s7065770.oraclecloudatcustomer.com) (FAILOVER_MODE = (TYPE = select) (METHOD = basic) ) ) )'
---------------------------------------------------------------------------------------------------------------------------------------

--SERVICE NAME
OPAPMIMC = 
	(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)
	(HOST = exaimcpdb-scan.telkomsel.co.id)(PORT = 1521))) 
		(CONNECT_DATA = (SERVER = DEDICATED)
		(SERVICE_NAME = OPAPMIMC) 
	(UR = A)
	)
)

--SID
OPAPM1 =
	(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)
	(HOST = exaimcpdb01-vip.telkomsel.co.id)(PORT = 1521))) 
		(CONNECT_DATA = (SERVER = DEDICATED) 
			(SERVICE_NAME = OPAPMIMC) 
		(SID = OPAPM1)
	 (UR = A)
	 )
 )


---------------------------------------------------------------------------------------------------------------------------------------

-- CONN STRING on DB EXACM (cloud)

PRODHR = 
  (DESCRIPTION = 
    (ADDRESS = (PROTOCOL = TCP)(HOST = cc011-scan1.id1.ocm.s7065770.oraclecloudatcustomer.com)(PORT = 1521))
    (CONNECT_DATA = 
      (SERVER = DEDICATED) 
      (SERVICE_NAME = PRODHR) 
      (FAILOVER_MODE = 
        (TYPE = select) 
        (METHOD = basic) 
      ) 
    ) 
  )  
  
PRODHR1 = 
   (DESCRIPTION = 
     (ADDRESS = (PROTOCOL = TCP)(HOST = 10.54.42.3)(PORT = 1521)) 
       (CONNECT_DATA = (SERVER = DEDICATED) 
     (SERVICE_NAME = PRODHR) 
   (SID = PRODHR1)
)
)


OPHPOINT = 
  (DESCRIPTION = 
    (ADDRESS = (PROTOCOL = TCP)(HOST = cc011-scan1.id1.ocm.s7065770.oraclecloudatcustomer.com)(PORT = 1521))
    (CONNECT_DATA = 
      (SERVER = DEDICATED) 
      (SERVICE_NAME = OPHPOINT.id1.ocm.s7065770.oraclecloudatcustomer.com) 
      (FAILOVER_MODE = 
        (TYPE = select) 
        (METHOD = basic) 
      ) 
    ) 
  )  



OPHPOINT1 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.54.42.3)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
          (SERVICE_NAME = OPHPOINT.id1.ocm.s7065770.oraclecloudatcustomer.com)
      (SID = OPHPOINT1)
    )
  )


---------------------------------------------------------------------------------------------------------------------------------------

jdbc:oracle:thin:@cc011-scan1.id1.ocm.s7065770.oraclecloudatcustomer.com:1521/ODPOM.ID1.OCM.S7065770.ORACLECLOUDATCUSTOMER.COM

jdbc:oracle:thin:@(DESCRIPTION=
(CONNECT_TIMEOUT=10)
(RETRY_COUNT=3)
(ADDRESS_LIST=
	(ADDRESS=
		(PROTOCOL=TCP)
		(HOST=cc011-scan1.id1.ocm.s7065770.oraclecloudatcustomer.com)
		(PORT=1521)
	)
)
(CONNECT_DATA=
	(SERVICE_NAME=ODPOM.ID1.OCM.S7065770.ORACLECLOUDATCUSTOMER.COM)
	))