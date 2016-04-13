CREATE SCHEMA `iacym_lince` ;

/*PAIS*/
CREATE TABLE pais
( 
	CodigoPais           varchar(3)  NOT NULL ,
	Nombre               varchar(50)  NOT NULL ,
	Abreviatura          varchar(5)  NOT NULL ,
	NroPostal            varchar(20)  NULL 
);
ALTER TABLE `iacym_lince`.`pais` 
ADD PRIMARY KEY (`CodigoPais`);

/*DEPARTAMENTO*/
CREATE TABLE Departamento
( 
	CodigoDpto           varchar(3)  NOT NULL ,
	Nombre               varchar(50)  NOT NULL ,
	CodigoPais           varchar(3)  NOT NULL 
);
ALTER TABLE `iacym_lince`.`departamento` 
ADD PRIMARY KEY (`CodigoPais`, `CodigoDpto`),
ADD INDEX `IDX_CodigoPais_Pais_FK` (`CodigoPais` ASC);

ALTER TABLE `iacym_lince`.`departamento` 
ADD CONSTRAINT `FK_CodigoPais_Pais`
  FOREIGN KEY (`CodigoPais`)
  REFERENCES `iacym_lince`.`pais` (`CodigoPais`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*PROVINCIA*/
CREATE TABLE Provincia
( 
	CodigoPais           varchar(3)  NOT NULL ,
    CodigoDpto           varchar(3)  NOT NULL ,
    CodigoProv           varchar(3)  NOT NULL ,
	Nombre               varchar(50)  NOT NULL 	
);

ALTER TABLE `iacym_lince`.`provincia` 
ADD PRIMARY KEY (`CodigoPais`, `CodigoDpto`, `CodigoProv`),
ADD INDEX `IDX_CodigoPaisDpto_Departamento_FK` (`CodigoPais` ASC, `CodigoDpto` ASC);

ALTER TABLE `iacym_lince`.`provincia` 
ADD CONSTRAINT `FK_CodigoPaisDpto_Departamento`
  FOREIGN KEY (`CodigoPais` , `CodigoDpto`)
  REFERENCES `iacym_lince`.`departamento` (`CodigoPais` , `CodigoDpto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*DISTRITO*/
CREATE TABLE Distrito
( 
	CodigoPais           varchar(3)  NOT NULL ,
    CodigoDpto           varchar(3)  NOT NULL ,
    CodigoProv           varchar(3)  NOT NULL ,
    CodigoDist           varchar(3)  NOT NULL ,
	Nombre               varchar(50)  NULL
);

ALTER TABLE `iacym_lince`.`distrito` 
ADD PRIMARY KEY (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`),
ADD INDEX `IDX_CodigoPaisDptoProv_Provincia_FK` (`CodigoPais` ASC, `CodigoDpto` ASC, `CodigoProv` ASC);

ALTER TABLE `iacym_lince`.`distrito` 
ADD CONSTRAINT `FK_CodigoPaisDptoProv_Provincia`
  FOREIGN KEY (`CodigoPais` , `CodigoDpto` , `CodigoProv`)
  REFERENCES `iacym_lince`.`provincia` (`CodigoPais` , `CodigoDpto` , `CodigoProv`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*PERSONA*/
CREATE TABLE Persona
( 
	CodigoPersona        varchar(20)  NOT NULL ,
    Nombres              varchar(100)  NOT NULL ,
	ApellidoPaterno      varchar(50)  NOT NULL ,
    ApellidoMaterno      varchar(50)  NOT NULL ,
	FechaNacimiento      date  NULL ,
	Direccion            varchar(200)  NULL ,
    CorreoPersonal       varchar(100)  NOT NULL ,
	NroCelular           varchar(12)  NOT NULL ,	
	EsMiembro            bit  NOT NULL ,	
	CodigoPais           varchar(3)  NULL ,
    CodigoDpto           varchar(3)  NULL ,
    CodigoProv           varchar(3)  NULL ,
    CodigoDist           varchar(3)  NULL 
);

ALTER TABLE `iacym_lince`.`persona` 
ADD PRIMARY KEY (`CodigoPersona`),
ADD INDEX `IDX_CodigoPaisDptoProvDist_Distrito_FK` (`CodigoPais` ASC, `CodigoDpto` ASC, `CodigoProv` ASC, `CodigoDist` ASC);

ALTER TABLE `iacym_lince`.`persona` 
ADD CONSTRAINT `FK_CodigoPaisDptoProvDist_Distrito`
  FOREIGN KEY (`CodigoPais` , `CodigoDpto` , `CodigoProv` , `CodigoDist`)
  REFERENCES `iacym_lince`.`distrito` (`CodigoPais` , `CodigoDpto` , `CodigoProv` , `CodigoDist`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*TITULO*/
CREATE TABLE Titulo
( 
	CodigoTitulo         varchar(5)  NOT NULL ,
	Nombre               varchar(50)  NOT NULL ,
	Descripcion          varchar(200)  NULL 
);

ALTER TABLE `iacym_lince`.`titulo` 
ADD PRIMARY KEY (`CodigoTitulo`);

/*MEMBRESIA*/
CREATE TABLE Membresia
( 
	CodigoMiembro        varchar(20)  NOT NULL ,
	NroDiezmo            integer  NOT NULL ,
	FechaConversion      date   NULL ,
	CodigoPersona        varchar(20)  NOT NULL ,
	CodigoTitulo         varchar(5)  NOT NULL 
);

ALTER TABLE `iacym_lince`.`membresia` 
ADD PRIMARY KEY (`CodigoMiembro`),
ADD INDEX `IDX_CodigoPersona_Persona_FK` (`CodigoPersona` ASC),
ADD INDEX `IDX_CodigoTitulo_Titulo_FK` (`CodigoTitulo` ASC);

ALTER TABLE `iacym_lince`.`membresia` 
ADD CONSTRAINT `FK_CodigoPersona_Persona`
  FOREIGN KEY (`CodigoPersona`)
  REFERENCES `iacym_lince`.`persona` (`CodigoPersona`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_CodigoTitulo_Titulo`
  FOREIGN KEY (`CodigoTitulo`)
  REFERENCES `iacym_lince`.`titulo` (`CodigoTitulo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*ZONA*/
CREATE TABLE Zona
( 
	CodigoZona           varchar(5)  NOT NULL ,
	NroZona              integer  NOT NULL ,
    Abreviatura			 varchar(50)  NULL ,	
	Nombre               varchar(50)  NULL ,
    Descripcion			 varchar(200) NULL ,
	CodigoPastor         varchar(20)  NOT NULL    
);

ALTER TABLE `iacym_lince`.`zona` 
ADD PRIMARY KEY (`CodigoZona`),
ADD INDEX `IDX_CodigoMiembro_Membresia_FK` (`CodigoPastor` ASC);

ALTER TABLE `iacym_lince`.`zona` 
ADD CONSTRAINT `FK_CodigoMiembro_Membresia`
  FOREIGN KEY (`CodigoPastor`)
  REFERENCES `iacym_lince`.`membresia` (`CodigoMiembro`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*CELULA*/
CREATE TABLE Celula
( 
	CodigoZona           varchar(5)  NOT NULL ,
    CodigoCelula         varchar(5)  NOT NULL ,
	NroCelula            integer  NOT NULL ,	
	CodigoLider          varchar(20)  NOT NULL 
);

ALTER TABLE `iacym_lince`.`celula` 
ADD PRIMARY KEY (`CodigoZona`, `CodigoCelula`),
ADD INDEX `IDX_CodigoMiembro_Membresia_FK` (`CodigoLider` ASC);


ALTER TABLE `iacym_lince`.`celula` 
ADD CONSTRAINT `FK_CodigoZona_Zona`
  FOREIGN KEY (`CodigoZona`)
  REFERENCES `iacym_lince`.`zona` (`CodigoZona`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION ,
ADD CONSTRAINT `Miembro`
  FOREIGN KEY (`CodigoLider`)
  REFERENCES `iacym_lince`.`membresia` (`CodigoMiembro`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*USUARIO*/
 CREATE TABLE `usuario` (
 `id` int(11) NOT NULL auto_increment,
 `full_name` varchar(32) NOT NULL default '',
 `email` varchar(32) NOT NULL default '',
 `username` varchar(20) NOT NULL default '',
 `password` varchar(32) NOT NULL default '',
 PRIMARY KEY (`id`),
 UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*==================================================================================*/

INSERT INTO `iacym_lince`.`pais` (`CodigoPais`, `Nombre`, `Abreviatura`) VALUES ('01', 'PERU', 'PE');

INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '00', 'SIN DEPARTAMENTO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '01', 'AMAZONAS');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '02', 'ANCASH');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '03', 'APURIMAC');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '04', 'AREQUIPA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '05', 'AYACUCHO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '06', 'CAJAMARCA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '07', 'PROVINCIAL CONST. DEL CALLAO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '08', 'CUSCO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '09', 'HUANCAVELICA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '10', 'HUANUCO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '11', 'ICA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '12', 'JUNIN');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '13', 'LA LIBERTAD');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '14', 'LAMBAYEQUE');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '15', 'LIMA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '16', 'LORETO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '17', 'MADRE DE DIOS');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '18', 'MOQUEGUA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '19', 'PASCO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '20', 'PIURA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '21', 'PUNO');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '22', 'SAN MARTIN');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '23', 'TACNA');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '24', 'TUMBES');
INSERT INTO `iacym_lince`.`departamento` (`CodigoPais`, `CodigoDpto`, `Nombre`) VALUES ('01', '25', 'UCAYALI');

INSERT INTO `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) VALUES ('01', '00', '00', 'SIN PROVINCIA');
INSERT INTO `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) VALUES ('01', '01', '01', 'CHACHAPOYAS');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '01', '02', 'BAGUA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '01', '03', 'BONGARA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '01', '04', 'CONDORCANQUI');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '01', '05', 'LUYA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '01', '06', 'RODRIGUEZ DE MENDOZA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '01', '07', 'UTCUBAMBA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '01', 'HUARAZ');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '02', 'AIJA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '03', 'ANTONIO RAYMONDI');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '04', 'ASUNCION');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '05', 'BOLOGNESI');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '06', 'CARHUAZ');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '07', 'CARLOS F. FITZCARRALD');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '08', 'CASMA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '09', 'CORONGO');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '10', 'HUARI');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '11', 'HUARMEY');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '12', 'HUAYLAS');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '13', 'MARISCAL LUZURIAGA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '14', 'OCROS');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '15', 'PALLASCA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '16', 'POMABAMBA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '17', 'RECUAY');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '18', 'SANTA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '19', 'SIHUAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '02', '20', 'YUNGAY');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '01', 'ABANCAY');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '02', 'ANDAHUAYLAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '03', 'ANTABAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '04', 'AYMARAES');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '05', 'COTABAMBAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '06', 'CHINCHEROS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '03', '07', 'GRAU');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '01', 'AREQUIPA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '02', 'CAMANA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '03', 'CARAVELI');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '04', 'CASTILLA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '05', 'CAYLLOMA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '06', 'CONDESUYOS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '07', 'ISLAY');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '04', '08', 'LA UNION');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '01', 'HUAMANGA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '02', 'CANGALLO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '03', 'HUANCA SANCOS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '04', 'HUANTA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '05', 'LA MAR');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '06', 'LUCANAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '07', 'PARINACOCHAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '08', 'PAUCAR DEL SARA SARA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '09', 'SUCRE');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '10', 'VICTOR FAJARDO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '05', '11', 'VILCAS HUAMAN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '01', 'CAJAMARCA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '02', 'CAJABAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '03', 'CELENDIN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '04', 'CHOTA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '05', 'CONTUMAZA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '06', 'CUTERVO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '07', 'HUALGAYOC');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '08', 'JAEN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '09', 'SAN IGNACIO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '10', 'SAN MARCOS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '11', 'SAN MIGUEL');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '12', 'SAN PABLO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '06', '13', 'SANTA CRUZ');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '07', '01', 'PROV. CONST. DEL CALLAO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '01', 'CUSCO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '02', 'ACOMAYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '03', 'ANTA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '04', 'CALCA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '05', 'CANAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '06', 'CANCHIS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '07', 'CHUMBIVILCAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '08', 'ESPINAR');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '09', 'LA CONVENCION');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '10', 'PARURO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '11', 'PAUCARTAMBO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '12', 'QUISPICANCHI');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '08', '13', 'URUBAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '01', 'HUANCAVELICA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '02', 'ACOBAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '03', 'ANGARAES');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '04', 'CASTROVIRREYNA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '05', 'CHURCAMPA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '06', 'HUAYTARA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '09', '07', 'TAYACAJA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '01', 'HUANUCO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '02', 'AMBO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '03', 'DOS DE MAYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '04', 'HUACAYBAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '05', 'HUAMALIES');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '06', 'LEONCIO PRADO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '07', 'MARAÑON');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '08', 'PACHITEA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '09', 'PUERTO INCA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '10', 'LAURICOCHA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '10', '11', 'YAROWILCA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '11', '01', 'ICA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '11', '02', 'CHINCHA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '11', '03', 'NAZCA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '11', '04', 'PALPA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '11', '05', 'PISCO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '01', 'HUANCAYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '02', 'CONCEPCION');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '03', 'CHANCHAMAYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '04', 'JAUJA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '05', 'JUNIN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '06', 'SATIPO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '07', 'TARMA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '08', 'YAULI');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '12', '09', 'CHUPACA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '01', 'TRUJILLO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '02', 'ASCOPE');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '03', 'BOLIVAR');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '04', 'CHEPEN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '05', 'JULCAN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '06', 'OTUZCO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '07', 'PACASMAYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '08', 'PATAZ');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '09', 'SANCHEZ CARRION');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '10', 'SANTIAGO DE CHUCO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '11', 'GRAN CHIMU');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '13', '12', 'VIRU');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '14', '01', 'CHICLAYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '14', '02', 'FERREÑAFE');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '14', '03', 'LAMBAYEQUE');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '01', 'LIMA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '02', 'BARRANCA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '03', 'CAJATAMBO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '04', 'CANTA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '05', 'CAÑETE');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '06', 'HUARAL');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '07', 'HUAROCHIRI');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '08', 'HUAURA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '09', 'OYON');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '15', '10', 'YAUYOS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '01', 'MAYNAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '02', 'ALTO AMAZONAS');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '03', 'LORETO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '04', 'MARISCAL RAMON CASTILLA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '05', 'REQUENA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '06', 'UCAYALI');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '16', '07', 'DATEM DEL MARAÑON');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '17', '01', 'TAMBOPATA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '17', '02', 'MANU');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '17', '03', 'TAHUAMANU');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '18', '01', 'MARISCAL NIETO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '18', '02', 'GENERAL SANCHEZ CERRO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '18', '03', 'ILO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '19', '01', 'PASCO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '19', '02', 'DANIEL ALCIDES CARRION');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '19', '03', 'OXAPAMPA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '01', 'PIURA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '02', 'AYABACA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '03', 'HUANCABAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '04', 'MORROPON');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '05', 'PAITA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '06', 'SULLANA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '07', 'TALARA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '20', '08', 'SECHURA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '01', 'PUNO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '02', 'AZANGARO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '03', 'CARABAYA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '04', 'CHUCUITO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '05', 'EL COLLAO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '06', 'HUANCANE');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '07', 'LAMPA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '08', 'MELGAR');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '09', 'MOHO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '10', 'SAN ANTONIO DE PUTINA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '11', 'SAN ROMAN');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '12', 'SANDIA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '21', '13', 'YUNGUYO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '01', 'MOYOBAMBA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '02', 'BELLAVISTA');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '03', 'EL DORADO');
Insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '04', 'HUALLAGA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '05', 'LAMAS');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '06', 'MARISCAL CACERES');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '07', 'PICOTA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '08', 'RIOJA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '09', 'SAN MARTIN');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '22', '10', 'TOCACHE');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '23', '01', 'TACNA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '23', '02', 'CANDARAVE');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '23', '03', 'JORGE BASADRE');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '23', '04', 'TARATA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '24', '01', 'TUMBES');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '24', '02', 'CONTRALMIRANTE VILLAR');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '24', '03', 'ZARUMILLA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '25', '01', 'CORONEL PORTILLO');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '25', '02', 'ATALAYA');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '25', '03', 'PADRE ABAD');
insert into `iacym_lince`.`provincia` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `Nombre`) Values ('01', '25', '04', 'PURUS');

INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '00', '00', '00', 'SIN DISTRITO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '01', '01', 'CHACHAPOYAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '01', '02', 'ASUNCION');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '01', '03', 'BALSAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '02', '01', 'BAGUA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '02', '02', 'ARAMANGO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '02', '03', 'COPALLIN');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '03', '01', 'JUMBILLA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '03', '02', 'CHISQUILLA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '03', '03', 'CHURUJA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '04', '01', 'NIEVA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '04', '02', 'EL CENEPA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '04', '03', 'RIO SANTIAGO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '05', '01', 'LAMUD');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '05', '02', 'CAMPORREDONDO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '05', '03', 'COCABAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '06', '01', 'SAN NICOLAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '06', '02', 'CHIRIMOTO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '06', '03', 'COCHAMAL');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '07', '01', 'BAGUA GRANDE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '07', '02', 'CAJARURO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '01', '07', '03', 'CUMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '01', '01', 'HUARAZA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '01', '02', 'COCHABAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '01', '03', 'COLCABAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '02', '01', 'AIJA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '02', '02', 'CORIS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '02', '03', 'HUACLLAN');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '03', '01', 'LLAMELLIN');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '03', '02', 'ACZO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '03', '03', 'CACCHO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '04', '01', 'CHACAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '04', '02', 'ACOCHACA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '05', '01', 'CHIQUIAN');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '05', '02', 'ABELARDO PARDO LEZAMETA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '05', '03', 'ANTONIO RAYMONDI');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '06', '01', 'CARHUAZ');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '06', '02', 'ACOPAMPA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '06', '03', 'AMASHCA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '07', '01', 'SAN LUIS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '07', '02', 'SAN NICOLAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '07', '03', 'YAUYA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '08', '01', 'CASMA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '08', '02', 'BUENA VISTA ALTA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '08', '03', 'COMANDANTE NOEL');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '09', '01', 'CORONGO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '09', '02', 'ACO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '09', '03', 'BAMBAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '10', '01', 'HUARI');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '10', '02', 'ANRA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '10', '03', 'CAJAY');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '11', '01', 'HUARMEY');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '11', '02', 'COCHAPETI');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '11', '03', 'CULEBRAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '12', '01', 'CARAZ');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '12', '02', 'HUALLANCA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '12', '03', 'HUATA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '13', '01', 'PISCOBAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '13', '02', 'CASCA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '13', '03', 'ELEAZAR GUZMAN BARRON');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '14', '01', 'OCROS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '14', '02', 'ACAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '14', '03', 'CAJAMARQUILLA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '15', '01', 'CABANA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '15', '02', 'BOLOGNESI');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '15', '03', 'CONCHUCOS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '16', '01', 'POMABAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '16', '02', 'HUAYLLAN');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '16', '03', 'PAROBAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '17', '01', 'RECUAY');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '17', '02', 'CATAC');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '17', '03', 'COTAPARACO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '18', '01', 'CHIMBOTE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '18', '02', 'CACERES DEL PERU');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '18', '03', 'COISHCO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '19', '01', 'SIHUAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '19', '02', 'ACOBAMBA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '19', '03', 'ALFONSO UGARTE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '20', '01', 'YUNGAY');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '20', '02', 'CASCAPARA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '02', '20', '03', 'MANCOS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '01', 'LIMA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '02', 'ANCON');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '03', 'ATE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '04', 'BARRANCO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '05', 'BREÑA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '06', 'CARABAYLLO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '07', 'CHACLACAYO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '08', 'CHORRILLOS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '09', 'CIENIGUILLA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '10', 'COMAS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '11', 'EL AGUSTINO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '12', 'INDEPENDENCIA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '13', 'JESUS MARIA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '14', 'LA MOLINA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '15', 'LA VICTORIA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '16', 'LINCE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '17', 'LOS OLIVOS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '18', 'LURIGANCHO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '19', 'LURIN');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '20', 'MAGADALENA DEL MAR');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '21', 'PUEBLO LIBRE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '22', 'MIRAFLORES');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '23', 'PACHACAMAC');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '24', 'PUCUSANA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '25', 'PUENTE PIEDRA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '26', 'PUNTA HERMOSA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '27', 'PUNTA NEGRA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '28', 'RIMAC');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '29', 'SAN BARTOLO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '30', 'SAN BORJA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '31', 'SAN ISIDRO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '32', 'SAN JUAN DE LURIGANCO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '33', 'SAN JUAN DE MIRAFLORES');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '34', 'SAN LUIS');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '35', 'SAN MARTIN DE PORRES');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '36', 'SAN MIGUEL');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '37', 'SANTA ANITA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '38', 'SANTA MARIA DEL MAR');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '39', 'SANTA ROSA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '40', 'SANTIAGO DE SURCO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '41', 'SURQUILLO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '42', 'VILLA EL SALVADOR');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '43', 'VILLA MARIA DEL TRIUNFO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '44', 'CHOSICA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '45', 'PUCUSANA (KM 61.300)');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '46', 'VITARTE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '47', 'SURCO');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '48', 'PUCUSANA (KM 61.200)');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '49', 'TRAPICHE');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '50', 'EL PROGRESO (CARABAYLLO)');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '51', 'ARICA');
INSERT INTO `iacym_lince`.`distrito` (`CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`, `Nombre`) VALUES ('01', '15', '01', '52', 'HUAYCAN');

