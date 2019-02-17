#!/bin/sh
echo "Type the hour range (e.g. 1-2) you want to check, followed by [ENTER]:"
read range
IFS=- read start end <<< "$range"

../../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../../mapreduce-test-data/access.log /logstat_lab1/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file ../../mapreduce-test-python/logstat_lab1/mapper_p2_alt.py -mapper ../../mapreduce-test-python/logstat_lab1/mapper_p2_alt.py \
-file ../../mapreduce-test-python/logstat_lab1/reducer_p2.py -reducer ../../mapreduce-test-python/logstat_lab1/reducer_p2.py \
-input /logstat_lab1/input/* -output /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -cat /logstat_lab1/output/part-00000
-cmdenv param_h0=$start -cmdenv param_h1=$end
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
../../stop.sh
