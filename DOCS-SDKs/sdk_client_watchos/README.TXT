LIGHTSTREAMER - watchOS CLIENT (UNIFIED API) DEVELOPMENT RESOURCES
==================================================================

This directory includes the resources needed to develop an application for
Apple Watch that works as a client of Lightstreamer Server.

This SDK is compatible with watchOS 2.0 and newer.

This client implements the Lightstreamer Unified Client API. The goal of the Unified API is to offer a common set of interfaces and functionalities across different languages and platforms.

In addition to the standard features required by any kind of Lightstreamer client, the Unified Client API provides several others, including:

* Support for automatic re-connections and re-subscriptions.
* Completely asynchronous interfaces: all blocking operations are performed on dedicated threads.

This library is distributed through CocoaPods or traditional download, see the lib folder for details and instructions.

- Version.txt
  Reports the current SDK version and compatibility constraints.

- doc/API-reference.html
- doc/API-reference.txt
  Links to online documentation for this SDK.

- lib/README.txt
  Explains how to include the library into your project using CocoaPods or traditional download.

- lib/fixup-framework.sh
  Helper script needed only if the library is included traditionally (i.e. not via CocoaPods).
  Strips the i386 code segment from the watchOS SDK framework when doing an Archive operation.

- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK.

