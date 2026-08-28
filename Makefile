USER=$(shell whoami)

##
## Configure the Hadoop classpath for the GCP dataproc environment
##

HADOOP_CLASSPATH=$(shell hadoop classpath)

URLCounter.jar: URLCounter.java
	javac -source 1.8 -target 1.8 -classpath $(HADOOP_CLASSPATH) -d ./ URLCounter.java
	jar cf URLCounter.jar URLCounter*.class
	-rm -f URLCounter*.class

prepare:
	hdfs dfs -mkdir -p input
	curl -sL https://en.wikipedia.org/wiki/Apache_Hadoop > /tmp/input.txt
	hdfs dfs -put -f /tmp/input.txt input/file01
	curl -sL https://en.wikipedia.org/wiki/MapReduce > /tmp/input.txt
	hdfs dfs -put -f /tmp/input.txt input/file02

filesystem:
	-hdfs dfs -mkdir -p /usr/$(USER)

run: URLCounter.jar
	-hdfs dfs -rm -r -f output
	hadoop jar URLCounter.jar URLCounter input output

##
## GCP Dataproc Streaming Jar Path
##
STREAM_JAR = /usr/lib/hadoop-mapreduce/hadoop-streaming.jar

stream:
	-hdfs dfs -rm -r -f stream-output
	hadoop jar $(STREAM_JAR) \
	-mapper Mapper.py \
	-reducer Reducer.py \
	-file Mapper.py -file Reducer.py \
	-input input -output stream-output
