select * from user_users;
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_temp_files;

create tablespace baseDatosAvanzada
datafile 'baseDatosAvanzada' size 50M
extent MANAGEMENT local autoallocate;

create tablespace baseDatosAvanzada1
datafile 'baseDatosAvanzada1' size 20M, 'baseDatosAvanzada2' size 50M
extent MANAGEMENT local autoallocate;

create bigfile tablespace bigtbs 
datafile 'bigtbs1' size 50M;

create temporary tablespace lmtemp2 tempfile 'lmtep1' size 20M reuse extent management local uniform size 16M;

alter tablespace users offline normal;
alter tablespace users online;

alter tablespace bigtbs read only;
alter tablespace bigtbs read write;

alter tablespace bigtbs rename to bigtbssts;
 
drop tablespace uber_undo including contents and datafiles; 

create tablespace taller1
datafile 'taller1' size 50M;

create user manuels
identified by manuels
default tablespace bigtbssts;

grant connect to manuels;

grant create session to manuels; 

alter user manuels quota 100M on bigtbssts; 
alter user usuario1 quota UNLIMITED on taller1;

grant create table to manuels;

grant insert any table to manuels; 

grant drop any table to manuels;

drop tablespace undosts1 including contents;

create tablespace baseDatosAvanzada
datafile 'baseDatosAvanzada' size 100M
extent MANAGEMENT local autoallocate;

create user usuario1
identified by usuario1
default tablespace baseDatosAvanzada
quota unlimited on baseDatosAvanzada;

grant connect to usuario1

create role desarrollador;

grant connect to desarrollador;

grant desarrollador to usuario3;

grant SYSDBA to usuario1;

create user usuario3
identified by usuario3
default tablespace taller1
quota unlimited on taller1;

grant create table to desarrollador;
grant create sequence to desarrollador;
grant alter sequence to desarrollador;

select * from v$version;

create sequence agencies_seq
start with 500
increment by 2
nocycle;

select agencies_seq.currval from dual;
select agencies_seq.nextval from dual;
