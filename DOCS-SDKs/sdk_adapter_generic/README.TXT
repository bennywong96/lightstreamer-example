LIGHTSTREAMER - GENERIC ADAPTER DEVELOPMENT RESOURCES
=====================================================

This directory includes the documentation of the ARI protocol, based on
TCP sockets, used by Remote Adapters to communicate with the Proxy Adapters
deployed inside the Lightstreamer Server.

The other Adapter SDKs (except for Java In-Process Adapter SDK) implement 
this protocol through different languages.

This SDK enables the development of any Remote Adapter by working at TCP
level, without leveraging the adapter library provided within the other
SDKs.

Refer to the Lightstreamer/DOCS-SDKs/adapter_remoting_infrastructure for
an overview of the general architecture and deploy instructions for the Proxy
Adapters.

- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK.

- doc/ARI Protocol.pdf  
  Full specification, for the TCP-based protocol used in the communication 
  between a Proxy Adaptert and its Remote Adapter counterpart.
  
- A "Hello World" tutorial that covers the development of a simple
  socket-based Data Adapter can be found on GitHub:
  https://github.com/Lightstreamer/Lightstreamer-example-HelloWorld-adapter-socket
