#!/bin/sh

_LS_SOURCE=$(dirname "${0}")
if [[ "${_LS_SOURCE}" = "." ]]; then
    _LS_SOURCE=$(dirname "${PWD}")
else
    _LS_SOURCE=$(dirname "${_LS_SOURCE}")
fi
_LS_SOURCE=$(dirname "${_LS_SOURCE}")
_LS_SOURCE=$(dirname "${_LS_SOURCE}")
LS_SOURCE=$(dirname "${_LS_SOURCE}")
export LS_SOURCE

## DISTRO SPECIFIC PART
LS_DISTRO="openSUSE"
LS_USERADD_ARGS="-m"
LS_USERADD_HOME="/home/lightstreamer"
LS_USERADD_SHELL="/bin/sh"
export LS_DISTRO USERADD_ARGS LS_USERADD_HOME LS_USERADD_SHELL

add_service() {
    if [ "${LS_ADD_SERVICE}" != "0" ]; then
        chkconfig "${SOURCE_INIT_NAME}" on
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
