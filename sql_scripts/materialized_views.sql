
-- materialized view of measurements
drop materialized view if exists odm2.measuredvalues;
create materialized view odm2.measuredvalues as
select f.samplingfeatureid, f.actionid, 
r.*,
u.unitstypecv , u.unitsabbreviation , u.unitsname , u.unitgeoroc,
v.variabletypecv, v.variablecode , v.variabletypecode , v.variablenamecv,
m.*
from odm2.results r  
left join odm2.featureactions f on f.featureactionid = r.featureactionid 
left join odm2.units u on u.unitsid = r.unitsid 
left join odm2.variables v on v.variableid = r.variableid 
left join odm2.measurementresultvalues m on m.valueid = r.resultid;

CREATE INDEX IF NOT EXISTS measuredvalues_samplingfeatureid_idx ON odm2.measuredvalues (samplingfeatureid);
CREATE INDEX IF NOT EXISTS measuredvalues_variablecode_idx ON odm2.measuredvalues (variablecode,datavalue);
CREATE INDEX IF NOT EXISTS measuredvalues_variablecode1_idx ON odm2.measuredvalues USING btree (variablecode);



-- create materialized view for citation data; intermediate step for samplelistinformationextended
create materialized view odm2.samplecitationdata as
select samples.samplingfeatureid,
citation.*,
cei.citationexternalidentifier as externalIdentifier
from
(
select s.samplingfeatureid
from odm2.samplingfeatures s
where s.samplingfeaturedescription = 'Sample'
) samples
left join odm2.citationsamplingfeatures cs on cs.samplingfeatureid = samples.samplingfeatureid
left join 
(
select c.*,
jsonb_agg(distinct (jsonb_build_object('order', a.authororder , 'lastname', p.personlastname, 'firstname', p.personfirstname))) as authors,
array_agg(distinct p.personfirstname) as personfirstnames,
array_agg(distinct p.personlastname) as personlastnames
from odm2.citations c
left join odm2.authorlists a on a.citationid = c.citationid 
left join odm2.people p on p.personid = a.personid
group by c.citationid, c.title, c.publisher, c.publicationyear, c.citationlink, c.journal, c.volume, c.issue, c.firstpage, c.lastpage, booktitle, c.editors
) citation on citation.citationid = cs.citationid
left join odm2.citationexternalidentifiers cei on cei.citationid = citation.citationid;

CREATE INDEX IF NOT EXISTS samplecitationdata_sampleid_idx ON odm2.samplecitationdata (samplingfeatureid);



