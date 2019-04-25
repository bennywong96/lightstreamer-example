#!/bin/sh
# Do not remove this line. File tag: linux_launch-APV-20181003.

# =======================================================================
# === CHECK THIS OUT
# =======================================================================
# JAVA_HOME must point to your Java Development Kit installation
JAVA_HOME="/usr/jdk1.8.0"

# =======================================================================
# === CHECK THIS OUT
# =======================================================================
# JAVA_OPTS should contain any Java Virtual Machine options. Here are some tips:
# 1) Always use the "-server" option, when available.
# 2) Give more RAM to the server process, especially with heavy traffic, by specifying a min and max "heap"
#    E.g.: If you have 4 GB and the box is dedicated to Lightstreamer, you might set 1 GB min heap and 3 GB max
#    heap with these options: "-Xms1G -Xmx3G"
# 3) Choose a better "garbage collector" if you want to reduce latency. This should not be needed since Java 9,
#    but if you are using Java 8 or Java 7 (apart from early versions) we suggest you enforcing:
#    "-XX:+UseG1GC". For previous versions, an option that often gives good results is:
#    "-XX:+UseConcMarkSweepGC". Many other tuning options are available (please see Oracle docs).
# 4) Configure the garbage collector in such a way as to prevent long pauses. Choose the maximum pause based
#    on your latency and throughput requirements, but consider anyway that GC pauses cause the connection
#    to stay idle and pauses longer than 4 or 5 seconds may cause the clients to timeout and reconnect.
JAVA_OPTS="-server -XX:MaxGCPauseMillis=1000"

# Options needed by third party libraries:
JAVA_OPTS="$JAVA_OPTS -Dcom.sun.xml.bind.v2.bytecode.ClassTailor.noOptimize"

echo "Java environment:"
echo "JAVA_HOME = \"${JAVA_HOME}\""
echo "JAVA_OPTS = \"${JAVA_OPTS}\""
echo

# =======================================================================
# === CHECK THIS OUT
# =======================================================================
# In order to serve many concurrent user connections,
# the limits on the available file descriptors should be released;
# these limits also apply to the open sockets.
# NOTE: By default, the script takes the current 'hard limit' granted to the shell process as the limit
# that can be made available to the Server.
# If, for any reason, the limit granted to the shell process in the execution environment is lower
# than the limit that is available to the involved user, the preferred limit (possibly including
# 'unlimited') can be specified by just changing the setting below. Note that if the limit supplied
# is higher than the limit granted to the user, the request may be just refused.
LS_FILELIMIT=""

if [ "${LS_FILELIMIT}" != "" ]; then
    echo Changing file descriptor hard limit to $LS_FILELIMIT
    ulimit -Hn $LS_FILELIMIT
    FD_HARD_SET=$?
    FD_HARD_LIMIT=`ulimit -Hn`
    if [ $FD_HARD_SET -ne 0 ]; then
        echo "Warning: could not enlarge maximum file descriptor limit"
        echo "ensure that the current limit is suitable: " $FD_HARD_LIMIT
    fi
else
    FD_HARD_LIMIT=`ulimit -Hn`
fi

echo Setting file descriptor limit to $FD_HARD_LIMIT

ulimit -Sn $FD_HARD_LIMIT
FD_SOFT_SET=$?
FD_SOFT_LIMIT=`ulimit -Sn`
if [ $FD_SOFT_SET -ne 0 ]; then
    echo "Warning: could not enlarge current file descriptor limit"
    echo "ensure that the current limit is suitable: " $FD_SOFT_LIMIT
fi

# Dump current ulimit and sysctl values
echo "Configured file descriptors, soft limit: $(ulimit -Sn)"
echo "Configured file descriptors, hard limit: $(ulimit -Hn)"
fs_file=$(/sbin/sysctl -a 2> /dev/null | grep ^fs.file)
if [ -n "${fs_file}" ]; then
	echo "Configured sysctl fs.file.* values:"
	echo "${fs_file}"
fi
echo

# ---------------------------------------------------------------------------

# up two dirs there is LS_HOME
_LS_HOME=$(dirname "${0}")
if [ "${_LS_HOME}" = "." ]; then
    # in the same dir
    _LS_HOME=$(dirname "${PWD}")
elif [ -z "$(echo ${_LS_HOME} | grep "^/" 2> /dev/null)" ]; then
    # relative dir to target
    _LS_HOME="${PWD}"
