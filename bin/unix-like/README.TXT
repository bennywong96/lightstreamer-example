LIGHTSTREAMER SERVER LAUNCH SCRIPTS FOR UNIX-LIKE SYSTEMS
=========================================================

-------------
CONFIGURATION
-------------

Before launching any script, some configuration must be performed.

LS.sh defines the JAVA_HOME and JAVA_OPTS variables. Follow the instructions
in the head section of the LS.sh file to edit them.
You may also need to increase the maximum number of file descriptors (for TCP
sockets) available to Lightstreamer. See LS_FILELIMIT in the head section
of the LS.sh file to tune them.

Moreover, if you are interested in installing Lightstreamer Server on any
major Linux and Unix-like Operating Systems, you may want to have a look at
the install/ subdirectory and its README.TXT file.

-----
USAGE
-----

All the included scripts assume that the "bash" shell is the default shell
for the system.

- LS.sh

  General launch script. It must be called with one of the following options:
  
  - run         Start Lightstreamer Server in foreground.
  - background  Start Lightstreamer Server in background (process output
                goes to the LS.log file under the logs subdirectory
                of the installation directory).
  - restart     Stop Lightstreamer Server and start a new instance
                in background (suitable only for the case in which
                the Server was, previously, also started in background).
  - stop        Stop Lightstreamer Server.

  The script also checks the LS_CONFIG environment variable;
  by setting it before running the script, it is possible to override the
  default path of the Server main configuration file.

  This script can be called from any directory.

- start.sh
- background_start.sh
- stop.sh
- restart.sh

  Shortcut scripts for "run", "background", "stop" and "restart" operations;
  they do not require parameters and can be invoked by point and click.
  These scripts can only be called from this directory.

- install

  Contains automatic installation scripts for the main Unix-like Operating
  Systems.
  See the included README.TXT for all details.

NOTE on the "stop" and "restart" operations:
In order to stop a running Server, the "stop" and "restart" operations try
to access the Server process through the JMX interface; this requires that
the Server has successfully completed the initialization of JMX.
If the Server startup is slow, it is possible that an early attempt to stop
the Server will fail.

----------------------
FILE DESCRIPTORS LIMIT
----------------------

Given the nature of push server applications, having thousands of open connections
(thus file descriptors) is a common scenario. On Unix Operating Systems however
a process by default has a very limited amount of allowable open files per process.
You can see the current limit by calling:

$ ulimit -Sn
For the soft limit

$ ulimit -Hn
For the hard limit

You may want to increase the maximum number of open files for both soft and hard
limit to match your deployment scenario.
If so, please see LS.sh script.

----------------------
USING PRIVILEGED PORTS
----------------------

If you need to have Lightstreamer Server directly listen on HTTP port 80 or
HTTPS port 443 (recommended in production environments), some different solutions
are possible:

A) The easiest way is to run the server as root.

B) On Linux, an alternative and safer way would be to grant the right to
   listen on these ports to the Server executable, which hence can be run from
   a non-root user. Consider, however, that Lightstreamer Server leans on the JVM
   executable, which, once granted the listening capability, will exhibit such
   capability also if launched to run any other java application.

   In order to grant the listening capability on port 80, 443 and any other port
   less than 1024, run the following command as root:

   # setcap cap_net_bind_service=+ep /path/to/the/executable/java

   Running the following command as root revokes the capability:

   # setcap cap_net_bind_service=-ep /path/to/the/executable/java

   Please notice that there are some known issues in applying setcap to the java
   executable of some JVM distributions.

C) On Linux, it is possible to use port forwarding, via a command (to run as root) like:

   # /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
   # /sbin/service iptables save
   
   Be aware that with high loads, port forwarding might impair performance.

