LIGHTSTREAMER - FLASH CLIENT DEVELOPMENT RESOURCES
==================================================

This directory includes the resources needed to make a Flash movie
a Client of Lightstreamer Server.


Any Flash application can be fed with real-time data
delivered by Lightstreamer Server. The integration strategy
used by this SDK is based on a JavaScript/ActionScript bridge.

The standard Lightstreamer Web (Unified API) Client Library is used
to implement a page that will contain the Flash application
and feed it through a LightstreamerClient object.
The library includes a bridge module.

The lsjavascriptbridge.as library is added to the Flash movie.

The following diagram shows the data flow from Lightstreamer
Server to the Flash application:


 ------          -------------------------------------------------
|  LS  |        |  LS core          JS           AS         Flash |
|      |  --->  |    Web     -->  Bridge  -->          -->        |
|Server|        |  Client         module       Bridge        App  |
 ------          -------------------------------------------------
                                      BROWSER


- Version.txt
  Reports the current SDK version and compatibility constraints.

- doc/API-reference/*
  The JavaScript and ActionScript API interface class documentation files,
  in JSDoc format.

- doc/API-reference-index.html
  The home page for both the JavaScript and ActionScript API interface class
  documentation.

- jsdoc/index.html
  The home page for both the JavaScript API interface and the ActionScript
  API interface, in JSDoc format.

- lib/lsjavascriptbridge.as 
  The library to be included inside a Flash movie to enable the
  communication with a hosting page defining a LightstreamerClient object.
  
- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK.


REQUIREMENTS:

- ActionScript 2
- Flash Player 9 or newer
