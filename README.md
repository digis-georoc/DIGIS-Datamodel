# DIGIS Data Model
The data model of the GEOROC 2.0 database developed within the [DIGIS](http://digis.geo.uni-goettingen.de) project. The model is based upon the Observations Data Model Version 2 (ODM2; [Horsburgh et al., 2016](http://dx.doi.org/10.1016/j.envsoft.2016.01.010)) with minor modifications in line with the PetDB use case ([Hsu et al. 2017](http://dx.doi.org/10.5334/dsj-2017-004)) and the ECDB [EarthChem](https://earthchem.org/) model.

A simplified overview of the schema can be found in GEOROC2.0_v1.0_schema.pdf.

Browse the GEOROC database this data model is designed for on [https://georoc.eu/](https://georoc.eu/). For more information on ODM2 visit [https://www.odm2.org/](https://www.odm2.org/).


## Setup
You can generate a copy of the GEOROC 2.0 data model by running the SQL script located in `/sql_scripts`.
Note that this script is written for a PostgreSQL database - if you want to use a different database management system, you will have to adapt the script to your specific SQL dialect.
