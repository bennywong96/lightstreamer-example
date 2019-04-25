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
LS_DISTRO="OpenBSD"
INIT_DIR="/etc/rc.d"
export LS_DISTRO INIT_DIR

add_service() {
    echo "Init script installed at: ${INIT_PATH}"
    echo "You should add lightstreamer_flags=\"YES\""
    echo "to /etc/rc.conf.local in order to automatically start it"
    echo "see: http://www.openbsd.org/faq/faq10.html"
    return 0
}

## END: DISTRO SPECIFIC PART

. "${LS_SOURCE}/bin/unix-like/install/common.inc"

user_available() {
    userinfo -e "${LS_USER}"
    return ${?}
}

setup_user_group() {
    groupinfo -e "${LS_GROUP}"
    if [ "${?}" != "0" ]; then
        # add group
        groupadd "${LS_GROUP}"
    fi
    if [ "${?}" != "0" ]; then
        echo "Cannot add group ${LS_GROUP}" >&2
        return 1
    fi

    if ! user_available; then
        useradd -g "${LS_GROUP}" -d "${LS_USERADD_HOME}" -s /usr/bin/false "${LS_USER}"
        if [ "${?}" != "0" ]; then
            echo "Cannot add user ${LS_USER}" >&2
            return 1
        fi
    fi
    return 0
}


show_intro || exit 1

echo "Installing to ${LS_DESTDIR}..."
setup_user_group && \
    copy_to_destdir && \
    setup_init_script && \
    add_service
