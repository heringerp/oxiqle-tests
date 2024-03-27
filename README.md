# oxiqle-tests
Repository for all the tests and supplementary code of the OXIQLE project.

## Setup data
To setup the patient data the `rdf_builder.py` script is used. The resulting
RDF file is uploaded in the web interface of Apache Jena Fuseki
(https://jena.apache.org/documentation/fuseki2/) in an in-memory database
called `Patient_FHIR`

For the pangenome graphs a pangenome is dowloaded from
https://s3-us-west-2.amazonaws.com/human-pangenomics/index.html?prefix=pangenomes/freeze/freeze1/pggb/chroms/
(either `chrY.hprc-v1.0-pggb.gfa.gz` or `chr19.hprc-v1.0-pggb.gfa.gz`) and extracted.
The script `pathname_changer.sh` is used to replace all occurences of `#` with
`/` (otherwise OXIQLE will give errors).

### rdf_builder.py
This script is used to generate an RDF file from the Uni Leipzig Kerndatensatzkonforme
FHIR Testdaten. It requires a running HAPI FHIR server
(https://github.com/hapifhir/hapi-fhir-jpaserver-starter?tab=readme-ov-file),
this is best done using the provided Docker container.

Additionally, it needs a file contain all sample names, named `paths.txt` in
the form:
```
HG00621
HG00673
HG01106
HG01109
HG01243
HG01258
HG01358
HG01928
HG01952
HG02055
```

Then it can be run inside the folder containing all the JSON files. For the
OXIQLE project, this was done inside the extracted zip folder of the first
data set (https://github.com/medizininformatik-initiative/kerndatensatz-testdaten/blob/master/Test_Data/POLAR_WP_1.1_v2/POLAR_WP_1.1_v2-POLAR_WP1.1_00001-POLAR_WP1.1_01650.json.zip).
```
python3 rdf_builder.py
```
The resulting RDF file will be written to a file called `out.ttl`.

### pathname_changer.sh
This file can be used to change all the pathnames in a GFA file from using
`#` as the separator to using `/`.
```
./pathname_changer.sh <INPUT_GFA> <OUTPUT_GFA>
```
