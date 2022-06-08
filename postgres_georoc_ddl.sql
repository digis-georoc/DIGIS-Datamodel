drop schema if exists dbo cascade;

CREATE SCHEMA dbo;
-- dbo.g_analyses definition

-- Drop table

-- DROP TABLE dbo.g_analyses;

CREATE TABLE dbo.g_analyses (
	analyses_num int4 NOT NULL,
	batch_num int4 NOT NULL,
	data_quality_num int4 NULL,
	num_analyses int2 NULL,
	calc_average text NULL,
	CONSTRAINT idx_24852_pk_g_analyses PRIMARY KEY (analyses_num)
);
CREATE INDEX idx_24852_ix_bat ON dbo.g_analyses USING btree (batch_num, analyses_num);


-- dbo.g_author_list definition

-- Drop table

-- DROP TABLE dbo.g_author_list;

CREATE TABLE dbo.g_author_list (
	ref_num int4 NOT NULL,
	author_num int4 NOT NULL,
	author_order int2 NOT NULL
);
CREATE INDEX idx_24858_ix_aut ON dbo.g_author_list USING btree (author_num, ref_num);
CREATE INDEX idx_24858_ix_ref ON dbo.g_author_list USING btree (ref_num);


-- dbo.g_batches definition

-- Drop table

-- DROP TABLE dbo.g_batches;

CREATE TABLE dbo.g_batches (
	batch_num int4 NOT NULL,
	sample_num int4 NOT NULL,
	material text NOT NULL,
	ref_num int4 NOT NULL,
	CONSTRAINT idx_24861_pk_g_batches PRIMARY KEY (batch_num)
);
CREATE INDEX idx_24861_ix_mat ON dbo.g_batches USING btree (material, batch_num);
CREATE INDEX idx_24861_ix_ref ON dbo.g_batches USING btree (ref_num, batch_num);
CREATE INDEX idx_24861_ix_sam ON dbo.g_batches USING btree (sample_num, batch_num);


-- dbo.g_chemistry definition

-- Drop table

-- DROP TABLE dbo.g_chemistry;

CREATE TABLE dbo.g_chemistry (
	analyses_num int4 NOT NULL,
	item_measured text NOT NULL,
	item_type text NULL,
	value_meas float8 NOT NULL,
	stdev float8 NULL,
	stdev_type text NULL,
	unit text NULL,
	table_in_ref text NULL
);
CREATE INDEX idx_24867_ix_ana ON dbo.g_chemistry USING btree (analyses_num);
CREATE INDEX idx_24867_ix_item ON dbo.g_chemistry USING btree (item_measured, analyses_num);


-- dbo.g_expeditions definition

-- Drop table

-- DROP TABLE dbo.g_expeditions;

CREATE TABLE dbo.g_expeditions (
	expedition_num int4 NOT NULL,
	expedition_name text NULL,
	leg int2 NULL,
	ship text NULL,
	exp_year_from int2 NULL,
	exp_year_to int2 NULL,
	chief_scientist_num int4 NULL,
	institution_num int4 NULL,
	CONSTRAINT idx_24873_pk_g_expeditions PRIMARY KEY (expedition_num)
);


-- dbo.g_fract_correct definition

-- Drop table

-- DROP TABLE dbo.g_fract_correct;

CREATE TABLE dbo.g_fract_correct (
	fract_correct_num int4 NOT NULL,
	fcorr_item text NULL,
	fcorr_value float8 NULL,
	fcorr_standard_name text NULL,
	ref_num int4 NULL,
	CONSTRAINT idx_24879_pk_g_fract_correct PRIMARY KEY (fract_correct_num)
);


-- dbo.g_fract_correct_list definition

-- Drop table

-- DROP TABLE dbo.g_fract_correct_list;

CREATE TABLE dbo.g_fract_correct_list (
	fract_correct_num int4 NULL,
	data_quality_num int4 NULL
);
CREATE INDEX idx_24885_ix_fra ON dbo.g_fract_correct_list USING btree (fract_correct_num);


-- dbo.g_geograph_loc definition

-- Drop table

-- DROP TABLE dbo.g_geograph_loc;

CREATE TABLE dbo.g_geograph_loc (
	location_num int4 NOT NULL,
	location_type text NOT NULL,
	location_name text NOT NULL,
	hierarchyid int2 NULL
);
CREATE INDEX idx_24888_ix_hi ON dbo.g_geograph_loc USING btree (hierarchyid, location_num);
CREATE INDEX idx_24888_ix_loc ON dbo.g_geograph_loc USING btree (location_num);
CREATE INDEX idx_24888_ix_name ON dbo.g_geograph_loc USING btree (location_name, location_num);


