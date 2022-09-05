-- inbound.algorithm_match definition

-- Drop table

-- DROP TABLE inbound.algorithm_match;

CREATE TABLE inbound.algorithm_match (
	id int4 NOT NULL,
	algorithm text NULL,
	compound_id int4 NULL,
	cas_rn varchar NULL,
	probability float8 NULL,
	CONSTRAINT algorithm_match_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.algorithm_match OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.algorithm_match TO rsadmin;


-- inbound.analyzer definition

-- Drop table

-- DROP TABLE inbound.analyzer;

CREATE TABLE inbound.analyzer (
	id int4 NOT NULL,
	brand text NULL,
	model text NULL,
	site text NULL,
	CONSTRAINT analyzer_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.analyzer OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.analyzer TO rsadmin;


-- inbound.bacteria definition

-- Drop table

-- DROP TABLE inbound.bacteria;

CREATE TABLE inbound.bacteria (
	id int4 NOT NULL,
	family_id int4 NULL,
	strain varchar NULL DEFAULT 'unknown'::character varying,
	CONSTRAINT bacteria_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.bacteria OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.bacteria TO rsadmin;


-- inbound.bacteria_family definition

-- Drop table

-- DROP TABLE inbound.bacteria_family;

CREATE TABLE inbound.bacteria_family (
	id int4 NOT NULL,
	"name" varchar NULL,
	CONSTRAINT bacteria_family_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.bacteria_family OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.bacteria_family TO rsadmin;


-- inbound.bacteria_set definition

-- Drop table

-- DROP TABLE inbound.bacteria_set;

CREATE TABLE inbound.bacteria_set (
	id int4 NOT NULL,
	bacteria_strain_id int4 NULL,
	CONSTRAINT bacteria_set_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.bacteria_set OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.bacteria_set TO rsadmin;


-- inbound.compound definition

-- Drop table

-- DROP TABLE inbound.compound;

CREATE TABLE inbound.compound (
	id int4 NOT NULL,
	measurement_id int4 NULL,
	mass float8 NULL,
	retention_time float8 NULL,
	area float8 NULL,
	max_value float8 NULL,
	CONSTRAINT compound_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.compound OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.compound TO rsadmin;


-- inbound.diagnosis definition

-- Drop table

-- DROP TABLE inbound.diagnosis;

CREATE TABLE inbound.diagnosis (
	experiment_id int4 NULL,
	pneumonia bool NULL,
	vap bool NULL,
	covid19 bool NULL
);

-- Permissions

ALTER TABLE inbound.diagnosis OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.diagnosis TO rsadmin;


-- inbound.era definition

-- Drop table

-- DROP TABLE inbound.era;

CREATE TABLE inbound.era (
	id int4 NOT NULL,
	"name" text NULL,
	date_start date NULL,
	date_end date NULL,
	CONSTRAINT era_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.era OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.era TO rsadmin;


-- inbound.experiment definition

-- Drop table

-- DROP TABLE inbound.experiment;

CREATE TABLE inbound.experiment (
	id int4 NOT NULL,
	"label" varchar NULL,
	measurement_1 int4 NULL,
	measurement_2 int4 NULL,
	reader_id int4 NULL,
	ventilator_id int4 NULL,
	bed_id varchar NULL,
	room_id varchar NULL,
	CONSTRAINT experiment_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.experiment OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.experiment TO rsadmin;


-- inbound.experiment_type definition

-- Drop table

-- DROP TABLE inbound.experiment_type;

CREATE TABLE inbound.experiment_type (
	id int4 NOT NULL,
	"name" text NULL,
	CONSTRAINT experiment_type_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.experiment_type OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.experiment_type TO rsadmin;


-- inbound.incubator definition

-- Drop table

-- DROP TABLE inbound.incubator;

CREATE TABLE inbound.incubator (
	id int4 NOT NULL,
	brand text NULL,
	model text NULL,
	"usage" text NULL,
	CONSTRAINT incubator_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.incubator OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.incubator TO rsadmin;


-- inbound.institution definition

-- Drop table

-- DROP TABLE inbound.institution;

CREATE TABLE inbound.institution (
	id int4 NOT NULL,
	"name" text NULL,
	"type" text NULL,
	CONSTRAINT institution_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.institution OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.institution TO rsadmin;


-- inbound.internal_standard definition

-- Drop table

-- DROP TABLE inbound.internal_standard;

CREATE TABLE inbound.internal_standard (
	id int4 NOT NULL,
	"name" text NULL,
	analyzer_id int4 NULL,
	retention_time float8 NULL,
	retention_time_stdev float8 NULL,
	cas_rn varchar NULL,
	CONSTRAINT internal_standard_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.internal_standard OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.internal_standard TO rsadmin;


-- inbound.internal_standards_set definition

-- Drop table

-- DROP TABLE inbound.internal_standards_set;

CREATE TABLE inbound.internal_standards_set (
	id int4 NOT NULL,
	internal_standard_id int4 NULL,
	CONSTRAINT internal_standards_set_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.internal_standards_set OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.internal_standards_set TO rsadmin;


-- inbound.invitro_measurement definition

-- Drop table

-- DROP TABLE inbound.invitro_measurement;

CREATE TABLE inbound.invitro_measurement (
	id int4 NOT NULL,
	td_tube_sn text NULL,
	measurement_id int4 NULL,
	set_number int4 NULL,
	sample_number int4 NULL,
	rep_number int4 NULL DEFAULT 0,
	"control" bool NULL,
	time_incubation_start timestamp NULL,
	time_incubation_end timestamp NULL,
	time_collection_start timestamp NULL,
	time_collection_end timestamp NULL,
	experiment_type int4 NULL,
	plate_number int4 NULL,
	flow_reg float8 NULL,
	accumulative bool NULL,
	bacteria_set int4 NULL,
	co2_percent float8 NULL,
	incubator_id int4 NULL,
	medium_id int4 NULL,
	remarks varchar(255) NULL,
	CONSTRAINT invitro_measurement_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.invitro_measurement OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.invitro_measurement TO rsadmin;


-- inbound.invivo_measurement definition

-- Drop table

-- DROP TABLE inbound.invivo_measurement;

CREATE TABLE inbound.invivo_measurement (
	id int4 NOT NULL,
	measurement_id int4 NULL,
	td_tube_sn text NULL,
	time_collection_start timestamp NULL,
	time_collection_end timestamp NULL,
	vent_tube_number int4 NULL,
	CONSTRAINT invivo_measurement_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.invivo_measurement OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.invivo_measurement TO rsadmin;


-- inbound.measurement definition

-- Drop table

-- DROP TABLE inbound.measurement;

CREATE TABLE inbound.measurement (
	id int4 NOT NULL,
	type_id int4 NULL,
	era_id int4 NULL,
	time_analysis timestamp NULL,
	internal_standards_set_id int4 NULL,
	analyzer_id int4 NULL,
	injection_pos int4 NULL,
	chromatogram varchar NULL,
	cef varchar NULL,
	CONSTRAINT measurement_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.measurement OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.measurement TO rsadmin;


-- inbound.measurement_type definition

-- Drop table

-- DROP TABLE inbound.measurement_type;

CREATE TABLE inbound.measurement_type (
	id int4 NOT NULL,
	"type" text NULL,
	CONSTRAINT measurement_type_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.measurement_type OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.measurement_type TO rsadmin;


-- inbound.medium definition

-- Drop table

-- DROP TABLE inbound.medium;

CREATE TABLE inbound.medium (
	id int4 NOT NULL,
	"type" text NULL,
	CONSTRAINT medium_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.medium OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.medium TO rsadmin;


-- inbound.molecule definition

-- Drop table

-- DROP TABLE inbound.molecule;

CREATE TABLE inbound.molecule (
	id int4 NOT NULL,
	cas_rn varchar NOT NULL,
	"name" text NULL,
	formula text NULL,
	type_id int4 NULL,
	CONSTRAINT molecule_pkey PRIMARY KEY (id, cas_rn)
);

-- Permissions

ALTER TABLE inbound.molecule OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.molecule TO rsadmin;


-- inbound.molecule_bacteria definition

-- Drop table

-- DROP TABLE inbound.molecule_bacteria;

CREATE TABLE inbound.molecule_bacteria (
	match_id int4 NULL,
	bacteria_id int4 NULL,
	retention_time_average float8 NULL,
	area_average float8 NULL,
	height_average float8 NULL,
	rrt1 float8 NULL,
	rrt2 float8 NULL,
	rrt3 float8 NULL,
	rrt4 float8 NULL
);

-- Permissions

ALTER TABLE inbound.molecule_bacteria OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.molecule_bacteria TO rsadmin;


-- inbound.molecule_type definition

-- Drop table

-- DROP TABLE inbound.molecule_type;

CREATE TABLE inbound.molecule_type (
	id int4 NOT NULL,
	"name" text NULL,
	CONSTRAINT molecule_type_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.molecule_type OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.molecule_type TO rsadmin;


-- inbound.patient_culture definition

-- Drop table

-- DROP TABLE inbound.patient_culture;

CREATE TABLE inbound.patient_culture (
	experiment_label varchar NOT NULL,
	invitro_measurement_id int4 NULL,
	source_id int4 NULL,
	CONSTRAINT patient_culture_pkey PRIMARY KEY (experiment_label)
);

-- Permissions

ALTER TABLE inbound.patient_culture OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.patient_culture TO rsadmin;


-- inbound.patient_culture_source definition

-- Drop table

-- DROP TABLE inbound.patient_culture_source;

CREATE TABLE inbound.patient_culture_source (
	id int4 NOT NULL,
	"type" text NULL,
	CONSTRAINT patient_culture_source_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.patient_culture_source OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.patient_culture_source TO rsadmin;


-- inbound.patient_emrdata definition

-- Drop table

-- DROP TABLE inbound.patient_emrdata;

CREATE TABLE inbound.patient_emrdata (
	patient_id int4 NOT NULL,
	age_years int4 NULL,
	sex text NULL,
	weight_kg int4 NULL,
	stuff1 varchar NULL,
	stuff2 varchar NULL,
	stuff3 varchar NULL,
	CONSTRAINT patient_emrdata_pkey PRIMARY KEY (patient_id)
);

-- Permissions

ALTER TABLE inbound.patient_emrdata OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.patient_emrdata TO rsadmin;


-- inbound.patient_reference definition

-- Drop table

-- DROP TABLE inbound.patient_reference;

CREATE TABLE inbound.patient_reference (
	rs_id varchar NOT NULL,
	patient_id int4 NULL,
	institution_id int4 NULL,
	CONSTRAINT patient_reference_pkey PRIMARY KEY (rs_id)
);

-- Permissions

ALTER TABLE inbound.patient_reference OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.patient_reference TO rsadmin;


-- inbound.spectrum definition

-- Drop table

-- DROP TABLE inbound.spectrum;

CREATE TABLE inbound.spectrum (
	id int4 NOT NULL,
	compound_id int4 NULL,
	x int4 NULL,
	y int4 NULL,
	z int4 NULL,
	CONSTRAINT spectrum_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.spectrum OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.spectrum TO rsadmin;


-- inbound.td_tube definition

-- Drop table

-- DROP TABLE inbound.td_tube;

CREATE TABLE inbound.td_tube (
	id text NOT NULL,
	type_id int4 NULL,
	CONSTRAINT td_tube_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.td_tube OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.td_tube TO rsadmin;


-- inbound.td_tube_type definition

-- Drop table

-- DROP TABLE inbound.td_tube_type;

CREATE TABLE inbound.td_tube_type (
	id int4 NOT NULL,
	manufacturer text NULL,
	model text NULL,
	CONSTRAINT td_tube_type_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.td_tube_type OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.td_tube_type TO rsadmin;


-- inbound.visit definition

-- Drop table

-- DROP TABLE inbound.visit;

CREATE TABLE inbound.visit (
	id int4 NOT NULL,
	experiment_id int4 NULL,
	CONSTRAINT visit_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE inbound.visit OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.visit TO rsadmin;


-- inbound.visit_history definition

-- Drop table

-- DROP TABLE inbound.visit_history;

CREATE TABLE inbound.visit_history (
	rs_id varchar NULL,
	visit_id int4 NULL
);

-- Permissions

ALTER TABLE inbound.visit_history OWNER TO rsadmin;
GRANT ALL ON TABLE inbound.visit_history TO rsadmin;