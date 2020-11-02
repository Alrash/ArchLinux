#! /usr/bin/sh


IP="your ip address"
PORT="port"
DIR="pack_transfer"

# 安装
sudo yum install epel-release python3-certbot-nginx nginx httpd -y

if [ ! -f "pack.tar.gz" ]; then
    scp -P $PORT alrash@$IP:"~/pack.tar.gz" .
fi
tar zxvf pack.tar.gz

cd $DIR
# 还原文件
sudo cp -rf * /

# 修正权限
WEBDAV_PATH=`head -n 1 .conf`
sudo chown -R apache:apache $WEBDAV_APTH
sudo chown root:apache /etc/httpd/.htpasswd
sudo chmod 755 /usr/bin/frps

# 创建ssl证书
sudo certbot certonly -d alrash.xyz -m kasukuikawai@gmail.com --agree-tos --standalone

# 开启启动
sudo systemctl {enable,start} letsencrypt.timer
sudo systemctl {enable,start} nginx
sudo systemctl {enable,start} httpd
sudo systemctl {enable,start} frps
