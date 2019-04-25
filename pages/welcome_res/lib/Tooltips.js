//////////////// Retrieve tooltip messages for client libs

var tooltipMessages = {
    javascript_client:"To connect your HTML application to Lightstreamer Server, you just need to include a JavaScript library, which is provided together with extensive documentation and example code. The Web library works in any browser and supports PhoneGap and other hybrid platforms.",
    dotnet_client:"To connect your Unity game to Lightstreamer Server, you just need to include a .NET library, which is provided together with extensive documentation and example code.",
    pcl_client:"To connect your .NET application to Lightstreamer Server, you just need to include a .NET PCL lib, which is provided together with extensive documentation and example code. The Portable Class Library (PCL) works seamlessly with desktop .NET applications, as well as Windows Phone and WinRT apps.",
    dotnet_standard_client:"To connect your .NET application to Lightstreamer Server, you just need to include a .NET Standard lib, which is provided together with extensive documentation and example code. The .NET Standard allows greater uniformity through the .NET ecosystem and works seamlessly with .NET Core, .NET Framework, Mono, Unity, Xamarin and UWP apps.",
    android_client:"To connect your Kotlin or Java app for Android to Lightstreamer Server, you just need to include a Java library, which is provided together with extensive documentation and example code.",
    blackberry_client:"To connect your legacy BlackBerry 7 application to Lightstreamer Server, you just need to include a Java library, which is provided together with extensive documentation and example code. If you are targeting BlackBerry 10 apps, you can choose among the Web Client API, Android Client API, and Flex Client API instead.",
    flex_client:"To connect your legacy Flex and AIR applications to Lightstreamer Server, you just need to include an ActionScript library, which is provided together with extensive documentation and example code. This same client API can be used within BlackBerry10 projects as well.",
    ios_client:"To connect your Swift or Objective-C app for iOS to Lightstreamer Server, you just need to include an iOS library, which is provided together with extensive documentation and example code.",
    javame_client:"To connect your legacy Java midlet to Lightstreamer Server, you just need to include a Java ME library, which is provided together with extensive documentation and example code.",
    javase_client:"To connect your Java SE application to Lightstreamer Server, you just need to include a Java library, which is provided together with extensive documentation and example code.",
    nodejs_client:"To connect your Node.js server to Lightstreamer Server, so that Node acts as a Lightstreamer client, you just need to include a JavaScript library, which is provided together with extensive documentation and example code.",
    osx_client:"To connect your Swift or Objective-C application for Mac to Lightstreamer Server, you just need to include a specific macOS library, which is provided together with extensive documentation and example code.",
    silverlight_client:"To connect your legacy Silverlight application to Lightstreamer Server, you just need to include a Silverlight library, which is provided together with extensive documentation and example code.",
    windows_phone_client:"To connect your Windows Phone application to Lightstreamer Server, you just need to include a .NET library, which is provided together with extensive documentation and example code.",
    winrt_client:"To connect your legacy Windows 8 application to Lightstreamer Server, you just need to include a WinRT library, which is provided together with extensive documentation and example code.",
    generic_client:"You can develop Lightstreamer clients in any language by implementing a well documented network protocol, called TLCP (Text Lightstreamer Client Protocol). TLCP is based on HTTP and WebSockets and it is straightforward to implement.",                    
    tvos_client:"To connect your Swift or Objective-C app for Apple TV to Lightstreamer Server, you just need to include a specific tvOS library, which is provided together with extensive documentation and example code.",
    watchos_client:"To connect your Swift or Objective-C app for Apple Watch to Lightstreamer Server, you just need to include a specific watchOS library, which is provided together with extensive documentation and example code.",
    else:"To connect your client application to Lightstreamer Server, you just need to include the provided client library."
};

function  getTooltipMessage(lib) {
    var tmp =  tooltipMessages[lib];
    
    if (tmp != null ) { 
        return tmp;
    } else {
        return tooltipMessages["else"];
    }
        
}
    
