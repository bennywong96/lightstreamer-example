LIGHTSTREAMER - iOS CLIENTS (UNIFIED API) - USAGE INSTRUCTIONS
==============================================================

The library is available for import through CocoaPods or via direct traditional download.

Please note that the instructions below are based on the library version currently
available at the time of release of this distribution of Lightstreamer.
Check on CocoaPods for any newer version still compatible with this version
of Lightstreamer Server.


Importing the Library via CocoaPods
===================================

To install CocoaPods, read its Getting Started guide. Then, follow these simple steps:

* If you haven't created your podfile yet, do it by running pod init from a terminal positioned in your project's directory.

* Edit your Podfile and add the following line:

    pod 'Lightstreamer_iOS_Client', '4.1.0'

* Run

    pod install

  and CocoaPods will download, verify and integrate the requested client library in your project.

* Close Xcode and reopen it with the workspace that CocoaPods just created in your project's directory.

* Finally, add the following import line wherever you need the client library's services:

    #import <Lightstreamer_iOS_Client/Lightstreamer_iOS_Client.h>


Importing the Library Traditionally
===================================

If CocoaPods is not for you, you can still install the library more traditionally by following these steps:

* Download the iOS client library's distribution from:

  https://www.lightstreamer.com/repo/cocoapods/ls-ios-client/4.1.0/ls-ios-client-4.1.0.zip

* Unzip the library's distribution and copy the framework inside your project.

* In your project's Build Phases page, please add the following libraries in the Link Binary With Libraries section:

    Lightstreamer_iOS_Client.framework
    SystemConfiguration.framework
    Security.framework
    libiconv

* Finally, add the following import line wherever you need the client library's services:

    #import <Lightstreamer_iOS_Client/Lightstreamer_iOS_Client.h>


The library supports compilations targeted to a simulator, compilations targeted to a physical device for both 32 (ARMv7) and 64 bit (ARM64) architectures, and compilations targeted to bitcode.
