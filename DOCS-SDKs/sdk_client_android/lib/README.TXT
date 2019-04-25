LIGHTSTREAMER - ANDROID CLIENTS (UNIFIED API) - USAGE INSTRUCTIONS
==================================================================

The library jar is deployed on a Maven repository at https://www.lightstreamer.com/repo/maven

To include the library in a custom project, using any maven-compatible build tool 
(e.g. Maven, Gradle, Ivy, etc.) it is necessary to configure both a pointer to the 
external repository and the reference to the lib itself.

Please note that the examples below are based on the library version currently
available at the time of release of this distribution of Lightstreamer.
Check on the Maven repository for any newer version still compatible with this
version of Lightstreamer Server. 

Two alternative flavours of the library are available: full and compact.
The following examples refer to the normal, "full" library; for the limited,
"compact" library, just replace "ls-android-client" with "ls-android-client-compact"
in the instructions below.

Maven Example
=============

<repositories>
  <repository>
    <id>lightstreamer</id>
    <name>Lightstreamer repository</name>
    <url>https://www.lightstreamer.com/repo/maven</url>
  </repository>
</repositories>

<dependencies>
  <dependency>
    <groupId>com.lightstreamer</groupId>
    <artifactId>ls-android-client</artifactId>
    <version>4.1.0</version>
  </dependency>
</dependencies>

Gradle Example
==============

repositories {
    maven {
        url "https://www.lightstreamer.com/repo/maven"
    }
}

dependencies {
    compile 'com.lightstreamer:ls-android-client:4.1.0'
}

Ivy Example
===========

<ibiblio name="lightstreamer" m2compatible="true" root="https://www.lightstreamer.com/repo/maven/"/>

<dependency org="com.lightstreamer" name="ls-android-client" rev="4.1.0"/>
