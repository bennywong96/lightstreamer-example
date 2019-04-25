LIGHTSTREAMER SERVER INSTALL INSTRUCTIONS FOR UNIX-LIKE SYSTEMS
===============================================================

Quick Install requires a very limited UNIX knowledge and is geared towards
fresh installations. Using the install scripts listed above also works
for upgrades, but YOU ARE GOING to lose any customization for those config
files owned by the Lightstreamer package.

------------
INTRODUCTION
------------

Inside this directory you can find ready-to-use install scripts for the
major Linux distributions and their derivatives (for example: the Debian
install script also works on Ubuntu, etc), OpenBSD, FreeBSD, macOS and
Solaris.
These are BASH scripts, please use at least version 3 (ksh should be
OK as well).

Debian/
---> install.sh
---> init/lightstreamer

FreeBSD/
---> install.sh
---> init/lightstreamer

Gentoo/
---> install.sh
---> init/lightstreamer

macOS/
---> install.sh
---> init/com.lightstreamer.server.plist

OpenBSD/
---> install.sh
---> init/lightstreamer

openSUSE/
---> install.sh
---> init/lightstreamer

Redhat/
---> install.sh
---> init/lightstreamer

Solaris/
---> install.sh
---> init/http-lightstreamer
---> init/http-lightstreamer.xml


The install script must be run as root, using the following call:

# cd <DISTRO> && bash install.sh

The default installation directory is set by the DESTDIR env variable.
If this variable is set, Lightstreamer will be installed in
LS_DESTDIR="${DESTDIR}/opt/Lightstreamer" and the installed launch script
will address the Server through a path relative to LS_DESTDIR.
On the other hand, if DESTDIR is not set, Lightstreamer will be installed
in LS_DESTDIR="/opt/Lightstreamer" and the installed launch script
will address the Server through an absolute path.

In both cases, you can override LS_DESTDIR by prefixing the install.sh
call with LS_DESTDIR=/my/other/full/path, example:

# cd <DISTRO> && LS_DESTDIR=/my/other/root bash install.sh


By default, a "lightstreamer" user belonging to a "lightstreamer"
group will be referred and, if needed, created to be both the owner
of all the files deployed in LS_DESTDIR and the user that will be
running the installed instance.

In order to refer to a different user, you can override the LS_USER
and LS_GROUP variables at install time as follows:

# cd <DISTRO> && LS_USER=myuser LS_GROUP=mygroup bash install.sh

For macOS only, if a new user/group has to be created, they will
be assigned the ID 8888. If needed, the settings can be changed by
overriding the LS_NEW_USER_ID and LS_NEW_GROUP_ID variables at install
time as follows:

# cd <DISTRO> && LS_NEW_USER_ID=9876 LS_NEW_GROUP_ID=6789 bash install.sh


The installation is interactive and you will need to press Enter
before the actual process starts.

-------------------------
OTHER LINUX DISTRIBUTIONS
-------------------------

If your distribution doesn't belong to any of the above, you can
still manually install Lightstreamer Server by copying the whole
package content to /opt/Lightstreamer and following the standard
Lightstreamer Server deployment documentation.
In particular, you should run Lightstreamer Server as unprivileged
user using the startup scripts at bin/unix-like/.

--------------------------
RUNNING THE SERVER AS ROOT
--------------------------

If you need to install Lightstreamer Server having it run as root,
you can either change LS_USER and LS_GROUP variables in
/etc/init.d/lightstreamer after installation or override the same
at install time as follows:

# cd <DISTRO> && LS_USER=root LS_GROUP=root bash install.sh

In the latter case, note that all the files deployed in LS_DESTDIR
will have root as their owner; you may change the owner to a suitable
user by acting manually. 

You may need to run the Server as root in order to let it listen
on HTTP port 80 or HTTPS port 443, as recommended in production
environments (although other ways to achieve that are available).

---------------------------------------------
JAVA_HOME, JAVA_OPTS AND OTHER CUSTOMIZATIONS
---------------------------------------------

You are asked to properly configure JAVA_HOME and JAVA_OPTS inside
${LS_DESTDIR}/bin/unix-like/LS.sh after install to match your environment.
Not doing so, will result in a startup failure.

In some environments, a proper configuration of LS_FILELIMIT in
${LS_DESTDIR}/bin/unix-like/LS.sh may also be needed, to ensure that the
Server is granted the desired number of file descriptors (for TCP sockets).

On the other hand, overriding the default path of the Server main
configuration file is not supported for this kind of installation.

--------------------------------------
RUNNING THE INSTALLER PROGRAMMATICALLY
--------------------------------------
In order to use install.sh inside 3rd party code, it is
possible to tweak its behaviour through several environment
variables:

- LS_INTERACTIVE="0"
Disable install.sh script interactivity.

- LS_ADD_SERVICE="0"
Disable Lightstreamer Server service (init script) activation.

LS_INTERACTIVE and LS_ADD_SERVICE are both set to "1" by default.
