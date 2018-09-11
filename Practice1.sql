create table assignments
(
id INT NOT NULL,
employee_id INT NOT NULL,
project_id INT NOT NULL,

CONSTRAINT assignments_pk PRIMARY KEY (id),

CONSTRAINT FK_ASSIGMENT_EMPLOYEE
FOREIGN KEY (employee_id)
REFERENCES employees(ID),

CONSTRAINT FK_ASSIGMENT_PROJECT
FOREIGN KEY (project_id)
REFERENCES PROJECTS(ID)
)

create table PROJECTS
(
id INT NOT NULL,
code VARCHAR2(40) NOT NULL,
manager_id INT NOT NULL,
budget DECIMAL(19,4),
date_of_beginning DATE NOT NULL,
date_of_ending DATE NOT NULL,

CONSTRAINT projects_pk PRIMARY KEY (id),

CONSTRAINT FK_MANAGER_PROJECT
FOREIGN KEY (manager_id)
REFERENCES employees(ID)
)

create table employees
(
id INT NOT NULL,
manager_id INT,
date_of_joining DATE NOT NULL,
name VARCHAR2(50) NOT NULL,
last_name VARCHAR2(50) NOT NULL,
salary INT NOT NULL,

CONSTRAINT employees_pk PRIMARY KEY (id),

CONSTRAINT FK_MANAGER_ID FOREIGN KEY (manager_id) REFERENCES employees(id),

CONSTRAINT salario CHECK (salary > 50000)
)

ALTER TABLE employees
ADD CONSTRAINT SALARIO1
CHECK (salary > 50000);

CREATE TABLE EQUIPO
(
ID     NUMBER(3),
PLACA_BASE   VARCHAR2(20),
N_ARMARIO   NUMBER(2),
CONSTRAINT PK_EQUIPO PRIMARY KEY(ID),
CONSTRAINT FK_ARMARIO_EQUIPO FOREIGN KEY(N_ARMARIO)
REFERENCES ARMARIO(N_ARMARIO)
)

DROP TABLE EMPLOYEES;
DROP TABLE assignments;
DROP TABLE PROJECTS;
DROP TABLE ARMARIO;
DROP TABLE EQUIPO;

CREATE TABLE ARMARIO
(
N_ARMARIO   NUMBER(2),
TIPO    VARCHAR2(3),
CONSTRAINT PK_ARMARIO PRIMARY KEY(N_ARMARIO)
);

CREATE TABLE EQUIPO
(
ID     NUMBER(3),
PLACA_BASE   VARCHAR2(20),
N_ARMARIO   NUMBER(2),
CONSTRAINT PK_EQUIPO PRIMARY KEY(ID),
CONSTRAINT FK_ARMARIO_EQUIPO FOREIGN KEY(N_ARMARIO)
REFERENCES ARMARIO(N_ARMARIO)
)





