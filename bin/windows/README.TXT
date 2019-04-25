LIGHTSTREAMER SERVER LAUNCH SCRIPTS FOR WINDOWS SYSTEMS
=======================================================

-------------
CONFIGURATION
-------------

Before launching any script, some configuration must be performed.

LS.bat defines the JAVA_HOME and JAVA_OPTS variables. Follow the instructions
in the head section of the LS.bat file to edit them.

On Windows systems it is possible to install Lightstreamer Server as a Windows
service. A component called "NSSM" is used to wrap the Lightstreamer
process within a Windows service in a transparent way. This means that
you can then start/stop Lightstreamer through the standard Windows
Services console. Lightstreamer is using a custom version of NSSM,
available (at the time of writing this document) at https://iain.cx/src/nssm.
The tool is available for both Windows 32 and 64-bit releases and the right
version is automatically selected for you by the provided helper batch files.

-----
USAGE
-----

- LS.bat

  General launch script. It must be called with one of the following options:
  
  - run         Start Lightstreamer Server in the current shell window.
  - background  Start Lightstreamer Server in a separate shell window.
  - stop        Stop Lightstreamer Server.
  - restart     Stop Lightstreamer Server and start a new instance
                in a separate shell window.
  
  The script also checks the LS_CONFIG environment variable;
  by setting it before running the script, it is possible to override
  the default path of the Server main configuration file.

  This script can be called from any directory.

- Start_LS_as_Application.bat
- BackgroundStart_LS_as_Application.bat
- Stop_LS_as_Application.bat
- Restart_LS_as_Application.bat

  Shortcut scripts for "run", "background", "stop" and "restart" operations;
  they do not require parameters and can be invoked by point and click.
  These scripts can only be called from this directory.

NOTE on the "stop" and "restart" operations:
In order to stop a running Server, the "stop" and "restart" operations try
to access the Server process through the JMX interface; this requires that
the Server has successfully completed the initialization of JMX.
If the Server startup is slow, it is possible that an early attempt to stop
the Server will fail.

- Install_LS_as_Service-NT.bat
- Uninstall_LS_as_Service-NT.bat

  Scripts to be used to install and uninstall Lightstreamer Server as a service;
  they do not require parameters and can be invoked by point and click.
  Please NOTE however that administrative privileges are required. So if you're
  running Windows Vista, Seven or later versions, or if you're running with
  unprivileged credentials, you have to make sure that the above scripts are
  executed with Administrator credentials.

  Furthermore, these scripts can only be called from this directory.
  Note that, at least with Windows 7, you can't install the Lightstreamer server 
  in a user's folder, otherwise the service installed by the above script will 
  not be able to start. In general, this is also a bad practice.

  If you want to change the default service display name, or the default service 
  description, or the default service startup type, you may change the corresponding 
  variables defined in the Install_LS_as_Service-NT.bat install script.
  Before running Install_LS_as_Service-NT.bat, we suggest checking if the
  Server configuration is correct by trying Start_LS_as_Application.bat first.

  If you want to override the default path of the Server main configuration file
  through the dedicated LS_CONFIG environment variable, the variable needs to be
  included in the service execution environment. This has to be enforced manually.

- nssm.exe
- nssm_x64.exe

  Allows Lightstreamer Server to be launched as a Windows service.
  This executable must not be invoked directly. While nssm.exe is
  for 32-bit architectures and nssm_x64.exe is for 64-bit ones,
  the batch files above are capable to select the right executable for
  your architecture automatically.

