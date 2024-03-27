#!/usr/bin/env bash
threads=10
time="$(which time)"

echo "file_name,file_size,odgi_traversal,odgi_time,odgi_memory,packed_traversal,packed_time,packed_memory,hash_traversal,hash_time,hash_memory"
echo "file_name,file_size,odgi_traversal,odgi_time,odgi_memory,packed_traversal,packed_time,packed_memory,hash_traversal,hash_time,hash_memory" >> benchmark.csv

for file in *.gfa; do
    odgi="${file}_odgi.log"
    packed="${file}_packed.log"
    hashed="${file}_hashed.log"
    # vg="${file}_vg.log"
    # gbwt="${file}_gbwt.log"

    $time -v -- odgi performance --threads=$threads -i "$file" 2> $odgi > /dev/null
    todgi="$(grep -E "(Time: )|(Elapsed)|(Maximum resident set size)" $odgi | sed "s/.*: //;s/ms//" | paste -sd "," -)"

    RAYON_NUM_THREADS=$threads $time -v -- step_counter "$file" 2> $packed > /dev/null
    tpacked="$(grep -E "(Time: )|(Elapsed)|(Maximum resident set size)" $packed | sed "s/.*: //;s/ms//" | paste -sd "," -)"

    RAYON_NUM_THREADS=$threads $time -v -- step_counter --hashgraph "$file" 2> $hashed > /dev/null
    thashed="$(grep -E "(Time: )|(Elapsed)|(Maximum resident set size)" $hashed | sed "s/.*: //;s/ms//" | paste -sd "," -)"


    # $time -v -- vg gbwt -p -g "$file.gbz" --gbz-format -G "$file" 2> $vg > /dev/null 
    # conversion="$(grep -E "(Elapsed)|(Maximum resident set size)" $vg | sed "s/.*: //;s/ms//" | paste -sd "," -)"    
    # RAYON_NUM_THREADS=$threads $time -v -- performance "$file.gbz" 2> $gbwt > /dev/null
    # tgbwt="$(grep -E "(Time: )|(Elapsed)|(Maximum resident set size)" $gbwt | sed "s/.*: //;s/ms//" | paste -sd "," -)"

    file_size="$(wc -c "$file" | cut -d " " -f 1)"
    chr_name="$(echo "$file" | sed "s/\..*//")"

    # echo "$chr_name,$file_size,$todgi,$tpacked,$thashed,$conversion,$tgbwt"
    # echo "$chr_name,$file_size,$todgi,$tpacked,$thashed,$conversion,$tgbwt" >> benchmark.csv
    echo "$chr_name,$file_size,$todgi,$tpacked,$thashed"
    echo "$chr_name,$file_size,$todgi,$tpacked,$thashed" >> benchmark.csv
done
