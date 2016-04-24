#!/bin/bash
# File Name: start.sh
# Author: zhenyangze
# mail: zhenyangze@gmail.com
# Created Time: 六  4/23 11:32:54 2016

# 需要修改
MYSQL_PASSWORD="root" # 数据库密码
NGINX_CONF="~/Documents/work/git/web/conf.d" # 本地映射的nginx conf目录
HTDOCS="~/Documents/work/git/web/" # 本地代码目录
BASE_NAME="local" #docker命名前缀

BASE_DIR=$(dirname $0) 
CATEGOTY=$1 && shift
ARGS=$1 && shift

SHELL_PATH=${BASE_DIR}/${CATEGOTY}/start.sh

OPTION=""
function check_file(){
    OPTION=$CATEGOTY
    select v in $(ls -F | grep '/$') "exit";do
        OPTION=$v
        break
    done
    if [[ $OPTION == 'exit' ]];then
        exit
    else 
        CATEGOTY=${OPTION/\//}
        SHELL_PATH=${BASE_DIR}/${CATEGOTY}/start.sh
    fi
}

function check_args(){
    OPTION=$ARGS
    select v in $(cat $SHELL_PATH | grep 'function ' | cut -d "(" -f 1 | cut -d " " -f 2) "up" "exit";do
        OPTION=$v
        break
    done
    if [[ $OPTION == 'exit' ]];then
        exit 
    else
        ARGS=$OPTION
    fi
}

function execute(){
    source  $SHELL_PATH
    cd ${BASE_DIR}/${CATEGOTY} && $ARGS
    cd -
}
while true;do
    if [[ -z $CATEGOTY || ! -f $SHELL_PATH ]];then
        check_file
    elif [[ $OPTION == 'up' ]];then
        check_file
    elif [[ -z $ARGS ]];then
        check_args
    else
        execute
        if [[ $? -ne 0 ]];then
            ARGS=''
            check_args
        else
            ARGS=''
            CATEGOTY=''
            check_file
        fi
    fi
done
