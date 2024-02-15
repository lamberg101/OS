Check PORT.
$ lsnrctl status
---> bisa juga grep inherit dulu.
$ ps -ef | grep inherit
/bin/tnslsnr LISTENER_PROD -inherit --> hasilnya kira2 seperti ini
/bin/tnslsnr LISTENER_PROD -inherit
$ lsnrctl status LISTENER_PROD
