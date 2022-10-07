#!/bin/bash

if [ -z ${TEST_TARGET} ]
then
    source env/env.bash
fi

source ${TEST_LOGGER}
if [ $# -ne 2 ]
then
    terror "Usage: $0 <id> <repeat_id>"
    exit 1
fi
ID=${1}
RID=${2}

tlog "ID=${ID}, RID=${RID}:DOING VERSION TEST..."
cd ${EXMENT_PHP_TOPDIR}
tlog "ID=${ID}, RID=${RID}:`php test/system/version.php`"

