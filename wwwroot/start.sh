#!/bin/bash
# File Name: wwwroot/run.sh
# Author: zhenyangze
# mail: zhenyangze@gmail.com
# Created Time: 六  4/23 11:20:14 2016

function run(){
    docker run --name=wwwroot -v ${HTDOCS}:/var/www/html -d busybox echo wwwroot
}
