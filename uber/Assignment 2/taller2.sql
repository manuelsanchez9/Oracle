/* Getulio Rafael Vargas Sierra
Manuel Andres Sanchez Muñoz
Paula Andrea Vera Cardeño */


/* --- PUNTOS ADICIONALES ---*/

-- Cambio de nombre a la tabla Localizaciones por Ciudades
RENAME LOCALIZACIONES TO CIUDADES;

-- Cambio de nombre de la columna ciudad a nombre (por nombre de ciudad)
ALTER TABLE CIUDADES RENAME COLUMN CIUDAD TO NOMBRE;

-- Cambio de nombre de la columna localizacon_id a ciudad_id en las tablas 'personas' y 'servicios'
ALTER TABLE PERSONAS RENAME COLUMN LOCALIZACION_ID TO CIUDAD_ID;
ALTER TABLE SERVICIOS RENAME COLUMN LOCALIZACION_ID TO CIUDAD_ID;

--Actulización de datos del detalle servicio
--Se elimina los detalles para los servicios que fueron estandar
DELETE FROM DETALLE_SERVICIOS WHERE SERVICIO_ID IN (2, 4, 6, 8, 10);

--Se elimina el detalle de tariba base, ya que se maneja a traves de la tabla ciudad
DELETE FROM DETALLE_SERVICIOS WHERE TIPO_COBRO = 'TARIFA BASE';

--Se actuliza los detalles de los servicios premium
UPDATE DETALLE_SERVICIOS 
SET  TIPO_COBRO = 'INCREMENTO POR LLUVIA';

--Se agregan detalles a algunos servicios
INSERT INTO DETALLE_SERVICIOS VALUES (Detalle_servicios_seq.nextval, 1, 'EVENTO ESPECIAL', 6000);
INSERT INTO DETALLE_SERVICIOS VALUES (Detalle_servicios_seq.nextval, 7, 'EVENTO ESPECIAL', 6000);

--Se agrega la tabla Empresas para poder realizar la vista del punto 1 sin problema
create table Empresas(
    id int not null,
    nit varchar2(255) not null,
    nombre varchar2(255) not null,
    direccion varchar2(255) null,
    telefono varchar2(255) null,
    constraint PK_Empresas primary key (id)
);

--Creamos la secuencia de la tabla anterior
create sequence Empresas_seq start with 1 increment by 1;

--Insertamos datos en la tabla empresa
INSERT INTO empresas (id,nit,nombre,direccion,telefono)values(Empresas_seq.nextval,'890123816-3','EPM','P.O. Box 948, 9389 Elementum Ave','4256355'); 
INSERT INTO empresas (id,nit,nombre,direccion,telefono)values(Empresas_seq.nextval,'890123816-3','ITM','Ap #700-9803 Sagittis Av.','2256358');
INSERT INTO empresas (id,nit,nombre,direccion,telefono)values(Empresas_seq.nextval,'990523856-1','UDEA','5739 Eu Avenue','4456855');
INSERT INTO empresas (id,nit,nombre,direccion,telefono)values(Empresas_seq.nextval,'790523816-2','TIGO UNE','P.O. Box 704, 5030 Nunc Av.','2256355');
INSERT INTO empresas (id,nit,nombre,direccion,telefono)values(Empresas_seq.nextval,'590443816-4','NUTRESA','4276 Ipsum St.','6557552');

--Agregamos la columna empresa_id a la tabla Medios_pago
alter table Medios_pago add empresa_id int null;
--Creamos la relación entre la tabla Empresas y Medios_pago
alter table Medios_pago add constraint FK_Empresas foreign key (empresa_id) references Empresas(id);

--Como se creó la tabla de empresas y la relación de esta con la tabla medios_pago se procede a actualizar los medios de pago "EMPRESARIALES"
update medios_pago
set empresa_id = (select id from empresas where nombre = 'EPM')
where datos_adicionales like '%EPM%';

