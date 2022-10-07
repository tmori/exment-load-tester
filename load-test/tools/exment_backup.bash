#!/bin/bash

if [ $# -eq 1 ]
then
    EXEC_DIR=${1}
    cd ${EXEC_DIR}
fi

source env/env.bash

if [ -z ${EXMENT_PHP_DIR} ]
then
    echo "ERROR: EXMENT_PHP_DIR is not set"
    exit 1
fi

cd ${EXMENT_PHP_DIR}
su www-data -c "php artisan exment:backup"
