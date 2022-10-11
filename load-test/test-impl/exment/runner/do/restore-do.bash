#!/bin/bash
if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}
if [ $# -ne 3 ]
then
    terror "Usage: $0 <id> <repeat_id> <backup-file>"
    exit 1
fi
ID=${1}
RID=${2}
BACKUP_FILE=${3}

tlog "DO RESTORE... : backup-file=${BACKUP_FILE}"
bash test-utils/remote_script.bash \
    ${EXMENT_DB_BKP_TOOL_DIR}/exment_restore.bash \
    ${BACKUP_FILE} \
    ${TEST_TARGET_TOOL_DIR}
