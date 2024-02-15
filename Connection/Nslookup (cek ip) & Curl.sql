$ nslookup hostname
--CONTOH
$ nslookup pro.telkomsel.co.id
$ nslookup exaimcpdb02-vip


[oracle@testet01 ~]$ nslookup exapdb01-vip
Server:		10.250.193.114
Address:	10.250.193.114#53

Non-authoritative answer:
Name:	exapdb01-vip.telkomsel.co.id
Address: 10.250.193.103 ----> ini ip nya


---------------------------------------------------------------------------------------------------

--CURL
curl -X GET --header 'Content-Type: text/xml' 'http://pro.telkomsel.co.id:8787/pro/proxy_service/halo_crossbrands_delete_queue?msisdn=6281310001637&trxid=testosb' -vi