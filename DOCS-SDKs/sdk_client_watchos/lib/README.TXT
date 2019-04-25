LIGHTSTREAMER - watchOS CLIENT (UNIFIED API) - USAGE INSTRUCTIONS
=================================================================

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

    pod 'Lightstreamer_watchOS_Client', '4.1.0'

* Run

    pod install

  and CocoaPods will download, verify and integrate the requested client library in your project.

* Close Xcode and reopen it with the workspace that CocoaPods just created in your project's directory.

* Finally, add the following import line wherever you need the client library's services:

    #import <Lightstreamer_watchOS_Client/Lightstreamer_watchOS_Client.h>


Importing the Library Traditionally
===================================

If CocoaPods is not for you, you can still install the library more traditionally by following these steps:

* Download the watchOS client library's distribution from:

  https://www.lightstreamer.com/repo/cocoapods/ls-watchos-client/4.1.0/ls-watchos-client-4.1.0.zip

* Unzip the library's distribution and copy the framework inside your project.

* In your WatchKit extension target configuration:

  * In the General page, please add the client library Lightstreamer_watchOS_Client.framework in the Embedded Binaries section.

  * In the Build Phases page, add the following libraries in the Link Binary With Libraries section:

    Security.framework
    libiconv

  * Still in the Build Phases page, also add a final Run Script phase with the content of the fixup-framework.sh file available in this distribution directory.

* Finally, add the following import line wherever you need the client library's services:

    #import <Lightstreamer_watchOS_Client/Lightstreamer_watchOS_Client.h>


The library supports compilations targeted to a simulator, compilations targeted to a physical device with ARMv7k architecture, and compilations targeted to bitcode.
