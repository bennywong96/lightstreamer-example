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
LS_DISTRO="Solaris"
# lightstreamer is too long
LS_GROUP="lights"
LS_USER="lights"
LS_USERADD_HOME=/
export LS_DISTRO LS_GROUP LS_USER LS_USERADD_HOME

## END: DISTRO SPECIFIC PART

. "${LS_SOURCE}/bin/unix-like/install/common.inc"

# Override defaults in common.inc
SOURCE_INIT_DIR="${LS_SOURCE}/bin/unix-like/install/${LS_DISTRO}/init"
INIT_PATH="/lib/svc/method/http-lightstreamer"
MANIFEST_PATH="/lib/svc/manifest/network/http-lightstreamer.xml"
INIT_DIR=$(basename "${INIT_PATH}")

copy_init_script() {
    local manifest_name=$(basename "${MANIFEST_PATH}")
    local method_name=$(basename "${INIT_PATH}")
    cp -p "${SOURCE_INIT_DIR}/${manifest_name}" "${MANIFEST_PATH}" || return 1
    cp -p "${SOURCE_INIT_DIR}/${method_name}" "${INIT_PATH}" || return 1
}

setup_init_script_perms() {
    chmod 555 "${INIT_PATH}" || return 1
    chmod 444 "${MANIFEST_PATH}" || return 1
}

add_service() {
    if [ "${LS_ADD_SERVICE}" != "0" ]; then
        local ls_serv="svc:/network/http:lightstreamer"
        svcadm restart "svc:/system/manifest-import" "${ls_serv}" &> /dev/null
        sleep 2
        svcadm enable "${ls_serv}" &> /dev/null
        echo "Init script installed at: ${INIT_PATH}"
        echo "It is set to automatically start at boot (and is also now online)"
        echo "You can restart Lightstreamer Server using:"
        echo "  svcadm restart ${ls_serv}"
    fi
    return 0
}

show_intro || exit 1

echo "Installing to ${LS_DESTDIR}..."
setup_user_group && \
    copy_to_destdir && \
    setup_init_script && \
    add_service
