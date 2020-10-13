/*Inserciones ligas */
insert into bdfutbol.ligas (codLiga, nomLiga)
    values ('pdn','liga del pdn');

insert into bdfutbol.ligas (codLiga, nomLiga)
    values ('tdp','liga del tdp');

insert into bdfutbol.ligas (codLiga, nomLiga )
    values ('cgh','liga del cgh'   );
/*Fin insert ligas*/
/*Inserciones equipos*/
insert INTO bdfutbol.equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    values (null,'los duros','pdn','duro landia',0 );

insert INTO bdfutbol.equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    values (null,'los grandes','tdp','el olimpo',1 );

insert INTO bdfutbol.equipos (cod_equipo,nom_equipo,cod_liga,localidad,internacional)
    values (null,'los inutiles','cgh','a la izquierda',0 );
/*fin inserciones equipo*/
/*Inserciones futbolistas*/
insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('45984461p','benito','ESP');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('45984451p','ramon','ESP');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('43333331p','vladimir','RUS');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('43333332p','dimitri ','RUS');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('66666661p','keni','GER');

insert into bdfutbol.futbolistas (cod_dni_nie,nombre,nacionalidad)
    values ('66666662p','cartman','GER');

/*fin inserciones futbolistas*/
/*Inserciones contratos*/

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='benito'),
    (select cod_equipo from equipos where cod_liga='pdn'),
    (select curdate()),
    '2030-11-28',
    5000,
    20000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='ramon'),
    (select cod_equipo from equipos where cod_liga='pdn'),
    (select curdate()),
    '2030-11-28',
    5500,
    21000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='vladimir'),
    (select cod_equipo from equipos where cod_liga='tdp'),
    (select curdate()-10),
    '2030-11-28',
    30000,
    50000);


insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='dimitri'),
    (select cod_equipo from equipos where cod_liga='tdp'),
    (select curdate()-10),
    '2030-11-28',
    40000,
    90000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='keni'),
    (select cod_equipo from equipos where cod_liga='cgh'),
    (select curdate()-20),
    '2030-11-28',
    900000,
    1000000);

insert into bdfutbol.contratos (cod_contrato,dni_nie,cod_equipo,fecha_inicio,fecha_fin,precio_anual,precio_recision)
    values (null,
    (select cod_dni_nie from bdfutbol.futbolistas where nombre='cartman'),
    (select cod_equipo from equipos where cod_liga='cgh'),
    (select curdate()-20),
    '2030-11-28',
    100,
    200);

/*fin inserciones contratos*/
/*fin inserciones*/