INSERT INTO `iacym_lince`.`titulo` (`CodigoTitulo`, `Nombre`) VALUES ('T01', 'PASTOR');
INSERT INTO `iacym_lince`.`titulo` (`CodigoTitulo`, `Nombre`) VALUES ('T02', 'LIDER DE CELULA');
INSERT INTO `iacym_lince`.`titulo` (`CodigoTitulo`, `Nombre`) VALUES ('T03', 'APOYO');
INSERT INTO `iacym_lince`.`titulo` (`CodigoTitulo`, `Nombre`) VALUES ('T04', 'LIDER DE MACRO');
INSERT INTO `iacym_lince`.`titulo` (`CodigoTitulo`, `Nombre`) VALUES ('T05', 'MAESTRO');
INSERT INTO `iacym_lince`.`titulo` (`CodigoTitulo`, `Nombre`) VALUES ('T06', 'APOYO PASTORAL');

INSERT INTO `iacym_lince`.`persona` (`CodigoPersona`, `Nombres`, `ApellidoPaterno`, `ApellidoMaterno`, `FechaNacimiento`, `Direccion`, `CorreoPersonal`, `NroCelular`, `EsMiembro`, `CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`) VALUES ('P00001', 'Raquel', 'Velasquez', 'Paz', '1987-05-15', 'Av. Mariscal Miller 2374 int.7', 'raqui140@gmail.com', '987249140', 1, '01', '15', '01', '16');
INSERT INTO `iacym_lince`.`persona` (`CodigoPersona`, `Nombres`, `ApellidoPaterno`, `ApellidoMaterno`, `FechaNacimiento`, `Direccion`, `CorreoPersonal`, `NroCelular`, `EsMiembro`, `CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`) VALUES ('P00002', 'Samuel', 'Velasquez', 'Paz', '1982-04-16', 'Av. Brigida Silva', 'raqui140@gmail.com', '987249140', 1, '01', '15', '01', '36');
INSERT INTO `iacym_lince`.`persona` (`CodigoPersona`, `Nombres`, `ApellidoPaterno`, `ApellidoMaterno`, `FechaNacimiento`, `Direccion`, `CorreoPersonal`, `NroCelular`, `EsMiembro`, `CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`) VALUES ('P00003', 'Samuel', 'Chavez', 'Quiroz', '1982-02-13', 'Av. Paso de los Andes 555', 'raqui140@gmail.com', '987249140', 1, '01', '15', '01', '21');
INSERT INTO `iacym_lince`.`persona` (`CodigoPersona`, `Nombres`, `ApellidoPaterno`, `ApellidoMaterno`, `FechaNacimiento`, `Direccion`, `CorreoPersonal`, `NroCelular`, `EsMiembro`, `CodigoPais`, `CodigoDpto`, `CodigoProv`, `CodigoDist`) VALUES ('P00004', 'Manuel', 'Alves', 'Alves', '1966-03-27', 'Av. Javier Prado Este', 'raqui140@gmail.com', '987249140', 1, '01', '15', '01', '21');

