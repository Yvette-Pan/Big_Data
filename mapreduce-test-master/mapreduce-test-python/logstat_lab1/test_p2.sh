#!/bin/bash
echo "Type the hour range (e.g. 1-2) you want to check, followed by [ENTER]:"
read range
IFS=- read start end <<< "$range"
h0=$start;h1=$((end+1))

../../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../../mapreduce-test-data/access.log /logstat_lab1/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file ../../mapreduce-test-python/logstat_lab1/mapper_p2.py -mapper ../../mapreduce-test-python/logstat_lab1/mapper_p2.py \
-file ../../mapreduce-test-python/logstat_lab1/reducer_p2.py -reducer ../../mapreduce-test-python/logstat_lab1/reducer_p2.py \
-input /logstat_lab1/input/* -output /logstat_lab1/output/ \
-cmdenv param_h0=$h0 -cmdenv param_h1=$h1
/usr/local/hadoop/bin/hdfs dfs -cat /logstat_lab1/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
../../stop.sh



