#!/bin/bash

export EXMENT_CLIENT_ID=
export EXMENT_CLIENT_SECRET=
export EXMENT_APK_KEY=

export EXMENT_PHP_TOPDIR=/root/workspace
export EXMENT_RS_TOPDIR=/root/workspace/load-test

export WEB_SERVER_URL=192.168.11.52
export TOP_DIR=`pwd`
export TEST_TARGET=exment
export TEST_IMPL_DIR=${EXMENT_RS_TOPDIR}/test-impl/${TEST_TARGET}
export TEST_ITEM_DIR=${EXMENT_RS_TOPDIR}/test-item/${TEST_TARGET}
export TEST_RNTM_DIR=${TOP_DIR}/test-runtime
export TEST_LOGGER=${TOP_DIR}/test-logger/simple-logger.bash
export TEST_LOGPATH=${EXMENT_RS_TOPDIR}/log
export TEST_PERFPATH=${EXMENT_RS_TOPDIR}/log/perf
export TEST_RESULTPATH=${EXMENT_RS_TOPDIR}/test-result/${TEST_TARGET}

# Options
export TEST_SAR_ENABLE=TRUE
export TEST_TARGET_TOOL_DIR=/mnt/project/work/exment/exment-load-tester/web-server-load-tester
export TEST_SSH_ACCOUNT=tmori@192.168.11.52
export TEST_DISK_DEV=/dev/sdb5

# DB options
export DB_TYPE=mysql

export MYSQL_DB_NAME=exment_database
export MYSQL_USER=exment_user
export MYSQL_PASSWD=secret
export MYSQL_DB_DATA_DIR=/var/lib/mysql

#export POSTGRES_DB_NAME=mattermost
#export POSTGRES_USER=mmuser
#export POSTGRES_PASSWD=mmuser-password
#export POSTGRES_DB_DATA_DIR=/var/lib/postgresql/14/main

# TODO SSH SETTING COMMANDS
# cd /root
# ssh-keygen -t rsa (all return)
# ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@<host ipaddr>

# TOOL OPTIONS
export EXMENT_TOOL_DIR=/mnt/project/work/exment/exment-load-tester
export EXMENT_ROOT_USER=root
export EXMENT_ROOT_PASSWD=Password-999

export EXMENT_DB_BKP_TOOL_DIR=
export EXMENT_DB_BKP_DIR=
