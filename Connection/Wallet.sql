1. Create a new location to hold the wallet on /report/wallet/prn_wallet
orapki wallet create -wallet /report/wallet/wallet_prn -pwd WalletPasswd123 -auto_login


2. Adding existing certificate (uniprov.crt) to the new wallet
$ cp /report/wallet/uniprov.cer /report/wallet/wallet_prn
$ orapki wallet add -wallet /report/wallet/wallet_prn -trusted_cert -cert "/report/wallet/ wallet_prn/uniprov.cer" -pwd WalletPasswd123


3. Execute test secured connection with utl_http.set_wallet procedure
SQL> EXEC UTL_HTTP.set_wallet('file:/report/wallet/wallet_prn', 'WalletPasswd123');


----------------------
Mas @jhonikeren gue jadi kepikiran yg wallet td taruh di /u01 ketimbang di /report, 
mesti nya di node 2 perlu di create wallet dgn address yg sama jg ga sih? 
Krn RAC kan, takutnya nanti function nya ngecall dr node 2, tp ga ketemu wallet nya


/u01/app/oracle/wallet_prn


srvctl status database -d PDBSIS
srvctl stop database -d PDBSIS
srvctl start database -d PDBSIS



srvctl status database -d ODTEST1
srvctl start database -d ODTEST1



srvctl status database -d ODHCISC
srvctl start database -d ODHCISC

srvctl config database -d PDBSIS