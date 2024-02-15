select instance_caging from gv$rsrc_plan where is_top_plan ='TRUE';
SELECT name, is_top_plan FROM v$rsrc_plan;


--ALTER

create pfile='/home/oracle/ssi/pfile_OPTMENU.txt' from spfile;

alter system set allow_group_access_to_sga=TRUE sid='*' scope=spfile; --untuk ptech
alter system set cpu_count=4 scope=both sid='*';
alter system set resource_manager_plan='default_plan' scope=both sid='*';					


date; srvctl status database -d OPTMENU
date; srvctl stop database -d OPTMENU; date
date; srvctl start database -d OPTMENU; date