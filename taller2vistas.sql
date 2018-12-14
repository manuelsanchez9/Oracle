/* --- PUNTO 1 --- */

--Creacion de la vista medios_pago_clientes
create or replace view medios_pago_clientes
as
    select cli.persona_id as cliente_id,
		   pers.nombre || ' ' || pers.apellido as nombre_cliente,
		   mdp.id as medio_pago_id, mdp.tipo_medio as tipo, mdp.datos_adicionales as detalles_medio_pago, 
		   case when mdp.empresarial = 1 then 'VERDADERO' else 'FALSO' end, emp.nombre as nombre_empresa
	from clientes cli INNER JOIN personas pers on (cli.persona_id = pers.id)
					  INNER JOIN medios_pago mdp on (cli.persona_id = mdp.cliente_id)
					  INNER JOIN empresas emp on (mdp.empresa_id = emp.id);

--select * from medios_pago_clientes;

/* --- PUNTO 2 --- */

--Creacion de la vista viajes_clientes
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
