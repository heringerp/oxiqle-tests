#!/usr/bin/env bash

# heaptrack java -Xmx12g -jar $1 --gfa chrS19.hprc-v1.0-pggb.gfa "$(cat query/query_all.sparql)
heaptrack java -Xmx12g -jar $1 --gfa chrS19.hprc-v1.0-pggb.gfa "$(cat query/query_nodes_high_path_count.sparql)"
# heaptrack java -Xmx12g -jar $1 --gfa chrS19.hprc-v1.0-pggb.gfa "$(cat query/query_path_lengths.sparql)"
# heaptrack java -Xmx12g -jar $1 --gfa chrS19.hprc-v1.0-pggb.gfa "$(cat query/query_path_lengths_through_node.sparql)"
# heaptrack java -Xmx12g -jar $1 --gfa chrS19.hprc-v1.0-pggb.gfa "$(cat query/query_steps_ionodes.sparql)"
# heaptrack java -Xmx12g -jar $1 --gfa chrS19.hprc-v1.0-pggb.gfa "$(cat query/query_federated.sparql)"

heaptrack rsh_analog --query nodes_high_path_count chrS19.hprc-v1.0-pggb.gfa
heaptrack rsh_analog --query path_lengths chrS19.hprc-v1.0-pggb.gfa
heaptrack rsh_analog --query path_lengths_through_node chrS19.hprc-v1.0-pggb.gfa
heaptrack rsh_analog --query steps_ionodes chrS19.hprc-v1.0-pggb.gfa

# heaptrack oxigraph query -l $2 --results-file /dev/null --results-format txt --query-file query/query_all.sparql
# heaptrack oxigraph query -l $2 --results-file /dev/null --results-format txt --query-file query/query_nodes_high_path_count.sparql
# heaptrack oxigraph query -l $2 --results-file /dev/null --results-format txt --query-file query/query_path_lengths.sparql
# heaptrack oxigraph query -l $2 --results-file /dev/null --results-format txt --query-file query/query_path_lengths_through_node.sparql
# heaptrack oxigraph query -l $2 --results-file /dev/null --results-format txt --query-file query/query_steps_ionodes.sparql
# heaptrack oxigraph query -l $2 --results-file /dev/null --results-format txt --query-file query/query_federated.sparql

heaptrack oxigraph_server query -l chrS19.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_all.sparql
heaptrack oxigraph_server query -l chrS19.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_nodes_high_path_count.sparql
heaptrack oxigraph_server query -l chrS19.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_path_lengths.sparql
# heaptrack oxigraph_server query -l chrS19.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_path_lengths_through_node.sparql
# heaptrack oxigraph_server query -l chrS19.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_steps_ionodes.sparql
heaptrack oxigraph_server query -l chrS19.hprc-v1.0-pggb.gfa --results-file /dev/null --results-format txt --query-file query/query_federated.sparql

