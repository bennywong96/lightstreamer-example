LIGHTSTREAMER - WEB CLIENT (UNIFIED API) DEVELOPMENT RESOURCES
==============================================================

This directory includes the resources needed to transform any
HTML or HTML5 web application into a Client of Lightstreamer Server.

- Version.txt
  Reports the current SDK version and compatibility constraints.

- doc/Web Client Guide.pdf
  Introduces the main concepts regarding Lightstreamer client
  development using the provided JavaScript API.

- A "Hello World" tutorial, that covers the development of a simple
  Web Client can be found on GitHub:
  https://github.com/Lightstreamer/Lightstreamer-example-HelloWorld-client-javascript

- doc/API-reference/*
  The JavaScript API Interface class JSDoc files.

- doc/API-reference-index.html
  The home page for the JavaScript API Interface class documentation,
  in JSDoc format.

- lib/generator.html
  A tool that allows you to generate a subset of the full library,
  which can be used for deployment in case some features are not needed
  by the application. It can be opened with any browser.
  The tool also allows you to create different versions of the library,
  which expose the interface with different syntax flavours.
  For instance, you can produce versions of the library that can be used
  when full interoperability with other libraries is needed and
  - either an external AMD loader is available (see the "Use AMD with
    namespaced names" case)
  - or it is not available (see the "Use globals" case).
  Open the page for all the details and usage examples.

- lib/lightstreamer.js
  The resources to be deployed on the Web Server as part of a web
  application. The Client Library is comprised of only this file.
  This is the basic version of the library, used in all the included JavaScript
  examples; it leans on an external AMD loader. 

- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK.
