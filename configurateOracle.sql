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
 
drop tablespace lmtemp2 including contents and datafiles; 

create undo tablespace undosts1
datafile 'undosts123' size 10M;

create user manuels
identified by manuels
default tablespace bigtbssts;

grant connect to manuels;

grant create session to manuels; 