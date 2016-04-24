#!/bin/bash
# File Name: start.sh
# Author: zhenyangze
# mail: zhenyangze@gmail.com
# Created Time: 六  4/23 11:02:37 2016


function build(){
    docker build -t $BASE_NAME/mysql .
}
function run(){
    docker run --name=mysql_server --volumes-from mysql_data -e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} -d ${BASE_NAME}/mysql
}
