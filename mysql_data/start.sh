#!/bin/bash
# File Name: start.sh
# Author: zhenyangze
# mail: zhenyangze@gmail.com
# Created Time: 六  4/23 11:02:05 2016

function run(){
    docker run --name=mysql_data -v /var/lib/mysql -d busybox echo MySQL Data
}
