#!/bin/sh
../../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../../mapreduce-test-data/access.log /logstat_lab1/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file ../../mapreduce-test-python/logstat_lab1/mapper.py -mapper ../../mapreduce-test-python/logstat_lab1/mapper.py \
-file ../../mapreduce-test-python/logstat_lab1/reducer.py -reducer ../../mapreduce-test-python/logstat_lab1/reducer.py \
-input /logstat_lab1/input/* -output /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -cat /logstat_lab1/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
../../stop.sh
