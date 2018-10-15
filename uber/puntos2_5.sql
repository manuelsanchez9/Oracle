/* Getulio Rafael Vargas Sierra
Manuel Andres Sanchez Muñoz
Paula Andrea Vera Cardeño */



/* 2. Create 3 Tablespaces */

-- a. first one with 2 Gb and 1 datafile, tablespace should be named "uber"

CREATE TABLESPACE UBER
     DATAFILE 'UBER01.dbf' SIZE 2000M;

-- b. Undo tablespace with 25Mb of space and 1 datafile

CREATE UNDO TABLESPACE UBER_UNDO
    DATAFILE 'UBER_UNDO01.dbf' SIZE 25M;

-- c. Bigfile tablespace of 5Gb

CREATE BIGFILE TABLESPACE UBER_BIG
    DATAFILE 'UBER_BIG01.dbf' SIZE 5000M;

-- d. Set the undo tablespace to be used in the system

ALTER SYSTEM 
	SET UNDO_TABLESPACE = UBER_UNDO;



/* 3. Create a DBA user (with the role DBA) and assign it to the tablespace called "uber", this user has unlimited space on the tablespace 
(The user should have permission to connect) */

CREATE USER DBA_1
	IDENTIFIED BY DBA_1
	DEFAULT TABLESPACE UBER
	QUOTA UNLIMITED ON UBER;

GRANT DBA TO DBA_1;

GRANT CONNECT TO DBA_1; 
GRANT CREATE SESSION TO DBA_1;



/* 4. Create 2 profiles */

-- a. Profile 1: "clerk" password life 40 days, one session per user, 10 minutes idle, 4 failed login attempts

CREATE PROFILE CLERK LIMIT 
	SESSIONS_PER_USER 1
    PASSWORD_LIFE_TIME 40
    IDLE_TIME 10
    FAILED_LOGIN_ATTEMPTS 4;

-- b. Profile 3: "development " password life 100 days, two session per user, 30 minutes idle, no failed login attempts

CREATE PROFILE DEVELOPMENT LIMIT 
    SESSIONS_PER_USER 2
    PASSWORD_LIFE_TIME 100
    IDLE_TIME 30;
	


/* 5. Create 4 users, assign them the tablespace "uber" */

-- a. 2 of them should have the clerk profile and the remaining the development profile, all the users should be allow to connect to the database.

CREATE USER USUARIO1 
	IDENTIFIED BY USUARIO1
	DEFAULT TABLESPACE UBER 
	PROFILE CLERK;

CREATE USER USUARIO2 
	IDENTIFIED BY USUARIO2
	DEFAULT TABLESPACE UBER 
	PROFILE CLERK;

CREATE USER USUARIO3 
	IDENTIFIED BY USUARIO3
	DEFAULT TABLESPACE UBER 
	PROFILE DEVELOPMENT;

CREATE USER USUARIO4 
	IDENTIFIED BY USUARIO4
	DEFAULT TABLESPACE UBER 
	PROFILE DEVELOPMENT;
	
GRANT CONNECT TO USUARIO1, USUARIO2, USUARIO3, USUARIO4; 
GRANT CREATE SESSION TO USUARIO1, USUARIO2, USUARIO3, USUARIO4;

-- b. Lock one user associate with clerk profile

ALTER USER USUARIO1 ACCOUNT LOCK;
