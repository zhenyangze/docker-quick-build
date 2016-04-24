#!/bin/bash
# File Name: start.sh
# Author: zhenyangze
# mail: zhenyangze@gmail.com
# Created Time: 六  4/23 14:10:20 2016

function build(){
    docker build -t $BASE_NAME/nginx .
}
function run(){
    # docker run --name=nginx --volumes-from wwwroot --link php-fpm:php -p 80:80 -d $BASE_NAME/nginx
    docker run --name=nginx --volumes-from wwwroot --link php-fpm:php -v ${NGINX_CONF}:/etc/nginx/conf.d -p 80:80 -d $BASE_NAME/nginx
    #cp ./conf.d/* $NGINX_CONF/
}