-- create materialized view for taxonomic classifiers grouped by sample; intermediate step for samplelistinformationextended
create materialized view odm2.sampletaxonomicclassifiers as
select st.samplingfeatureid,
array_remove(array_agg(distinct st.rockClass), null) as rockClasses,
array_remove(array_agg(distinct st.rockClassID), null) as rockClassIDs,
array_remove(array_agg(distinct (case when st.rockClassID is not null then jsonb_build_object('id', st.rockClassID, 'value', st.rockClass, 'label', st.rockClass) end )), null) as rockClassObj,
array_remove(array_agg(distinct st.rockType), null) as rockTypes,
array_remove(array_agg(distinct st.rockTypeLabel), null) as rockTypeLabels,
array_remove(array_agg(distinct (case when st.rockTypeID is not null then jsonb_build_object('id', st.rockTypeID, 'value', st.rockType, 'label', st.rockTypeLabel) end )), null) as rockTypeObj,
array_remove(array_agg(distinct st.mineral), null) as minerals,
array_remove(array_agg(distinct (case when st.mineralID is not null then jsonb_build_object('id', st.mineralID, 'value', st.mineral, 'label', st.mineralLabel) end )), null) as mineralObj,
array_remove(array_agg(distinct st.hostMineral), null) as hostMinerals,
array_remove(array_agg(distinct (case when st.hostMineralID is not null then jsonb_build_object('id', st.hostMineralID, 'value', st.hostMineral, 'label', st.hostMineralLabel) end )), null) as hostMineralObj,
array_remove(array_agg(distinct st.incMineral), null) as incMinerals,
array_remove(array_agg(distinct (case when st.incMineralID is not null then jsonb_build_object('id', st.incMineralID, 'value', st.incMineral, 'label', st.incMineralLabel) end )), null) as incMineralObj,
array_remove(array_agg(distinct st.mineralLabel), null) as mineralLabels,
array_remove(array_agg(distinct st.hostMineralLabel), null) as hostMineralLabels,
array_remove(array_agg(distinct st.incMineralLabel), null) as incMineralLabels
from 
(
select samples.samplingfeatureid,
case when t.taxonomicclassifiertypecv = 'Lithology' then t.taxonomicclassifiername else null end as rockClass,
case when t.taxonomicclassifiertypecv = 'Lithology' then t.taxonomicclassifierid else null end as rockClassID,
case when t.taxonomicclassifiertypecv = 'Rock' then t.taxonomicclassifiername else null end as rockType,
case when t.taxonomicclassifiertypecv = 'Rock' then t.taxonomicclassifiercommonname else null end as rockTypeLabel,
case when t.taxonomicclassifiertypecv = 'Rock' then t.taxonomicclassifierid else null end as rockTypeID,
case when t.taxonomicclassifiertypecv = 'Mineral' then t.taxonomicclassifiername else null end as mineral,
case when t.taxonomicclassifiertypecv = 'Mineral' then t.taxonomicclassifierid else null end as mineralID,
case when stc.specimentaxonomicclassifiertype = 'host mineral' then t.taxonomicclassifiername else null end as hostMineral,
case when stc.specimentaxonomicclassifiertype = 'host mineral' then t.taxonomicclassifierID else null end as hostMineralID,
case when stc.specimentaxonomicclassifiertype = 'mineral inclusion' then t.taxonomicclassifiername else null end as incMineral,
case when stc.specimentaxonomicclassifiertype = 'mineral inclusion' then t.taxonomicclassifierid else null end as incMineralID,
case when t.taxonomicclassifiertypecv = 'Mineral' then t.taxonomicclassifiercommonname else null end as mineralLabel,
case when stc.specimentaxonomicclassifiertype = 'host mineral' then t.taxonomicclassifiercommonname else null end as hostMineralLabel,
case when stc.specimentaxonomicclassifiertype = 'mineral inclusion' then t.taxonomicclassifiercommonname else null end as incMineralLabel
from
(
    select s.samplingfeatureid
    from odm2.samplingfeatures s
    where s.samplingfeaturedescription = 'Sample'
) samples
left join odm2.relatedfeatures r on r.relatedfeatureid = samples.samplingfeatureid
left join odm2.specimentaxonomicclassifiers stc on stc.samplingfeatureid = samples.samplingfeatureid or stc.samplingfeatureid = r.samplingfeatureid
left join odm2.taxonomicclassifiers t on t.taxonomicclassifierid = stc.taxonomicclassifierid 
) st
group by st.samplingfeatureid
;

CREATE INDEX IF NOT EXISTS sampletaxonomicclassifiers_sampleid_idx ON odm2.sampletaxonomicclassifiers (samplingfeatureid);
CREATE INDEX IF NOT EXISTS sampletaxonomicclassifiers_rc_rt_m_idx ON odm2.sampletaxonomicclassifiers (rockclassids, rocktypes, minerals);



-- create materialized view for sample relation data; intermediate step for samplelistinformationextended
create materialized view odm2.samplerelations as
select samples.samplingfeatureid as sampleID,
samples.samplingfeaturename as samplename,
samples.samplingfeaturedescription,
r.samplingfeatureid as batch,
r.relationshiptypecv,
r2.relatedfeatureid as site,
sites.elevation_m as elevation,
sites.elevationPrecisionComment as elevationComment,
sann.annotationid
from
(
    select *
    from odm2.samplingfeatures s
    where s.samplingfeaturedescription = 'Sample'
) samples
left join odm2.relatedfeatures r on r.relatedfeatureid = samples.samplingfeatureid and r.relationshiptypecv != 'Is identical to'
left join odm2.relatedfeatures r2 on r2.samplingfeatureid = samples.samplingfeatureid and r2.relationshiptypecv != 'Is identical to'
left join odm2.samplingfeatures sites on sites.samplingfeatureid = r2.relatedfeatureid
left join odm2.samplingfeatureannotations sann on sann.samplingfeatureid = samples.samplingfeatureid or sann.samplingfeatureid = r.samplingfeatureid;

