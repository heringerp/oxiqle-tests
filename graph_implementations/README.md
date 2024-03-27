# Graph Implementations
This directory contains the code for the benchmark of the different graph
data structure implementations.

To redo the benchmark one needs to do the following steps:

1. Install ODGI and have it available on PATH.
2. Build step_counter and make it available on PATH.
3. Download all chromosomal HPRC PGGB graphs into a directory, extract them.
4. Run the `benchmark_all.sh` script inside this directory. A `benchmark.csv` file will be written.
5. Run the `gen_plots.py` script in the directory containing the `benchmark.csv` file from the previous step.