update medios_pago
set empresa_id = (select id from empresas where nombre = 'ITM')
where datos_adicionales like '%ITM%';

update medios_pago
set empresa_id = (select id from empresas where nombre = 'UDEA')
where datos_adicionales like '%UDEA%';

update medios_pago
set empresa_id = (select id from empresas where nombre = 'TIGO UNE')
where datos_adicionales like '%TIGO UNE%';

update medios_pago
set empresa_id = (select id from empresas where nombre = 'NUTRESA')
where datos_adicionales like '%NUTRESA%';

--Insertamos datos en la tabla servicios para los puntos 2 y 3
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,11,'PREMIUM',8,'P.O. Box 837, 1256 Vestibulum Avenue','P.O. Box 707, 4020 Fames Street','03-10-2018 12:30','03-10-2018 12:40','03-10-2018 12:50',35,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,12,'ESTANDAR',5,'288-1588 Non, Street','492-6733 Orci Rd.','10-10-2018 09:30','10-10-2018 09:46','10-10-2018 09:56',17,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,13,'PREMIUM',10,'P.O. Box 553, 7843 Malesuada Rd.','Ap #733-8193 Mus. Avenue','13-10-2018 06:00','13-10-2018 06:10','13-10-2018 06:20',32,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,14,'ESTANDAR',5,'P.O. Box 516, 5046 Nulla. Street','241-3653 Porttitor Ave','18-10-2018 07:43','18-10-2018 07:56','18-10-2018 08:06',10,'10','CANCELADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,15,'PREMIUM',2,'546-9422 Nascetur Street','Ap #700-9803 Sagittis Av.','20-10-2018 09:07','20-10-2018 09:20','20-10-2018 09:30',20,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,16,'ESTANDAR',3,'966-3826 Nunc Road','P.O. Box 948, 9389 Elementum Ave','22-10-2018 07:45','22-10-2018 08:03','22-10-2018 08:13',12,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,17,'PREMIUM',8,'P.O. Box 943, 9569 Gravida Street','P.O. Box 704, 5030 Nunc Av.','25-10-2018 10:45','25-10-2018 10:58','25-10-2018 11:08',9,'10','CANCELADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,18,'ESTANDAR',1,'154-461 Suspendisse Rd.','5739 Eu Avenue','25-10-2018 11:23','25-10-2018 11:32','25-10-2018 11:42',8,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,19,'PREMIUM',4,'6068 Aliquet. Av.','4276 Ipsum St.','27-10-2018 05:23','27-10-2018 05:40','27-10-2018 05:50',17,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,20,'ESTANDAR',1,'9115 Laoreet Road','P.O. Box 354, 3223 Et, Rd.','28-10-2018 12:00','28-10-2018 12:05','28-10-2018 12:15',21,'10','CANCELADO','0');

INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,21,'PREMIUM',8,'P.O. Box 837, 1256 Vestibulum Avenue','P.O. Box 707, 4020 Fames Street','03-11-2018 12:30','03-11-2018 12:40','03-11-2018 12:50',35,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,22,'ESTANDAR',5,'288-1588 Non, Street','492-6733 Orci Rd.','10-11-2018 09:30','10-11-2018 09:46','10-11-2018 09:56',17,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,23,'PREMIUM',10,'P.O. Box 553, 7843 Malesuada Rd.','Ap #733-8193 Mus. Avenue','13-11-2018 06:00','13-11-2018 06:10','13-11-2018 06:20',32,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,24,'ESTANDAR',5,'P.O. Box 516, 5046 Nulla. Street','241-3653 Porttitor Ave','18-11-2018 07:43','18-11-2018 07:56','18-11-2018 08:06',10,'10','CANCELADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,25,'PREMIUM',2,'546-9422 Nascetur Street','Ap #700-9803 Sagittis Av.','20-11-2018 09:07','20-11-2018 09:20','20-11-2018 09:30',20,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,26,'ESTANDAR',3,'966-3826 Nunc Road','P.O. Box 948, 9389 Elementum Ave','22-11-2018 07:45','22-11-2018 08:03','22-11-2018 08:13',12,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,27,'PREMIUM',8,'P.O. Box 943, 9569 Gravida Street','P.O. Box 704, 5030 Nunc Av.','25-11-2018 10:45','25-11-2018 10:58','25-11-2018 11:08',9,'10','CANCELADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,28,'ESTANDAR',1,'154-461 Suspendisse Rd.','5739 Eu Avenue','25-11-2018 11:23','25-11-2018 11:32','25-11-2018 11:42',8,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,29,'PREMIUM',4,'6068 Aliquet. Av.','4276 Ipsum St.','27-11-2018 05:23','27-11-2018 05:40','27-11-2018 05:50',17,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,30,'ESTANDAR',1,'9115 Laoreet Road','P.O. Box 354, 3223 Et, Rd.','28-11-2018 12:00','28-11-2018 12:05','28-11-2018 12:15',21,'10','CANCELADO','0');

INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,31,'PREMIUM',8,'P.O. Box 837, 1256 Vestibulum Avenue','P.O. Box 707, 4020 Fames Street','03-12-2018 12:30','03-12-2018 12:40','03-12-2018 12:50',35,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,32,'ESTANDAR',5,'288-1588 Non, Street','492-6733 Orci Rd.','10-12-2018 09:30','10-12-2018 09:46','10-12-2018 09:56',17,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,33,'PREMIUM',10,'P.O. Box 553, 7843 Malesuada Rd.','Ap #733-8193 Mus. Avenue','13-12-2018 06:00','13-12-2018 06:10','13-12-2018 06:20',32,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,34,'ESTANDAR',5,'P.O. Box 516, 5046 Nulla. Street','241-3653 Porttitor Ave','18-12-2018 07:43','18-12-2018 07:56','18-12-2018 08:06',10,'10','CANCELADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,35,'PREMIUM',2,'546-9422 Nascetur Street','Ap #700-9803 Sagittis Av.','20-12-2018 09:07','20-12-2018 09:20','20-12-2018 09:30',20,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,36,'ESTANDAR',3,'966-3826 Nunc Road','P.O. Box 948, 9389 Elementum Ave','22-12-2018 07:45','22-12-2018 08:03','22-12-2018 08:13',12,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,37,'PREMIUM',8,'P.O. Box 943, 9569 Gravida Street','P.O. Box 704, 5030 Nunc Av.','25-12-2018 10:45','25-12-2018 10:58','25-12-2018 11:08',9,'10','CANCELADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,38,'ESTANDAR',1,'154-461 Suspendisse Rd.','5739 Eu Avenue','25-12-2018 11:23','25-12-2018 11:32','25-12-2018 11:42',8,'10','FINALIZADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,39,'PREMIUM',4,'6068 Aliquet. Av.','4276 Ipsum St.','27-12-2018 05:23','27-12-2018 05:40','27-12-2018 05:50',17,'10','INICIADO','0');
INSERT INTO Servicios (id,conductor_vehiculo_id,tipo_servicio,ciudad_id,direccion_origen,direccion_destino,fecha_recepcion,fecha_hora_inicio,fecha_hora_fin,kilometros,tiempo,estado,tarifa_compartida) VALUES (Servicios_seq.nextval,40,'ESTANDAR',1,'9115 Laoreet Road','P.O. Box 354, 3223 Et, Rd.','28-12-2018 12:00','28-12-2018 12:05','28-12-2018 12:15',21,'10','CANCELADO','0');

INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,11,1,29750);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,12,3,14578);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,13,57,24752);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,14,140,11424);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,15,149,18683);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,16,148,13447);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,17,147,10115);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,18,98,9223);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,19,123,16244);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,20,156,19278);

INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,21,5,29750);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,22,67,14578);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,23,73,24752);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,24,253,11424);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,25,345,18683);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,26,231,13447);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,27,236,10115);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,28,237,9223);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,29,238,16244);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,30,300,19278);

INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,31,2,29750);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,32,7,14578);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,33,8,24752);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,34,9,11424);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,35,10,18683);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,36,13,13447);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,37,14,10115);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,38,15,9223);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,39,19,16244);
INSERT INTO Detalle_pagos (id,servicio_id,cliente_medio_pago_id,valor_pago) VALUES (Detalle_pagos_seq.nextval,40,20,19278);

--Se agrega la columna tarifa_dinamica a la tabla servicios, para identificarlos en la vista del punto 2
alter table Servicios add tarifa_dinamica char(1) check(tarifa_dinamica in (1,0)) null;

--Se actualiza los servicios que aplican tarifa dinamica
update Servicios
set tarifa_dinamica = 1
where id in (1, 3, 5, 7, 9);


/* --- PUNTO 1 --- */

--Creacion de la vista medios_pago_clientes
create or replace view medios_pago_clientes
as
    select cli.persona_id as cliente_id,
		   pers.nombre || ' ' || pers.apellido as nombre_cliente,
		   mdp.id as medio_pago_id, mdp.tipo_medio as tipo, mdp.datos_adicionales as detalles_medio_pago, 
		   case when mdp.empresarial = 1 then 'VERDADERO' else 'FALSO' end as empresarial, emp.nombre as nombre_empresa
	from clientes cli INNER JOIN personas pers on (cli.persona_id = pers.id)
					  INNER JOIN medios_pago mdp on (cli.persona_id = mdp.cliente_id)
					  LEFT JOIN empresas emp on (mdp.empresa_id = emp.id);

--select * from medios_pago_clientes;


/* --- PUNTO 2 --- */

--Creacion de la vista viajes_clientes
create or replace view viajes_clientes
as
select ser.fecha_hora_inicio as fecha_viaje, per_con.nombre || ' ' || per_con.apellido as nombre_conductor,
           veh.placa as placa_vehiculo, per_cli.nombre || ' ' || per_cli.apellido as nombre_cliente,
           sum(dp.valor_pago) over(partition by dp.servicio_id) as valor_total,
           case when ser.tarifa_dinamica = 1 then 'VERDADERO' else 'FALSO' end as tarifa_dinamica,
           case ser.tipo_servicio when 'ESTANDAR' then 'UberX' else 'UberBlack' end as tipo_servicio,
           ciu.nombre as ciudad_viaje
    from servicios ser INNER JOIN conductores_vehiculos cv on (ser.conductor_vehiculo_id = cv.id)
                       INNER JOIN conductores cond on (cv.conductor_id = cond.persona_id)
                       INNER JOIN personas per_con on (cond.persona_id = per_con.id)
                       INNER JOIN vehiculos veh on (cv.vehiculo_id = veh.id)
                       INNER JOIN detalle_pagos dp on (ser.id = dp.servicio_id)
                       INNER JOIN medios_pago mp on (dp.cliente_medio_pago_id = mp.id)
                       INNER JOIN clientes cli on (mp.cliente_id = cli.persona_id)
                       INNER JOIN personas per_cli on (cli.persona_id = per_cli.id)
                       INNER JOIN ciudades ciu on (ser.ciudad_id = ciu.id)
    order by per_cli.id asc, ser.fecha_hora_inicio asc;
    
--select * from viajes_clientes;


/* --- PUNTO 3 --- */
--Plan de ejecución para la vista viajes_clientes
explain plan for select * from viajes_clientes;
select * from table(dbms_xplan.display);

--Índices que mejoran la consulta de la vista viajes_clientes
create index ix_serv_cond_vehi on servicios(conductor_vehiculo_id);
create index ix_conductores_vehiculos_cond on conductores_vehiculos(conductor_id);
create index ix_conductores_vehiculos_vehi on conductores_vehiculos(vehiculo_id);
create index ix_detalle_pagos_medios_pago on detalle_pagos(cliente_medio_pago_id);
create index ix_medios_pago_cliente on medios_pago(cliente_id);
create index ix_servicio_ciudad on servicios(ciudad_id);


