#!/usr/bin/env bash

# This script has to be executed inside the oxiqle repository!
# Please change the variables to reflect your setup
DB="./chrSY.hprc-v1.0-pggb.gfa"
QUERY_PREFIX="."

cargo flamegraph --bin oxigraph_server -- query -l $DB --results-file /dev/null --results-format txt --query-file "$QUERY_PREFIX/query_all.sparql"
cargo flamegraph --bin oxigraph_server -- query -l $DB --results-file /dev/null --results-format txt --query-file "$QUERY_PREFIX/query_nodes_high_path_count.sparql"
cargo flamegraph --bin oxigraph_server -- query -l $DB --results-file /dev/null --results-format txt --query-file "$QUERY_PREFIX/query_path_lengths.sparql"
cargo flamegraph --bin oxigraph_server -- query -l $DB --results-file /dev/null --results-format txt --query-file "$QUERY_PREFIX/query_path_lengths_through_node.sparql"
cargo flamegraph --bin oxigraph_server -- query -l $DB --results-file /dev/null --results-format txt --query-file "$QUERY_PREFIX/query_steps_ionodes.sparql"
cargo flamegraph --bin oxigraph_server -- query -l $DB --results-file /dev/null --results-format txt --query-file "$QUERY_PREFIX/query_federated.sparql"