INSERT INTO `iacym_lince`.`membresia` (`CodigoMiembro`, `NroDiezmo`, `FechaConversion`, `CodigoPersona`, `CodigoTitulo`) VALUES ('M0001', '4293', '1997-05-01', 'P00001', 'T02');
INSERT INTO `iacym_lince`.`membresia` (`CodigoMiembro`, `NroDiezmo`, `FechaConversion`, `CodigoPersona`, `CodigoTitulo`) VALUES ('M0002', '1493', '1997-05-01', 'P00002', 'T06');
INSERT INTO `iacym_lince`.`membresia` (`CodigoMiembro`, `NroDiezmo`, `FechaConversion`, `CodigoPersona`, `CodigoTitulo`) VALUES ('M0003', '1493', '1997-05-01', 'P00003', 'T01');
INSERT INTO `iacym_lince`.`membresia` (`CodigoMiembro`, `NroDiezmo`, `FechaConversion`, `CodigoPersona`, `CodigoTitulo`) VALUES ('M0004', '1493', '1997-05-01', 'P00004', 'T01');

INSERT INTO `iacym_lince`.`zona` (`CodigoZona`, `NroZona`, `Abreviatura`, `Nombre`, `Descripcion`, `CodigoPastor`) VALUES ('Z01', '1', 'DANI', 'Zona niños', 'Zona de niños de 7 a 11 años.', 'M0001');
INSERT INTO `iacym_lince`.`zona` (`CodigoZona`, `NroZona`, `Abreviatura`, `Nombre`, `Descripcion`, `CodigoPastor`) VALUES ('Z02', '2', 'ADHAC', 'Zona adolescentes', 'Zona de adolescentes de 12 a 18 años.', 'M0003');
INSERT INTO `iacym_lince`.`zona` (`CodigoZona`, `NroZona`, `Abreviatura`, `Nombre`, `Descripcion`, `CodigoPastor`) VALUES ('Z03', '3', 'MJ', 'Zona jovenes', 'Zona de jovenes de 19 a 25 años.', 'M0004');

INSERT INTO `iacym_lince`.`celula` (`CodigoZona`, `CodigoCelula`, `NroCelula`, `CodigoLider`) VALUES ('Z02', 'CEL01', '56', 'M0001');


select * from zona

