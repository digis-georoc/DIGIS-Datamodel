-- INDEXES
-- relatedfeatures
CREATE INDEX IF NOT EXISTS relatedfeatures_samplingfeatureid_idx ON odm2.relatedfeatures (samplingfeatureid);
CREATE INDEX IF NOT EXISTS relatedfeatures_relatedfeatureid_idx ON odm2.relatedfeatures (relatedfeatureid);

-- results
CREATE INDEX IF NOT EXISTS results_featureactionid_idx ON odm2.results (featureactionid);

-- featureactions
CREATE INDEX IF NOT EXISTS featureactions_samplingfeatureid_idx ON odm2.featureactions (samplingfeatureid);
CREATE INDEX IF NOT EXISTS featureactions_actionid_idx ON odm2.featureactions (actionid);

-- citationexternalidentifiers
CREATE INDEX IF NOT EXISTS citationexternalidentifiers_citationid_idx ON odm2.citationexternalidentifiers (citationid);
CREATE INDEX IF NOT EXISTS citationexternalidentifiers_externalidentifiersystemid_idx ON odm2.citationexternalidentifiers (externalidentifiersystemid);

-- citationsamplingfeatures
CREATE INDEX IF NOT EXISTS citationsamplingfeatures_samplingfeatureid_idx ON odm2.citationsamplingfeatures USING btree (samplingfeatureid);

-- authorlists
CREATE INDEX IF NOT EXISTS authorlists_citationid_idx ON odm2.authorlists (citationid);

-- specimentaxonomicclassifers
CREATE INDEX IF NOT EXISTS specimentaxonomicclassifiers_samplingfeatureid_idx ON odm2.specimentaxonomicclassifiers (samplingfeatureid);
CREATE INDEX IF NOT EXISTS specimentaxonomicclassifiers_taxonomicclassifierid_idx ON odm2.specimentaxonomicclassifiers (taxonomicclassifierid);

-- taxonomicclassifiers
CREATE INDEX IF NOT EXISTS taxonomicclassifiers_taxonomicclassifiername_idx ON odm2.taxonomicclassifiers (taxonomicclassifiername);
CREATE INDEX IF NOT EXISTS taxonomicclassifiers_taxonomicclassifierid_idx ON odm2.taxonomicclassifiers USING btree (taxonomicclassifierid, taxonomicclassifiertypecv);

-- samplingfeatureannotations
CREATE INDEX IF NOT EXISTS samplingfeatureannotations_samplingfeatureid_idx ON odm2.samplingfeatureannotations (samplingfeatureid);

-- annotations
CREATE INDEX IF NOT EXISTS annotations_annotationid_idx ON odm2.annotations (annotationid,annotationcode);
CREATE INDEX IF NOT EXISTS annotations_annotationcode_idx ON odm2.annotations USING btree (annotationcode);

-- samplingfeatureannotations
CREATE INDEX IF NOT EXISTS samplingfeatureannotations_annotationid_idx ON odm2.samplingfeatureannotations (annotationid);

-- specimen
CREATE INDEX IF NOT EXISTS specimens_samplingfeatureid_idx ON odm2.specimens (samplingfeatureid,specimentexture);

-- datasetresults
CREATE INDEX IF NOT EXISTS datasetsresults_datasetid_idx ON odm2.datasetsresults (datasetid); -- remove?
CREATE INDEX IF NOT EXISTS datasetsresults_resultid_idx ON odm2.datasetsresults (resultid); -- remove?

-- datasetcitations
CREATE INDEX IF NOT EXISTS datasetcitations_datasetid_idx ON odm2.datasetcitations (datasetid); --remove?
CREATE INDEX IF NOT EXISTS datasetcitations_citationid_idx ON odm2.datasetcitations (citationid); -- remove?

-- sitegeologicalsettings
CREATE INDEX sitegeologicalsettings_samplingfeatureid_idx ON odm2.sitegeologicalsettings USING btree (samplingfeatureid);

-- citationsamplingfeatures
CREATE INDEX IF NOT EXISTS citationsamplingfeatures_citationid_idx ON odm2.citationsamplingfeatures (citationid);
CREATE INDEX IF NOT EXISTS citationsamplingfeatures_samplingfeatureid_idx ON odm2.citationsamplingfeatures USING btree (samplingfeatureid);

-- sitegeometries
-- add spatial index
create index if not exists sitegeometries_geometries_idx on odm2.sitegeometries using GIST (geometry);
create index if not exists sitegeometries_samplingfeatureid_idx on odm2.sitegeometries (samplingfeatureid);