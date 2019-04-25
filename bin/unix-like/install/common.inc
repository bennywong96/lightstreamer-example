## VARIABLES
MY_DESTDIR="${DESTDIR:-/}"
LS_DESTDIR="${LS_DESTDIR:-${MY_DESTDIR}/opt/Lightstreamer}"
LS_USER="${LS_USER:-lightstreamer}"
LS_GROUP="${LS_GROUP:-lightstreamer}"
# set to "0" to disable interactivity
LS_INTERACTIVE="${LS_INTERACTIVE:-1}"
# set to "0" to disable Lightstreamer service activation
LS_ADD_SERVICE="${LS_ADD_SERVICE:-1}"
# make possible to override default LS_USER home directory
# (for Solaris)
LS_USERADD_HOME="${LS_USERADD_HOME:-/dev/null}"
# Linux useradd, default options
LS_USERADD_ARGS="${LS_USERADD_ARGS:--M -N}"
# Default LS_USER shell exec
LS_USERADD_SHELL="${LS_USERADD_SHELL:-/bin/false}"

# LS_DISTRO is set by the caller
SOURCE_INIT_NAME="${SOURCE_INIT_NAME:-lightstreamer}"
SOURCE_INIT_PATH="${LS_SOURCE}/bin/unix-like/install/${LS_DISTRO}/init/${SOURCE_INIT_NAME}"
INIT_DIR="${INIT_DIR:-${MY_DESTDIR}/etc/init.d}"
INIT_PATH="${INIT_DIR}/${SOURCE_INIT_NAME}"
# manifest file supporting INIT_PATH, if needed
# this file, if provided, is part of the init system
# (on Solaris, for example)
MANIFEST_PATH="${MANIFEST_PATH:-}"
XML_INIT="${XML_INIT:-}"
# mktemp wrapper, required for FreeBSD and macOS
MKTEMP="${MKTEMP:-mktemp}"

block_non_root() {
    if [ "$(whoami)" != "root" ]; then
        echo "Please run this as superuser" >&2
        exit 1
    fi
}
block_non_root

show_intro() {
    echo "======================================================================="
    echo "Lightstreamer Server Installation"
    echo
    echo "Source directory: LS_SOURCE = ${LS_SOURCE}"
    echo "Install (target) directory: DESTDIR = ${MY_DESTDIR}"
    echo "Lightstreamer (target) directory: LS_DESTDIR = ${LS_DESTDIR}"
    echo "You can override DESTDIR and LS_DESTDIR"
    echo
    echo "Will create user: ${LS_USER}, group: ${LS_GROUP}"
    echo "You can override LS_USER and LS_GROUP"
    echo
    echo "JAVA_HOME and JAVA_OPTS are taken from LS.sh,"
    echo "as well as the optional LS_FILELIMIT;"
    echo "please edit bin/unix-like/LS.sh accordingly."
    echo "On the other hand, LS_CONFIG cannot be customized"
    echo "with this installation utility."
    echo
    echo "You need the following UNIX tools"
    echo "cp, grep, mv, sed"
    echo
    echo "======================================================================="
    echo
    if [ "${LS_INTERACTIVE}" != "0" ]; then
        echo "Press Enter to confirm, CTRL+C to cancel"
        read || exit 1
    fi
}

user_available() {
    grep "^${LS_USER}:" /etc/passwd > /dev/null
    return "${?}"
}

setup_user_group() {
    local res

    groupadd "${LS_GROUP}" 2> /dev/null
    res="${?}"
    if [ "${res}" != "9" ] && [ "${res}" != "0" ]; then
        # 9 is "group already exists"
        echo "Cannot add group ${LS_GROUP}" >&2
        return 1
    fi
    if ! user_available; then
        useradd ${LS_USERADD_ARGS} -d "${LS_USERADD_HOME}" -g "${LS_GROUP}" -s "${LS_USERADD_SHELL}" \
            "${LS_USER}" 2> /dev/null
        res="${?}"
        if [ "${res}" = "2" ]; then
            # wrong syntax, we have strict POSIX useradd
            useradd -d "${LS_USERADD_HOME}" -g "${LS_GROUP}" -s "${LS_USERADD_SHELL}" \
                "${LS_USER}" 2> /dev/null
            res="${?}"
        fi
        if [ "${res}" != "0" ]; then
            echo "Cannot add user ${LS_USER}" >&2
            return 1
        fi
    fi
    return 0
}

copy_to_destdir() {
    if [ ! -d "${LS_DESTDIR}" ]; then
        echo "Creating ${LS_DESTDIR}"
        mkdir -p "${LS_DESTDIR}" || return 1
    fi
    if [ ! -d "${LS_SOURCE}" ]; then
        echo "${LS_SOURCE} does not exist, exiting..." >&2
        return 1
    fi
    cp -Rp "${LS_SOURCE}"/* "${LS_DESTDIR}"/ || return 1
    chown -R "${LS_USER}":"${LS_GROUP}" "${LS_DESTDIR}" || return 1

    # make sure LS.sh is executable
    chmod 755 "${LS_DESTDIR}/bin/unix-like/LS.sh" || return 1

    echo "File copy complete"
}

copy_init_script() {
    if [ ! -d "${INIT_DIR}" ]; then
        echo "${INIT_DIR} not a directory" >&2
        return 1
    fi
    cp -p "${SOURCE_INIT_PATH}" "${INIT_DIR}/" || return 1
    chown root "${INIT_PATH}" || return 1
    # root group can be unavailable (macOS)
    chgrp root "${INIT_PATH}" &> /dev/null
    return 0
}

setup_init_script_perms() {
    chmod 744 "${INIT_PATH}" || return 1
}

setup_init_script() {
    copy_init_script || return 1

    # Tweak %LS_HOME%, %LS_USER%, %LS_GROUP%
    # Do it in a POSIX way
    tmp_file=$(${MKTEMP})
    if [ -z "${tmp_file}" ]; then
        return 1
    fi
    for path in "${INIT_PATH}" "${MANIFEST_PATH}"; do
        if [ -z "${path}" ]; then
            continue
        fi
        if [ -n "${XML_INIT}" ]; then
            sed -e "s:%LS_HOME%:${LS_DESTDIR/${DESTDIR}}:" -e \
                "s:%LS_USER%:${LS_USER}:" -e \
                "s:%LS_GROUP%:${LS_GROUP}:" "${path}" > "${tmp_file}" || return 1
        else
            sed -e "s:%LS_HOME%:\"${LS_DESTDIR/${DESTDIR}}\":" -e \
                "s:%LS_USER%:\"${LS_USER}\":" -e \
                "s:%LS_GROUP%:\"${LS_GROUP}\":" "${path}" > "${tmp_file}" || return 1
        fi
        cat "${tmp_file}" > "${path}" || return 1
        rm -f "${tmp_file}"
    done
    setup_init_script_perms || return 1
}
