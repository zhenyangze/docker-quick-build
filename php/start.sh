#!/bin/bash
# File Name: start.sh
# Author: zhenyangze
# mail: zhenyangze@gmail.com
# Created Time: 六  4/23 10:57:14 2016

function build(){
    docker build -t $BASE_NAME/php .
}
function run(){
    docker run --name=php-fpm --volumes-from wwwroot --link mysql_server:mysql -d $BASE_NAME/php
}

