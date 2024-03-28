#!/usr/bin/env bash

# hyperfine --runs 3 'java -Xmx12g -jar '"$1"' --gfa chrSY.hprc-v1.0-pggb.gfa "$(cat query/query_all.sparql)"'
hyperfine --runs 3 'java -Xmx12g -jar '"$1"' --gfa chrSY.hprc-v1.0-pggb.gfa "$(cat query/query_nodes_high_path_count.sparql)"'
# hyperfine --runs 3 'java -Xmx12g -jar '"$1"' --gfa chrSY.hprc-v1.0-pggb.gfa "$(cat query/query_path_lengths.sparql)"'
# hyperfine --runs 3 'java -Xmx12g -jar '"$1"' --gfa chrSY.hprc-v1.0-pggb.gfa "$(cat query/query_path_lengths_through_node.sparql)"'
# hyperfine --runs 3 'java -Xmx12g -jar '"$1"' --gfa chrSY.hprc-v1.0-pggb.gfa "$(cat query/query_steps_ionodes.sparql)"'
# hyperfine --runs 3 'java -Xmx12g -jar '"$1"' --gfa chrSY.hprc-v1.0-pggb.gfa "$(cat query/query_federated.sparql)"'

hyperfine --runs 3 'rsh_analog --query nodes_high_path_count chrSY.hprc-v1.0-pggb.gfa'
hyperfine --runs 3 'rsh_analog --query path_lengths chrSY.hprc-v1.0-pggb.gfa'
hyperfine --runs 3 'rsh_analog --query path_lengths_through_node chrSY.hprc-v1.0-pggb.gfa'
hyperfine --runs 3 'rsh_analog --query steps_ionodes chrSY.hprc-v1.0-pggb.gfa'

hyperfine --runs 3 "oxigraph query -l $2 --results-file out.txt --query-file query/query_all.sparql"
hyperfine --runs 3 "oxigraph query -l $2 --results-file out.txt --query-file query/query_nodes_high_path_count.sparql"
hyperfine --runs 3 "oxigraph query -l $2 --results-file out.txt --query-file query/query_path_lengths.sparql"
hyperfine --runs 3 "oxigraph query -l $2 --results-file out.txt --query-file query/query_path_lengths_through_node.sparql"
hyperfine --runs 3 "oxigraph query -l $2 --results-file out.txt --query-file query/query_steps_ionodes.sparql"
hyperfine --runs 3 "oxigraph query -l $2 --results-file out.txt --query-file query/query_federated.sparql"

hyperfine --runs 3 'oxigraph_server query -l chrSY.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_all.sparql'
hyperfine --runs 3 'oxigraph_server query -l chrSY.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_nodes_high_path_count.sparql'
hyperfine --runs 3 'oxigraph_server query -l chrSY.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_path_lengths.sparql'
hyperfine --runs 3 'oxigraph_server query -l chrSY.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_path_lengths_through_node.sparql'
hyperfine --runs 3 'oxigraph_server query -l chrSY.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_steps_ionodes.sparql'
hyperfine --runs 3 'oxigraph_server query -l chrSY.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_federated.sparql'

