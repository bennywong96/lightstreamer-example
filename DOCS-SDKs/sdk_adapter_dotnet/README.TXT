LIGHTSTREAMER - .NET ADAPTER DEVELOPMENT RESOURCES
==================================================

This directory includes the resources needed to write Data Adapters and
Metadata Adapters for Lightstreamer Server in a .NET environment.
Only .NET environment version 4.0 or greater is supported.

The adapters will run in a separate process, communicating with the Proxy 
Adapters deployed inside the Lightstreamer Server through the 
Adapter Remoting Infrastructure.

Refer to the Lightstreamer/DOCS-SDKs/adapter_remoting_infrastructure for
an overview of the general architecture and deploy instructions for the 
Proxy Adapters.

- Version.txt
  Reports the current SDK version and compatibility constraints.
   
- doc/API-reference/*
  The Adapter API Interface class documentation files.

- doc/API-reference-index.html
  The home page for the Adapter API Interface class documentation.

- conf/app.config
  A sample configuration file for the including application, which shows
  the available configuration flags.

- A "Hello World" tutorial that covers the development of a simple .NET
  Data Adapter can be found on GitHub:
  https://github.com/Lightstreamer/Lightstreamer-example-HelloWorld-adapter-dotnet.

- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK. 

- lib/*
- lib/StrongName/*
  Binaries to be used for building and running Remote Adapters in a .NET 4.0
  or greater environment.
  The StrongName subfolder contains a version of the Server Wrapper 
  identified with a "strong name".
  
- bin/*
- bin/StrongName/*
  A ready-made application that can be used to host a single Remote Adapter
  instance (either Data or Metadata).
  The StrongName subfolder contains a version of the Server Wrapper 
  identified with a "strong name".
  

