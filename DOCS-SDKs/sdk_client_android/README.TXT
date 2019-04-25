LIGHTSTREAMER - ANDROID CLIENTS (UNIFIED API) - DEVELOPMENT RESOURCES
=====================================================================

This directory includes the resources needed to develop an Android application
that works as a client of Lightstreamer Server.

This SDK is designed for Android 4.4.2 (API level 19) and greater.

This client implements the Lightstreamer Unified Client API.
The goal of the Unified API is to offer a common set of
interfaces and functionalities across different languages
and platforms.
In addition to the standard features required by any kind of 
Lightstreamer client, the Unified Client API provides several
others, including:
* Support for automatic re-connections and re-subscriptions.
* Completely asynchronous interfaces: all blocking operations
are performed on dedicated threads.

The library comes in two alternative flavors: full and compact.
The "compact" version can be used in place of the normal "full" version
when a significant reduction of the memory footprint is needed;
this is mainly achieved with a reduction of the dependent libraries.
This comes at the cost of reduced efficiency in network management,
whereby, in particular, WebSocket support is not available.

This library is distributed through a Maven repository, see the
lib folder for details and instructions.

- Version.txt
  Reports the current SDK version and compatibility constraints.

- doc/API-reference.html
- doc/API-reference.txt
  Links to online documentation for this SDK.

- lib/README.txt
  Explains how to include the library into your project using Maven/Gradle and similar build tools.

- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK.
