create database IF NOT EXISTS bdfutbol;
/*Creacion de base de datos */
create table if not EXISTS ligas(
    codLiga char(5),
    nomLiga varchar(50),
    PRIMARY KEY(codLiga)
);
drop table equipos
create table if not EXISTS equipos (
    cod_equipo int AUTO_INCREMENT,
    nom_equipo varchar (40), 
    cod_liga char(5) DEFAULT ('pdn'),
    localidad varchar(60),
    internacional tinyint(1) DEFAULT 0,
    PRIMARY KEY (cod_equipo),
    /* index pk_cod_equipo (cod_equipo),  no es necesario o si yo que se*/
    FOREIGN key fk_codligaLigas (cod_liga) REFERENCES ligas(codLiga)
);
create table if NOT EXISTS futbolistas (
    cod_dni_nie char (9),
    nombre varchar(50),
    nacionalidad varchar(40),
    PRIMARY KEY (cod_dni_nie)
);
create table IF NOT EXISTS contratos (
    cod_contrato int AUTO_INCREMENT,
    dni_nie char(9),
    cod_equipo int,
    fecha_inicio date,
    fecha_fin date,
    precio_anual int,
    precio_recision int,
    PRIMARY KEY (cod_contrato),
    FOREIGN KEY fk_dniFutbolistas (dni_nie) REFERENCES futbolistas(cod_dni_nie),
    FOREIGN KEY fk_codequipoEquipos (cod_equipo) REFERENCES equipos(cod_equipo)
);
select * from contratos;
/*fin creacion base de datos*/
