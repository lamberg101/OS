[oracle@oem13cpdb1 dd]$ more sqlplus.sh 
echo "MASUKIN NAMA DB"
read dbname
sqlplus sys/OR4cl35y5#2015@$dbname as sysdba