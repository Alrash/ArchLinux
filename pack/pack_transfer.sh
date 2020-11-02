#! /usr/bin/sh

FRP_PATH='/etc/frp'
NGINX_FILE='/etc/nginx/nginx.conf'
APACHE_FILE='/etc/httpd/conf/httpd.conf:/etc/httpd/conf.d/webdav.conf:/etc/httpd/.htpasswd'
WEBDAV_PATH='/var/www/html'
WEBDAV_USER='apache'
SERVICE_FILE='/etc/systemd/system/letsencrypt.service:/etc/systemd/system/letsencrypt.timer:/usr/lib/systemd/system/frps.service:/usr/lib/systemd/system/frps@.service'

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
