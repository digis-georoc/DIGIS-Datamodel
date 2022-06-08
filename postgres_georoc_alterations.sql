DROP SEQUENCE IF EXISTS sample_id_seq;
CREATE SEQUENCE sample_id_seq;
ALTER TABLE dbo.g_samples ADD COLUMN id int;
ALTER TABLE dbo.g_locations ADD COLUMN id int;
alter table dbo.g_batches add column id int;
update dbo.g_samples set id = nextval('sample_id_seq');
update dbo.g_locations set id = nextval('sample_id_seq');
update dbo.g_batches set id = nextval('sample_id_seq');

DROP SEQUENCE IF EXISTS result_id_seq;
CREATE SEQUENCE result_id_seq;
ALTER TABLE dbo.g_chemistry ADD COLUMN id int;
ALTER TABLE dbo.g_rockmodes ADD COLUMN id int;
update dbo.g_chemistry set id = nextval('result_id_seq');
alter table dbo.g_chemistry add primary key (id);
update dbo.g_rockmodes set id = nextval('result_id_seq');
alter table dbo.g_rockmodes add primary key (id);


DROP SEQUENCE IF EXISTS action_id_seq;
CREATE SEQUENCE action_id_seq;
ALTER TABLE dbo.g_methods ADD COLUMN id int;
ALTER TABLE dbo.g_expeditions ADD COLUMN id int;
ALTER TABLE dbo.g_rockmode_analyses ADD COLUMN id int;
update dbo.g_methods set id = nextval('action_id_seq');
update dbo.g_expeditions set id = nextval('action_id_seq');
update dbo.g_rockmode_analyses set id = nextval('action_id_seq');

ALTER TABLE dbo.g_standards ADD COLUMN id int;
update dbo.g_standards set id = nextval('result_id_seq');
alter table dbo.g_standards add primary key (id);

ALTER TABLE dbo.g_method_precis ADD COLUMN id int;
update dbo.g_method_precis set id = nextval('result_id_seq');
alter table dbo.g_method_precis add primary key (id);