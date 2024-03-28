# oxiqle-tests
Repository for all the tests and supplementary code of the OXIQLE project.

Other used repositories:
- ODGI performance: https://github.com/heringerp/odgi/tree/performance_release, https://doi.org/10.5281/zenodo.10888417
- step_counter: https://github.com/heringerp/step_counter, https://zenodo.org/doi/10.5281/zenodo.10888440
- oxigraph-gfa: https://github.com/heringerp/oxigraph-gfa, https://zenodo.org/doi/10.5281/zenodo.10889250
- rsh_analog: https://github.com/heringerp/rsh_analog, https://zenodo.org/doi/10.5281/zenodo.10888608
- oxiqle: https://github.com/heringerp/oxiqle/tree/dev, https://zenodo.org/doi/10.5281/zenodo.10888681


## Setup data
The patient data RDF file is already provided as `patients.ttl`. Alternatively,
it can be built using the `rdf_builder.py` script. The resulting
RDF file should be uploaded in the web interface of Apache Jena Fuseki
(https://jena.apache.org/documentation/fuseki2/) in an in-memory database
called `Patient_FHIR`.

For the pangenome graphs a pangenome is dowloaded from
https://s3-us-west-2.amazonaws.com/human-pangenomics/index.html?prefix=pangenomes/freeze/freeze1/pggb/chroms/
(either `chrY.hprc-v1.0-pggb.gfa.gz` or `chr19.hprc-v1.0-pggb.gfa.gz`) and extracted.
The script `pathname_changer.sh` is used to replace all occurences of `#` with
`/` (otherwise OXIQLE will give errors).

For the pregenerated triples a database per graph is necessary. To generate it
please use the following commands (oxigraph-gfa should be available on the PATH
as `oxigraph`)
```bash
oxigraph load -l db_chrY -f chrY.hprc-v1.0-pggb.gfa
oxigraph load -l db_chr19 -f chr19.hprc-v1.0-pggb.gfa   # Be careful with this, as the resulting databases will be very large
```
Please note that the files are generated using the original pangenomes and not
the ones with replaced slashes. Also note that generating these databases
takes a lot of time and disk space.

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

## Benchmarking

To benchmark note that you need to have all programs compiled and on the PATH,
the data should be in this directory and the Apache Jena Fuseki Server should
be running with the dataset loaded.

Programs needed on path:
- hyperfine (https://github.com/sharkdp/hyperfine)
- heaptrack (https://invent.kde.org/sdk/heaptrack)
- oxigraph (oxigraph-gfa repo)
- rsh_analog (rsh_analog repo)
- oxigraph_server (oxiqle repo) 

The four benchmarking scripts take two arguments: the path of the sapfhir-cli
jar-file and the path of the generated oxigraph database (if this guide was followed
`db_chrY` or `db_chr19` depending on the benchmark).

The four scripts are
```bash
runtime_chry.sh <SAPFHIR_CLI_JAR> <OXIGRAPH_DB>
runtime_chr19.sh <SAPFHIR_CLI_JAR> <OXIGRAPH_DB>
memory_chry.sh <SAPFHIR_CLI_JAR> <OXIGRAPH_DB>
memory_chr19.sh <SAPFHIR_CLI_JAR> <OXIGRAPH_DB>
```

All of them can take quite a while to execute. All commands that ran into errors
or could not be executed are commented out.
