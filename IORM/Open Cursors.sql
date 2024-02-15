

select a.value, s.username, s.sid, s.serial# 
from v$sesstat a, v$statname b, v$session s 
where a.statistic# = b.statistic#  
and s.sid=a.sid 
and b.name = 'opened cursors current' 
and s.username is not null
order by a.value asc;




set linesize 132 pagesize 999
column sql_fulltext format a60 word_wrap
break on sql_text skip 1




SET LONG 9999999999 
set LONGCHUNKSIZE 9999999999
set lines 1000
set pages 1000


select  a.USER_NAME, a.sid,a.SQL_ID,  b.sql_text, count(*) as "OPEN CURSORS"
from v$open_cursor a, v$sql b
where a.SQL_ID=b.SQL_ID
and a.sid=1990
group by a.USER_NAME,a.sid,a.SQL_ID, b.sql_text 
;


select sql_fulltext
from v$sql
where lower(sql_fulltext) 
like lower('%AUTHORS%');



SQL> desc v$sql
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 SQL_TEXT					    VARCHAR2(1000)
 SQL_FULLTEXT					    CLOB
 SQL_ID 					    VARCHAR2(13)





select ts# from ts$ where ts$.online$ != 3 and bitand(flags, 	 150 DBSNMP
SELECT m.tablespace_name, ROUND(m.used_percent, 2), ROUND(( 	 147 DBSNMP

column sql_text format a100 word_wrap




SELECT  max(a.value) as highest_open_cur, p.value as max_open_cur FROM v$sesstat a, v$statname b, v$parameter p WHERE  a.statistic# = b.statistic#  and b.name = 'opened cursors current' and p.name= 'open_cursors' group by p.value;

select INST_ID, SQL_ID,event,count(*) from gv$session 
where type!='BACKGROUND' 
and status='ACTIVE' 
group by SQL_ID,event, INST_ID 
order by 3;