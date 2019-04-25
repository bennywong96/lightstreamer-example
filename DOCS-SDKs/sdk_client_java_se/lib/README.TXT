LIGHTSTREAMER - JAVA SE CLIENTS (UNIFIED API) - USAGE INSTRUCTIONS
==================================================================

The library jar is deployed on a Maven repository at https://www.lightstreamer.com/repo/maven

To include the library in a custom project, using any maven-compatible build tool 
(e.g. Maven, Gradle, Ivy, etc.) it is necessary to configure both a pointer to the 
external repository and the reference to the lib itself.

Please note that the examples below are based on the library version currently
available at the time of release of this distribution of Lightstreamer.
Check on the Maven repository for any newer version still compatible with this
version of Lightstreamer Server. 

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
    <artifactId>ls-javase-client</artifactId>
    <version>4.3.0</version>
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
    compile 'com.lightstreamer:ls-javase-client:4.3.0'
}

Ivy Example
===========

<ibiblio name="lightstreamer" m2compatible="true" root="https://www.lightstreamer.com/repo/maven/"/>

<dependency org="com.lightstreamer" name="ls-javase-client" rev="4.3.0"/>