/* --- PUNTO 4 --- */

--Adicion de nuevas columnas
ALTER TABLE CIUDADES 
    ADD VALOR_KILOMETRO NUMBER(10,6)
    ADD VALOR_MINUTO NUMBER(10,6)
    ADD TARIFA_BASE NUMBER(10,6);

--Agregar valores a los nuevas columnas de las ciudades  
UPDATE CIUDADES
SET VALOR_KILOMETRO = 764.525994, VALOR_MINUTO = 178.571429, TARIFA_BASE = 2500
WHERE NOMBRE IN ('Medellin', 'Armenia', 'Pereira','Medellín');

UPDATE CIUDADES
SET VALOR_KILOMETRO = 522.43456, VALOR_MINUTO = 173.1273, TARIFA_BASE = 2400
WHERE NOMBRE IN ('Bogota', 'Cali','Bogotá');

UPDATE CIUDADES
SET VALOR_KILOMETRO = 643.4321, VALOR_MINUTO = 175.34789, TARIFA_BASE = 2350
WHERE NOMBRE IN ('Manizales', 'Bucaramanga');

UPDATE CIUDADES
SET VALOR_KILOMETRO = 793.879054, VALOR_MINUTO = 180.1429, TARIFA_BASE = 2650
WHERE NOMBRE IN ('Santa Marta', 'Barranquilla', 'Cartagena');

--SELECT * FROM CIUDADES;


/* --- PUNTO 5 --- */

create or replace function valor_distancia(distancia number, ciudad varchar2)
return number
is
valor_km number(10,6);
valor_total number(20,6);
begin
    if (distancia < 0) then
        dbms_output.put_line('La distancia debe ser mayor o igual a cero..');
        return 0;
    end if;
    
    if (length(ciudad) is null) then
        dbms_output.put_line('Debe enviar la ciudad donde se realizó el viaje..');
        return 0;
    end if;
    
    if (distancia >= 0 and length(ciudad) > 0) then
        select case when valor_kilometro is null then 0 else valor_kilometro end into valor_km from ciudades where nombre = ciudad;
        valor_total := distancia * valor_km;
        return valor_total;
    end if;
exception
    when no_data_found then
        dbms_output.put_line('No se encontraron ciudades con el nombre enviado..');
        return 0;
    when others then
        return 0;
end;


/* --- PUNTO 6 --- */

create or replace function valor_tiempo(minutos number, ciudad varchar2)
return number
is
valor_min number(10,6);
valor_total number(20,6);
begin
    if (minutos < 0) then
        dbms_output.put_line('La cantidad de minutos debe ser mayor o igual a cero..');
        return 0;
    end if;
    
    if (length(ciudad) is null) then
        dbms_output.put_line('Debe enviar la ciudad donde se realizó el viaje..');
        return 0;
    end if;
    
    if (minutos >= 0 and length(ciudad) > 0) then
        select case when valor_minuto is null then 0 else valor_minuto end into valor_min from ciudades where nombre = ciudad;
        valor_total := minutos * valor_min;
        return valor_total;
    end if;
exception
    when no_data_found then
        dbms_output.put_line('No se encontraron ciudades con el nombre enviado..');
        return 0;
    when others then
        return 0;
end;


/* --- PUNTO 7 --- */

CREATE OR REPLACE PROCEDURE CALCULAR_TARIFA (ID_SERVICIO IN NUMBER) 
AS 
    --Definicion de variables
    TARIFA NUMBER(10,0);
    ESTADO VARCHAR2(255);
    CIUDAD VARCHAR2(255);
    BASE NUMBER(10,6);
    KILOMETROS NUMBER(38,0);
    INICIO TIMESTAMP(6);
    FIN TIMESTAMP(6);
    MINUTOS NUMBER;
    DISTANCIA NUMBER;
    TIEMPO NUMBER;
    VAL_DETALLES NUMBER;
