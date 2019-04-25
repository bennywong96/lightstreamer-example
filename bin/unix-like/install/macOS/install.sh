#!/bin/sh

_LS_SOURCE=$(dirname "${0}")
if [[ "${_LS_SOURCE}" = "." ]]; then
    _LS_SOURCE=$(dirname "${PWD}")
elif [[ -z "$(echo ${_LS_SOURCE} | grep "^/" 2> /dev/null)" ]]; then
    _LS_SOURCE="${PWD}"
else
    _LS_SOURCE=$(dirname "${_LS_SOURCE}")
fi
_LS_SOURCE=$(dirname "${_LS_SOURCE}")
_LS_SOURCE=$(dirname "${_LS_SOURCE}")
LS_SOURCE=$(dirname "${_LS_SOURCE}")
export LS_SOURCE

## DISTRO SPECIFIC PART
LS_DISTRO="macOS"
SOURCE_INIT_NAME="com.lightstreamer.server.plist"
INIT_DIR="/Library/LaunchDaemons"
XML_INIT="1"
MKTEMP="mktemp -t ls"
export SOURCE_INIT_NAME INIT_DIR LS_DISTRO XML_INIT MKTEMP

add_service() {
    if [ "${LS_ADD_SERVICE}" != "0" ]; then
        launchctl unload "${INIT_PATH}" &> /dev/null
        launchctl load "${INIT_PATH}" 2> /dev/null || return 1
        echo "Init script installed at: ${INIT_PATH}"
        echo "It is set to automatically start at boot"
        echo "and to restart upon Server termination."
        echo "If you don't want this, please run:"
        echo "  sudo launchctl unload \"${INIT_PATH}\""
    fi
    return 0
}

## END: DISTRO SPECIFIC PART

LS_NEW_USER_ID="${LS_NEW_USER_ID:-8888}"
LS_NEW_GROUP_ID="${LS_NEW_GROUP_ID:-8888}"
. "${LS_SOURCE}/bin/unix-like/install/common.inc"

user_available() {
    dscl . -read /Users/"${LS_USER}" &> /dev/null
    return $?
}

group_available() {
    dscl . -read /Groups/"${LS_GROUP}" &> /dev/null
    return $?
}

setup_user_group() {
    group_available || {
        dscl . -create /Groups/"${LS_GROUP}" PrimaryGroupID "${LS_NEW_GROUP_ID}" &> /dev/null || {
            echo "Cannot add group ${LS_GROUP}" >&2
            exit 1;
        };
        dscl . -create /Groups/"${LS_GROUP}" RealName "Lightstreamer" || exit 1
    }
    user_available || {
        dscl . -create /Users/"${LS_USER}" UniqueID "${LS_NEW_USER_ID}" || exit 1
        dscl . -create /Users/"${LS_USER}" RealName "Lightstreamer" || exit 1
        dscl . -create /Users/"${LS_USER}" PrimaryGroupID "${LS_NEW_GROUP_ID}" || exit 1
        dscl . -create /Users/"${LS_USER}" UserShell /bin/bash || exit 1
        dscl . -append /Groups/"${LS_GROUP}" GroupMembership "${LS_USER}" || \
            exit 1;
     }
}

show_intro || exit 1

echo "Installing to ${LS_DESTDIR}..."
setup_user_group && \
    copy_to_destdir && \
    setup_init_script && \
    add_service
