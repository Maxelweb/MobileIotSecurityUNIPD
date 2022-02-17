#!/bin/bash
# ------------------------------------
# MobIotSec - Security Report
# SIMPLIFY-EXPERIMENT
# Mariano Sciacco (UniPD 2021-2022)
# ------------------------------------

# TODO: change and adapt this cose

echo "[Experiment] START"

if [[ $1 != "-s" && $1 != "-d" ]]; then
    echo "[Experiment] You need to specify a flag by calling this file like: -s,-d" 
    exit 1
fi

case $1 in
    -s) NAME="summary";;
    -d) NAME="detail";;
    *) exit 1;;
esac

for FILE in extra/apk-malware-samples/*
do
    if [[ $FILE == "extra/apk-malware-samples/README.md" ]]; then 
        continue
    fi
    echo "[Experiment] executing $FILE"
    quark -a "$FILE" "$1" > experiments/$NAME/"$(basename "$FILE")".txt
done

echo "[Experiment] executing VerificaC19"
quark -a extra/verificac19.apk "$1" > experiments/$NAME/verificac19.apk.txt

echo "[Experiment] END"