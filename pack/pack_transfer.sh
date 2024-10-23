#! /usr/bin/sh

FRP_PATH='/etc/frp'
NGINX_FILE='/etc/nginx/nginx.conf'
APACHE_FILE='/etc/apache2/ports.conf:/etc/apache2/conf-enabled/webdav.conf:/etc/apache2/.htpasswd'
WEBDAV_PATH='/var/www/html'
WEBDAV_USER='www-data'
SERVICE_FILE='/etc/systemd/system/letsencrypt.service:/etc/systemd/system/letsencrypt.timer:/usr/lib/systemd/system/frps.service:/usr/lib/systemd/system/frps@.service'
MYSQL_USER='mysql_user'
MYSQL_PASSWD='mysql_passwd'
MYSQL_DATABASES='wp_blog'

copy_file(){
    root=`dirname $1`
    mkdir -p  ./$root
    cp -rf $1 ./$root
}

copy_file_list(){
    FILE=($(echo $1 | tr ":" "\n"))
    for file in "${FILE[@]}"
    do
        copy_file $file
    done
}

# 创建打包目录
PACK_ROOT='pack_transfer'
mkdir $PACK_ROOT
cd $PACK_ROOT

# 导出数据库
mysqldump -u$MYSQL_USER -p$MYSQL_PASSWD --databases $MYSQL_DATABASES > blog.sql

# 拷贝frp
copy_file $FRP_PATH
copy_file /usr/bin/frps

# 拷贝nginx
copy_file $NGINX_FILE

# 拷贝apache
copy_file_list $APACHE_FILE

# 拷贝webdav
copy_file $WEBDAV_PATH

# 拷贝service文件
copy_file_list $SERVICE_FILE

dirname $WEBDAV_PATH >> .conf
# 打包
cd ..
tar zcvf pack.tar.gz $PACK_ROOT
