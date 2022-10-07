#!/bin/bash

if [ $# -ne 1 -a $# -ne 2 ]
then
    echo "Usage: $0 <backup_file> [exec-dir]"
    exit 1
fi

BACKUP_FILE=${1}
if [ $# -eq 2 ]
then
    EXEC_DIR=${2}
    cd ${EXEC_DIR}
fi

source env/env.bash

if [ -z ${EXMENT_PHP_DIR} ]
then
    echo "ERROR: EXMENT_PHP_DIR is not set"
    exit 1
fi

cd ${EXMENT_PHP_DIR}
su www-data -c "php artisan exment:restore ${BACKUP_FILE}"

