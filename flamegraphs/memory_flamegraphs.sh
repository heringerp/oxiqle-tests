# This file takes as its input the heaptrack files generated using the benchmark
# with the `memory_chry.sh` script.
# Please change the variables to reflect your file ids
HT_PATH_LENGTHS_THROUGH_NODE="heaptrack.oxigraph_server.31574.zst"
HT_STEPS_IONODES="heaptrack.oxigraph_server.6638.zst"

heaptrack_print $HT_PATH_LENGTHS_THROUGH_NODE -F stacks-path-lengths-through-node.txt --flamegraph-cost-type "peak"
flamegraph --colors mem < stacks-path-lengths-through-node.txt > fgm-path-lengths-through-node.svg

heaptrack_print $HT_STEPS_IONODES -F stacks-steps-ionodes.txt --flamegraph-cost-type "peak"
flamegraph --colors mem < stacks-steps-ionodes.txt > fgm-steps-ionodes.svg