-- dbo.g_germ definition

-- Drop table

-- DROP TABLE dbo.g_germ;

CREATE TABLE dbo.g_germ (
	ref_num int4 NOT NULL,
	reservoir text NOT NULL,
	item text NOT NULL,
	item_type_germ text NULL,
	res_value float8 NOT NULL,
	unit text NULL
);
CREATE INDEX idx_24894_ix_item ON dbo.g_germ USING btree (item);
CREATE INDEX idx_24894_ix_ref ON dbo.g_germ USING btree (ref_num);


-- dbo.g_inclusions definition

-- Drop table

-- DROP TABLE dbo.g_inclusions;

CREATE TABLE dbo.g_inclusions (
	batch_num int4 NOT NULL,
	spot_id text NULL,
	inclusion_type text NOT NULL,
	host_mineral text NULL,
	mineral text NULL,
	heating bool NULL,
	heating_temperature text NULL,
	rim_or_core_inc text NULL,
	inclusion_size text NULL
);
CREATE UNIQUE INDEX idx_24900_ix_bat ON dbo.g_inclusions USING btree (batch_num);
CREATE INDEX idx_24900_ix_host ON dbo.g_inclusions USING btree (host_mineral, batch_num);
CREATE INDEX idx_24900_ix_min ON dbo.g_inclusions USING btree (mineral, batch_num);
CREATE INDEX idx_24900_ix_typ ON dbo.g_inclusions USING btree (inclusion_type, batch_num);


-- dbo.g_institutions definition

-- Drop table

-- DROP TABLE dbo.g_institutions;

CREATE TABLE dbo.g_institutions (
	institution_num int4 NOT NULL,
	department text NULL,
	institution text NULL,
	address_part1 text NULL,
	address_part2 text NULL,
	city_state_zip text NULL,
	country text NULL,
	CONSTRAINT idx_24906_pk_g_institutions PRIMARY KEY (institution_num)
);


-- dbo.g_locations definition

-- Drop table

-- DROP TABLE dbo.g_locations;

CREATE TABLE dbo.g_locations (
	location_num int4 NOT NULL,
	location_comment text NULL,
	crustal_age float8 NULL,
	latitude_min float8 NULL,
	longitude_min float8 NULL,
	elevation_min float4 NULL,
	elevation_max float4 NULL,
	latitude_max float8 NULL,
	longitude_max float8 NULL,
	tectonic_setting text NOT NULL,
	land_or_sea text NULL,
	CONSTRAINT idx_24912_pk_g_locations PRIMARY KEY (location_num)
);
CREATE INDEX idx_24912_ix_lat ON dbo.g_locations USING btree (latitude_min, location_num);
CREATE INDEX idx_24912_ix_lng ON dbo.g_locations USING btree (longitude_min, location_num);
CREATE INDEX idx_24912_ix_tect ON dbo.g_locations USING btree (tectonic_setting, location_num);


-- dbo.g_method_precis definition

-- Drop table

-- DROP TABLE dbo.g_method_precis;

CREATE TABLE dbo.g_method_precis (
	data_quality_num int4 NULL,
	item_measured text NULL,
	precision_type text NULL,
	precision_min float8 NULL,
	precision_max float8 NULL
);
CREATE INDEX idx_24918_ix_dat ON dbo.g_method_precis USING btree (data_quality_num);


-- dbo.g_methods definition

-- Drop table

-- DROP TABLE dbo.g_methods;

CREATE TABLE dbo.g_methods (
	data_quality_num int4 NOT NULL,
	methods_acronyms text NOT NULL,
	method_loc int4 NULL,
	method_comment text NULL,
	ref_num int4 NULL,
	CONSTRAINT idx_24924_pk_g_methods PRIMARY KEY (data_quality_num)
);


-- dbo.g_minerals definition

-- Drop table

-- DROP TABLE dbo.g_minerals;

CREATE TABLE dbo.g_minerals (
	batch_num int4 NOT NULL,
	spot_id text NULL,
	mineral text NOT NULL,
	crystal text NULL,
	rim_or_core_min text NULL,
	mineral_size text NULL,
	prim_or_sec text NULL
);
CREATE UNIQUE INDEX idx_24930_ix_bat ON dbo.g_minerals USING btree (batch_num);
CREATE INDEX idx_24930_ix_min ON dbo.g_minerals USING btree (mineral, batch_num);


-- dbo.g_normalization definition

-- Drop table

-- DROP TABLE dbo.g_normalization;

CREATE TABLE dbo.g_normalization (
	normalization_num int4 NOT NULL,
	norm_item text NULL,
	norm_value float8 NULL,
	norm_standard_name text NULL,
	ref_num int4 NULL,
	CONSTRAINT idx_24936_pk_g_normalization PRIMARY KEY (normalization_num)
);