CREATE INDEX if not exists samplerelations_sampleid_batch_idx ON odm2.samplerelations USING btree (sampleid, batch);
CREATE index if not exists samplerelations_sampleid_idx ON odm2.samplerelations USING btree (sampleid);
CREATE INDEX if not exists samplerelations_sampleid_site_idx ON odm2.samplerelations USING btree (sampleid, site);



-- materialized view for frontend sample list
create materialized view odm2.samplelistinformationextended as
select sr.sampleID,
(array_agg(distinct sr.sampleName))[1] as sampleName,
(array_agg(distinct sr.batch)) as batches,
(array_agg(distinct sr.site)) as sites,
array_remove(array_agg(distinct (case when mv.variablecode is not null then jsonb_build_object('element',mv.variablecode, 'value', mv.datavalue, 'unit', mv.unitgeoroc) end)), null) as selectedMeasurements,
(array_agg(distinct scd.publicationyear))[1] as publicationYear,
(array_agg(distinct scd.externalidentifier))[1] as doi,
(array_agg(distinct scd.authors))[1] as authors, -- without "distinct": ERROR: array size exceeds the maximum allowed (1073741823) ?
(array_agg(distinct st.rockClasses[1]) filter (where st.rockclasses <> '{}')) as rockClasses,
(array_agg(distinct st.rockClassIDs[1]) filter (where st.rockclassIDs <> '{}')) as rockClassIDs,
(array_agg(distinct st.rockTypes[1]) filter (where st.rocktypes  <> '{}')) as rockTypes,
(array_agg(distinct st.minerallabels[1]) filter (where st.minerals  <> '{}')) as minerals,
(array_agg(distinct st.hostminerallabels[1]) filter (where st.hostminerals  <> '{}')) as hostMinerals,
(array_agg(distinct st.incminerallabels[1]) filter (where st.incminerals  <> '{}')) as inclusionMinerals,
array_remove(array_agg(distinct ann_inc_type.annotationtext), null) as inclusionTypes,
array_remove(array_agg(distinct gs.settingname), null) as geologicalSettings,
array_remove(array_agg(distinct (case when sa.specimengeolageprefix is not null then sa.specimengeolageprefix || '-' || sa.specimengeolage else sa.specimengeolage end)), null) as geologicalAges,
array_remove(array_agg(distinct sa.specimenagemin), null) as geologicalAgesMin,
array_remove(array_agg(distinct sa.specimenagemax), null) as geologicalAgesMax
from
odm2.samplerelations sr
left join odm2.sitegeologicalsettings sgs on sgs.samplingfeatureid = sr.site
left join odm2.geologicalsettings gs on gs.settingid = sgs.settingid
left join odm2.sampletaxonomicclassifiers st on st.samplingfeatureid = sr.sampleID
left join odm2.annotations ann_inc_type on ann_inc_type.annotationid = sr.annotationid and ann_inc_type.annotationcode = 'g_inclusions.inclusion_type'
left join odm2.specimenages sa on sa.samplingfeatureid = sr.sampleID
left join odm2.measuredvalues mv on (mv.samplingfeatureid = sr.sampleID or mv.samplingfeatureid = sr.batch) and (mv.variablecode = 'SIO2' or mv.variablecode = 'MGO')
left join 
(
    select sc.samplingfeatureid,
    (array_agg(distinct sc.publicationyear))[1] as publicationYear,
    (array_agg(distinct sc.externalidentifier))[1] as externalidentifier,
    (array_agg(distinct sc.authors))[1] as authors
    from odm2.samplecitationdata sc
    group by sc.samplingfeatureid
) scd on scd.samplingfeatureid = sr.sampleID
group by sr.sampleID;

CREATE INDEX IF NOT EXISTS samplelistinformationextended_sampleid_idx ON odm2.samplelistinformationextended (sampleid);