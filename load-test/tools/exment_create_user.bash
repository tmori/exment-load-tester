#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 <base-user.csv> <user-num>"
    exit 1
fi

BASE_USER=${1}
USER_NUM=${2}

cat ${BASE_USER}
for seq_id in `seq ${USER_NUM}`
do 
    USER_NAME="test-user${seq_id}"
    ID=$(($seq_id + 1))
    echo "\"${ID}\",\"\",\"\",\"\",\"${USER_NAME}\",\"${USER_NAME}\",\"${USER_NAME}@example.com\",\"2022-10-11 09:01:51\",\"2022-10-11 09:01:51\",\"\"" 
done
