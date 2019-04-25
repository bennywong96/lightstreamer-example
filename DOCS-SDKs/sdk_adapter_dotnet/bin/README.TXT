LIGHTSTREAMER - .NET ADAPTER SERVER WRAPPER
===========================================

The EXE contained in this folder can be used to deploy a single Remote Adapter
instance (either Data or Metadata).

To run your own adapter through the server wrapper:

* Copy the DotNetAdapter.dll (and DotNetAdapter.pdb) file from the ../lib folder into 
  this folder.
* Copy the .dll file (and .pdb) file of your Adapter into this folder
* Launch the DotNetServer executable properly configured through command line arguments. 
  e.g.:
    DotNetServer YourPackage.YourAdapter /host localhost /rrport 6661 /notifport 6662
  Run DotNetServer.exe without any parameter for configuration help.
