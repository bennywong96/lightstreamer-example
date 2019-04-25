LIGHTSTREAMER - JMX DEVELOPMENT RESOURCES
=========================================

This directory includes the documentation of the JMX MBeans that Lightstreamer
Server makes available to management clients that are compatible with the
JMX specification.

- Version.txt
  Reports the current SDK version and compatibility constraints.

- doc/API-reference/*
  The MBean Interface documentation files.

- doc/API-reference-index.html
  The home page for the documentation of the MBean interface in javadoc format.

A resume of the monitoring information made available to external clients
through the monitoring Data and Metadata Providers, embedded into the Server,
is available in the "General Concepts.pdf" document.


NOTE ON THE AVAILABLE CONNECTORS
================================

Lightstreamer Server's JMX MBeans can be accessed from external processes
in three different ways.

- Through RMI (see <rmi_connector> on the Server configuration file).

- Through Sun/Oracle's proprietary JMXMP protocol (see <jmxmp_connector>
  on the Server configuration file).
  Note that this service is not supported in the factory deployment of the Server;
  support can be enabled by adding the proper library to the Server classpath,
  through the following steps:
  - download the "Java Management Extensions (JMX) Remote API Reference
    Implementation 1.0.1_03" package from the Oracle site (currently at
    http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-java-plat-419418.html#jmx_remote-1.0.1_03-mr-oth-JPR
    ),
  - extract the jmxremote_optional.jar library and add it to the Server "lib" folder.

- As web pages, through the JMX Tree feature of the Monitoring Dashboard
  (see <jmxtree_enabled> on the Server configuration file).

