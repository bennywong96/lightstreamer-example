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
LS_DISTRO="Gentoo"
export LS_DISTRO

add_service() {
    if [ "${LS_ADD_SERVICE}" != "0" ]; then
        rc-update add "${SOURCE_INIT_NAME}" default 2> /dev/null
        echo
        echo "Now type: /etc/init.d/lightstreamer start"
        echo "to start Lightstreamer"
    fi
    return 0
}

## END: DISTRO SPECIFIC PART

. "${LS_SOURCE}/bin/unix-like/install/common.inc"

show_intro || exit 1

echo "Installing to ${LS_DESTDIR}..."
setup_user_group && \
    copy_to_destdir && \
    setup_init_script && \
    add_service