-- dbo.g_normalization_list definition

-- Drop table

-- DROP TABLE dbo.g_normalization_list;

CREATE TABLE dbo.g_normalization_list (
	normalization_num int4 NULL,
	data_quality_num int4 NULL
);
CREATE INDEX idx_24942_ix_dat ON dbo.g_normalization_list USING btree (data_quality_num);
CREATE INDEX idx_24942_ix_nor ON dbo.g_normalization_list USING btree (normalization_num);


-- dbo.g_persons definition

-- Drop table

-- DROP TABLE dbo.g_persons;

CREATE TABLE dbo.g_persons (
	person_num int4 NOT NULL,
	last_name text NOT NULL,
	first_name text NULL,
	institution_num int4 NULL,
	phone text NULL,
	e_mail text NULL,
	CONSTRAINT idx_24945_pk_g_persons PRIMARY KEY (person_num)
);


-- dbo.g_reference definition

-- Drop table

-- DROP TABLE dbo.g_reference;

CREATE TABLE dbo.g_reference (
	ref_num int4 NOT NULL,
	title text NULL,
	journal_abbreviation text NULL,
	volume_num text NULL,
	issue_num text NULL,
	first_page text NULL,
	last_page text NULL,
	pub_year text NULL,
	book_title text NULL,
	book_editors text NULL,
	publisher text NULL,
	georem_id int4 NULL,
	doi text NULL,
	CONSTRAINT idx_24951_pk_g_reference PRIMARY KEY (ref_num)
);
CREATE INDEX idx_24951_ix_pub ON dbo.g_reference USING btree (pub_year, ref_num);


-- dbo.g_rockmode_analyses definition

-- Drop table

-- DROP TABLE dbo.g_rockmode_analyses;

CREATE TABLE dbo.g_rockmode_analyses (
	rock_mode_num int4 NOT NULL,
	sample_num int4 NOT NULL,
	ref_num int4 NULL,
	n_count_min int2 NULL,
	n_count_max int2 NULL,
	CONSTRAINT idx_24957_pk_g_rockmode_analyses PRIMARY KEY (rock_mode_num)
);
CREATE INDEX idx_24957_ix_sam ON dbo.g_rockmode_analyses USING btree (sample_num, rock_mode_num);


-- dbo.g_rockmodes definition

-- Drop table

-- DROP TABLE dbo.g_rockmodes;

CREATE TABLE dbo.g_rockmodes (
	rock_mode_num int4 NULL,
	mineral text NULL,
	volume float8 NULL,
	min_texture text NULL
);
CREATE INDEX idx_24960_ix_min ON dbo.g_rockmodes USING btree (mineral, rock_mode_num);
CREATE INDEX idx_24960_ix_mod ON dbo.g_rockmodes USING btree (volume, rock_mode_num);
CREATE INDEX idx_24960_ix_rock ON dbo.g_rockmodes USING btree (rock_mode_num);


-- dbo.g_sample_ages definition

-- Drop table

-- DROP TABLE dbo.g_sample_ages;

CREATE TABLE dbo.g_sample_ages (
	sample_num int4 NOT NULL,
	age_min float8 NULL,
	age_max float8 NULL,
	geol_age text NULL,
	geol_age_prefix text NULL,
	eruption_day int2 NULL,
	eruption_month int2 NULL,
	eruption_year int2 NULL
);
CREATE UNIQUE INDEX idx_24966_ix_sam ON dbo.g_sample_ages USING btree (sample_num);


-- dbo.g_samples definition

-- Drop table

-- DROP TABLE dbo.g_samples;

CREATE TABLE dbo.g_samples (
	sample_num int4 NOT NULL,
	unique_id text NULL,
	sample_id text NOT NULL,
	location_num int4 NOT NULL,
	rock_type text NOT NULL,
	rock_class text NOT NULL,
	sample_comment text NULL,
	rock_texture text NULL,
	alteration text NULL,
	alteration_type text NULL,
	drill_depth_min float4 NULL,
	drill_depth_max float4 NULL,
	samp_technique text NULL,
	expedition_num int4 NULL,
	CONSTRAINT idx_24972_pk_g_samples PRIMARY KEY (sample_num)
);
CREATE INDEX idx_24972_ix_cls ON dbo.g_samples USING btree (rock_class, sample_num);
CREATE INDEX idx_24972_ix_drl ON dbo.g_samples USING btree (drill_depth_min, sample_num);
CREATE INDEX idx_24972_ix_exp ON dbo.g_samples USING btree (expedition_num, sample_num);
CREATE INDEX idx_24972_ix_id ON dbo.g_samples USING btree (sample_id, sample_num);
CREATE INDEX idx_24972_ix_loc ON dbo.g_samples USING btree (location_num, sample_num);
CREATE INDEX idx_24972_ix_typ ON dbo.g_samples USING btree (rock_type, sample_num);


