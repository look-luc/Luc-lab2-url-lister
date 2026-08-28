USER=$(shell whoami)

##
## Configure the Hadoop classpath for the GCP dataproc environment
##
HADOOP_CLASSPATH=$(shell hadoop classpath)

# Parameterized Java version (defaults to 11, common on Dataproc)
JAVAC_VERSION ?= 11

URLCounter.jar: URLCounter.java
	javac -source $(JAVAC_VERSION) -target $(JAVAC_VERSION) -classpath $(HADOOP_CLASSPATH) -d ./ URLCounter.java
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
## GCP Dataproc Streaming Jar Path (Dynamic Resolution)
##
STREAM_JAR = $(shell find /usr/lib/hadoop-mapreduce -name 'hadoop-streaming*.jar' | head -n 1)

stream:
	-hdfs dfs -rm -r -f stream-output
	hadoop jar $(STREAM_JAR) \
	-mapper Mapper.py \
	-reducer Reducer.py \
	-file Mapper.py -file Reducer.py \
	-input input -output stream-output
