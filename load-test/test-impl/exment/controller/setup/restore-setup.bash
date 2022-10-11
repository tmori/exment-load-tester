#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 <id> <backup-file>"
    exit 1
fi
ID=${1}
BACKUP_FILE=${2}

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}

tlog "SETUP RESTORE... : backup-file=${BACKUP_FILE}"
bash test-utils/remote_script.bash \
    ${EXMENT_DB_BKP_TOOL_DIR}/exment_restore.bash \
    ${BACKUP_FILE} \
    ${TEST_TARGET_TOOL_DIR}