-- dbo.g_standards definition

-- Drop table

-- DROP TABLE dbo.g_standards;

CREATE TABLE dbo.g_standards (
	data_quality_num int4 NULL,
	item_measured text NULL,
	standard_name text NULL,
	standard_value float8 NULL,
	stdev float8 NULL,
	stdev_type text NULL,
	unit text NULL
);
CREATE INDEX idx_24978_ix_dat ON dbo.g_standards USING btree (data_quality_num);


-- dbo.s_mineral_acronyms definition

-- Drop table

-- DROP TABLE dbo.s_mineral_acronyms;

CREATE TABLE dbo.s_mineral_acronyms (
	mineral_acronym text NOT NULL,
	mineral text NOT NULL,
	CONSTRAINT idx_24984_pk_s_mineral_acronyms PRIMARY KEY (mineral_acronym)
);


-- dbo.tbl_loc_hierarchy definition

-- Drop table

-- DROP TABLE dbo.tbl_loc_hierarchy;

CREATE TABLE dbo.tbl_loc_hierarchy (
	tectonic_setting text NULL,
	location_type text NULL,
	hierarchyid int2 NULL
);


-- dbo.tblchemcomp definition

-- Drop table

-- DROP TABLE dbo.tblchemcomp;

CREATE TABLE dbo.tblchemcomp (
	unique_id text NOT NULL DEFAULT '_'::text,
	batch_num int4 NOT NULL,
	item_measured text NOT NULL,
	value_meas float8 NOT NULL,
	unit text NULL,
	item_type text NOT NULL,
	methods_acronyms text NULL,
	pub_year text NULL,
	mineral text NULL,
	priority int2 NULL
);
CREATE INDEX idx_24996_ix_ana ON dbo.tblchemcomp USING btree (unique_id, item_measured, unit);
CREATE INDEX idx_24996_ix_bat ON dbo.tblchemcomp USING btree (batch_num);


-- dbo.tblchemlimit definition

-- Drop table

-- DROP TABLE dbo.tblchemlimit;

CREATE TABLE dbo.tblchemlimit (
	item_measured text NOT NULL,
	value_meas float8 NOT NULL,
	sample_num int4 NOT NULL,
	unit text NULL
);
CREATE INDEX idx_25003_ix_item ON dbo.tblchemlimit USING btree (item_measured, sample_num);
CREATE INDEX idx_25003_ix_sam ON dbo.tblchemlimit USING btree (sample_num);
CREATE INDEX idx_25003_ix_val ON dbo.tblchemlimit USING btree (value_meas, sample_num);


-- dbo.tblgermcit definition

-- Drop table

-- DROP TABLE dbo.tblgermcit;

CREATE TABLE dbo.tblgermcit (
	ref_num int4 NOT NULL,
	citation text NOT NULL
);
CREATE INDEX idx_25009_ix_ref ON dbo.tblgermcit USING btree (ref_num);


-- dbo.tblloccont definition

-- Drop table

-- DROP TABLE dbo.tblloccont;

CREATE TABLE dbo.tblloccont (
	location_num int4 NOT NULL,
	"location" text NOT NULL,
	CONSTRAINT idx_25015_pk_tblloccont PRIMARY KEY (location_num)
);


-- dbo.tblloclist definition

-- Drop table

-- DROP TABLE dbo.tblloclist;

CREATE TABLE dbo.tblloclist (
	location_name text NOT NULL,
	CONSTRAINT idx_25021_pk_tblloclist PRIMARY KEY (location_name)
);


-- dbo.tbltascont definition

-- Drop table

-- DROP TABLE dbo.tbltascont;

CREATE TABLE dbo.tbltascont (
	sample_num int4 NOT NULL,
	sio2 float8 NULL,
	k2o float8 NULL,
	na2o float8 NULL,
	tas float8 NULL,
	rock_spec text NULL,
	CONSTRAINT idx_25027_pk_tbltascont PRIMARY KEY (sample_num)
);


-- dbo.tbltectlist definition

-- Drop table

-- DROP TABLE dbo.tbltectlist;

CREATE TABLE dbo.tbltectlist (
	location_name text NOT NULL,
	tectonic_setting text NOT NULL
);
CREATE UNIQUE INDEX idx_25033_ix_tect ON dbo.tbltectlist USING btree (location_name, tectonic_setting);

