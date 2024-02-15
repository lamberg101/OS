Check jumlah cluster
$> . .grid
$> olsnodes -n

--------------------------------------------------------------------------------------------------------------

--CHECK CURRENT CONFIG
$ srvctl config database -d SERVICENAME


--REMOVE THE PASSWORD FILE 
$ srvctl modify database -d SERVICENAME -pwfile ''


cp +DATA1/OPIRIS/PASSWORD/orapwopiris1 +DATA1/OPIRIS/PASSWORD/pwdopiris.303.1070634949

srvctl modify database -d OPIRIS -pwfile '+DATA1/OPIRIS/PASSWORD/orapwopiris1'