BEGIN
    --Busqueda de informacion del servicio
    SELECT S.ESTADO, C.NOMBRE, C.TARIFA_BASE, S.KILOMETROS, FECHA_HORA_INICIO, FECHA_HORA_FIN INTO ESTADO, CIUDAD, BASE, 
    KILOMETROS, INICIO, FIN
    FROM SERVICIOS S INNER JOIN CIUDADES C ON (S.CIUDAD_ID = C.ID)
    WHERE S.ID = ID_SERVICIO;
    
    --Decision segun el estado del servicio 
    IF (ESTADO = 'FINALIZADO') THEN   
        --Diferencia entre las fechas para encontrar la cantidad de minutos del servicio
        SELECT (TO_DATE(TO_CHAR(FIN, 'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss') - 
        TO_DATE(TO_CHAR(INICIO,'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss')) * (60 * 24) INTO MINUTOS FROM DUAL;
        
        --Llamado a funcion para obtener el valor de la distancia
        DISTANCIA := valor_distancia(KILOMETROS, CIUDAD);
        --Llamado a funcion para obtener el valor del tiempo 
        TIEMPO := valor_tiempo(MINUTOS, CIUDAD);

        --Validacion de las funciones, si retornan 0 quiere decir que hubo una excepcion 
        IF (DISTANCIA = 0 OR TIEMPO = 0) THEN
            TARIFA := 0;
        ELSE
            --Seleccion del valor total de los detalles del servicio
            SELECT SUM(VALOR_COBRO) INTO VAL_DETALLES FROM DETALLE_SERVICIOS WHERE SERVICIO_ID = ID_SERVICIO;
            
            --Validacion por si un servicio no presenta detalles de servicios
            IF (VAL_DETALLES IS NULL) THEN
                VAL_DETALLES := 0;
            END IF;
        
            --Sumatoria del total neto del servicio
            TARIFA := BASE + DISTANCIA + TIEMPO + VAL_DETALLES;
         END IF;
    ELSE
        --Asignacion de valor cuando el servicio no ha finalizado
        TARIFA := 0;
    END IF;
    
    --Actulizacion del valor neto del servicio
    UPDATE DETALLE_PAGOS
    SET VALOR_PAGO = TARIFA
    WHERE SERVICIO_ID = ID_SERVICIO;
    
    dbms_output.put_line('Actualización de la información exitosa');
EXCEPTION
    --Validacion de excepciones
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontraron registros');
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo procesar la información');

    --Actulizacion del valor neto del servicio, en 0
    UPDATE DETALLE_PAGOS
    SET VALOR_PAGO = 0
    WHERE SERVICIO_ID = ID_SERVICIO;
END;

/*EXEC CALCULAR_TARIFA(1);

SELECT S.ID, S.ESTADO, C.NOMBRE, C.TARIFA_BASE, C.VALOR_KILOMETRO, C.VALOR_MINUTO, S.KILOMETROS, 
    (TO_DATE(TO_CHAR(FECHA_HORA_FIN, 'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss') - 
    TO_DATE(TO_CHAR(FECHA_HORA_INICIO,'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss')) * (60 * 24) MINUTOS,
    (C.VALOR_KILOMETRO * S.KILOMETROS) AS TOTAL_KILOMETROS, 
    ((TO_DATE(TO_CHAR(FECHA_HORA_FIN, 'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss') - 
    TO_DATE(TO_CHAR(FECHA_HORA_INICIO,'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss')) * (60 * 24) *  C.VALOR_MINUTO) AS
    TOTAL_MINUTOS
FROM SERVICIOS S INNER JOIN CIUDADES C ON (S.CIUDAD_ID = C.ID)
WHERE S.ID IN (1, 4);

SELECT * FROM DETALLE_PAGOS WHERE SERVICIO_ID IN (1, 4);

SELECT * FROM DETALLE_SERVICIOS WHERE SERVICIO_ID IN (1, 4);*/


    
