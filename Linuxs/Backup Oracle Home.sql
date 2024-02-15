--BACKUP LANGSUNG TIAP NODE
cd /u01/app/oracle/product/
tar -czvf bkup_rdbms_home_11203.tar.gz ./11.2.0.3  
tar -czvf bkup_rdbms_home_11204.tar.gz ./11.2.0.4  
tar -czvf bkup_rdbms_home_12201.tar.gz ./12.2.0.1  



--USING EXCLUDE
nohup tar -czvf bkup_rdbms_home_11203_exclude.tar.gz ./11.2.0.3 
--exclude "./11.2.0.3/dbhome_1/rdbms/audit/*.aud" 
--exclude "./11.2.0.3/dbhome_1/rdbms/log" 
--exclude "./11.2.0.3/dbhome_2/rdbms/audit/*.aud" 
--exclude "./11.2.0.3/dbhome_2/rdbms/log" 
> log12_exclude.txt &



nohup tar -czvf bkup_rdbms_home_1210_excluden2.tar.gz ./12.1.0 --exclude "./u01/app/12.1.0/grid/rdbms/audit/*.aud" --exclude "./u01/app/12.1.0/grid/rdbms/log" > log12_exclude.txt &


/u01/app/12.1.0/grid

--JALAIN BUAT 1 BARIS (example)
nohup tar -czvf bkup_rdbms_home_11204_exclude.tar.gz ./11.2.0.4 --exclude "./11.2.0.4/dbhome_1/rdbms/audit" --exclude "./11.2.0.4/dbhome_1/rdbms/log" --exclude "./11.2.0.4/dbhome_2/rdbms/audit" --exclude "./11.2.0.4/dbhome_2/rdbms/log" > log1124_exclude.txt &

