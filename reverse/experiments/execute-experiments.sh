#!/bin/bash
# ------------------------------------
# MobIotSec - Security Report
# SIMPLIFY-EXPERIMENT
# Mariano Sciacco (UniPD 2021-2022)
# ------------------------------------

# Important: use java 8 to run this script correctly
# Then, you must have simplify.jar in the same folder.
# The apps to test must be inserted inside the apps folder

echo "[Experiment] START"

start=$(date +%s.%N)
for FILE in apps/*
do
    base=$(basename "$FILE")
    start=$(date +%s.%N)
    if [[ $base == ".gitkeep" ]]; then 
        continue
    elif [[ $base == "obfuscated-app.apk" ]]; then 
        et="MainActivity" it="org/cf/obfuscated" 
    elif [[ $base == "rootbeer.apk" ]]; then 
        et="ui" it="com/scottyab/rootbeer/sample" 
    elif [[ $base == "verificac19.apk" ]]; then 
        et="MainActivity" it="*" 
    fi

    echo "[Experiment] executing $FILE"
    java -jar simplify.jar "$FILE" \
        -ie \
        -q \
        --max-address-visits 1000\
        --max-execution-time 10 \
        --max-method-visits 1000 \
        --max-passes 10 \
        -et $et \
        -it $it \
        > records/"$base".txt

    end=$(date +%s)
    runtime=$( echo "$end - $start" | bc -l )
    echo "[Experiment] Current execution time: $runtime s"
done
echo "[Experiment] END"
