-- Create all the required tables 
-- secound line

-- DROP ROLE rsadmin;

CREATE ROLE rsadmin WITH 
	NOSUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	REPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;

-- DROP SCHEMA athena;

CREATE SCHEMA athena AUTHORIZATION rsadmin;

CREATE SCHEMA inbound AUTHORIZATION rsadmin;


CREATE TABLE Measurement_Type (
  id int PRIMARY KEY,
  type text
);

CREATE TABLE Era (
  id int PRIMARY KEY,
  name text,
  date_start date,
  date_end date
);

CREATE TABLE Internal_Standards_Set (
  id int PRIMARY KEY,
  internal_standard_id int
);

CREATE TABLE Internal_Standard (
  id int PRIMARY KEY,
  name text,
  analyzer_id int,
  retention_time float DEFAULT NULL,
  retention_time_stdev float DEFAULT NULL,
  cas_rn varchar
);

CREATE TABLE Td_Tube (
  id text PRIMARY KEY,
  type_id int
);

CREATE TABLE Td_Tube_Type (
  id int PRIMARY KEY,
  manufacturer text,
  model text
);

CREATE TABLE Measurement (
  id int PRIMARY KEY,
  type_id int,
  era_id int,
  time_analysis timestamp,
  internal_standards_set_id int,
  analyzer_id int,
  injection_pos int,
  chromatogram varchar,
  cef varchar
);

CREATE TABLE Bacteria (
  id int PRIMARY KEY,
  family_id int,
  strain varchar DEFAULT 'unknown'
);

CREATE TABLE Bacteria_Family (
  id int PRIMARY KEY,
  name varchar DEFAULT NULL
);

CREATE TABLE Experiment (
  id int PRIMARY KEY,
  label varchar,
  measurement_1 int,
  measurement_2 int,
  reader_id int,
  ventilator_id int,
  bed_id varchar,
  room_id varchar
);

CREATE TABLE Visit (
  id int PRIMARY KEY,
  experiment_id int
);

CREATE TABLE Visit_History (
  rs_id varchar,
  visit_id int
);

CREATE TABLE Invivo_Measurement (
  id int PRIMARY KEY,
  measurement_id int,
  td_tube_sn text,
  time_collection_start timestamp,
  time_collection_end timestamp,
  vent_tube_number int
);

CREATE TABLE Patient_Reference (
  rs_id varchar PRIMARY KEY,
  patient_id int,
  institution_id int
);

CREATE TABLE Patient_EMRData (
  patient_id int PRIMARY KEY,
  age_years int,
  sex text,
  weight_kg int,
  stuff1 varchar,
  stuff2 varchar,
  stuff3 varchar
);

CREATE TABLE Institution (
  id int PRIMARY KEY,
  name text,
  type text
);

CREATE TABLE Diagnosis (
  experiment_id int,
  pneumonia bool DEFAULT NULL,
  vap bool DEFAULT NULL,
  covid19 bool DEFAULT NULL
);

CREATE TABLE Invitro_Measurement (
  id int PRIMARY KEY,
  td_tube_sn text,
  measurement_id int,
  set_number int,
  sample_number int,
  rep_number int DEFAULT 0,
  control bool,
  time_incubation_start timestamp,
  time_incubation_end timestamp,
  time_collection_start timestamp,
  time_collection_end timestamp,
  experiment_type int,
  plate_number int,
  flow_reg float,
  accumulative bool,
  bacteria_set int,
  co2_percent float,
  incubator_id int,
  medium_id int,
  remarks varchar(255)
);

CREATE TABLE Analyzer (
  id int PRIMARY KEY,
  brand text,
  model text,
  site text
);

CREATE TABLE Incubator (
  id int PRIMARY KEY,
  brand text,
  model text,
  usage text
);

CREATE TABLE Experiment_Type (
  id int PRIMARY KEY,
  name text
);

CREATE TABLE Medium (
  id int PRIMARY KEY,
  type text
);

CREATE TABLE Patient_Culture (
  experiment_label varchar PRIMARY KEY,
  invitro_measurement_id int,
  source_id int
);

CREATE TABLE Patient_Culture_Source (
  id int PRIMARY KEY,
  type text
);

CREATE TABLE Compound (
  id int PRIMARY KEY,
  measurement_id int,
  mass float DEFAULT NULL,
  retention_time float DEFAULT NULL,
  area float DEFAULT NULL,
  max_value float DEFAULT NULL
);

CREATE TABLE Spectrum (
  id int PRIMARY KEY,
  compound_id int,
  x int DEFAULT NULL,
  y int DEFAULT NULL,
  z int DEFAULT NULL
);

CREATE TABLE Algorithm_Match (
  id int PRIMARY KEY,
  algorithm text,
  compound_id int,
  cas_rn varchar,
  probability float
);

CREATE TABLE Molecule (
  id int,
  cas_rn varchar,
  name text,
  formula text,
  type_id int,
  PRIMARY KEY (id, cas_rn)
);

