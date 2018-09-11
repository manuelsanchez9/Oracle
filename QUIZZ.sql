create table employees
(
id INT NOT NULL,
manager_id INT,
date_of_joining DATE,
FULL_NAME VARCHAR2(50) NOT NULL,

CONSTRAINT employees_pk PRIMARY KEY (id),

CONSTRAINT FK_MANAGER_ID FOREIGN KEY (manager_id) REFERENCES employees(id)

)

create table PROJECTS
(
id INT NOT NULL,
code VARCHAR2(255 BYTE),
manager_id INT,
budget DECIMAL(10,2),
date_of_beginning DATE,
date_of_ending DATE,

CONSTRAINT projects_pk PRIMARY KEY (id),

CONSTRAINT FK_MANAGER_PROJECT
FOREIGN KEY (manager_id)
REFERENCES employees(ID)
)