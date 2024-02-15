
telnet <ip/hostname> <port>

time telnet exapdb62a-vip.telkomsel.co.id 1521

--------------------------------------------------------------------------------------------------------------

nc -zv ip port

--------------------------------------------------------------------------------------------------------------


echo "
10.54.128.145 1521
10.54.128.146 1521
" | (
  TCP_TIMEOUT=5
  while read host port; do
    (CURPID=$BASHPID;
    (sleep $TCP_TIMEOUT;kill $CURPID) &
    exec 3<> /dev/tcp/$host/$port
    ) 2>/dev/null
    case $? in
    0)
      echo $host $port is OPEN;;
    1)
      echo $host $port is CLOSED;;
    143) # killed by SIGTERM
       echo $host $port TIMEOUT;;
     esac
     done
         ) 2>/dev/null
echo "===== END - TELNET OPERATION ====="