else
    # absolute path
    _LS_HOME=$(dirname "${_LS_HOME}")
fi
LS_HOME=$(dirname "${_LS_HOME}")

echo "Lightstreamer Server directory:"
echo "LS_HOME = \"${LS_HOME}\""
echo

# Main configuration file: the default can be changed by the caller
# by setting the optional LS_CONFIG variable to an absolute path
LS_CONFIG="${LS_CONFIG:-${LS_HOME}/conf/lightstreamer_conf.xml}"

echo "Lightstreamer Server main configuration file:"
echo "LS_CONFIG = \"${LS_CONFIG}\""
echo

# Inherited from environment, write current PID to
# given file path (declared as WRITE_PID).
# This is useful for init scripts unable to figure
# out the pid by themselves (OpenBSD) and only
# works when Lightstreamer starts.
WRITE_PID="${WRITE_PID:-}"

# Base Classpaths
bootpath="$LS_HOME/lib/ls-bootstrap.jar"
kernelpath="$LS_HOME/lib/lightstreamer.jar"

# Variables for library paths
KERNEL_LIB_PATH=""
INTERNAL_LIB_PATH=""
LOGGING_LIB_PATH=""
DATABASE_LIB_PATH=""

if [ "$1" = "run" -o "$1" = "background" ] ; then

   echo Starting Lightstreamer Server...
   echo Please check logs for detailed information.
   class=com.lightstreamer.LS

   # Classpath
   cpath="$bootpath:$LS_HOME/lib/ls-adapter-interface.jar"
   # move ls-adapter-interface.jar in the com.lightstreamer.logging_lib_path property below to have slf4j/logback visible by the Adapters

   KERNEL_LIB_PATH="-Dcom.lightstreamer.kernel_lib_path=$kernelpath"
   INTERNAL_LIB_PATH="-Dcom.lightstreamer.internal_lib_path=$LS_HOME/lib/ls-monitor.jar:$LS_HOME/lib/core/*:$LS_HOME/lib/mpn/*:$LS_HOME/lib/mpn/apns/*:$LS_HOME/lib/mpn/gcm/*"
   LOGGING_LIB_PATH="-Dcom.lightstreamer.logging_lib_path=$LS_HOME/lib/ls-logging-utilities.jar:$LS_HOME/lib/log/*"
   DATABASE_LIB_PATH="-Dcom.lightstreamer.database_lib_path=$LS_HOME/lib/mpn/hibernate/*:$kernelpath"

elif [ "$1" = "stop" -o "$1" = "restart" ] ; then

   echo Stopping Lightstreamer Server...
   class=com.lightstreamer.LS_Stop
   JAVA_OPTS=""

   # Classpath
   cpath="$bootpath"

else

   echo "Usage:  LS.sh ( command )"
   echo "commands:"
   echo "  run               Start Lightstreamer Server in foreground"
   echo "  background        Start Lightstreamer Server in background"
   echo "  stop              Stop Lightstreamer Server"
   echo "  restart           Stop Lightstreamer Server and start a new instance in background"
   exit 1

fi


# Configuration file
arg1="${LS_CONFIG}"

write_pid() {
   if [ -n "${WRITE_PID}" ]; then
      echo $$ > "${WRITE_PID}"
   fi
}

if [ "$1" = "restart" ] ; then

   # call command and wait
   eval '"$JAVA_HOME/bin/java" -cp "$cpath" $class "$arg1"'
   # now start a new Server
   write_pid
   exec $0 background

elif [ "$1" = "run" ] ; then

   # leave control to command
   write_pid
   exec "$JAVA_HOME/bin/java" $JAVA_OPTS "$KERNEL_LIB_PATH" "$INTERNAL_LIB_PATH" "$LOGGING_LIB_PATH" "$DATABASE_LIB_PATH" -cp "$cpath" $class "$arg1"

elif [ "$1" = "stop" ] ; then

   # leave control to command
   exec "$JAVA_HOME/bin/java" -cp "$cpath" $class "$arg1"

elif [ "$1" = "background" ] ; then

   # call command in a separate window and leave
   touch "$LS_HOME/logs/LS.out"
   write_pid
   exec "$JAVA_HOME/bin/java" $JAVA_OPTS "$KERNEL_LIB_PATH" "$INTERNAL_LIB_PATH" "$LOGGING_LIB_PATH" "$DATABASE_LIB_PATH" -cp "$cpath" $class "$arg1" >> "$LS_HOME/logs/LS.out" 2>&1 &

fi
