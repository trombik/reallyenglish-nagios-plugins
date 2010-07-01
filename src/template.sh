#!/bin/sh
#
# Copyright (C) 2009 by Tomoyuki Sakurai <cherry@trombik.org>
# 
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#                                                                                            
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
MYNAME=$( basename $0 )
SERVICE_NAME="%%SERVICE_NAME%%"
PLUGINS_DIR=$( dirname $0 )
VERSION="0.1"

usage() {
    echo "${MYNAME} version ${VERSION}
    Usage:
" >/dev/stderr
}

mylog() {
    local text="$1"
    if [ ! -z ${VERBOSE} ]; then
        ${ECHO} "${text}" >/dev/stderr
    fi
}

if [ -r ${PLUGINS_DIR}/utils.sh ]; then
    . ${PLUGINS_DIR}/utils.sh
else
    echo "${SERVICE_NAME} UNKNOWN cannot find utils.sh in ${PLUGINS_DIR}"
    echo "make sure ${MYNAME} is in Nagios plugins dir."
    usage
    exit 3
fi

do_check() {
    # write your chech code here
    # set STATUS_CODE and STATUS_TEXT, then return
    STATUS_CODE=${STATE_UNKNOWN}
    STATUS_TEXT="bug: please implement do_check!"
}

HOST=""
STATUS_CODE=""
STATUS_TEXT=""
while getopts :hH: ARG; do case ${ARG} in
    H) HOST=${OPTARG} ;;
    v) VERBOSE=y ;;
    h) usage; exit ${STATE_UNKNOWN};;
esac; done; shift $(( $OPTIND - 1 ))

do_check

case ${STATUS_CODE} in
    ${STATE_UNKNOWN}) STATUS="UNKNOWN";;
    ${STATE_CRITICAL}) STATUS="CRITICAL";;
    ${STATE_WARNING}) STATUS="WARNING";;
    ${STATE_OK}) STATUS="OK";;
esac

${ECHO} "${SERVICE_NAME} ${STATUS} ${STATUS_TEXT}"
exit ${STATUS_CODE}
