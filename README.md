# DIGIS Data Model
The data model of the GEOROC 2.0 database, developed within the [DIGIS](http://digis.geo.uni-goettingen.de) project. A simplified overview of the schema can be found in GEOROC2.0_schema.pdf.

The model is based on the Observations Data Model Version 2 (ODM2; [Horsburgh et al., 2016](http://dx.doi.org/10.1016/j.envsoft.2016.01.010)) with minor modifications in accordance with the PetDB use case ([Hsu et al. 2017](http://dx.doi.org/10.5334/dsj-2017-004)) and the [EarthChem](https://earthchem.org/) ECDB model. For more information on ODM2 visit [https://www.odm2.org/](https://www.odm2.org/).


## The GEOROC Database
The GEOROC Database (Geochemistry of Rocks of the Oceans and Continents) is a comprehensive collection of published analyses of igneous and metamorphic rocks and minerals. It contains major and trace element concentrations, radiogenic and nonradiogenic isotope ratios as well as analytical ages for whole rocks, glasses, minerals and inclusions. Metadata include geospatial and other sample information, analytical details and references.

The GEOROC Database was established at the Max Planck Institute for Chemistry in Mainz (Germany). In 2021, the database was moved to Göttingen University, where it continues to be curated as part of the [DIGIS](http://digis.geo.uni-goettingen.de) project of the Department of Geochemistry and Isotope Geology at the Geoscience Centre (GZG) and the University and State Library (SUB). Development for GEOROC 2.0 includes a new data model for greater interoperability, options to contribute data, and improved access to the database.

For more information, and to access the data, visit the GEOROC website: [https://georoc.eu/](https://georoc.eu/).


## Model Setup
You can generate a copy of the GEOROC 2.0 data model by running the SQL script located in `/sql_scripts`.
Note that this script is written for a PostgreSQL database - if you want to use a different database management system, you will have to adapt the script to your specific SQL dialect.

This repository contains the new data model only. Visit [https://georoc.eu/](https://georoc.eu/) for access to the data held within the GEOROC database.


## Future Goals
We are working on an API, based upon this data model, to allow native access to the GEOROC data holdings and to facilitate seamless data exchange with our partners at EarthChem as well as other geochemical data systems.

For any questions or if you would like to get involved, get in touch via email: digis-info@uni-goettingen.de
