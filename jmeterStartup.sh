#!/bin/bash
set -e

#freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
#s=$(($freeMem/10*8))
#x=$(($freeMem/10*8))
#n=$(($freeMem/10*2))
#export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"
export JVM_ARGS="-Xms256m -Xmx256m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
#echo "jmeter args=$@"

$JMETER_HOME/bin/jmeter-server \
    -Dserver.rmi.ssl.disable=true \
    -Dserver.rmi.localport=26000 \
    -Dserver_port=1099 &
