LIGHTSTREAMER - .NET Standard CLIENTS - DEVELOPMENT RESOURCES
=============================================================

This directory points to the various resources needed to develop
a .NET application that works as a client to Lightstreamer Server,
in order to send and receive real-time data.

The Lightstreamer .NET Standard Client Library exposes a simple
interface, which enables the application to communicate with the
Lightstreamer Server, by opening and closing connections and
sessions, performing subscriptions and unsubscriptions, receiving
data, and sending client messages to the server.
Clients access Library services by creating an object of type
Lightstreamer.DotNetStandard.Client.LSClient. Each LSClient
object manages a private connection to Lightstreamer Server.
The .NET Standard allows greater uniformity through the .NET
ecosystem and works seamlessly with .NET Core, .NET Framework,
Mono, Unity, Xamarin and UWP apps. 

This SDK is designed for .NET Standard API Specifications 2.0
and greater.

This library is distributed through the NuGet package manager
(nuget.org), see the lib folder for details and instructions.

- Version.txt
  Reports the current SDK version and compatibility constraints.

- doc/API-reference.html
- doc/API-reference.txt
  Links to online documentation for this SDK.

- lib/README.txt
  Explains how to include the library into your project via NuGet.

- examples/examples.html
- examples/examples.txt
  Links to online examples for this SDK.
