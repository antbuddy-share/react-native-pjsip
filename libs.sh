#!/bin/bash
set -e

VERSION="v2.8.0"
URL="https://github.com/datso/react-native-pjsip-builder/releases/download/${VERSION}/release.tar.gz"
LOCK=".libs.lock"
DEST=".libs.tar.gz"
DOWNLOAD=true

if ! type "curl" > /dev/null; then
    echo "Missed curl dependency" >&2;
    exit 1;
fi
if ! type "tar" > /dev/null; then
    echo "Missed tar dependency" >&2;
    exit 1;
fi

if [ -f ${LOCK} ]; then
    CURRENT_VERSION=$(cat ${LOCK})

    if [ "${CURRENT_VERSION}" == "${VERSION}" ];then
        DOWNLOAD=false
    fi
fi

if [ "$DOWNLOAD" = true ]; then
    echo "If following command is too long please run manual!"
    echo "curl -L --progress \"${URL}\" -o \"${DEST}\""
    echo "tar -xvf \"${DEST}\""
    echo "rm -f \"${DEST}\""
    echo "echo \"${VERSION}\" > ${LOCK}"
    curl -L --progress "${URL}" -o "${DEST}"
    tar -xvf "${DEST}"
    rm -f "${DEST}"

    echo "${VERSION}" > ${LOCK}
fi
