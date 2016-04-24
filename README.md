# docker-quick-build
docker php环境快速布署脚本
## 注意
1. 需要docker环境，不明白的可搜索docker如何安装。
2. 首次执行前请修改start.sh文件。
``` shell
  MYSQL_PASSWORD="root" # 数据库密码
  NGINX_CONF="~/Documents/work/git/web/conf.d" # 本地映射的nginx conf目录          
  HTDOCS="~/Documents/work/git/web/" # 本地代码目录
```
  nginx conf 简单配置文件存放在nginx/conf.d 目录，可以参考使用。

3. 修改文件执行权限
``` shell
chmod a+x start.sh
```
4. docker容器尽量把环境和数据独立开。

## 操作流程
1. 安装mysql_data数据卷
```shell
➜  docker  ./start.sh   #执行入口文件
1) mysql_data/    3) nginx/     5) wwwroot/
2) mysql_server/  4) php/       6) exit
#? 1    #这里先择1，回车
1) run
2) up
3) exit
#? 1 #选择1，回车
# 进入安装环节，如果没有对应的镜像文件，则会花时间下载
```
2. 安装mysql_service
**没有创建镜像文件则先Build**
```shell
➜  docker  ./start.sh
1) mysql_data/    3) nginx/     5) wwwroot/
2) mysql_server/  4) php/       6) exit
#? 2
1) build
2) run
3) up
4) exit
#? 1 # 选择1 执行build
```
**若已存在，则选择2，执行run方法**
> 镜像查看命令 `docer images`
> 容器查看命令 `docker ps -a`
> 下面操作跟此类似

3. 安装wwwroot数据卷
> 选择run 方法
4. 安装php环境
> 先Build,再run
> Dockerfiler可个性修改
5. 安装nginx环境
6. 测试
> win,unix可直接访问localhost测试。 
> mac上查看有些特殊，需要先通过 `docker-machine ip [defalut]` 获取容器ip,再用容器Ip访问