CREATE TABLE Molecule_Type (
  id int PRIMARY KEY,
  name text
);

CREATE TABLE Molecule_Bacteria (
  match_id int,
  bacteria_id int,
  retention_time_average float,
  area_average float,
  height_average float,
  rrt1 float,
  rrt2 float,
  rrt3 float,
  rrt4 float
);

CREATE TABLE Bacteria_Set (
  id int PRIMARY KEY,
  bacteria_strain_id int
);

ALTER TABLE Internal_Standards_Set ADD FOREIGN KEY (internal_standard_id) REFERENCES Internal_Standard (id);

ALTER TABLE Internal_Standard ADD FOREIGN KEY (analyzer_id) REFERENCES Analyzer (id);

ALTER TABLE Td_Tube ADD FOREIGN KEY (type_id) REFERENCES Td_Tube_Type (id);

ALTER TABLE Measurement ADD FOREIGN KEY (type_id) REFERENCES Measurement_Type (id);

ALTER TABLE Measurement ADD FOREIGN KEY (era_id) REFERENCES Era (id);

ALTER TABLE Measurement ADD FOREIGN KEY (internal_standards_set_id) REFERENCES Internal_Standards_Set (id);

ALTER TABLE Measurement ADD FOREIGN KEY (analyzer_id) REFERENCES Analyzer (id);

ALTER TABLE Bacteria ADD FOREIGN KEY (family_id) REFERENCES Bacteria_Family (id);

ALTER TABLE Experiment ADD FOREIGN KEY (label) REFERENCES Patient_Culture (experiment_label);

ALTER TABLE Experiment ADD FOREIGN KEY (measurement_1) REFERENCES Invivo_Measurement (id);

ALTER TABLE Experiment ADD FOREIGN KEY (measurement_2) REFERENCES Invivo_Measurement (id);

ALTER TABLE Visit ADD FOREIGN KEY (experiment_id) REFERENCES Experiment (id);

ALTER TABLE Visit_History ADD FOREIGN KEY (rs_id) REFERENCES Patient_Reference (rs_id);

ALTER TABLE Visit_History ADD FOREIGN KEY (visit_id) REFERENCES Visit (id);

ALTER TABLE Invivo_Measurement ADD FOREIGN KEY (measurement_id) REFERENCES Measurement (id);

ALTER TABLE Invivo_Measurement ADD FOREIGN KEY (td_tube_sn) REFERENCES Td_Tube (id);

ALTER TABLE Patient_Reference ADD FOREIGN KEY (patient_id) REFERENCES Patient_EMRData (patient_id);

ALTER TABLE Patient_Reference ADD FOREIGN KEY (institution_id) REFERENCES Institution (id);

ALTER TABLE Diagnosis ADD FOREIGN KEY (experiment_id) REFERENCES Experiment (id);

ALTER TABLE Invitro_Measurement ADD FOREIGN KEY (td_tube_sn) REFERENCES Td_Tube (id);

ALTER TABLE Invitro_Measurement ADD FOREIGN KEY (measurement_id) REFERENCES Measurement (id);

ALTER TABLE Invitro_Measurement ADD FOREIGN KEY (experiment_type) REFERENCES Experiment_Type (id);

ALTER TABLE Invitro_Measurement ADD FOREIGN KEY (bacteria_set) REFERENCES Bacteria_Set (id);

ALTER TABLE Invitro_Measurement ADD FOREIGN KEY (incubator_id) REFERENCES Incubator (id);

ALTER TABLE Invitro_Measurement ADD FOREIGN KEY (medium_id) REFERENCES Medium (id);

ALTER TABLE Patient_Culture ADD FOREIGN KEY (invitro_measurement_id) REFERENCES Invitro_Measurement (id);

ALTER TABLE Patient_Culture ADD FOREIGN KEY (source_id) REFERENCES Patient_Culture_Source (id);

ALTER TABLE Compound ADD FOREIGN KEY (measurement_id) REFERENCES Measurement (id);

ALTER TABLE Spectrum ADD FOREIGN KEY (compound_id) REFERENCES Compound (id);

ALTER TABLE Algorithm_Match ADD FOREIGN KEY (compound_id) REFERENCES Compound (id);

ALTER TABLE Algorithm_Match ADD FOREIGN KEY (cas_rn) REFERENCES Molecule (cas_rn);

ALTER TABLE Molecule ADD FOREIGN KEY (type_id) REFERENCES Molecule_Type (id);

ALTER TABLE Molecule_Bacteria ADD FOREIGN KEY (match_id) REFERENCES Algorithm_Match (id);

ALTER TABLE Molecule_Bacteria ADD FOREIGN KEY (bacteria_id) REFERENCES Bacteria (id);

ALTER TABLE Bacteria_Set ADD FOREIGN KEY (bacteria_strain_id) REFERENCES Bacteria (id);
