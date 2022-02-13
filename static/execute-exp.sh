# MobIotSec - Security Report
# Mariano Sciacco 

for FILE in extra/apk-malware-samples/*
do
    if [[ $FILE == "extra/apk-malware-samples/README.md" ]]; then 
        continue
    fi
    echo "[Experiment] executing $FILE"
    quark -a $FILE -s > experiments/summary/$(basename $FILE).txt
done