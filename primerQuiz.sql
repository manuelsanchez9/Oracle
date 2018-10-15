select count(id) from attacks where url like '%https%';

select * from attacks where url like '%google%' order by number_of_attacks asc;

select ip_address, time_of_last_attack from attacks where time_of_last_attack 
between TO_DATE 
('2017-01-01T00:00:00', 'YYYY-MM-DD"T"HH24:MI:SS') AND TO_DATE('2017-12-31T23:59:59', 'YYYY-MM-DD"T"HH24:MI:SS');

select ip_address, number_of_attacks from attacks where url like '%instagram%' and url like '%https%'; 

select ip_address from attacks where number_of_attacks = 1 and id = 192;
